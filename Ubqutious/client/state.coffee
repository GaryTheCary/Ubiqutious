# - - - - - - - - - - - - - - - - - 
# Identify Different emotion states 
# - - - - - - - - - - - - - - - - -


Meteor.emotion_female = {
	sad: "a",
	sympathy: "b",
	complacent: "c",
	normal: "d",
	distain: "e",
	jealous: "f",
	hope: "g",
	love: "h",
	happy: "i",
	drool: "j",
	disappoint: "k",
	missing: "l",
	enjoy: "m",
	tied: "n",
	big_love: "o"
}

Meteor.emotion_male = {
	angry: "a",
	frustrating: "b",
	tired: "c",
	proud: "d",
	enjoy: "e",
	smily: "f",
	normal: "g",
	interested: "h",
	caring: "i",
	tied: "j",
	hope: "k",
	crush: "l",
	liking: "m",
	love: "n",
	big_love: "o"
}

Meteor.emotion_judge =

	strJudge: (str, db_f, db_m)->
		switch str
			when "sad_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.sad)
			when "angry_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.angry)
			when "sympathy_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.sympathy)
			when "complacent_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.complacent)
			when "normal_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.normal)
			when "distain_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.distain)
			when "jealous_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.jealous)
			when "hope_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.hope)
			when "love_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.love)
			when "happy_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.happy)
			when "drool_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.drool)
			when "disappoint_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.disappoint)
			when "missing_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.missing)
			when "enjoy_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.enjoy)
			when "tied" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.tied)
			when "big_love_f" then Meteor.emotion_judge.insertToDB(db_f, Meteor.emotion_female.big_love)
			when "frustrating_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.frustrating)
			when "tired_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.tired)
			when "proud_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.proud)
			when "enjoy_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.enjoy)
			when "smily_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.smily)
			when "normal_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.normal)
			when "interested" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.interested)
			when "caring_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.caring)
			when "tied_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.tied)
			when "hope_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.hope)
			when "crush_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.crush)
			when "liking_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.liking)
			when "love_m" then Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.love)
			else Meteor.emotion_judge.insertToDB(db_m, Meteor.emotion_male.big_love)

	insertToDB: (db, str)->
		data = str
		index = db.find().count()

		insertData = {index: index, data: data}
		db.insert insertData
		# console.log "new data insert to: " + data		
