require 'pathname' 
# require 'FileUtils'
require 'fileutils'

class Tocmd::TranslatorTrans  
  def initialize(source_file_path) 
    #源文件路径
    @source_file_path = source_file_path    
    #gem跟目录                          
    @gem_root_path = File.expand_path('../', @source_file_path)   
    #editor path
    @editor_path =  Pathname.new(File.expand_path('../../../template', __FILE__)).realpath.to_s  

  end
  
  def hi
      generate_meta_js
      # cp_source_file_to_cur_file
      
			ar = @source_file_path.split('/')
			ar.pop()
			
			puts "src path = #{ar.join('/').to_s}"
			src_path = ar.join('/').to_s
			
			ar.push('preview');
			dest_dir = ar.join('/').to_s
			
			puts "desc path = #{ar.join('/').to_s}"
      
      # copy vendor/toc to dest directory
      `mkdir -p #{dest_dir}/toc`
      `cp -rf #{@editor_path}/toc #{dest_dir}/`
      
      if File.exist?("#{dest_dir}/toc_conf.js")
        puts 'toc_conf file exist'
      else
        `cp -rf #{@editor_path}/toc/toc_conf.js #{dest_dir}/`
      end
      
      # _toc_config(dest_dir)
      
      # build now
			build_with_dir(@source_file_path ,dest_dir)
			
      # if mac open in browser
			open_in_browser
  end
	
  def hi_dir
      generate_meta_js
      # cp_source_file_to_cur_file
    
			ar = @source_file_path.split('/')
			# ar.pop()
			
			puts "hi_dir src path = #{ar.join('/').to_s}"
			src_path = ar.join('/').to_s
			
			ar.push('preview');
			dest_dir = ar.join('/').to_s
			
			puts "hi_dir desc path = #{ar.join('/').to_s}"
      
      # copy vendor/toc to dest directory
      `cp -rf #{@editor_path}/ #{dest_dir}`
      
      if File.exist?("#{dest_dir}/toc_conf.js")
        puts 'toc_conf file exist'
      else
        `cp -rf #{@editor_path}/toc/toc_conf.js #{dest_dir}/`
      end
      # _toc_config(dest_dir)
      
			build_with_dir(src_path ,dest_dir)
			
			open_in_browser
  end
  
  def _toc_config(dest_dir)
    if File.exist?("#{dest_dir}/toc_conf.js")
      puts 'toc_conf file exist'
    else
      # if file not exit,create toc_conf
      `touch #{dest_dir}/toc_conf.js`
      
      # fill data to toc_conf.js
      `echo 'var jquery_ztree_toc_opts = {'>#{dest_dir}/toc_conf.js`
  		    `echo 'is_auto_number:true,' >> #{dest_dir}/toc_conf.js`
  		    `echo "documment_selector:'.markdown-body'" >> #{dest_dir}/toc_conf.js`
      
      `echo '};' >> #{dest_dir}/toc_conf.js`
      
      `echo "var markdown_panel_style = {'width':'70%','margin-left':'20%'};">> #{dest_dir}/toc_conf.js`
    end
  end
  
  def open_in_browser
		ar = @source_file_path.split('/')

		if File.directory?(@source_file_path) == false #普通文件
				file_name = ar.pop().split('.')[0]
				src_path = ar.join('/').to_s

				ar.push('preview');
				dest_dir = ar.join('/').to_s		
				
				`open #{ar.join('/').to_s}/#{file_name}.html`		
		
		else  
			# 目录
			src_path = ar.join('/').to_s

			Dir.foreach(src_path) do |ff| 
				file_name = ff.split('.')[0]
			end
		
			ar.push('preview');
			dest_dir = ar.join('/').to_s		
			`open #{ar.join('/').to_s}/#{file_name}.html`		
		end
  end
  
  def generate_meta_js
    f = File.new(File.join(@editor_path,"meta.js"), "w+")
    f.puts("#{@source_file_path}")
  end
  
  def cp_source_file_to_cur_file
		# cp param must be string
    f = File.new(File.join(@editor_path,"cur.file"), "w+").path
    FileUtils.cp(@source_file_path,f)
  end
	
	def build_with_dir(destiny_dir,dest_dir)
		p "start building......"
		
		if File.directory?(destiny_dir) == false
			p 'process_with_one'
			ar = @source_file_path.split('/')
			file_name = ar.pop().split('.')[0]
		
			src_path = ar.join('/').to_s

			ar.push('preview');
			dest_dir = ar.join('/').to_s		
			
			# return;
			process_with_one(src_path,dest_dir,destiny_dir.split('/').pop().to_s)
			
			return;
		end
		
		p "src_dir = #{destiny_dir}"
		p "dest_dir = #{dest_dir}"
		Dir.foreach(destiny_dir) do |ff| 
		  # puts ff
			unless /^\./ =~ ff ||/^images/ =~ ff ||/^css/ =~ ff || File.directory?(ff) || File.extname(ff) != '.md'
				
				process_with_one(destiny_dir,dest_dir,ff)
			
			end
		end 
	end 
 
  def process_with_one(destiny_dir ,dest_dir ,ff)
		# get markdown text
		text = IO.read(destiny_dir + '/' + ff)

		# options = [:fenced_code,:generate_toc,:hard_wrap,:no_intraemphasis,:strikethrough,:gh_blockcode,:autolink,:xhtml,:tables]

		# convert to html
		markdown = Redcarpet::Markdown.new(HTMLwithPygments,:gh_blockcode=>true,:no_intra_emphasis=>true,:filter_html => true,:hard_wrap => true,:autolink => false, :space_after_headers => true,:fenced_code_blocks => true,:tables => true,:filter_html=>false)
		parse_markdown = markdown.render(text)
		# parse_markdown = syntax_highlighter(parse_markdown)
	
		css_link = ''
		if destiny_dir.to_s.index('/')
			css_link =  %Q{
				<link href="toc/style/github-bf51422f4bb36427d391e4b75a1daa083c2d840e.css" media="all" rel="stylesheet" type="text/css"/>
				<link href="toc/style/github2-d731afd4f624c99a4b19ad69f3083cd6d02b81d5.css" media="all" rel="stylesheet" type="text/css"/>
    		<link rel="stylesheet" type="text/css" href="toc/css/trans.min.css" />
			}
		else
			css_link =  %Q{
				<link href="toc/style/github-bf51422f4bb36427d391e4b75a1daa083c2d840e.css" media="all" rel="stylesheet" type="text/css"/>
				<link href="toc/style/github2-d731afd4f624c99a4b19ad69f3083cd6d02b81d5.css" media="all" rel="stylesheet" type="text/css"/>
				<link rel="stylesheet" type="text/css" href="toc/css/trans.min.css" />
			}
		end
	
	  t = %Q{
	    <html>
	      <head>
				  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
	        <title>泰然逸品#{ff.gsub('.md','')}</title>
					#{css_link}
	      </head>
	      <body>
    		<div class="container">
    			<!-- Push Wrapper -->
    			<div class="mp-pusher" id="mp-pusher">

    				<!-- mp-menu -->
    				<nav id="mp-menu" class="mp-menu">
    					<div class="mp-level">
    						<h2 class="icon icon-world" id='mp_title' style='font-size: 34;color:white;'>泰然译品</h2>
    						<ul>
    						</ul>
							
    					</div>
    				</nav>
    				<!-- /mp-menu -->

    				<div class="scroller"><!-- this is for emulating position fixed of the nav -->
    					<div class="scroller-inner">
    						<!-- Top Navigation -->
				
      				  <div>
      							<div style='width:25%;'>
      									<ul id="tree" class="ztree" style='width:100%'>
		
      									</ul>
      							</div>
      			        <div id='readme' style='width:70%;margin-left:20%;'>
      			          	<article class='markdown-body'>
      			            	#{parse_markdown}
      			          	</article>
      			        </div>
      					</div>
          			<div id="normal-button" class="settings-button">
          				<img src="toc/img/icon-cog-small.png" />
          			</div>
                
                
    					</div><!-- /scroller-inner -->
    				</div><!-- /scroller -->

    			</div><!-- /pusher -->
    		</div><!-- /container -->
				 
          
	      </body>
	    </html>
			
			<script src="toc/lib/jquery.js"></script>
			<script src="toc/lib/jquery.ztree.all-3.5.min.js"></script>
			<script src="toc/lib/modernizr.custom.js"></script>
      
			<script type="text/javascript" src="toc/js/trans.min.js"></script>
      <script type="text/javascript" src="toc/toc_conf.js"></script>	  
	  }
	
		if destiny_dir.to_s.index('/') 
			# p '1build src/' + destiny_dir.to_s.split('/')[1] + '/' + ff.gsub('.md','') + '.html'
			build_dir = 'preview/'
			
			p 'build = ' + dest_dir + '/' + ff.gsub('.md','') + '.html'
			IO.write(dest_dir +  '/'  + ff.gsub('.md','') + '.html',t) # => 10
		else
			# p '2build src/' + ff.gsub('.md','') + '.html'
			build_dir = 'preview/'  
			# write to html file
			IO.write(build_dir + '/' + ff.gsub('.md','') + '.html',t) # => 10
		end
	end
  
end  


require 'redcarpet'
require 'pygments'

require 'redcarpet'
require 'rexml/document'
module Redcarpet::Render
  class Custom < Base
    def header(title, level)
      @headers ||= []
 
      title_elements = REXML::Document.new(title)
      flattened_title = title_elements.inject('') do |flattened, element|
        flattened +=  if element.respond_to?(:text)
                        element.text
                      else
                        element.to_s
                      end
      end
      permalink = flattened_title.downcase.gsub(/[^a-z\s]/, '').gsub(/\W+/, "-")
      
      # for extra credit: implement this as its own method
      if @headers.include?(permalink)
        permalink += "_1"
         # my brain hurts
        loop do
          break if !@headers.include?(permalink)
          # generate titles like foo-bar_1, foo-bar_2
          permalink.gsub!(/\_(\d+)$/, "_#{$1.to_i + 1}")
        end
      end
      @headers << permalink
      %(\n<h#{level}><a name="#{permalink}" class="anchor" href="##{permalink}"><span class="anchor-icon"></span></a>#{title}</h#{level}>\n)
    end
  end
end

class HTMLwithPygments < Redcarpet::Render::HTML
	def doc_header()
    '<style>' + Pygments.css('.highlight',:style => 'friendly') + '</style>'
  end
	
  def block_code(code, language)
    Pygments.highlight(code, :lexer => language, :options => {:encoding => 'utf-8'})
  end
end
