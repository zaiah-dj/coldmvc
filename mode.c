#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>

#if 0
	fprintf(stderr, "FILE TYPE\n");
	fprintf(stderr, "%-30s %d\n", "S_IFMT",  mode = S_IFMT);
	fprintf(stderr, "%-30s %d\n", "S_IFBLK", mode = S_IFBLK);
	fprintf(stderr, "%-30s %d\n", "S_IFCHR", mode = S_IFCHR);
	fprintf(stderr, "%-30s %d\n", "S_IFIFO", mode = S_IFIFO);
	fprintf(stderr, "%-30s %d\n", "S_IFREG", mode = S_IFREG);
	fprintf(stderr, "%-30s %d\n", "S_IFDIR", mode = S_IFDIR);
	fprintf(stderr, "%-30s %d\n", "S_IFLNK", mode = S_IFLNK);

	fprintf(stderr, "\nMODE\n");
	fprintf(stderr, "%-30s %d\n", "S_IRWXU", mode = S_IRWXU);
	fprintf(stderr, "%-30s %d\n", "S_IRUSR", mode = S_IRUSR);
	fprintf(stderr, "%-30s %d\n", "S_IWUSR", mode = S_IWUSR);
	fprintf(stderr, "%-30s %d\n", "S_IXUSR", mode = S_IXUSR);
	fprintf(stderr, "%-30s %d\n", "S_IRWXG", mode = S_IRWXG);
	fprintf(stderr, "%-30s %d\n", "S_IRGRP", mode = S_IRGRP);
	fprintf(stderr, "%-30s %d\n", "S_IWGRP", mode = S_IWGRP);
	fprintf(stderr, "%-30s %d\n", "S_IXGRP", mode = S_IXGRP);
	fprintf(stderr, "%-30s %d\n", "S_IRWXO", mode = S_IRWXO);
	fprintf(stderr, "%-30s %d\n", "S_IROTH", mode = S_IROTH);
	fprintf(stderr, "%-30s %d\n", "S_IWOTH", mode = S_IWOTH);
	fprintf(stderr, "%-30s %d\n", "S_IXOTH", mode = S_IXOTH);
	fprintf(stderr, "%-30s %d\n", "S_ISUID", mode = S_ISUID);
	fprintf(stderr, "%-30s %d\n", "S_ISGID", mode = S_ISGID);
	fprintf(stderr, "%-30s %d\n", "S_ISVTX", mode = S_ISVTX);
#endif

/*Jump to RWX if somebody sets some crazy shit...*/

/*Get the file mode with no extra anything*/
#define mode(x) \
 64 * ((((int)#x[0] < 48 || (int)#x[0] > 55) ? 0 : #x[0]) - 48) | \
	8 * ((((int)#x[1] < 48 || (int)#x[1] > 55) ? 0 : #x[1]) - 48) | \
	    ((((int)#x[2] < 48 || (int)#x[2] > 55) ? 0 : #x[2]) - 48)


int main (int argc, char *argv[]) {
	fprintf(stderr, "Mode: %d - %d\n", mode(544), mode(766));
	fprintf(stderr, "Mode: %d - %d\n", mode(777), S_IRWXU | S_IRWXG | S_IRWXO);
#if 1
	open("a1", O_CREAT | O_WRONLY | O_TRUNC, mode(544));
	/*Default ACL lists will affect this value.  ~022 is what changes it*/
	open("a2", O_CREAT | O_WRONLY | O_TRUNC, (S_IRWXU | S_IRWXG | S_IRWXO));
#endif

	/*Test these stupid numbers*/
#if 0
	int c[3] = { 64, 8, 1 };	
	for (int inc=0; inc<3; inc++) {
		int d = 0;
		for (int i=0;  i<8; i++, d += c[inc])
			fprintf(stderr, "%d\n",  d);
	}
#endif
	
#if 0
  for (int i=48; i<48+24; i++)
		fprintf(stderr, "file mode: %d -> %d\n", i, MM[i]);
#endif
	return 0;
}
