

def note_to_name note
    name = note%12
    if name == 0 then name = "C"
    elsif name == 1 then name = "C#"
    elsif name == 2 then name = "D"
    elsif name == 3 then name = "Eb"
    elsif name == 4 then name = "E"
    elsif name == 5 then name = "F"
    elsif name == 6 then name = "F#"
    elsif name == 7 then name = "G"
    elsif name == 8 then name = "Ab"
    elsif name == 9 then name = "A"
    elsif name == 10 then name = "Bb"
    elsif name == 11 then name = "B"
    else
        puts "note_to_name: Something impossible happened."
        exit 1
    end
    octave = note/12
    if octave < 2 then
        puts "note_to_name: octave too low."
        exit 1
    end
    octave -= 2
    return name.to_s + octave.to_s
end

def fit_to_time delta, division
    triplet = 2.0/3.0
    dot = 3.0/2.0
    fits = {
        "S" => (1.0/16.0), "S." => (1.0/16.0)*dot, "S^" => (1.0/16.0)*triplet,
        "t" => (1.0/8.0), "t." => (1.0/8.0)*dot, "t^" => (1.0/8.0)*triplet,
        "s" => 0.25, "s." => 0.25*dot, "s^" => 0.25*triplet,
        "e" => 0.5, "e." => 0.5*dot, "e^" => 0.5*triplet,
        "q" => 1.0, "q." => 1.0*dot, "q^" => 1.0*triplet,
        "h" => 2.0, "h." => 2.0*dot, "h^" => 2.0*triplet,
        "w" => 4.0, "w." => 4.0*dot, "w^" => 4.0*triplet
    }
    duration = delta.to_s + "/" + division.to_s + "?"

    fits.each { |x|
        if delta == (division * x[1]).to_i then
            duration = x[0]
            break
        end
    }

    return duration
end

midiFile = File.open(ARGV[0], "r")

# read in header
head = midiFile.read 4
if head != "MThd" then
    puts "Not a MIDI file!"
    exit 1
end
# MIDI standard header is always of length 6
len = midiFile.read(4).unpack("N")[0]
if len != 6 then
    puts "Bad MIDI file."
    exit 1
end

format = midiFile.read(2).unpack("n")[0]
if format != 1 then
    printf "This is a format %d file.\n", format;
    puts "Regrettably, we only support format 1 at the moment."
    exit 1
end

# number of tracks
ntrks = midiFile.read(2).unpack("n")[0]
# time division of a quarter note
division = midiFile.read(2).unpack("n")[0]

channels = Array.new(0)

# for each track...
0.upto(ntrks-1) do |i|
    head = midiFile.read(4)
    if head != "MTrk" then
        puts "Uh oh, that wasn't a track... "
        printf "%s\n", head
        exit 1
    end
    len = midiFile.read(4).unpack("N")[0]
    # XXX if this is the first track, just output the text but don't
    # allocate a channel?
    time = 0
    note = "C0"

    j = 0
    while j < len do
        # read delta time
        delta = 0
        c = midiFile.read(1).unpack("C")[0].to_i; j += 1
        while c > 127 do
            delta += c&127
            delta <<= 7
            c = midiFile.read(1).unpack("C")[0].to_i; j += 1
        end
        delta += c
        time += delta

        # decode next event into this channel's array
        x = midiFile.read(1).unpack("C")[0].to_i; j += 1
        if x == 0xff then
            type = midiFile.read(1).unpack("C")[0].to_i; j += 1
            length = midiFile.read(1).unpack("C")[0].to_i; j += 1
            midiFile.read(length); j += length
            if type == 0x2f then
                printf "\n\n"
                break
            end
        elsif (x&0xf0) == 0x80 then
            # we ignore the note off note and velocity for the moment
            # because rosegarden sends cracksmoking values for them
            midiFile.read(2)
            duration = fit_to_time(delta,division)
            printf "%s%s ", note, duration
        elsif (x&0xf0) == 0x90 then
            note = midiFile.read(1).unpack("C")[0].to_i; j += 1
            note = note_to_name(note)
            velocity = midiFile.read(1).unpack("C")[0].to_i; j += 1
            # output a rest if delta > 0
            if delta > 1 then
                if delta > 4.0*division then
                    # XXX optimize into loop
                    (delta/(4.0*division)).to_i.times { printf "R0w " }
                    delta = delta % (4.0*division).to_i
                end
                # XXX XXX XXX EVIL HACKS
                if delta == 560 and division == 160 then
                    printf "R0e "
                    delta = 480
                elsif delta == 481 and division == 160 then
                    delta = 480
                elsif delta == 0 then
                    next
                end
                duration = fit_to_time(delta, division)
                printf "R0%s ", duration
            end
        else
        end
    end
end

# output pattern header

# for each channel
    # output decoded events

exit 0

# EOF joseph.rb
