%Yogesh Pawar
clear classes;
vidObj = webcam;
faceDetector = vision.CascadeObjectDetector(); 
tracker = MultiObjectTrackerKLT;
frame = snapshot(vidObj);
frameSize = size(frame);
videoPlayer  = vision.VideoPlayer('Position',[200 100 fliplr(frameSize(1:2)+30)]);
bboxes = [];
while isempty(bboxes)
    framergb = snapshot(vidObj);
    frame = rgb2gray(framergb);
    bboxes = faceDetector.step(frame);
end
tracker.addDetections(frame, bboxes);
frameNumber = 0;
keepRunning = true;
disp('Press Ctrl-C to exit...');
while keepRunning
    
    framergb = snapshot(vidObj);
    frame = rgb2gray(framergb);
    
    if mod(frameNumber, 10) == 0

        bboxes = 2 * faceDetector.step(imresize(frame, 0.5));
        if ~isempty(bboxes)
            tracker.addDetections(frame, bboxes);
        end
    else

        tracker.track(frame);
    end
    displayFrame = insertObjectAnnotation(framergb, 'rectangle',...
        tracker.Bboxes, tracker.BoxIds);
    displayFrame = insertMarker(displayFrame, tracker.Points);
    videoPlayer.step(displayFrame);
    
    frameNumber = frameNumber + 1;
end
release(videoPlayer);


















