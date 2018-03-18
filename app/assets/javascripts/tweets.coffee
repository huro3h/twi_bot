# $(function(){
#   $(".textbox").bind("change keyup",function(){
#   var count = $(this).val().length;
#     $("#num").text(count);
#   });
# });

$ ->
  $('.textbox').bind 'change keyup', ->
    count = $(this).val().length
    $('#num').text count
    return
  return