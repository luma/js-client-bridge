= js-client-bridge

* https://github.com/luma/js-client-bridge/tree/master

== DESCRIPTION:

Little library that encapsulates a (particular) standardised way of talking between a service and javascript. Probably not the best way of doing things, but it's been handy in a pinch.

== FEATURES/PROBLEMS:

* TODO

== SYNOPSIS:

=== Standard and Custom Fields ===
Any fields that begin with a '_' are standard fields that will be used among all the different response types. These fields are quite often required or will have specific set behavior that the client side is expected to follow. Any fields that don't begin with '_' are custom fields and the client side can use them (or not) however they want.

=== Use of JSON With Padding (JSONP) ===
We support JSONP (see [http://bob.pythonmac.org/archives/2005/12/05/remote-json-jsonp/ Here] for an introduction to JSONP). Meaning that, rather than the standard JSON responses below:

	{
		_status  : 'ok',
		_message : 'a status message'
	} 


A service may be required to return a response of the form:

	jsonp_identifier_12321({
		_status  : 'ok',
		_message : 'a status message'
	} )


Whether JSONP is used for a response or not is decided by the calling client and services should support either response format.


=== Everything's Cool Response ===
This is returned when a remote call succeeds, it must include the status of 'ok'. It can optionally include a message, if a message is included it should be displayed to the user.


==== Required Fields ====
{| border="1" cellpadding="5" cellspacing="0"
|-
|Name || Type || Description
|-
|'''_status'''
|String
|This will always be 'ok'.
|}


==== Optional Fields ====
{| border="1" cellpadding="5" cellspacing="0"
|-
|Name || Type || Description
|-
|'''_message'''
|String
|If sent from server-side client side should display it.
|}


==== Example ====
<source lang="javascript">
{
	_status  : 'ok',
	_message : 'a status message'
} 
</source>


=== A General Error Occurred ===
This is returned when a remote call fails with a general error, where in this case general error means we want to display feedback to the user but we want to leave any further action up to the client side. It can optionally include a message, if a message is included it should be displayed to the user.


==== Required Fields ====
{| border="1" cellpadding="5" cellspacing="0"
|-
|Name || Type || Description
|-
|'''_status'''
|String
|This will always be 'error'.
|}


==== Optional Fields ====
{| border="1" cellpadding="5" cellspacing="0"
|-
|Name || Type || Description
|-
|'''_message'''
|String
|If sent from server-side client side should display it.
|}


==== Example ====
<source lang="javascript">
{
	_status	: 'error',
	_message	: 'asdfasfasd'
}
</source>


=== An Unexpected Exception Occurred ===
This is returned when something explodes on the server side. These errors are assumed to be unhandlable on the client side (due to the absurdly large number of possible errors). The client side should take the error info and display it to the user in a standard format. During development or testing this should include displaying all the information on the screen. What happens in production is an open question.


==== Required Fields ====

{| border="1" cellpadding="5" cellspacing="0"
|-
|Name || Type || Description
|-
|'''_status'''
|String
|This will always be 'exception'.
|-
|'''_type'''
|String
|This will be the fully namespaced name of the exception.
|-
|'''_short_type'''
|String
|This will be the short, easily readable version of _type.
|-
|'''request_uri'''
|String
|The uri of the original request that triggered this exception.
|-
|'''parameters'''
|Hash
|A hash of key/value pairs representing the query string or POSTed data. If there are none, an empty hash ({}) should be used.
|-
|}


==== Optional Fields ====
{| border="1" cellpadding="5" cellspacing="0"
|-
|Name || Type || Description
|-
|'''_message'''
|String
|If sent from server-side client side should display it.
|}


==== Example ====
<source lang="javascript">
{
  _status            : "exception",
  _type             : "Merb::Controller::Exceptions::InternalServerError",
  _short_type  : "InternalServerError",
  request_uri   : '/asdf,
  parameters    : {name : value, name : value, name : value},
  exceptions    : [
    {
      name     : 'Twimmy::Exceptions::ServerError',
      message  : 'A awful error occured',
      backtrace : [
        "file:line",
        "file:line",
        "file:line",
        "file:line"
      ]
  ]
}
</source>


==== Open Questions ====
* How should exceptions be handled in production


=== Validation for the Request Failed ===
This response is returned when server side validation of an object failed, it should include enough information to display dynamic validation messages and highlight/animate input fields. It is suggested that to make this work seamlessly there must be some way to map html field ids to attribute names in a way that won't clash. One way that is quite efficient is to use form element ids of the form:
  '''short_object_type-object_id-attribute_name'''

Or if the object is not yet created and doesn't have an id:
  '''short_object_type-attribute_name'''

For example, if we were calling a remote service to update an Offer with the id of 1, and validation failed on the bid_amount field then the attribute mapping would be:
  '''offer-1-bid_amount'''


==== Example ====
The advantage of this scheme is that dynamic validation UI bits can be applied to a client side form using something like the following (this is pseudo code, it's untested):

<source lang="javascript">
var response = get_response_from_server_side();

jQuery.each(response.validation, function(field_name, errors) {
  var field_id = [response._short_type, response.id, field_name].join('-');
  $('#' + field_id).highlight().shake().addClass('error').after("<strong class='form-error'>" + errors.join(', ') + "</strong>");
});
</source>

==== Required Fields ====

{| border="1" cellpadding="5" cellspacing="0"
|-
|Name || Type || Description
|-
|'''_status'''
|String
|This will always be 'exception'.
|-
|'''_type'''
|String
|This will be the fully namespaced name of the exception.
|-
|'''_short_type'''
|String
|This will be the short, easily readable version of _type.
|-
|'''validation'''
|Hash
|The keys of the hash are the field name on which the error occured. these should has no spaces. The values are arrays of strings, where each string is an error message.
|-
|}


=== Optional Fields ===
{| border="1" cellpadding="5" cellspacing="0"
|-
|Name || Type || Description
|-
|'''_message'''
|String
|If sent from server-side client side should display it.
|-
|'''id'''
|String
|The server side id of the object.
|}


=== Example ===
<source lang="javascript">
{
 "_status"          => "validation",
 "_type"             => "Twimmy::Test::TestDO",
 "_short_type"  => "TestDO",
 "_message"     => "Sorry, we couldn't save your TestDO",
 "action"            => "create",
  "validation"  : {
                    "body"     :  ["Body must not be blank"],
                    "subject" :  ["Subject must not be blank", "Subject must be between 30 and 155 characters long"],
                    "id"          :  ["Id must not be blank"]
   },
} 
</source>

== REQUIREMENTS:

* json gem
* extlib gem

== INSTALL:

* FIX (sudo gem install, anything else)
* git clone

== LICENSE:

(The MIT License)

Copyright (c) 2009 Rolly

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.