'use strict';

/* Controllers */

angular.module('myApp.controllers', [])
  .controller('MyCtrl1', ['$scope', function($scope) {
	  $scope.data = [{
		  id: 1,
		  content: '请选择你的职业',
		  options: [{
		  	  title: 'A: 软件工程师',
			  weight: 0.1
		  },{
			  title:'B: 公务员',
  			  weight: 0.2
		  },{
			  title:'C: 销售管理人员',
  			  weight: 0.3
		  }]
	  },{
		  id: 2,
		  content: '请选择你的爱好',
		  options: [{
		  	  title: 'A: 抽烟',
			  weight: 0.4
		  },{
			  title:'B: 喝酒',
  			  weight: 0.5
		  },{
			  title:'C: 烫头',
  			  weight: 0.6
		  }]
	  },{
		  id: 3,
		  content: '请选择你的休息时间',
		  options: [{
		  	  title: 'A: 6小时以内',
			  weight: 0.3
		  },{
			  title:'B: 6到8个小时',
  			  weight: 0.3
		  },{
			  title:'C: 10个小时以上',
  			  weight: 0.7
		  }]
	  }];
	  
	  
	  $scope.show = function(index){
		  alert(index.options);
	  }
	  
	  $scope.all_count = 100;
	  
	  $scope.submit = function(){
		  var count = 0.0;
		  
		  angular.forEach($scope.data, function(obj, key) {
			  console.log(key + ': ' + obj);
			  
			  var item_count = 0;
			  for(var i = 0;i < obj.options.length; i++){
				  var opt = obj.options[i];
				  
				  if(opt.result == true){
					  item_count += $scope.all_count * opt.weight 
					  console.log(obj.content + ' item_count :=	 ' + item_count);
				  }
			  }
			  
			  count += item_count;
		  });
		  
		  $scope.user_custom_count = count;
	  }
	  
	  $scope.change = function(opt){
		  console.log(opt);
		  $scope.submit();
	  }
	  //end
  }])
  
  .controller('MyCtrl2', ['$scope', function($scope) {

  }]);
