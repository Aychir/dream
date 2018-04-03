class Report < ApplicationRecord
	belongs_to :reported, polymorphic: true, optional: true
	#Shouldn't be optional but there was an unknown issue with a reported_type I had that wasn't even necessary
		#I think that it screwed it up because it still said reported did not exist but this allowed it to work
	belongs_to :user

end
