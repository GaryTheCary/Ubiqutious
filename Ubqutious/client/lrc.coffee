# Define a lrc praser function here

Meteor.lrc = 
	loadlrc: (url, val)->
		$.ajax {
			url: url,
			headers: {
				contentType:"application/x-www-form-urlencoded"
			},
			success: (lrc)->
				lyric = Meteor.lrc.parseLyric(lrc, val)
				console.log "Get the data"
			,
			
			error: (e)->
				console.log "No data retrieved"  		
		} 

	parseLyric: (lrc, val)->
		lyric = lrc.split("\n")
		lrcobj = {}
		for item in lyric
			de_item = decodeURIComponent(item)
			timeReg = /\[\d*:\d*((\.|\:)\d*)*\]/g
			timeRegExpArr = de_item.match timeReg
			if !timeRegExpArr then continue
			clause = item.replace(timeReg, '')

			for time_item in timeRegExpArr
				t = time_item
				min = Number(String(t.match(/\[\d*/i)).slice(1))
				sec = Number(String(t.match(/\:\d*/i)).slice(1))
				time = min * 60 + sec
				lrcobj[time] = clause

		val = lrcobj
		Session.set 'val', val


		

