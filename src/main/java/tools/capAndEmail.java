package tools;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Properties;
import java.util.TimerTask;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class capAndEmail {
    public static void sendEmail(String toEmail, String name, String Upassword){
       String subject="Office hours password";
       String body="Welcome "+name+"\nyour password is: "+Upassword+"\n thanks for using Office hours web site";

        try
        {

            final String fromEmail = "officehoursapplication@gmail.com"; //requires valid gmail id
            final String password = "projectapp123"; // correct password for gmail id

            Authenticator auth = new Authenticator() {
                //override the getPasswordAuthentication method
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            };

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
            props.put("mail.smtp.port", "587"); //TLS Port
            props.put("mail.smtp.auth", "true"); //enable authentication
            props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS

            Session session = Session.getInstance(props, auth);
            MimeMessage msg = new MimeMessage(session);


            msg.setFrom(new InternetAddress("officehoursapplication@gmail.com", subject));

            msg.setReplyTo(InternetAddress.parse("officehoursapplication@gmail.com", false));

            msg.setSubject(subject, "UTF-8");

            msg.setText(body, "UTF-8");

            msg.setSentDate(new Date());

            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            Transport.send(msg);

            System.out.println("EMail Sent Successfully!!");
        }

        catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void sendEmail2(String toEmail,String subject,String body){
        try
        {

            final String fromEmail = "officehoursapplication@gmail.com"; //requires valid gmail id
            final String password = "projectapp123"; // correct password for gmail id

            Authenticator auth = new Authenticator() {
                //override the getPasswordAuthentication method
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            };

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
            props.put("mail.smtp.port", "587"); //TLS Port
            props.put("mail.smtp.auth", "true"); //enable authentication
            props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS

            Session session = Session.getInstance(props, auth);
            MimeMessage msg = new MimeMessage(session);


            msg.setFrom(new InternetAddress("officehoursapplication@gmail.com", subject));

            msg.setReplyTo(InternetAddress.parse("officehoursapplication@gmail.com", false));

            msg.setSubject(subject, "UTF-8");

            msg.setText(body, "UTF-8");

            msg.setSentDate(new Date());

            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            Transport.send(msg);

            System.out.println("EMail Sent Successfully!!");
        }

        catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static boolean captchaValidate(String cap)
    {
        boolean isFound=false;
        try {
            String url = "https://www.google.com/recaptcha/api/siteverify",
                    params = "secret=" + "6LdQ-CgaAAAAABcMZ0OG4gdV4-c3x8rYsR0QUM_O" + "&response=" + cap;

            HttpURLConnection http = (HttpURLConnection) new URL(url).openConnection();
            http.setDoOutput(true);
            http.setRequestMethod("POST");
            http.setRequestProperty("Content-Type",
                    "application/x-www-form-urlencoded; charset=UTF-8");
            OutputStream out = http.getOutputStream();
            out.write(params.getBytes("UTF-8"));
            out.flush();
            out.close();

            InputStream res = http.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(res, "UTF-8"));

            StringBuilder sb = new StringBuilder();
            int cp;
            while ((cp = rd.read()) != -1) {
                sb.append((char) cp);
            }
            isFound = sb.indexOf("true") !=-1? true: false;
            res.close();



        } catch (Exception e) {
        }
        return isFound;

    }
    public class MailTask extends TimerTask {
       String e,s,b;

        public MailTask(String e, String s, String b) {
            this.e = e;
            this.s = s;
            this.b = b;
        }

        public void run() {
            sendEmail2(e,s,b);
        }
    }

    public   void sendEmail3(String email,String endDate,String subject,String body)
    {

        DateFormat dtf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String dateStart = dtf.format(new Date()).toString();
        String dateStop = endDate+" 08:36:00";

        System.out.println(dateStart+" "+dateStop);

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

        Date d1 = null;
        Date d2 = null;
        try {
            d1 = format.parse(dateStart);
            d2 = format.parse(dateStop);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        long diff = d2.getTime() - d1.getTime();
        long diffSeconds = diff / 1000;

        System.out.println("Time in mil: " + diffSeconds*1000 + " mil.");

        ScheduledExecutorService ses = Executors.newSingleThreadScheduledExecutor();
        ses.schedule(new MailTask(email,subject,body),diffSeconds*1000, TimeUnit.MILLISECONDS);
    }
}
