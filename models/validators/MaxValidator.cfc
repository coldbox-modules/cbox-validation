/**
 * Copyright since 2020 by Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * This validator validates if a value is is less than a maximum number
 */
component
	extends  ="BaseValidator"
	accessors="true"
	singleton
{

	/**
	 * Constructor
	 */
	MaxValidator function init(){
		variables.name = "Max";
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
		required any validationResult,
		required any target,
		required string field,
		any targetValue,
		any validationData
	){
		// return true if no data to check, type needs a data element to be checked.
		if ( isNullOrEmpty( arguments.targetValue ) ) {
			return true;
		}

		// Max Tests
		if ( arguments.targetValue <= arguments.validationData ) {
			return true;
		}

		var args = {
			message        : "The '#arguments.field#' value is not less than or equal to #arguments.validationData#",
			field          : arguments.field,
			validationType : getName(),
			rejectedValue  : ( isSimpleValue( arguments.targetValue ) ? arguments.targetValue : "" ),
			validationData : arguments.validationData
		};
		var error = validationResult
			.newError( argumentCollection = args )
			.setErrorMetadata( { "max" : arguments.validationData } );
		validationResult.addError( error );
		return false;
	}

}
