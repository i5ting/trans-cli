'use strict';

/* Controllers */

angular.module('myApp.controllers', [])
  .controller('MyCtrl1', ['$scope','$http', function($scope,$http) {
	  $scope.data = {
	  	jquery_ztree_toc_opts:{
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
	  	},
			markdown_panel_style:{
		    'width':'70%',
		    'margin-left':'25%'
			},
			transtool_opts:{
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
		               
								},
		            'zh':{
									'icon':'icon-world',
									'href':'http://baidu.com',
									'target':'_blank',
									'display':"中文",
		                
		            },
		            'en':{
		                'icon':'icon-cloud',
										'display':"英文",
		                 
		            }
		        }
		    ]
			}
	  }
		
		
    $scope.config = function(){	

	    $http.post("http://127.0.0.1:3010/config",$scope.data).success(function(data, status, headers, config){
					console.log('succ = '+data+'----');
					var url = 'http://127.0.0.1:8000/';
					window.open(url);
	    }).error(function(data, status, headers, config){
	        alert("error");
	    })
	  }
		
	 
		
		
	  //end
  }])
  
  .controller('MyCtrl2', ['$scope', function($scope) {

    

  }]);
