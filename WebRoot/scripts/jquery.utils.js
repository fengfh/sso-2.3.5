/*
 utility js to extend jquery,usage:
 
 <script src="...jquery.js"></script>
 <script src="...jquery.utils.js"></script>
*/

//extend jquery event : on enter keydown
jQuery.fn.enterkeydown = function(f){
	return this.each(function(){
		jQuery(this).keypress(function(e){
			if((e.keyCode && e.keyCode == 13) || (e.which && e.which == 13)){
				f();
				return false;
			}else{
				return true;
			}
		});
	});
};