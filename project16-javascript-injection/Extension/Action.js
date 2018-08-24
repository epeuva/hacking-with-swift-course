var Action = function() {};

Action.prototype = {
    
    run: function(parameters) {
        // JS has been preprocessed. Send data dictionary to the extension
        parameters.completionFunction({"URL": document.URL, "title": document.title });
    },
    
    finalize: function(parameters) {
    
    }
};

var ExtensionPreprocessingJS = new Action
