$(document).ready(function(){
  $("#signupform").validate({
    rules: {
        username: 'required',
        password: {
            required: true,
            minlength: 6
        },
        retype_password: {
          required:true,
          equalTo: "#password"
        },
        email: {
            required: true,
            email: true
        }
    },
    messages: {
        password: {
            required: 'Please provide a password',
            minlength: 'Your password must be at least 6 characters long'
        },
        retype_password: 'They must be equal',
        email: 'Please enter a valid email address'
    }   
  });
});
