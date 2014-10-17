function smoothVel = smoothVelocityTrack(scaledTrack)

    sampleTime = .05;
    smoothSamples = 5;

    smoothTrack = smooth(scaledTrack,smoothSamples);  
    smoothVel = [diff(smoothTrack);0]./sampleTime;
