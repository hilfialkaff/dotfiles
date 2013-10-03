import imaplib

username = '<username>'
password = '<password>'
mailbox = 'INBOX'
mailserver = 'imap.gmail.com'
port = 993

if __name__=='__main__':
    server = imaplib.IMAP4_SSL(mailserver,port)
    server.login(username,password)
    server.select(mailbox)
    data = str(server.status(mailbox, '(MESSAGES UNSEEN)')).split()

    print data[5].replace(')\'])','')
