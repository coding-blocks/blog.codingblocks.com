require 'json' 

module Jekyll

  class JSONPost < Page; end

  class JSONGenerator < Generator
    priority :lowest
    safe true
    
    def generate(site)
      generate_posts(site)
    end

    def generate_posts(site)
      site.posts.each do |post|
        json_dest = post.destination("json")
        json_dest['index.html'] = ''

        full_path = "#{site.dest}/#{json_dest}"
        ensure_directory(full_path)

        post_hash = post.to_liquid.keep_if { |k, _| ['title', 'content', 'created_at', 'author'].include? k }
        File.open("#{full_path}index.json", 'w') { |f| f.write(post_hash.to_json) }

        post.data['json_url'] = "/#{json_dest}index.json"

        site.pages << Jekyll::JSONPost.new(site, site.dest, json_dest, 'index.json')
      end
    end
  
    def ensure_directory(path)
      FileUtils.mkdir_p(path)
    end
  end
end
