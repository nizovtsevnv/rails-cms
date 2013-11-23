View = {
  cache: {},

  render: function(view, params){
    var link = function(){
        var i, j, attribute, elements, value
        for(i in view){
          value = undefined
          if(view[i].css){
            document.head.appendChild(
              document.createElement('style', {innerHTML: View.cache[view[i].css]})
            )
          }else if(view[i].js){
            document.head.appendChild(
              document.createElement('script', {type: 'text/javascript', innerHTML: View.cache[view[i].js]})
            )
          }else if(view[i].element){
            elements = document.querySelectorAll(view[i].element)
            attribute = view[i].attribute || 'innerHTML'
            if(view[i].event){
              for(j = 0; j < elements.length; j++){
                elements[j].addEventListener(view[i].event, view[i].handler)
              }
            }else if(view[i].handler){
              for(j = 0; j < elements.length; j++){
                elements[j][attribute] = view[i].handler(params)
              }
            }else if(view[i].param){
              for(j = 0; j < elements.length; j++){
                elements[j][attribute] = params[view[i].param]
              }
            }else if(view[i].require){
              for(j = 0; j < elements.length; j++){
                elements[j][attribute] = View.cache[view[i].require]
              }
            }else if(view[i].value){
              for(j = 0; j < elements.length; j++){
                elements[j][attribute] = view[i].value
              }
            }
          }
        }
      },

      load_requirements = function(){
        var i, list = remaining_requirements()
        for(i = 0; i < list.length; i++){
          Xhr(list[i]).url(list[i]).fn(save_requirement).send()
        }
        return list
      },

      remaining_requirements = function(){
        var i, list = requirements(), new_list = []
        for(i = 0; i < list.length; i++){
          if(!View.cache[list[i]]){
            new_list.push(list[i])
          }
        }
        return new_list
      },

      requirements = function(){
        var i, list = []
        for(i = 0; i < view.length; i++){
          if(view[i].css){
            list.push(view[i].css)
          }else if(view[i].js){
            list.push(view[i].js)
          }else if(view[i].require){
            list.push(view[i].require)
          }
        }
        return list
      },
    
      save_requirement = function(xhr, name){
        View.cache[name] = xhr.responseText
        if(remaining_requirements().length == 0){
          link()
        }
      }

    if(load_requirements().length == 0){
      link()
    }
  }
}
