class Song
  def initialize(name, artist, duration)
    @name = name
    @artist = artist
    @duration = duration
  end

  attr_reader :name, :artist, :duration

  def to_s
  	"Song: #{@name}--#{@artist} (#{@duration})"
  end

  attr_writer :duration

  include Comparable
  def <=>(other)
  	self.duration <=> other.duration
  end
end

class KaraokeSong < Song
  def initialize(name, artist, duration, lyrics)
  	super(name, artist, duration)
    @lyrics = lyrics
  end

  def to_s
  	super + " [#{@lyrics}]"
  end
end

class SongList
  def initialize
  	@songs = []
  	@index = WordIndex.new
  end

  def append(aSong)
  	@songs.push(aSong)
  	@index.index(aSong, aSong.name, aSong.artist)
  	self
  end
  def lookup(aWord)
  	@index.lookup(aWord)
  end
  def deleteFirst
  	@songs.shift
  end
  def deleteLast
  	@songs.pop
  end

  def [](key)
  	
  	  return @songs[key] if key.kind_of?(Integer)
  	  return @songs.find { |aSong| aSong.name == key }
  	
  end
end

class WordIndex
  def initialize
  	@index = Hash.new(nil)
  end
  def index(anObject, *phrases)
  	phrases.each do |aPhrase|
  	  aPhrase.to_s.scan (/\w[-\w']+/) do |aWord|
  	    aWord.downcase!
  	    @index[aWord] = [] if @index[aWord].nil?
  	    @index[aWord].push(anObject)
  	  end
  	end
  end
  def lookup(aWord)
  	@index[aWord.downcase]
  end
end

songs = SongList.new

#f = File.open("songFile.txt")
#f.each do |line|
	#print line
#end

songFile = File.open("songFile.txt")
songFile.each do |line|
	print line
  file, length, name, title = line.chomp.split(/\s*\|\s*/)
  name.to_s.squeeze!(" ")
  mins, secs = length.to_s.scan(/\d+/)
  songs.append Song.new(title, name, mins.to_i*60+secs.to_i)
end
#songFile.close
puts songs.lookup("Fats")
puts songs.lookup("ain't")
puts songs.lookup("RED")
puts songs.lookup("WoRlD")
puts songs.lookup("Mike")

song1 = Song.new("My Way", "Sinatra", 225)
song2 = Song.new("Bicylops", "Fleck", 260)
print "#{song1.name} <=> #{song2.name} "; puts song1 <=> song2
puts song1 < song2
puts song1 == song2
puts song1 > song2

