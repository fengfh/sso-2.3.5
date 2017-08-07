    function HttpLcAgentFieldSet() {
        this.field_names = new Array();
        this.field_values = new Array();
    }

    HttpLcAgentFieldSet.prototype.addField = function (name, value) {
        this.field_names.push(name);
        this.field_values.push(value);
    }

    HttpLcAgentFieldSet.prototype.getCount = function () {
        return this.field_names.length;
    }


    function sendHttpLcAgentData(url, data)
    {
        if (typeof data != "object")
            return;
        
        var LC_post_frame =null;
        try{   
            var LC_post_frame = document.createElement("<iframe id='PostLocalFrame' name='PostLocalFrame'></iframe>");   
        }catch(e){  
        	var LC_post_frame = document.createElement('iframe');   
            LC_post_frame.name = 'PostLocalFrame';   
         }  
        LC_post_frame.width = "10px";
        LC_post_frame.height = "10px";
        LC_post_frame.style.display = "none";
        document.body.appendChild(LC_post_frame);

        var postForm = document.createElement("form");
        postForm.method = "POST";
        postForm.action = url;
        postForm.target ="PostLocalFrame";

        for (i = 0; i < data.getCount() ; i++) {
            var inputItem = document.createElement("input");
            inputItem.setAttribute("name", data.field_names[i]);
            inputItem.setAttribute("value", data.field_values[i]);
            postForm.appendChild(inputItem);
        }

        //LC_post_frame.contentWindow.document.write("<!DOCTYPE html><html><head></head><body></body></html>");
        //LC_post_frame.contentWindow.document.body.appendChild(postForm);
        //document.body.appendChild(postForm);
        postForm.submit();


    }