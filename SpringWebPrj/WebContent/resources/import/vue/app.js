Vue.use(VueMaterial.default)
var vueOJ = new Vue({
	    el: '#app',
	    name: 'TableBasic',
	    data: () =>({
	        userList : [],
	        isCreateRow : false,
	        users: [
	            {
	              id: 1,
	              name: 'Shawna Dubbin',
	              email: 'sdubbin0@geocities.com',
	              gender: 'Male',
	              title: 'Assistant Media Planner'
	            },
	            {
	              id: 2,
	              name: 'Odette Demageard',
	              email: 'odemageard1@spotify.com',
	              gender: 'Female',
	              title: 'Account Coordinator'
	            },
	            {
	              id: 3,
	              name: 'Lonnie Izkovitz',
	              email: 'lizkovitz3@youtu.be',
	              gender: 'Female',
	              title: 'Operator'
	            },
	            {
	              id: 4,
	              name: 'Thatcher Stave',
	              email: 'tstave4@reference.com',
	              gender: 'Male',
	              title: 'Software Test Engineer III'
	            },
	            {
	              id: 5,
	              name: 'Clarinda Marieton',
	              email: 'cmarietonh@theatlantic.com',
	              gender: 'Female',
	              title: 'Paralegal'
	            }
	          ]
	        
	    })
	})