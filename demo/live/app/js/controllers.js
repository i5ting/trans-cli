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
	  }
		
 
		
    $scope.config = function(){	
			var user = {'a':1,'b':3};
	    $http.post("http://127.0.0.1:3010/config",user).success(function(data, status, headers, config){
				console.log(data+'----');
	        alert("success" + data);
	    }).error(function(data, status, headers, config){
	        alert("error");
	    })
	  }
		
		$scope.classes = [
			{
				"Name": "柯织",
				"Options" : ["A" , "B", "C"]
			},
			{
				"Name": "雷朋",
				"Options" : ["A" , "B" , "C" ]
			}
		];

		$scope.SelectdCollection = {};

		$scope.submit = function() {
	     console .log($scope. SelectdCollection);
		};
		
		
	  //end
  }])
  
  .controller('MyCtrl2', ['$scope', function($scope) {

    

  }]);
