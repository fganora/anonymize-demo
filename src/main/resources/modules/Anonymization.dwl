%dw 2.0

fun doAnonymize (inVal, anonymizedValue, fieldsToAnonymize ,applyAnonymizedValue ) =
    inVal match {
        case is Array -> (inVal map (value,index) -> doAnonymize(value, anonymizedValue, fieldsToAnonymize, applyAnonymizedValue))
        case is Object -> inVal mapObject (objValue,objKey) -> {

             (objKey) : if (fieldsToAnonymize contains objKey as String) 
             	doAnonymize (objValue, anonymizedValue, fieldsToAnonymize, true) 
             else 
           	    doAnonymize (objValue, anonymizedValue, fieldsToAnonymize, false)
		 
        }
        case is String -> if (applyAnonymizedValue) anonymizedValue else inVal
        else -> inVal
    }

fun anonymize (inVal, anonymizedValue, fieldsToAnonymize) = doAnonymize (inVal, anonymizedValue, fieldsToAnonymize, false )
