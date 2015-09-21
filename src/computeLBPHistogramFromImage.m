function histogram = computeLBPHistogramFromImage(vocabulary,im)
if isstr(im)
  if exist(im, 'file')
    fullPath = im ;
  else
    fullPath = fullfile('data','images',[im '.jpg']) ;
  end
  im = imread(im) ;
end
numWord = size(vocabulary.words, 2);
lbp = computeLBPMulti(im) ;
word = quantizeDescriptors(vocabulary, lbp);
histogram =zeros(numWord, 1); % 1000 is the number of vocabulary;
for i=1:numWord
    histogram(i)=sum(word==i);
end
histogram = histogram/(length(word));