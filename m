Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE22836A2D2
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Apr 2021 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhDXTnq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Apr 2021 15:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhDXTno (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Apr 2021 15:43:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B265EC061574;
        Sat, 24 Apr 2021 12:43:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so815639pjz.0;
        Sat, 24 Apr 2021 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Eoyv3XG1ZYXEWoIOV6LUW5hDQHt2KxAWCkkKAqqPJAY=;
        b=CbXXAtAOVudmb5LcFoq3EFLwMI263EnPJykUMS6SNaZrMh8pptLwCWFxqpjUte7ff7
         bc6DdT614r5tXTDUAMLvlSOwUf8OkZNiJ/BeC8gUp4U8V4pHAmuWKtMcApgSzMF6qwPt
         Uu8NUdhAxLMpp7XhgBdwNYtGbuKBYv3swL8RfG4OfNSwZgj4nqs4CbN+J1fnBDGUAaGx
         LVTFqAB0bgXkFel3/4M8ZUylKrfWG2Ex/DJl7JkaNc3NFp4bXuEUoex7VvQRDKJbSbXA
         MeWb7PSzHIJQxyv3Umg9FW7At2oUv3QOnBY9AmgqAfi6V/k6GpCdJviY403mkbB7/FUp
         SaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Eoyv3XG1ZYXEWoIOV6LUW5hDQHt2KxAWCkkKAqqPJAY=;
        b=Dg5ectWlwYfG8vyxGiyP/tt2mdQct++AE7R3JfHnWwXhKPflyvG7UP+rYhg2m8m0WQ
         E5zwqdQEis7GUcQLGk8jyAvhJPl/t75hKhfJO5c8PZYpfHIHeGuwwaYWPjTm1XPPBCVX
         56lTV9XX7sP4FLMCD8ma81t8vJwx1MWjCG5L8SBlyqZJuFXmVzWBTHbK9DOlasYLPbgq
         wbudKq0+9Cz+yJU8iy35gpkAG5k2PnUpXIBXDYK10yRAM8vlmX7/2VHhHiHyANqe/8Pq
         p6p70eEohVqZK0/87xDL7esJ60F/Qa9YyuyS6RPFtkB/NAejxnNwm4zst0aZCDGnTjoA
         rsKw==
X-Gm-Message-State: AOAM531NSwHdnjjYsUvmoBoHYZwMDQk58IUd88nOoVpuOwylIwX0B41J
        bXT8MNLHlTIDmLTVndcR10X5JzFwYk0GGk6j
X-Google-Smtp-Source: ABdhPJzBw2E2Zkoqa8O0arEZVQ4U9ON+3Rt1poxgjpgfDwTquFvhv0YZPRwwbcpO4tG7rkR4LvgW3w==
X-Received: by 2002:a17:902:dac9:b029:eb:732:d914 with SMTP id q9-20020a170902dac9b02900eb0732d914mr10122606plx.85.1619293385028;
        Sat, 24 Apr 2021 12:43:05 -0700 (PDT)
Received: from localhost ([122.172.37.94])
        by smtp.gmail.com with ESMTPSA id u18sm7572146pfm.4.2021.04.24.12.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 12:43:04 -0700 (PDT)
Date:   Sun, 25 Apr 2021 01:13:01 +0530
From:   Anupama K Patil <anupamakpatil123@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, bkkarthik@pesu.pes.edu,
        gregkh@linuxfoundation.org, kernelnewbies@kernelnewbies.org
Subject: [PATCH] drivers: pnp: proc.c: Handle errors while attaching devices
Message-ID: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qw4iz6cfhv4x3sq7"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--qw4iz6cfhv4x3sq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

isapnp_proc_init() does not look at the return value from
isapnp_proc_attach_device(). Check for this return value in
isapnp_proc_detach_device().

Cleanup in isapnp_proc_detach_device and
isapnp_proc_detach_bus() for cleanup.

Changed sprintf() to the kernel-space function scnprintf() as it returns
the actual number of bytes written.

Removed unnecessary variables de, e of type 'struct proc_dir_entry' to
save memory.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Co-developed-by: B K Karthik <bkkarthik@pesu.pes.edu>
Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
---
 drivers/pnp/isapnp/proc.c | 40 +++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
index 785a796430fa..46ebc24175b7 100644
--- a/drivers/pnp/isapnp/proc.c
+++ b/drivers/pnp/isapnp/proc.c
@@ -54,34 +54,54 @@ static const struct proc_ops isapnp_proc_bus_proc_ops =
=3D {
 	.proc_read	=3D isapnp_proc_bus_read,
 };
=20
+static int isapnp_proc_detach_device(struct pnp_dev *dev)
+{
+	proc_remove(dev->procent);
+	dev->procent =3D NULL;
+	return 0;
+}
+
+static int isapnp_proc_detach_bus(struct pnp_card *bus)
+{
+	proc_remove(bus->procdir);
+	return 0;
+}
+
 static int isapnp_proc_attach_device(struct pnp_dev *dev)
 {
 	struct pnp_card *bus =3D dev->card;
-	struct proc_dir_entry *de, *e;
 	char name[16];
=20
-	if (!(de =3D bus->procdir)) {
-		sprintf(name, "%02x", bus->number);
-		de =3D bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
-		if (!de)
+	if (!bus->procdir) {
+		scnprintf(name, 16, "%02x", bus->number);
+		bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
+		if (!bus->procdir)
 			return -ENOMEM;
 	}
-	sprintf(name, "%02x", dev->number);
-	e =3D dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, de,
+	scnprintf(name, 16, "%02x", dev->number);
+	dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, bus->procdir,
 					    &isapnp_proc_bus_proc_ops, dev);
-	if (!e)
+	if (!dev->procent) {
+		isapnp_proc_detach_bus(bus);
 		return -ENOMEM;
-	proc_set_size(e, 256);
+	}
+	proc_set_size(dev->procent, 256);
 	return 0;
 }
=20
 int __init isapnp_proc_init(void)
 {
 	struct pnp_dev *dev;
+	int dev_attach;
=20
 	isapnp_proc_bus_dir =3D proc_mkdir("bus/isapnp", NULL);
 	protocol_for_each_dev(&isapnp_protocol, dev) {
-		isapnp_proc_attach_device(dev);
+		dev_attach =3D isapnp_proc_attach_device(dev);
+		if (!dev_attach) {
+			pr_info("procfs: pnp: Unable to attach the device, not enough memory");
+			isapnp_proc_detach_device(dev);
+			return -ENOMEM;
+		}
 	}
 	return 0;
 }
--=20
2.25.1


--qw4iz6cfhv4x3sq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEDSQZGCDcREXgcOjQtGmOOZV75b4FAmCEdMAACgkQtGmOOZV7
5b5rYQv8DcfmujcVa4Pr/2j8qdR7cglKcWf8wD5DJzufBdxhKF64RpkQFtpHFfbS
yb1X0KXHY+LonQgM994qYdnGA9zrBG5xihlhc9LtTjGqG3FTovVix1DveLX6GrXs
9fmlEkGA8+Hn+rFbTfP6iJQBIGa3ifqqAWLVKbYPrA+9aox3b7HGDnzOvb6GhDAU
vKEjRBFaPjSSHVsfiRnKCZJ0QW/oWvy0kMprR8bBa/pj8iSXD9qy4izut+ZVPs60
JIe2YfGaitBlkhIU4Em0qgtJaACq4Ai6Kmb2x/gjQ3nupGzEoIe4XLVJKmggqdnX
ccSBPJDT1KxPtYjI7Z2jqvh1G8wIb4YgtSB3oDgY+N+qFdBnrBveGItRBD4C8QPd
80MFliKByEKy2v+ggnNweiznGp3Q1VVzvKySgdiKQz1rmUF3cLO2T84mm7TUYMNM
w73W0XKpRiqeuALqqKfCGV7fpFIHzjQgmX5vpwps+hY4xjgPnl+gg9bjOWviAHIb
6kKRsZYT
=x6jQ
-----END PGP SIGNATURE-----

--qw4iz6cfhv4x3sq7--
