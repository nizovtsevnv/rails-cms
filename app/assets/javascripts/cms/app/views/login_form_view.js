/* Properties:
 * - element
 *  - event + handler = set handler to event on element
 *  - [attribute] + handler / param / require / value = set innerHTML (attribute by default) of element with selected value
 * - css = load stylesheet to head
 * - js = load javascript to head
 */
 
LoginFormView = [
  {element: 'body', require: '/cms/login_form'},
  {element: '#submit', event: 'click', handler: function(){}}
]
