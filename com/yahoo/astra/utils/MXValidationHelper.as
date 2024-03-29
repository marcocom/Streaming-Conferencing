/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.astra.utils {
	import mx.validators.CreditCardValidator;
	import mx.validators.CurrencyValidator;
	import mx.validators.DateValidator;
	import mx.validators.EmailValidator;
	import mx.validators.NumberValidator;
	import mx.validators.PhoneNumberValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	import mx.validators.ZipCodeValidator;
	import mx.validators.ZipCodeValidatorDomainType;	
	/**
	 * A helper class to be used associated with <code>MX.validators</code> classes.
	 * <code>MX.validators</code> provides a variety of validation types and detailed error messages.
	 * You can edit the default error types and messages as needed.
	 * However, the use of the MXvalidator will increase your overall file size by approximately 20K.
	 * 
	 * Currently credit card, regExp and social security validations are not providing, but can be added as needed.
	 * 
	 *  @example The following code shows a use of <code>MXValidationHelper</code>:
	 *	<listing version="3.0">
	 *	import com.yahoo.astra.utils.MXValidationHelper;  
	 *     
	 *	myForm.formDataManager = new FormDataManager(FlValueParser); ;  
	 *	var validator : MXValidationHelper = new MXValidationHelper();  
	 *	formDataManager.dataSource = [
	 *	{id:"firstname", source:this["firstNameInput"], validator:validator.validateString, validatorExtraParam:[null, ["tooShortError","Hmmm, please enter your name."]],required:true, eventTargetObj:this["fistName_result"]},
	 *	{id:"zipcode", source:this["zipcodeInput"], validator:validator.validateZipCode,required:true, eventTargetObj:this["zip_result"]},
	 *	{id:"email", source:this["emailInput"], validator:validator.validateEmail,required:true },
	 *	{id:"delivery", source:this["deliveryInput"], validator:validator.validateNumber, validatorExtraParam:[null, ["minValue",1], ["maxValue",20]], required:true },
	 *	{id:"message", source:this["messageInput"], validator:validator.validateString, required:true },
	 *	];
	 *  </listing>
	 * 
	 * @see com.yahoo.astra.managers.FormDataManager
	 * @see http://livedocs.adobe.com/flex/3/langref/mx/validators/Validator.html
	 * 
	 * @author kayoh
	 */
	public class MXValidationHelper extends Object {
		/**
		 * Validate email value. Returning an array of error messages or empty array if there is no error.
		 * 
		 * @param str String to validate. 
		 * @param baseField String Text representation of the subfield specified in the value parameter.
		 * @param args Array parameter array of <code>validator</code>'s property.
		 */
		public function validateEmail(value : Object, baseField : String = null , ...args) : Array {
			var emailValidator : EmailValidator = new EmailValidator();
			emailValidator.invalidCharError = "The email address contains invalid input." ;
			emailValidator.invalidDomainError = "The server domain in your email address has an invalid format." ;
			emailValidator.invalidIPDomainError = "The email address contains an IP domain with an invalid format." ;
			emailValidator.invalidPeriodsInDomainError = "There are too many periods in the domain name in your email address." ;
			emailValidator.missingAtSignError = "Your email address is missing an 'at' sign. " ;
			emailValidator.missingPeriodInDomainError = "The server domain in the email address is missing a period." ;
			emailValidator.missingUsernameError = "There are no characters before the 'at' sign in your email address." ;
			emailValidator.tooManyAtSignsError = "Your email address contains more than one 'at' sign.";
			
			var argLeng : int = args.length;
			for (var i : int = 0;i < argLeng; i++) {
				emailValidator[args[i][0]] = args[i][1];
			}
			
			return EmailValidator.validateEmail(emailValidator, value, baseField);
		}
		/**
		 * Validate string value. Returning an array of error messages or empty array if there is no error.
		 * 
		 * @param str String to validate. 		 
		 * @param baseField Text representation of the subfield
		 *  specified in the value parameter.
		 * @param args Object Array to override validator method. 
		 */
		public function validateString(value : Object, baseField : String = null , ...args) : Array {
			var stringValidator : StringValidator = new StringValidator();
			stringValidator.minLength = 1;
			stringValidator.maxLength = NaN;
			stringValidator.tooShortError = "This input must have at least " + stringValidator.minLength + " characters." ;
			stringValidator.tooLongError = "This String is longer than the  " + stringValidator.maxLength + "  allowed length." ;
			
			var argLeng : int = args.length;
			for (var i : int = 0;i < argLeng; i++) {
				stringValidator[args[i][0]] = args[i][1];
			}
					
			return StringValidator.validateString(stringValidator, value, baseField);
		}
		/**
		 * Validate zipcode value. Returning an array of error messages or empty array if there is no error.
		 * 
		 * @param str String to validate. 	
		 * @param baseField Text representation of the subfield specified in the value parameter. 		 
		 * @param args Object Array to override validator method. 
		 */
		public function validateZipCode(value : Object, baseField : String = null , ...args) : Array {
			var zipCodeValidator : ZipCodeValidator = new ZipCodeValidator();
			zipCodeValidator.domain = ZipCodeValidatorDomainType.US_OR_CANADA;
			zipCodeValidator.allowedFormatChars = "/\-. " ;
			zipCodeValidator.wrongLengthError = "Provide the date as specified by inputFormat.";
			zipCodeValidator.invalidCharError = "The ZIP code has an invalid input." ;
			zipCodeValidator.invalidDomainError = "The domain parameter is incorrect. It has to be set to 'US Only' or 'US or Canada'." ;
			zipCodeValidator.wrongCAFormatError = "The Canadian ZIP code needs to be in the form 'A0A 0A0'." ;
			zipCodeValidator.wrongLengthError = "The ZIP code must consist either of 5 digits or 5+4 digits." ;
			zipCodeValidator.wrongUSFormatError = "The ZIP+4 input must be in the form '12345-6789'." ;
			
			var argLeng : int = args.length;
			for (var i : int = 0;i < argLeng; i++) {
				zipCodeValidator[args[i][0]] = args[i][1];
			}
			
			return ZipCodeValidator.validateZipCode(zipCodeValidator, value, baseField);
		}
		/**
		 * Validate number value. Returning an array of error messages or empty array if there is no error.
		 * 
		 * @param str String to validate. 		
		 * @param baseField Text representation of the subfield specified in the value parameter.
		 * @param args Object Array to override validator method. 
		 */
		public function validateNumber(value : Object, baseField : String = null, ...args) : Array {
			var numberValidator : NumberValidator = new NumberValidator();
			numberValidator.allowNegative = "true";
			numberValidator.decimalPointCountError = "There cannot be more than one decimal separator.";
			numberValidator.decimalSeparator = ".";
			numberValidator.domain = "real"; 
			numberValidator.exceedsMaxError = "The number provided exceeds maximum possible value.";
			numberValidator.integerError = "The number needs to be an integer.";
			numberValidator.invalidCharError = "Some of the characters in the input are invalid.";
			numberValidator.invalidFormatCharsError = "One of the format settings is incorrect.";
			numberValidator.lowerThanMinError = "The quantity entered is less than minimum.";
			numberValidator.maxValue = "NaN";
			numberValidator.minValue = "NaN";
			numberValidator.negativeError = "The amount cannot be less than 0.";
			numberValidator.precision = "-1";
			numberValidator.precisionError = "The amount contains too many digits after the decimal separator.";
			numberValidator.separationError = "The thousands separator must have exactly three digits after it.";
			numberValidator.thousandsSeparator = ",";
			var argLeng : int = args.length;
			for (var i : int = 0;i < argLeng; i++) {
				numberValidator[args[i][0]] = args[i][1];
			}
			return NumberValidator.validateNumber(numberValidator, value, baseField);
		}
		/**
		 * Validate currency value. Returning an array of error messages or empty array if there is no error.
		 * @param str String to validate. 
		 * @param baseField Text representation of the subfield specified in the value parameter.
		 * @param args Object Array to override validator method. 
		 */
		public function validateCurrency(value : Object, baseField : String = null , ...args) : Array {
			var currencyValidator : CurrencyValidator = new CurrencyValidator();
			currencyValidator.alignSymbol = "left";
			currencyValidator.allowNegative = "true";
			currencyValidator.currencySymbol = "$";
			currencyValidator.currencySymbolError = "The currency sign appears in an incorrect position.";
			currencyValidator.decimalPointCountError = "There cannot be more than one decimal separator.";
			currencyValidator.decimalSeparator = ".";
			currencyValidator.exceedsMaxError = "The amount provided exceeds maximum value.";
			currencyValidator.invalidCharError = "There are invalid characters in the input.";
			currencyValidator.invalidFormatCharsError = "One of the format settings is incorrect.";
			currencyValidator.lowerThanMinError = "The quantity entered is less than minimum.";
			currencyValidator.maxValue = "NaN";
			currencyValidator.minValue = "NaN";
			currencyValidator.negativeError = "The amount cannot be less than 0.";
			currencyValidator.precision = "2";
			currencyValidator.precisionError = "The amount contains too many digits after the decimal separator.";
			currencyValidator.separationError = "The thousands separator must have exactly three digits after it.";
			currencyValidator.thousandsSeparator = ",";
			
			var argLeng : int = args.length;
			for (var i : int = 0;i < argLeng; i++) {
				currencyValidator[args[i][0]] = args[i][1];
			}
			
			return CurrencyValidator.validateCurrency(currencyValidator, value, baseField);
		}
		/**
		 * Validate date value. Returning an array of error messages or empty array if there is no error.
		 * 
		 * @param str String to validate. 
		 * @param baseField Text representation of the subfield specified in the value parameter.
		 * @param args Object Array to override validator method. 
		 */ 
		public function validateDate(value : Object, baseField : String = null , ...args) : Array {
			var dateValidator : DateValidator = new DateValidator();
			dateValidator.allowedFormatChars = "/\-. ";
			dateValidator.formatError = "Configuration error: Invalid formatting string.";
			dateValidator.inputFormat = "MM/DD/YYYY";
			dateValidator.invalidCharError = "There are invalid characters in the date.";
			dateValidator.validateAsString = "true";
			dateValidator.wrongDayError = "Provide a correct day for the month.";
			dateValidator.wrongLengthError = "Provide the date as specified by inputFormat.";
			dateValidator.wrongMonthError = "Provide a month value between 1 and 12.";
			dateValidator.wrongYearError = "Provide a year value between 0 and 9999.";
			
			var argLeng : int = args.length;
			for (var i : int = 0;i < argLeng; i++) {
				dateValidator[args[i][0]] = args[i][1];
			}
			
			return DateValidator.validateDate(dateValidator, value, baseField);
		}
		/**
		 * Validate phone number value. Returning an array of error messages or empty array if there is no error.
		 * @param str String to validate. 
		 * @param baseField Text representation of the subfield specified in the value parameter.
		 * @param args Object Array to override validator method. 
		 */
		public function validatePhoneNumber(value : Object, baseField : String = null , ...args) : Array {
			var phoneNumberValidator : PhoneNumberValidator = new PhoneNumberValidator();
			phoneNumberValidator.allowedFormatChars = "()- .+";
			phoneNumberValidator.invalidCharError = "There are invalid characters in the phone number.";
			phoneNumberValidator.wrongLengthError = "The phone number must consist of at least 10 digits.";
			
			var argLeng : int = args.length;
			for (var i : int = 0;i < argLeng; i++) {
				phoneNumberValidator[args[i][0]] = args[i][1];
			}
			
			return PhoneNumberValidator.validatePhoneNumber(phoneNumberValidator, value, baseField);
		}
	}
}
