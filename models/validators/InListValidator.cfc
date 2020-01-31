/**
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
This validator validates if an incoming value exists in a certain list
*/
component accessors="true" implements="cbvalidation.models.validators.IValidator" singleton {

	property name="name";

	/**
	 * Constructor
	 */
	InListValidator function init(){
		variables.name = "InList";
		return this;
	}

	/**
	 * Will check if an incoming value validates
	 * @validationResultThe result object of the validation
	 * @targetThe target object to validate on
	 * @fieldThe field on the target object to validate on
	 * @targetValueThe target value to validate
	 * @validationDataThe validation data the validator was created with
	 */
	boolean function validate(
		required cbvalidation.models.result.IValidationResult validationResult,
		required any target,
		required string field,
		any targetValue,
		any validationData
	){
		// return true if no data to check, type needs a data element to be checked.
		if ( isNull( arguments.targetValue ) || ( isSimpleValue( arguments.targetValue ) && !len( arguments.targetValue ) ) ) {
			return true;
		}

		// Now check
		if ( listFindNoCase( arguments.validationData, arguments.targetValue ) ) {
			return true;
		}

		var args = {
			message        : "The '#arguments.field#' value is not in the constraint list: #arguments.validationData#",
			field          : arguments.field,
			validationType : getName(),
			rejectedValue  : ( isSimpleValue( arguments.targetValue ) ? arguments.targetValue : "" ),
			validationData : arguments.validationData
		};

		var error = validationResult.newError( argumentCollection = args ).setErrorMetadata( { "inlist" : arguments.validationData } );

		validationResult.addError( error );
		return false;
	}

	/**
	 * Get the name of the validator
	 */
	string function getName(){
		return variables.name;
	}

}
