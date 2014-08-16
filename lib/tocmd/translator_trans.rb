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
      `cp -rf #{@editor_path}/toc #{dest_dir}`
      
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
      `cp -rf #{@editor_path}/toc #{dest_dir}/toc`
			
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
					<link href="toc/css/zTreeStyle/zTreeStyle.css" media="all" rel="stylesheet" type="text/css"/>
      		<link href="toc/css/bootstrap.icons.css" rel="stylesheet" />
      		<link rel="stylesheet" type="text/css" href="toc/css/normalize.css" />
      		<link rel="stylesheet" type="text/css" href="toc/css/demo.css" />
      		<link rel="stylesheet" type="text/css" href="toc/css/icons.css" />
      		<link rel="stylesheet" type="text/css" href="toc/css/component.css" />
			}
		else
			css_link =  %Q{
					<link href="toc/style/github-bf51422f4bb36427d391e4b75a1daa083c2d840e.css" media="all" rel="stylesheet" type="text/css"/>
					<link href="toc/style/github2-d731afd4f624c99a4b19ad69f3083cd6d02b81d5.css" media="all" rel="stylesheet" type="text/css"/>
					<link href="toc/css/zTreeStyle/zTreeStyle.css" media="all" rel="stylesheet" type="text/css"/>
      		<link href="toc/css/bootstrap.icons.css" rel="stylesheet" />
      		<link rel="stylesheet" type="text/css" href="toc/css/normalize.css" />
      		<link rel="stylesheet" type="text/css" href="toc/css/demo.css" />
      		<link rel="stylesheet" type="text/css" href="toc/css/icons.css" />
      		<link rel="stylesheet" type="text/css" href="toc/css/component.css" />
			}
		end
	
	  t = %Q{
	    <html>
	      <head>
				  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
	        <title>#{ff.gsub('.md','')}</title>
					#{css_link}
				  <style>
        

          .settings-button {
          	width: 36px;
          	height: 28px;
          	border-radius: 5px;
          	border: 1px solid #161615;
          	box-shadow: inset 0px 1px 3px 0px rgba(0, 0, 0, .26), 0px 1px 0px 0px rgba(255, 255, 255, .15);
          	opacity: 0.7;
          	background-color: #343433;
          	z-index: 2;
          	display: block;
          	margin: 20px 44px;
            position:fixed;
            bottom:0px;
          }

          .settings-button:hover, .pressed {
          	background-color: transparent;
          	opacity: 1;
          	cursor: pointer;
          	z-index: 2;
          }

          .settings-button img {
          	margin: 5px auto 0px auto;
          	display: block;
          	z-index: -1;
          }

          .settings-button span {
          	background: transparent url('../img/icon-cog-small.png') no-repeat top left;
          	width: 19px;
          	height: 18px;
          	display: block;
          	margin: 5px auto 0px auto;
          }
          
          
					pre {
					    counter-reset: line-numbering;
					    border: solid 1px #d9d9d9;
					    border-radius: 0;
					    background: #fff;
					    padding: 0;
					    line-height: 23px;
					    margin-bottom: 30px;
					    white-space: pre;
					    overflow-x: auto;
					    word-break: inherit;
					    word-wrap: inherit;
					}

					pre a::before {
					  content: counter(line-numbering);
					  counter-increment: line-numbering;
					  padding-right: 1em; /* space after numbers */
					  width: 25px;
					  text-align: right;
					  opacity: 0.7;
					  display: inline-block;
					  color: #aaa;
					  background: #eee;
					  margin-right: 16px;
					  padding: 2px 10px;
					  font-size: 13px;
					  -webkit-touch-callout: none;
					  -webkit-user-select: none;
					  -khtml-user-select: none;
					  -moz-user-select: none;
					  -ms-user-select: none;
					  user-select: none;
					}

					pre a:first-of-type::before {
					  padding-top: 10px;
					}

					pre a:last-of-type::before {
					  padding-bottom: 10px;
					}

					pre a:only-of-type::before {
					  padding: 10px;
					}
			
					.highlight { background-color: #ffffcc } /* RIGHT */
					</style>
	      </head>
	      <body>
    		<div class="container">
    			<!-- Push Wrapper -->
    			<div class="mp-pusher" id="mp-pusher">

    				<!-- mp-menu -->
    				<nav id="mp-menu" class="mp-menu">
    					<div class="mp-level">
    						<h2 class="icon icon-world">All Categories</h2>
    						<ul>
    							<li class="icon icon-arrow-left">
    								<a class="icon icon-display" href="#">Devices</a>
    								<div class="mp-level">
    									<h2 class="icon icon-display">Devices</h2>
    									<a class="mp-back" href="#">back</a>
    									<ul>
    										<li class="icon icon-arrow-left">
    											<a class="icon icon-phone" href="#">Mobile Phones</a>
    											<div class="mp-level">
    												<h2>Mobile Phones</h2>
    												<a class="mp-back" href="#">back</a>
    												<ul>
    													<li><a href="#">Super Smart Phone</a></li>
    													<li><a href="#">Thin Magic Mobile</a></li>
    													<li><a href="#">Performance Crusher</a></li>
    													<li><a href="#">Futuristic Experience</a></li>
    												</ul>
    											</div>
    										</li>
    										<li class="icon icon-arrow-left">
    											<a class="icon icon-tv" href="#">Televisions</a>
    											<div class="mp-level">
    												<h2>Televisions</h2>
    												<a class="mp-back" href="#">back</a>
    												<ul>
    													<li><a href="#">Flat Superscreen</a></li>
    													<li><a href="#">Gigantic LED</a></li>
    													<li><a href="#">Power Eater</a></li>
    													<li><a href="#">3D Experience</a></li>
    													<li><a href="#">Classic Comfort</a></li>
    												</ul>
    											</div>
    										</li>
    										<li class="icon icon-arrow-left">
    											<a class="icon icon-camera" href="#">Cameras</a>
    											<div class="mp-level">
    												<h2>Cameras</h2>
    												<a class="mp-back" href="#">back</a>
    												<ul>
    													<li><a href="#">Smart Shot</a></li>
    													<li><a href="#">Power Shooter</a></li>
    													<li><a href="#">Easy Photo Maker</a></li>
    													<li><a href="#">Super Pixel</a></li>
    												</ul>
    											</div>
    										</li>
    									</ul>
    								</div>
    							</li>
    							<li class="icon icon-arrow-left">
    								<a class="icon icon-news" href="#">Magazines</a>
    								<div class="mp-level">
    									<h2 class="icon icon-news">Magazines</h2>
    									<a class="mp-back" href="#">back</a>
    									<ul>
    										<li><a href="#">National Geographic</a></li>
    										<li><a href="#">Scientific American</a></li>
    										<li><a href="#">The Spectator</a></li>
    										<li><a href="#">The Rambler</a></li>
    										<li><a href="#">Physics World</a></li>
    										<li><a href="#">The New Scientist</a></li>
    									</ul>
    								</div>
    							</li>
    							<li class="icon icon-arrow-left">
    								<a class="icon icon-shop" href="#">Store</a>
    								<div class="mp-level">
    									<h2 class="icon icon-shop">Store</h2>
    									<a class="mp-back" href="#">back</a>
    									<ul>
    										<li class="icon icon-arrow-left">
    											<a class="icon icon-t-shirt" href="#">Clothes</a>
    											<div class="mp-level">
    												<h2 class="icon icon-t-shirt">Clothes</h2>
    												<a class="mp-back" href="#">back</a>
    												<ul>
    													<li class="icon icon-arrow-left">
    														<a class="icon icon-female" href="#">Women's Clothing</a>
    														<div class="mp-level">
    															<h2 class="icon icon-female">Women's Clothing</h2>
    															<a class="mp-back" href="#">back</a>
    															<ul>
    																<li><a href="#">Tops</a></li>
    																<li><a href="#">Dresses</a></li>
    																<li><a href="#">Trousers</a></li>
    																<li><a href="#">Shoes</a></li>
    																<li><a href="#">Sale</a></li>
    															</ul>
    														</div>
    													</li>
    													<li class="icon icon-arrow-left">
    														<a class="icon icon-male" href="#">Men's Clothing</a>
    														<div class="mp-level">
    															<h2 class="icon icon-male">Men's Clothing</h2>
    															<a class="mp-back" href="#">back</a>
    															<ul>
    																<li><a href="#">Shirts</a></li>
    																<li><a href="#">Trousers</a></li>
    																<li><a href="#">Shoes</a></li>
    																<li><a href="#">Sale</a></li>
    															</ul>
    														</div>
    													</li>
    												</ul>
    											</div>
    										</li>
    										<li>
    											<a class="icon icon-diamond" href="#">Jewelry</a>
    										</li>
    										<li>
    											<a class="icon icon-music" href="#">Music</a>
    										</li>
    										<li>
    											<a class="icon icon-food" href="#">Grocery</a>
    										</li>
    									</ul>
    								</div>
    							</li>
    							<li><a class="icon icon-photo" href="#">Collections</a></li>
    							<li><a class="icon icon-wallet" href="#">Credits</a></li>
    						</ul>
							
    					</div>
    				</nav>
    				<!-- /mp-menu -->

    				<div class="scroller"><!-- this is for emulating position fixed of the nav -->
    					<div class="scroller-inner">
    						<!-- Top Navigation -->
				
						 
    						<div class="content clearfix">
    							<p><a href="#" id="trigger" class="menu-trigger">Open/Close Menu</a></p>
    						</div>
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
			<script type="text/javascript" src="toc/js/jquery.js"></script>
			<script type="text/javascript" src="toc/js/jquery.ztree.all-3.5.min.js"></script>
			<script type="text/javascript" src="toc/js/ztree_toc.js"></script>
      <script type="text/javascript" src="toc/js/jquery.transtool.min.js"></script>
      <script type="text/javascript" src="toc/toc_conf.js"></script>
  		<script src="toc/js/classie.js"></script>
  		<script src="toc/js/mlpushmenu.js"></script>
  		<script src="toc/js/modernizr.custom.js"></script>
      
			<SCRIPT type="text/javascript" >
			<!--
			$(document).ready(function(){
          var css_conf = eval(markdown_panel_style);
          $('#readme').css(css_conf)
          
          var conf = eval(jquery_ztree_toc_opts);
  				$('#tree').ztree_toc(conf);
          
    			new mlPushMenu( document.getElementById( 'mp-menu' ), document.getElementById( 'trigger' ), {
    				type : 'cover'
    			} );
          
				
			});
			//-->
			</SCRIPT>
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
