$('#type_name').bind('railsAutocomplete.select', function(event, data){
  
  focus: function(e, ui) {
      return false;
  }
});