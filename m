Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7BD368652
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhDVSEC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 14:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhDVSEC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Apr 2021 14:04:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E2C06174A;
        Thu, 22 Apr 2021 11:03:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y32so33373807pga.11;
        Thu, 22 Apr 2021 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=k0VIW98Anrjot9UIkwH/dJvo32+FqeAF8F46I+kX+Io=;
        b=MytkApmmOFn5AU3TxwS/Obi5niW22MPciW9RlXaXerbbHPUXMMmTaUAzLJgma/w1fp
         IyXNfCr9sOxx+nhZqBIW9kAL6BtXcRXbVHz7y4aFHPZgK81TRCblAXdaMBrWdh9oUzi6
         2KVKv4JWS5dTtDfTIC6muxOcX72GAKK/xPeNc2nExGeu9b1+Nkt8CVepBpJ0/rr60ETi
         I0M7My07X9mFWZPfwcplIx/XqzgIZIFez2tBBUkU65AiPFjCWifmfuQ/RNRJ20XUxOX5
         G1yRvCBoPzo3bKnLV2MzscNeeDjL1+9/rrlLpsETxrqyceF9mEBStH3NzGKb62RT6n3F
         Cgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=k0VIW98Anrjot9UIkwH/dJvo32+FqeAF8F46I+kX+Io=;
        b=nqIkN7wUOdvE5y1/TaBtbtW0BCYXRKLKSGMamzdinWS6zgCsC5Q4MgBC+pO7zBdCBL
         Cl0PeVWQwzPwgiGYli9SuYKnZJWZByCVwI7q3b4kYmBO1IsVkXv/JNF0E1lJnb7enoMB
         rVbz3hnawEfGVS7+9CKE9jeJVb9+stsKUwbrEgZ10BCbdlj0roSIdNghC2XtFDdhipSp
         amR0rXqtp7YOi5oUrqjdVdJVMGksAGCZKr2ABoQLy7D44wwiRrbdo/BKypqBC+tBiFrE
         +80y6nYog638sp4P0oNNpwziS8E0CvdhKZfXvej+Ro2rJNQY59x9VMEI4JnIsx09cWlF
         lfhg==
X-Gm-Message-State: AOAM530sK9cXX0YjFZU08PjFbmERuH3cp5WSuRJywEMpwyQ/m3VaD+TV
        cWowzgL26Cwp8fbThELZsC4=
X-Google-Smtp-Source: ABdhPJw+sb072t/853L36S0k1UACj69vXg/3sPhkUxrxdMrs9IKOG7ppAzhXceTmAX70EhKUtlh6Aw==
X-Received: by 2002:a65:5808:: with SMTP id g8mr4657870pgr.137.1619114605600;
        Thu, 22 Apr 2021 11:03:25 -0700 (PDT)
Received: from localhost ([122.172.37.94])
        by smtp.gmail.com with ESMTPSA id 22sm5698913pjl.31.2021.04.22.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 11:03:25 -0700 (PDT)
Date:   Thu, 22 Apr 2021 23:33:22 +0530
From:   Anupama K Patil <anupamakpatil123@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Adam <developer@arusty.dev>,
        bkkarthik@pesu.pes.edu, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
Message-ID: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzysk5dfjuwhgqni"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--qzysk5dfjuwhgqni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

de, e are two variables of the type 'struct proc_dir_entry'
which can be removed to save memory. This also fixes a coding style
issue reported by checkpatch where we are suggested to make assignment
outside the if statement.

Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
---
 drivers/pnp/isapnp/proc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
index 785a796430fa..1ae458c02656 100644
--- a/drivers/pnp/isapnp/proc.c
+++ b/drivers/pnp/isapnp/proc.c
@@ -57,21 +57,20 @@ static const struct proc_ops isapnp_proc_bus_proc_ops =
=3D {
 static int isapnp_proc_attach_device(struct pnp_dev *dev)
 {
 	struct pnp_card *bus =3D dev->card;
-	struct proc_dir_entry *de, *e;
 	char name[16];
=20
-	if (!(de =3D bus->procdir)) {
+	if (!bus->procdir) {
 		sprintf(name, "%02x", bus->number);
-		de =3D bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
-		if (!de)
+		bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
+		if (!bus->procdir)
 			return -ENOMEM;
 	}
 	sprintf(name, "%02x", dev->number);
-	e =3D dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, de,
+	dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, bus->procdir,
 					    &isapnp_proc_bus_proc_ops, dev);
-	if (!e)
+	if (!dev->procent)
 		return -ENOMEM;
-	proc_set_size(e, 256);
+	proc_set_size(dev->procent, 256);
 	return 0;
 }
=20
--=20
2.25.1


--qzysk5dfjuwhgqni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEDSQZGCDcREXgcOjQtGmOOZV75b4FAmCBumQACgkQtGmOOZV7
5b77bQwAxwDa39VD4CMPQRKu/YD6PMA4RdJGz+xlci6C5d2/J6CBf+U1Pb3Br+qd
mHciKRDUOxDk36Qi8ChbR98rOyX+KljGd6JdbIJTDlxMdRE6qRn9Ab7oC+bsoYKa
emq8RUJJ8u3NzRkYfoPva6vg0HeNKNGseMyGWa+dFwMql30J9PhGf8ObfN4MSTEL
FHdKlFWF8vZR/pMOSg7/VxhoOCR+H2YtmFxE2h1CKxDzh2RmcU+wLvbuFVTrrD9A
rKdTf/Knfya5mrgNCr+CDDLttTWg5CzXki2rEGO1suBNZB8MChrot/6SEtnqeaMz
dnIuZq5pH91A4/ZSQKYyYNJhtwfcbxO5gagsiwV+Q5BJ0VuDE4L+E6jyvn75HD18
N9Gc3Ey3juPXQbWkK2f8QcJTIXUdlVzhWNDIDorbozgm03Xh/EWK+AoSfxyRxxKQ
DEzGmJgOWfh5BKFUBwSH8GG0WmpoWPfJnyJ0ZPSONLfxZz7hVy5LFhLVg/5fmyXG
GS6WBizO
=Bmv6
-----END PGP SIGNATURE-----

--qzysk5dfjuwhgqni--
