
def print_header(pWidth):
  print('<center><table><tr><td> \n')

  print('<table height=100  border=0 bgcolor=black width=' + str(pWidth) + '>\n' +
        '  <tr> \n' + \
        '    <td width=250><img width=250 src=img/pgsql-banner.png /></td> \n' + \
        '  </tr>\n' + \
        '</table>\n\n')

  print("<h3>Tested with:</h3>\n" + \
        "&nbsp;&nbsp; <b>1)</b> Linux on EL7/EL8,&nbsp; Amazon Linux 2,&nbsp; and Ubuntu 16.04/18.04 &nbsp;&nbsp;" + \
        " <b>2)</b> OSX on High Sierra 10.13 and newer")

  print('<h3>Install from the command line with the below:</h3>\n' + \
        '&nbsp;&nbsp;python -c "$(curl -fsSL https://pgsql-io-download.s3.amazonaws.com/REPO/install.py)"')

  print('<h3>Usage Instructions:</h3>\n' + \
        '&nbsp;&nbsp;cd pgsql; ./io install pg11; ./io start pg11; ./io install timescaledb-pg11</code>') 

  print("<h3>Components:</h3>")
 
def print_footer():
  print('&copy; 2020, All rights reserved.')
