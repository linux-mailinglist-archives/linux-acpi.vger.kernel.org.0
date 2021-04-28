Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919D336DFBD
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbhD1Tj5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 15:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241927AbhD1Tjv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 15:39:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0985C0613ED;
        Wed, 28 Apr 2021 12:39:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p17so5455008pjz.3;
        Wed, 28 Apr 2021 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=5M8EnYURBjzX8y0h+Dz4U0bf8pObQR33VCrys3oNTlE=;
        b=d0XPd+jYEgmFF3VoLFl6T1C2ZDiJ5qv6Dun4f3p0GrKheIcSwMuHxv6cMKpiJunMCg
         1Wy45ZzKygnRNbfChf6/sUS73LXKyafp0ud4/nWIKTddlTGoswxh30qtaoKeyadhVzxU
         rcP5X+2+zLVLsoApHXwuCh7z6+tdU1YXZTu7Gwd0WE7PRi9RzarDhd8yH4V9f/QYlb6i
         Kk9qI0udU/g9rPRP9K/wIsk0tGlvfkja04Vb85VkylCZi8nS/epH2ugQOfgwuLuq9Xg4
         BjOQA8srcwz1Z1G6jAqGUw46j8sIck3XT3DizGrWxikHBwhlgwCafRDQuRJ6oYHAdx9Y
         EcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=5M8EnYURBjzX8y0h+Dz4U0bf8pObQR33VCrys3oNTlE=;
        b=NHaRSWZZuvI0RcRuT7BB0kBsg50ESCNQRLrVmvRVjaOWRb57LtwiZrugHu8ZGdBhgB
         cgTes/tLYf4oI1XTKN1ZDlEsCOmZsGh8iuBTitdgCFVjcOd3qI7RcRcskcjqyJXic6Rv
         QZKY9cOGxvIWO2+3Wg7iLmWCUVit0PLobVQbpFTtjFp1OUzoYoeYCMoXTEY7OX35zHdd
         qDUGz2CwTQAuspPVRRiBDjztqBSriXxI+THbFcNPHbQFZZoVLjZyW91hzyhXyVAymkv0
         GcU+p1p8Boj2CtRnybPxMmzEE2Np08CHas16pgzSYXILX17VFrx2hXjLE993Fe3qufHI
         bHqg==
X-Gm-Message-State: AOAM532bacb0YeCYvkBSZHhK3kYSWkRalhb+rUb+PQewYaR3LZtyFGXG
        SU5BwizhAAJQk3Hv95wBLtymthpGIKCiaqf2
X-Google-Smtp-Source: ABdhPJzlegbErhljiRWH13MlTC4GxzfIYkNHi3YjnWLfx86OTyc6cXHrHDcd0GcR/2F3H/dwa7v/aA==
X-Received: by 2002:a17:902:ff09:b029:ed:3b29:ff43 with SMTP id f9-20020a170902ff09b02900ed3b29ff43mr15444309plj.14.1619638745292;
        Wed, 28 Apr 2021 12:39:05 -0700 (PDT)
Received: from localhost ([122.172.37.94])
        by smtp.gmail.com with ESMTPSA id e1sm450177pgl.25.2021.04.28.12.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 12:39:04 -0700 (PDT)
Date:   Thu, 29 Apr 2021 01:09:01 +0530
From:   Anupama K Patil <anupamakpatil123@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        B K Karthik <bkkarthik@pesu.pes.edu>
Subject: [PATCH v2] drivers: pnp: proc.c: Removed unnecessary variables
Message-ID: <20210428193901.rqs64di4g2svpaeg@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wpqdbbx7thmklwzk"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--wpqdbbx7thmklwzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

de, e are two variables of the type 'struct proc_dir_entry'
which can be removed to save memory. This also fixes a coding style
issue reported by checkpatch where we are suggested to make assignment
outside the if statement.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
---
v2: Added Reviewed-by: tag

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


--wpqdbbx7thmklwzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEDSQZGCDcREXgcOjQtGmOOZV75b4FAmCJudUACgkQtGmOOZV7
5b7ZGQv+OsD9HAhDMBbsq6Ute4rDohSUul6M4rW7LUnq+WnRUnvrNCr2LmgavQCT
2t6y8PDlb2lREPK3/I8bbIky5uX5d+/sC83qNpoKzhvYbepC/fptg/33OFIe3hbR
gbPrRmkDkqM8yhE/fOkQYSLGBnvFSzjSulh3VhcQlLkLsG5MmOHFzuyMsO0ANp58
0JzH181yuYUF9A+Q7+xoizF570q4Q9vmi88N5u7TEey3JLOwqMa9bu0ynGYHpzIn
DLFMfpZQNsOLX6Fy/mztzx0FZLb8H9xoHv7g0ypQExfIA/BPWcpPjs88AC0lhgTL
QxquiBbR6s37zM4ktMjwxOzu1bCHJK0SdmkXxWi1hlFuylxaDMbZI4tjfNjq3KsC
FZRuD31uKt7XQ/Q+8UZwoq2Bo4M3KIU8LaPy238Ef5p9L6QKS56+DKiu/LCEMCSV
6g8ASBxTB7mg3sxJiumP+xe9KKYEGETfwqLyC1hJ5cDvTtGvMkBS4glM0X8Dp3W5
fbekUmGL
=csKr
-----END PGP SIGNATURE-----

--wpqdbbx7thmklwzk--
