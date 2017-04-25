/* post the file to github */
/* used github desktop to post the file or alternatively the github website itself*/
/* also may need to be an API that the user calls */


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
/* using poor man's method */

/* create CSV file from SAS data set and place into local github repo */

proc export data=userfile_df_final
   outfile="\\OM0766L4\Users\dkhots\Documents\GitHub\interview\userfile_parsed_sorted.csv"
   dbms=dlm
   replace;
   delimiter=',';
   putnames=no;
run;

/* then use git push to add the file back into public github */

