//= require json2
//= require jquery-1.9.0
//= require jquery-ujs
//= require bootstrap
//= require underscore
//= require chosen.jquery
//= require bootstrap-datepicker
//= require bootstrap-datepicker.zh-CN
//= require jquery.ba-resize
//= require_self
_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};
$('.datepicker').datepicker({
	language: 'zh-CN',
    format: 'yyyy-mm-dd'
});
$(".chosen-select").chosen()
$(document).ready(function(e) {
	var docHeight = $(document).height();
	var docWidth = $(document).width();
	var topBarHeight = $('#topBar').height();
	var leftNavWidth = $('#leftNav').width();
	
	
	initNav();
	
	$('#rightBox').width(docWidth-leftNavWidth);
	
	$(window).resize(function() {
		docWidth = $(document).width();
		$('#rightBox').width(docWidth-leftNavWidth);
		//console.log('resize');
	});

	$('#rightBox').resize(function() {
		initNav();
	});

	function initNav(){
		var rightBoxHeight = $('#rightBox').height();
		if((rightBoxHeight+40) < $(window).height()){
			$('#leftNav').height($(window).height());
		}else{
			$('#leftNav').height(rightBoxHeight + 40);
		};
	};
	//
	$('#menuList li').attr('class','');
	$("#"+$('#sidebar_active_flag').val() +"_sidebar").attr('class','active');
});

function add_sku(){
	var sku_id =  $('#skus .controls').size()
	var seg_template = _.template($('#add_sku_template').text());
	var seg = seg_template({sku_id: sku_id});
	$('#skus').append(seg);
}

function del_sku(sku_id){
	$('#sku'+sku_id).hide();
	$('#sku'+sku_id).append('<input id="product_product_skus_attributes_'+sku_id+'__destroy" \
								    name="product[product_skus_attributes]['+sku_id+'][_destroy]" \
									type="hidden" value="1"></input>');
}

function reserve(act_token,prod_id){
	$.get('/buy/'+act_token+'/'+prod_id+'/check',function(res_cmd){
		//not login
		if(res_cmd == '1'){
			window.location="/login"
		}else{
			$('#reserveModal').modal()
		}
	})
}
$(document).ready(function(e){
	$('#do_reserve_form')
		.bind("ajax:complete", function(jxhr,res){
			data = JSON.parse(res.responseText)
			if(data.result == 'ok'){
				alert('预定成功');
				window.location.reload();
			}else if(data.errors){
				$('#reserve_errors_id').remove();
				var seg_template = _.template($('#reserve_errors_template').text());
				var seg = seg_template({errors: data.errors});
				$('#do_reserve_div').before(seg);
			}else{
				alert('网络出错');
			}
		}).bind('ajax:before',function(){
			var reserve_number =$('#order_item_number').val();
			if(_.isNaN(Number(reserve_number)) || Number(reserve_number) <= 0){
				alert('请输入大于0整数');
				return false;
			}
			return true;
		});
		
	//backend admin
	function fill_skus_value(){
		var product_id = $('#order_item_product_id').val();
		if(product_id){
			$.get("/admin/products/"+product_id+"/skus", function(result){
				var skus = result;
				var seg_template = _.template($('#skus_select_tag_template').text());
				var seg = seg_template({skus: skus});
				//console.log(skus)
				$('#admin_order_item_product_sku_div_id').html(seg);
			},'json');
		} 
	}
	fill_skus_value();
	$('#order_item_product_id').chosen().change(
		function(){
			fill_skus_value();
		}
	);
	//
	
	//
});