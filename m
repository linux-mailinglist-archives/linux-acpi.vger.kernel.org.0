Return-Path: <linux-acpi+bounces-15397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC5B14819
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 08:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7390A1AA0557
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 06:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D1234963;
	Tue, 29 Jul 2025 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZDNM/n3E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CC1DE4CA;
	Tue, 29 Jul 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770047; cv=none; b=Kll83FgcFyfAc/wlJY0a3nbjZxnqTORua2JlfWt6S60Z+flPkS85IVaqt2mzaLRxx7fTBfx1HzNEGW6xN2xcpvwolOcuXwgY4XOZmlI2levijXtzvgA8motuTmD/vY3socjOvCqZwJcsYDuD/B0aIqxvLPwk12c1QC2SqbtkXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770047; c=relaxed/simple;
	bh=QERG914yg3BynZPFquWTcOlz7UCP7Mz3s+ofkSOPeTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=drsw6vNDpUQ58ioXi2jaSz3tCIazUMfKRUc7y2wgT10M2p/cRXOiRx+FnS9mIN4j0ocJO2swgQnblt7VvMmEkh53A5cLbEGcrF78Pe/6RJY+ygnXfPeI7rxLsM6FqTDf7xZIwzxoYV6GANZIafP4RYHXwfZbD2r7ybN5jyQhgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZDNM/n3E; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753770041; x=1754374841; i=w_armin@gmx.de;
	bh=o00hO2gJzLfPANfIB1Jx+zNaKBkDbKqP/X3srWbHW/I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZDNM/n3E1r31himIel9pl+ThSm+FfWkm9UDAPGUQ/rpAqOAfkiKn1UBkpCsKFJjk
	 LL1tKNWd9UVjz0cGUEE+2hjvP/Mo4yThe0x0wd0NPgfitl5AuCZb7Dts75xnq++kl
	 yMlgMw+pzgjWTNcSoPTQYKjy60hIfIAILZirquFLilBL3yro3H83Wcilkfpzdz+lm
	 zMOAnnAUkbto1jFXRucp5+9+r76R7gSnB2rEoSBmlEqY/SbEm6Xw5szN/e7IlAtY5
	 vxN2gPTZhtYKxejlzKqUKLNEPDMpaot41gjlsWxaCMYy+yMcRA3t3lsvau3r75osv
	 cAXoP4mSgzwHuthE4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MD9XF-1upgF741DN-00DMDs; Tue, 29 Jul 2025 08:20:41 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org,
	me@0upti.me
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
Date: Tue, 29 Jul 2025 08:20:38 +0200
Message-Id: <20250729062038.303734-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EyH4Pb7b5VvhkOzB1GQeKT7WkqQZHBCaF+f3TAG7il324AbGqtR
 UnAahqBTFG2tML12d8ahBiYuuNB7BYAWPNT8gCurs8uR4o8Dd+lJr+yz6PIz3mzAlGquT0h
 MNyyqGDS77DD1mY+5DctbmCJMXzxVLJaKAE66/16UMfqJZmTK1Lt96KzkbChCY6MHR2cYYO
 BrzRHYtFFHSpwA2pTCvbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xCPOztklf70=;Zrpy/hzOX9UznhtY0S/M0UF8Jj/
 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

It turns out that the ECDT table inside the ThinkBook 14 G7 IML
contains a valid EC description but an invalid ID string
("_SB.PC00.LPCB.EC0"). Ignoring this ECDT based on the invalid
ID string prevents the kernel from detecting the built-in touchpad,
so relax the sanity check of the ID string and only reject ECDTs
with empty ID strings.

Compile-tested only.

Reported-by: Ilya K <me@0upti.me>
Fixes: 7a0d59f6a913 ("ACPI: EC: Ignore ECDT tables with an invalid ID stri=
ng")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/ec.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 75c7db8b156a..7855bbf752b1 100644
=2D-- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2033,7 +2033,7 @@ void __init acpi_ec_ecdt_probe(void)
 		goto out;
 	}
=20
-	if (!strstarts(ecdt_ptr->id, "\\")) {
+	if (!strlen(ecdt_ptr->id)) {
 		/*
 		 * The ECDT table on some MSI notebooks contains invalid data, together
 		 * with an empty ID string ("").
@@ -2042,9 +2042,13 @@ void __init acpi_ec_ecdt_probe(void)
 		 * a "fully qualified reference to the (...) embedded controller device=
",
 		 * so this string always has to start with a backslash.
 		 *
-		 * By verifying this we can avoid such faulty ECDT tables in a safe way=
.
+		 * However some ThinkBook machines have a ECDT table with a valid EC
+		 * description but an invalid ID string ("_SB.PC00.LPCB.EC0").
+		 *
+		 * Because of this we only check if the ID string is empty in order to
+		 * avoid the obvious cases.
 		 */
-		pr_err(FW_BUG "Ignoring ECDT due to invalid ID string \"%s\"\n", ecdt_p=
tr->id);
+		pr_err(FW_BUG "Ignoring ECDT due to empty ID string\n");
 		goto out;
 	}
=20
=2D-=20
2.39.5


