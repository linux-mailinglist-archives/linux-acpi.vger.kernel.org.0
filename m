Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8E3153F52
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2020 08:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBFHlo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Feb 2020 02:41:44 -0500
Received: from smtp4.tjgo.jus.br ([45.71.214.102]:60542 "EHLO mx2.tjgo.jus.br"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbgBFHlo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Feb 2020 02:41:44 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 02:41:43 EST
Received: from sv-email-p02.tjgo.jus.br (sv-email-p02.tjgo.jus.br [45.71.214.97])
        by mx2.tjgo.jus.br (Postfix) with ESMTPS id 91CF82C8394;
        Thu,  6 Feb 2020 04:31:48 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by sv-email-p02.tjgo.ldc (Postfix) with ESMTP id E510E637E1;
        Thu,  6 Feb 2020 04:31:46 -0300 (-03)
Received: from sv-email-p02.tjgo.jus.br ([127.0.0.1])
        by localhost (sv-email-p02.tjgo.ldc [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uzXEVNAdMVR2; Thu,  6 Feb 2020 04:31:46 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
        by sv-email-p02.tjgo.ldc (Postfix) with ESMTP id 8002B63B29;
        Thu,  6 Feb 2020 04:31:43 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.10.3 sv-email-p02.tjgo.ldc 8002B63B29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tjgo.jus.br;
        s=DB6EB6C0-19CB-11E9-B608-74AECE7D716B; t=1580974303;
        bh=5gt2CYgFnvZlp4wHHuTiqJSUi1SvWTf2DF/QDrLhfa0=;
        h=Date:From:Message-ID:MIME-Version;
        b=H3rGWGtDjb9PbouYCVI1NK5tk3bg0QT0PMD/qmPpFsJjN6sIrXdMHg7zM7IVaGkpl
         S6wuv0pYmybGP2XkheMFW5BpP3rVxuIkAEF2Rz+ijv3yvufjdIoVnya0KNLSV7zx3C
         s2KvsBSWS8UxRJxz+XwpJSHD5FOwoPZLEwWZ2OCo0ynsZxYkOCvmlCmmQHb6X/o+bD
         2poxChmfXEGTcBtM5cB+oGNtJ8eS4FETR3uClYlSTDfpXnMPvp/bRBgzQlNBEVcmFy
         W0Tr8ez45P5fTM+fMObMLv5XVfKPWPkkgfe6r138U64wMIMix7KruhbsF1Al+cEzgR
         oaFIW96Loa5Kw==
X-Virus-Scanned: amavisd-new at sv-email-p02.tjgo.ldc
Received: from sv-email-p02.tjgo.jus.br ([127.0.0.1])
        by localhost (sv-email-p02.tjgo.ldc [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jCgWvU2_eXnl; Thu,  6 Feb 2020 04:31:43 -0300 (-03)
Received: from sv-email-p00.tjgo.ldc (sv-email-p00.tjgo.ldc [45.71.214.95])
        by sv-email-p02.tjgo.ldc (Postfix) with ESMTP id A094F6380E;
        Thu,  6 Feb 2020 04:31:37 -0300 (-03)
Date:   Thu, 6 Feb 2020 04:31:37 -0300 (BRT)
From:   Viviane Jose Pereira <vjpereira@tjgo.jus.br>
Reply-To: Guo Ningning <guoninh2@gmail.com>
Message-ID: <1587568607.1018118.1580974297515.JavaMail.zimbra@tjgo.jus.br>
Subject: Re:
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [199.249.230.119]
X-Mailer: Zimbra 8.8.15_GA_3829 (zclient/8.8.15_GA_3829)
Thread-Index: +FjOihN3jh4wiloOYo0Vx+4DIzId7w==
Thread-Topic: 
X-HSC-Mail_Inspector-From: vjpereira@tjgo.jus.br
X-HSC-Mail_Inspector-IP: 45.71.214.97
X-HSC-Mail_Inspector-Point: 2
X-HSC-Mail_Inspector-ID: 91CF82C8394.ABCF6
X-HSC-Brasil-HSC_MailInspector: Mensagem OK
X-HSC-Brasil-HSC_MailInspector-SpamCheck: Nao e SPAM,
        HSC MailInspector (cached, Pontuacao=0.267, requerido 6,
        BAYES_00 -3.00, DKIM_VALID_AU -0.10, HELO_NO_DOMAIN 0.00,
        MISSING_HEADERS 1.02, RDNS_NONE 0.79, REPLYTO_WITHOUT_TO_CC 1.55)
X-HSC-Brasil-HSC_MailInspector-From: vjpereira@tjgo.jus.br
X-Spam-Status: No
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



Hallo,=20

ich entschuldige mich f=C3=BCr die St=C3=B6rung Ihrer Privatsph=C3=A4re, bi=
tte lassen Sie mich damit beginnen, mich vorzustellen, ich bin Miss Guo Nin=
gning, Executive Vice President Banking Division.Agricultural Bank of China=
, Beijing, China. Ich nehme Kontakt mit Ihnen aufbez=C3=BCglich einer =C3=
=A4u=C3=9Ferst dringenden und vertraulichen Angelegenheit.

Wenn Sie mir die Gelegenheit dazu geben w=C3=BCrden, werde ich Ihnen bei Ih=
rer Antwort Einzelheiten mitteilen.F=C3=BCr weitere Informationen wenden Si=
e sich bitte an: guoninh2@gmail.com

Mit freundlichen Gr=C3=BC=C3=9Fen,Guo Ningning
