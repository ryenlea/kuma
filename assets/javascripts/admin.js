//= require jquery
//= require jquery-ujs
//= require jquery-ui
//= require underscore
//= require chosen.jquery
//= require bootstrap-datepicker
//= require bootstrap-datepicker.zh-CN
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
	var rightBoxHeight = $('#rightBox').height();
	
	$('#leftNav').height(rightBoxHeight + 40);
	$('#rightBox').width(docWidth-leftNavWidth);
	
	$(window).resize(function() {
		docWidth = $(document).width();
		
		$('#rightBox').width(docWidth-leftNavWidth);
	});
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