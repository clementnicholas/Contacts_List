$(function() {
  var createButton = $("<button>").attr("id", "create").text("CREATE CONTACT");
  var contactListDiv = $("<div>").attr("id", "contactListDiv");
  $('body').append(contactListDiv);
  $('<h1>').text('Contact List').appendTo(contactListDiv);
  $('<table>').attr("id", "contactListTable").appendTo(contactListDiv);
  var tableHeader = $('<tr>').appendTo('#contactListTable');
  $('<th>').text('NAME').appendTo(tableHeader);
  $('<th>').text('EMAIL').appendTo(tableHeader);
  $('<th>').text('DELETE').appendTo(tableHeader);
  $('<th>').text('EDIT').appendTo(tableHeader);
  $(createButton).appendTo(contactListDiv);
  var formDiv = $("<div>").attr('class', 'formDiv').appendTo(contactListDiv);


  $.ajax({
    url: '/contacts',
    method: 'get',
    dataType: 'json',
    success: populateContactList
  });

  function populateContactList(contacts) {
    contacts.forEach(addContactToList);
  }

  function addContactToList(contact) {
    var contactRow = $('<tr>').data('id', contact.id).attr('id', 'contact' + contact.id).appendTo('#contactListTable');
    $('<td>').text(contact.firstname + ' ' + contact.lastname).attr('class','name').appendTo(contactRow); 
    $('<td>').text(contact.email).attr('class', 'email').appendTo(contactRow);
    $('<td>').html('<button class="delete">').appendTo(contactRow);
    $('.delete').html('&times;');
    $('<td>').html('<button class="edit">').appendTo(contactRow);
    $('.edit').html('EDIT CONTACT');
  }

  var newContactForm = $("<form method='post' action='/contacts'>").attr('class', 'create');
  $('<label>').text('First Name: ').appendTo(newContactForm);
  $('<input>').attr({type:'text', name:'firstname'}).appendTo(newContactForm);
  $('<label>').text('Last Name: ').appendTo(newContactForm);
  $('<input>').attr({type:'text', name:'lastname'}).appendTo(newContactForm);
  $('<label>').text('Email: ').appendTo(newContactForm);
  $('<input>').attr({type:'text', name:'email'}).appendTo(newContactForm);
  $('<button>').attr('type', 'submit').text('Submit').appendTo(newContactForm);
  var formDiv = $("<div>").attr('class', 'formDiv').appendTo(contactListDiv);
  $(newContactForm).appendTo(formDiv).hide();
  

  var editContactForm = $("<form method='put'>").attr('class', 'edit');
  function buildEditContactForm(contact) { 
    $('<label>').text('First Name: ').appendTo(editContactForm);
    $('<input>').attr({type:'text', name:'firstname', value: contact.firstname}).appendTo(editContactForm);
    $('<label>').text('Last Name: ').appendTo(editContactForm);
    $('<input>').attr({type:'text', name:'lastname', value: contact.lastname}).appendTo(editContactForm);
    $('<label>').text('Email: ').appendTo(editContactForm);
    $('<input>').attr({type:'text', name:'email', value: contact.email}).appendTo(editContactForm);
    $('<input>').attr({type:'hidden', name:'id', value: contact.id}).appendTo(editContactForm);
    $('<button>').data('id', contact.id).attr({type: 'submit', class: 'submit'}).text('Submit').appendTo(editContactForm);
    console.log(contact.id);
    $(formDiv).html(editContactForm);
  }

  $('#contactListTable').on('click', 'button.edit', function() {
    var listItem = $(this).closest('tr');
    var id = listItem.data('id');
    $.ajax({
      method: 'get',
      url: '/contacts/' + id,
      dataType: 'json',
      success: buildEditContactForm
    });
  });

  editContactForm.on('click' , 'button.submit', function() {
    var id = $(this).data('id');
    $.ajax({
      url: '/contacts/' + id,
      method: editContactForm.attr('method'),
      data: editContactForm.serialize(),
      success: function(response) {
        console.log(response);
      }
    })
    .done(editContactInList)
    .done(function() {
      $(editContactForm).empty();
    });
    return false;
  });

  function editContactInList(contact) {
    var contactRow = $('<tr>').data('id', contact.id).attr('id', 'contact' + contact.id);
    $('<td>').text(contact.firstname + ' ' + contact.lastname).attr('class','name').appendTo(contactRow); 
    $('<td>').text(contact.email).attr('class', 'email').appendTo(contactRow);
    $('<td>').html('<button class="delete">&times;</button>').appendTo(contactRow);
    $('<td>').html('<button class="edit">EDIT CONTACT</button>').appendTo(contactRow);
    var oldRow = $('#contact' + contact.id);
    console.log(oldRow);
    console.log(contactRow);
    $(oldRow).replaceWith(contactRow);
  }


  createButton.on('click' , function() {
    $(newContactForm).toggle();
  });

  newContactForm.on('submit', function() {
    $.ajax({
      url: newContactForm.attr('action'),
      method: newContactForm.attr('method'),
      data: newContactForm.serialize(),
    })
    .done(addContactToList)
    .done(function() {
      newContactForm[0].reset();
    });
    return false;
  });

  $('#contactListTable').on('click', 'button.delete', function() {
    var contactListItem = $(this).closest('tr');
    var id = contactListItem.data('id');
    $.ajax({
      method: 'delete',
      url: 'contacts/' + id,
      success: function() {
        contactListItem.remove();
      }
    });
  });


  

});
