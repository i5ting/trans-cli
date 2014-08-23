var jquery_ztree_toc_opts = {
    debug:false,
    scroll_selector: '.scroller',
    is_auto_number:true,
		highlight_on_scroll:true,
    documment_selector:'.markdown-body',
    ztreeStyle: {
        width:'320px',
        overflow: 'auto',
        position: 'fixed',
        'z-index': 1,
        border: '0px none',
        left: '0px',
        top: '0px',
				// 'overflow-x': 'hidden',
				'height': $(window).height() + 'px'
    }
}

var markdown_panel_style = {
    'width':'70%',
    'margin-left':'25%'
};

var transtool_opts = {
		toolbarselector:"#mp-menu",
		mp_title:"技术文档",
		default_state:'all',
		menu_container_selector:'#mp-menu',
		menu_trigger_selector:'#normal-button',
    states:[
        {
						'all':{
              'icon':'icon-shop',
							'display':"全部",
              click:function(){
                  alert('zh111');
              }
						},
            'zh':{
							'icon':'icon-world',
							'href':'http://baidu.com',
							'target':'_blank',
							'display':"中文",
               click:function(){
                   alert('zh111');
               }
            },
            'en':{
                'icon':'icon-cloud',
								'display':"英文",
                click:function(){
                    alert('en');
                }
            }
        }
    ]
}



/**
 * main方法
 */ 
$(document).ready(function(){
    var css_conf = eval(markdown_panel_style);
    $('#readme').css(css_conf)
    
    var conf = eval(jquery_ztree_toc_opts);
		$('#tree').ztree_toc(conf);
    
	
		var transtool_opts_conf = eval(transtool_opts);
		$.transtool(transtool_opts_conf);
		
		// $('#tree').hide()
});
