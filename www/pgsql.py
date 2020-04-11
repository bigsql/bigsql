
def print_header(pWidth):
  print("<title>PGSQL: PostgreSQL CE</title>")

  print("<center>")


  print('<table border=0 bgcolor=black cellpadding=0 width=' + str(pWidth) + '>\n' +
        '  <tr> \n' + \
        '    <td><img src=img/pgsql-banner5.png /></td> \n' + \
        '  </tr>\n' + \
        '</table>\n\n')

  print("<table bgcolor=whitesmoke width=" + str(pWidth) + " cellpadding=0 >")
  print("<tr><td>&nbsp;</td></tr>")
  string = \
"""\
PGSQL is the PostgreSQL Community Edition that is developer friendly and cross-platform.
We fully embrace both core PostgreSQL and it's rich eco-system of over
50 enterprise-class extensions, applications & connectors.
We support Linux (both AMD64 & ARM64), OSX, and Windows.
Our Linux support includes Centos/RHEL, Debian/Ubuntu, and openSUSE.
\
"""
  print("  <tr><td colspan=2><h2>Introduction</h2></td></tr>")
  print("  <tr><td colspan=2>\n" + string + "<br>&nbsp;\n" + \
        "  </td></tr>")
  print("</table>")


  print("<table bgcolor=white width=" + str(pWidth) + " cellpadding=1 >")
  print("  <tr><td>&nbsp;</td></tr>")
  print("  <tr><td colspan=2><h2>Download & Usage</h2></td></tr>")
  print("  <tr><td colspan=2>")
  print("We are verfied & tested with: Python 2.7+, Amazon Linux 2, CentOS/RHEL 7+, Ubuntu 16+, \n" + \
        "Debian 9+, opensSUSE 12+, Windows 10 Subsytem for Linux, and OSX 10.13+ &nbsp; \n" + \
        "We run in a sandboxed environment that is perfect for running \n" + \
        "in the development, container, bare metal, or cloud environment \n" + \
        "of your choice.")
  print("<br>&nbsp;</td></tr>")

  print("  <tr><td width=240 align=right><b>Install command line:</b></td><td>")
  print("  <input type='text' size=80 value ='" + \
        'python3 -c "$(curl -fsSL https://pgsql-io-download.s3.amazonaws.com/REPO/install.py)"' + \
        "' readonly='readonly'>")
  print("</td></tr>")

  print("<tr><td>&nbsp;</td></tr>")
  
  print("<tr><td align=right><p><b>Usage sample:</b></td><td>")
  print("<input type='text' size=80 value ='" + \
        'cd pgsql; ./io install pg11; ./io start pg11; ./io install timescale' + \
        "' readonly='readonly'>")
  print("</td></tr>")

  print("</table>")


def print_footer():
  print('<center><table><tr> \n' + \
        '   <td width=450>&copy; 2020, All rights reserved.</td> \n' + \
        '   <td width=450 align=right><a href="https://lussier.io">denis@lussier.io</a></td> \n' + \
        '</tr></table></center>')
