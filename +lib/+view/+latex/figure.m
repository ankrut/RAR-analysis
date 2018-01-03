function figure(varargin)
Q = module.struct(...
	'width',		'\textwidth',...
	'filename',		'figure',...
	varargin{:}...
);

if isfield(Q,'path')
	mkdir(Q.path);
	
	Q.texpath = [Q.path Q.filename '.tex'];
	Q.imgpath = [Q.path Q.filename];
	Q.imgfile = [Q.filename '.pdf'];
end

if isfield(Q,'figure')
	lib.view.file.figure(...
		'figure',	Q.figure,...
		'filepath',	Q.imgpath...
	);
end

str = fileread('+lib/+view/+latex/figure.tpl');
str = regexprep(str,'{{width}}',lib.escape(Q.width));
str = regexprep(str,'{{imgpath}}',lib.escape(Q.imgfile));
str = regexprep(str,'{{caption}}',lib.escape(Q.caption));
str = regexprep(str,'{{label}}',lib.escape(Q.label));

fh = fopen(Q.texpath,'w');
fwrite(fh,str);
fclose(fh);