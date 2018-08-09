import sqlite3
conn = sqlite3.connect('explico.db')

c=conn.cursor()

# c.execute("SELECT * FROM traduttore")
# data=c.fetchall()

# print "INSERT INTO traduttore (nome, cognome, username,email, citta, stato, madrelingua) VALUES"
#
# for value in data:
#     id=value[0]
#     nome=value[1]
#     cognome=value[2]
#     data=value[3]
#     madrelingua=value[4]
#     c.execute("SELECT * FROM utente WHERE id="+str(id))
#     transl=c.fetchall();
#     username=transl[0][1]
#     email=transl[0][5]
#     citta=transl[0][6]
#     stato=transl[0][7]
#
#     print "('"+nome+"','"+cognome+"','"+username+"','"+email+"','"+citta+"','"+stato+"','"+madrelingua+"'),"


# c.execute("SELECT * FROM language_pair;")
# data=c.fetchall()
#
# print "INSERT INTO language_pair (username,from_l, to_l, price,currency) VALUES"
#
# for value in data:
#     id=value[1]
#     from_l=value[2]
#     to_l=value[3]
#     price=value[6]
#     currency=value[7]
#     c.execute("SELECT * FROM utente WHERE id="+str(id))
#     transl=c.fetchall();
#     username=transl[0][1]
#
#     print "('"+username+"','"+from_l+"','"+to_l+"','"+str(price)+"','"+currency+"'),"

c.execute("SELECT currency FROM currencies;")
data=c.fetchall()

for field in data:
    print '"'+field[0]+'",'

conn.commit()
conn.close()
