如何使用 PHP 通过 Gmail 发送邮件
---

故事是这样的, 因为现在有这样的一个需求,做一个 SMS Proxy 的应用. 理想的使用场景是将一台手机作为固定电话,放在家里,对应的验证码和电话都能转发到其他的一台手机上.电话的话,可以通过呼叫转移实现,但是短信部分,就比较麻烦了,现在有很多的软件都可以实现 SMS Proxy 的功能,但是部分比较复杂,并且因为涉及敏感信息,还是自己开发比较靠谱.

于是,就有了这个一个产品.最理想的逻辑是,在手机端实现一个 callback 函数,当有短信到达时,执行一段代码.考虑到经济原因,理想的转发手段就成了邮件(便宜,实现方便,内容丰富).

于是乎,一个家用的邮件平台就出现了. 这篇博客主要会描述如何实现一个简单的 PHP 后端, 接收对应的数据并通过 Gmail 发送到对应的邮箱中.

#### 为什么 PHP

首先, 家用的信息平台使用 PHP 进行编写, 同时 PHP 易于开发易于部署, 并且我也稍微懂一些代码就使用了.

#### 依托的代码库
PHP 中就有 Mail 函数库, 为什么不直接使用? 其中的一个原因, 就是我不愿意维护一个邮件服务器, 该邮件平台依旧需要支持接收邮件的功能并且 PHP Mail 函数时常爆出漏洞, 结合以上几点, 在这次开发中我使用了 [PHPMailer](https://github.com/PHPMailer/PHPMailer) 库.

#### 遇到的坑
##### Subject 中出现中文乱码
解决办法就是强制指定字符编码为 utf8, 比如使用如下代码:
```php
$mail->Subject = '{YOUR SUBJECT}';
$mail->Subject = "=?UTF-8?B?".base64_encode($mail->Subject)."?=";
```

##### 邮件内容中文乱码
解决办法就是指定 Body 字符编码, 比如使用如下代码:
```php
$mail->CharSet = "UTF-8";
```

#### 实现代码
这部分其实是最简单的,以下就是官方给出的代码样例, 结合上面的坑解决办法,就能成功的发出邮件了:

```php
<?php

/**
 * This example shows settings to use when sending via Google's Gmail servers.
 * This uses traditional id & password authentication - look at the gmail_xoauth.phps
 * example to see how to use XOAUTH2.
 * The IMAP section shows how to save this message to the 'Sent Mail' folder using IMAP commands.
 */

//Import PHPMailer classes into the global namespace
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;

require '../vendor/autoload.php';

//Create a new PHPMailer instance
$mail = new PHPMailer();

//Tell PHPMailer to use SMTP
$mail->isSMTP();

//Enable SMTP debugging
//SMTP::DEBUG_OFF = off (for production use)
//SMTP::DEBUG_CLIENT = client messages
//SMTP::DEBUG_SERVER = client and server messages
$mail->SMTPDebug = SMTP::DEBUG_SERVER;

//Set the hostname of the mail server
$mail->Host = 'smtp.gmail.com';
//Use `$mail->Host = gethostbyname('smtp.gmail.com');`
//if your network does not support SMTP over IPv6,
//though this may cause issues with TLS

//Set the SMTP port number:
// - 465 for SMTP with implicit TLS, a.k.a. RFC8314 SMTPS or
// - 587 for SMTP+STARTTLS
$mail->Port = 465;

//Set the encryption mechanism to use:
// - SMTPS (implicit TLS on port 465) or
// - STARTTLS (explicit TLS on port 587)
$mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;

//Whether to use SMTP authentication
$mail->SMTPAuth = true;

//Username to use for SMTP authentication - use full email address for gmail
$mail->Username = 'username@gmail.com';

//Password to use for SMTP authentication
$mail->Password = 'yourpassword';

//Set who the message is to be sent from
//Note that with gmail you can only use your account address (same as `Username`)
//or predefined aliases that you have configured within your account.
//Do not use user-submitted addresses in here
$mail->setFrom('from@example.com', 'First Last');

//Set an alternative reply-to address
//This is a good place to put user-submitted addresses
$mail->addReplyTo('replyto@example.com', 'First Last');

//Set who the message is to be sent to
$mail->addAddress('whoto@example.com', 'John Doe');

//Set the subject line
$mail->Subject = 'PHPMailer GMail SMTP test';

//Read an HTML message body from an external file, convert referenced images to embedded,
//convert HTML into a basic plain-text alternative body
$mail->msgHTML(file_get_contents('contents.html'), __DIR__);

//Replace the plain text body with one created manually
$mail->AltBody = 'This is a plain-text message body';

//Attach an image file
$mail->addAttachment('images/phpmailer_mini.png');

//send the message, check for errors
if (!$mail->send()) {
    echo 'Mailer Error: ' . $mail->ErrorInfo;
} else {
    echo 'Message sent!';
    //Section 2: IMAP
    //Uncomment these to save your message in the 'Sent Mail' folder.
    #if (save_mail($mail)) {
    #    echo "Message saved!";
    #}
}

//Section 2: IMAP
//IMAP commands requires the PHP IMAP Extension, found at: https://php.net/manual/en/imap.setup.php
//Function to call which uses the PHP imap_*() functions to save messages: https://php.net/manual/en/book.imap.php
//You can use imap_getmailboxes($imapStream, '/imap/ssl', '*' ) to get a list of available folders or labels, this can
//be useful if you are trying to get this working on a non-Gmail IMAP server.
function save_mail($mail)
{
    //You can change 'Sent Mail' to any other folder or tag
    $path = '{imap.gmail.com:993/imap/ssl}[Gmail]/Sent Mail';

    //Tell your server to open an IMAP connection using the same username and password as you used for SMTP
    $imapStream = imap_open($path, $mail->Username, $mail->Password);

    $result = imap_append($imapStream, $path, $mail->getSentMIMEMessage());
    imap_close($imapStream);

    return $result;
}
```
