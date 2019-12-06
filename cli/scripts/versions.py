
import sqlite3

con = sqlite3.connect("../../conf/db_local.db")
c = con.cursor()

sql = "SELECT cat, cat_desc, image_file, component, project, release_name, \n" + \
      "       version, sources_url, project_url, platform, release_date \n" + \
      "  FROM v_versions \n" + \
      " WHERE is_current = 1 and stage = 'prod'"

c.execute(sql)
data = c.fetchall()

print("<table border=1>")

for d in data:
  cat = str(d[0])
  cat_desc = str(d[1])
  image_file = str(d[2])
  component = str(d[3])
  project = str(d[4])
  release_name = str(d[5])
  version = str(d[6])
  source_url = str(d[7])
  project_url = str(d[8])
  platform = str(d[9])
  release_date = str(d[10])

  print("  <tr>")

  print("    <td>" + cat + "</td>")
  print("    <td>" + cat_desc + "</td>")
  print("    <td>" + component + "</td>")
  print("    <td>" + project + "</td>")
  print("    <td>" + release_name + "</td>")
  print("    <td>" + version + "</td>")
  print("    <td>" + source_url + "</td>")
  print("    <td>" + project_url + "</td>")
  print("    <td>" + platform  + "</td>")
  print("    <td>" + release_date + "</td>")

  print("  </tr>")

print("</table>")


