/* this is a fible attempt to do this in SAS */
/* best thing is to create an API that will accept / return the file, but i don't know how to do this yet */
/* i'm using SAS to do the string parsing and sorting */
/* i'm also going to do this in Python */

/* retrieve user file from github */
filename userfile url "https://raw.githubusercontent.com/dkhots/interview/master/sample_user_file.csv";
data userfile_df(keep=userstring);
length userstring $1000;
infile userfile length=len lrecl=1000;
input userstring $varying10000. len;
run;

/* parse the userstring into numbers and characters */

data userfile_df_parsed;
	set userfile_df;
	userstring_num = input(compress(upcase(userstring), ' ', 'A'),20.);
	userstring_char = compress(userstring,"0123456789");
run;

/* sort per problem instructions - first by the number in ascending order and then alphabetically */
proc sort data = userfile_df_parsed;
by userstring_num userstring_char;
run;

/* create output - same file, only sorted -- this drops the aux fields */
data userfile_df_final;
	set userfile_df_parsed;
	drop userstring_num userstring_char;
run;

/* need to return the file to the user */
/* this should be API returning the file */







