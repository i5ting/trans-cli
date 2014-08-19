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
							'icon':'icon-edit',
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