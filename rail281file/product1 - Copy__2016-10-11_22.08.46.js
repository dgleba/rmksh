$(function() {

  // $('#product_type_name').bind('railsAutocomplete.select' , function(event, data){
  
    //  alert(data.item.id);

    // $(this).change (function(data){
        // if (!data.item) {
            // this.value = '';
            // console.log(data.item);
            // }
    // });   
    // console.log ("past change.. 1011");
  // });
  
  
  // run when eventlistener is triggered
  // http://stackoverflow.com/questions/6431459/jquery-autocomplete-trigger-change-event
  //
  $("#product_type_name").on( "autocompletechange", function(event,data) {
     // post value to console for validation
     console.log("Item is: ", $(this).val());
    // if item in box is on in the list of suggestions, it will be cleared out. The user must select an item.
    if (!data.item) {
        this.value = '';
        console.log('> Item selected is:', data.item);
        }
        
    });   
    console.log ("msg.. 1012")  
     
});



