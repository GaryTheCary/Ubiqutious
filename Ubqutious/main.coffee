Submit = new Mongo.Collection "submit"
Lyrics = new Mongo.Collection "lyricfile"	

if Meteor.isClient

	# Set a counter to set the index of the database collection

	Meteor.subscribe "submit"
	Meteor.subscribe "lyricfile"
	Router.route '/', ->
		this.render 'main'

	Template.logo.events {
		'submit form#getoptions': (e, tmpl)->
			e.preventDefault()
			data = $("#optionsavailable").val()
			e.target.optionsavailable.value = ""
			total_count = Submit.find().count()
			insertData = {index: total_count, data: data}
			Submit.insert insertData

			Meteor.call 'logo', insertData, (err)->
				if err 
					alert "Something goes wrong :("
				else
					alert "Your Message: " + data + " Sent Successfully!"
	}

	Template.music_steaming.events {
		'click #play': ->
			console.log "play"
			document.getElementById("taylor").play()
		'click #pause': ->
			console.log "pause"
			document.getElementById("taylor").pause()
		'click #stop': ->
			console.log "stop"
			obj = document.getElementById("taylor")
			obj.pause()
			obj.currentTime = 0

	}

	Template.music_steaming.rendered =->
		# Get obj from audio
		val = {}
		Meteor.lrc.loadlrc("/assets/timeline.lrc", val)
		m_lrc = Session.get 'val'
		obj = document.getElementById("taylor")
		Meteor.setInterval ->
			time = obj.currentTime
			time = Math.round((time*100)/100) 
			if time != 0
				temp = m_lrc[time]
				if temp? and temp != ""
					words = temp.split(" ")
					for word in words
						Meteor.emotion_judge.strJudge(word, Submit, Lyrics)
					# console.log temp
		, 1000	



if Meteor.isServer

	Meteor.startup(->
		console.log 'server started'
	)

	Meteor.publish "submit", -> Submit.find {}
	Meteor.publish "lyricfile", -> Lyrics.find {}
	prev = Submit.find().count()
	Meteor.setInterval ->
		current = Submit.find().count()
		if current != prev
			console.log "New data insert"
			prev = current
	, 5000		

	Meteor.methods {
		logo: (insertData)->
			unless insertData.data? then throw new Meteor.Error('Empty') 
	}

	# Route on server to update data

	Router.route '/data', (->
		req = @request
		res = @response
		res.setHeader 'access-control-allow-origin', '*'
		Meteor.setInterval ->
			num = Submit.find().count()
			if num != 0
				index = (num - 1)
				root = Submit.findOne {index: index}
				if root?
					res.statusCode = 200
					res.write root.data
				else
					res.statusCode = 404
					res.end {status: "404", message: "Data not found"}
		, 1000				 

	), {where: 'server'}

	Router.route '/mdata', (->
		req = @request
		res = @response
		res.setHeader 'access-control-allow-origin', '*'

		Meteor.setInterval ->
			num = Lyrics.find().count()
			if num != 0
			  index = (num - 1)
			  root = Lyrics.findOne {index: index}
			  if root?
			    res.statusCode = 200
			    res.write root.data
			  else
			  	res.statusCode = 404
			  	res.end {status: "404", message: "Data not found"}  
		, 1000	

	), {where: 'server'}


