Return-Path: <linux-acpi+bounces-11793-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99169A4E82E
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 18:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB208E1A96
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE0277812;
	Tue,  4 Mar 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl/6/xcx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A125DD08
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104652; cv=pass; b=otGq8Lf4mxCFIE6Q5H0pFslE2/WUZtUnf7mh/cV5C9QksQLxOF7r+mCzVcaon5nNA8csE9Rgx75l9pJglKmPpJnNL4NXDgw8UDoo44TYiaybLWE/enIPuKaglMrHu+ik0+hqdR2CJM3VwYAsJpHFbyktOwSpUBnUH0KUf5Xruyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104652; c=relaxed/simple;
	bh=jx3146JYbYlH5pk+ZQ9COOYht6moRMzBNf0ugU+7LZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZPplCLvhh30tTd/pfyNEBN4SwTUNTo8bknd2epZD4I9E7oP85xGoFcR6yPY/JdC1EDI/MXRHrgFYG7syRM1OHCkUuMuUBo2/nLgZgolJ2tZL5DFy6bbJUeBUXrtgbiZ7TjoictZ04NuCSekxpkP3XbIzBWjf7TjxMKylq+jAmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl/6/xcx; arc=none smtp.client-ip=209.85.167.44; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 5A7C8408B64B
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 19:10:49 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Jl/6/xcx
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gbJ1x4BzG26t
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 19:08:44 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5C4AD42749; Tue,  4 Mar 2025 19:08:32 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl/6/xcx
X-Envelope-From: <linux-kernel+bounces-541596-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl/6/xcx
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id B609F42164
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:37:11 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 63CBD2DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:37:11 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F291614D5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E5C1FCCEC;
	Mon,  3 Mar 2025 11:35:03 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758741F181F;
	Mon,  3 Mar 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001700; cv=none; b=QxGlS44W88z7IX2Lj38P+/1ixKVU2P4LWYtf42srMOQ75l4e8HoluKLRJPTdpb4MGzAGqwUoLm2gzCN5MSiZIsCST8Dexi42xUT4fsYNKVVIfAXgUnc+iEFTuLNbwP3bnxm3eT213AiwzXLXXOkHvO0GhxrjU4FG7gykJMjsLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001700; c=relaxed/simple;
	bh=jx3146JYbYlH5pk+ZQ9COOYht6moRMzBNf0ugU+7LZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUE/eYtDm7429E95ZV/up8JlbiNcul7Vn9mKFXbyC7ARj4eFmHBdzduIa4J7mUlMjWu7ujoSARiI8v1zn3egCrfRQZe9Po9C8SUASrDidLGQ0an0glOcYsHSMywft26YmDy23ZVwGKtN9m1U1rfgWkSFSgGPWqwRqScog0mn0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl/6/xcx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54954fa61c8so2919182e87.1;
        Mon, 03 Mar 2025 03:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001697; x=1741606497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vqQZzxtB3T8t2wF4cCO8ECh4fmEl1bhgAvi7y44b40I=;
        b=Jl/6/xcxheC6u90pwHY1kyuNzjN1Bh4ZJSOS2TFaVUUbnxgMFxmq+sK3PLB/W/tm6G
         mTzYlvOU9/QTPq5V4m2jXzuICpvORmvnr3xyg2qfG05JOTkDHdEwBItPAB1auk1ADDuX
         i3FTu/Yj4T7U7DnjCnYO5vdybWHg/sWd3dEgJnyURikKmKMsN+6Gufjot+gDqxdb6aZu
         d7sf1rXfinZFHeRmfNkgou3YF0F37uUVdK3gUyc6deY3tbrsrtfVswLrm+L6J/RjeEGZ
         be7wryxb8DANbc4JErQI1/+DLLlonDla97FqZfglgJZIPhbCUO2k/EDNffKaV8WT7T1c
         cIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001697; x=1741606497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqQZzxtB3T8t2wF4cCO8ECh4fmEl1bhgAvi7y44b40I=;
        b=Hp1wk6gCWcg3BYEInUc+22OG4gaFgNedi/8E39Q2lLB1p0dzb14sq0E0KYlVmTI43h
         0geBp1wDg/+cxDjNFAZylzS8mWu2pBkX5Ub5ISn4grbyU9EwLpRSj8MwOr3Tykye4Z2C
         tmoTmYNqt2stGsNS1Imi6kyRDH/3tV6pkzZhr/ugl547z4hbSM6Kp32TVQ5Pf9tEUDri
         KL7NHuL0qkWtZu/vxrGzmGBWUAM86XiLwm9MLEOd9uS5VZvCDBBTEYFrFfrywpAjKEyk
         M65589M2+rRX/tEBab5B9msLwNsWD8Nm5JxF2i3QD9uPtGXGgrYcIcOtn+XDU6EjDhs5
         LJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCXKw4DAWGSJHw4LKXAsf16u7+8rmGtOqipeESFG8mOly78VG8Z/Rvkj4MOWAtOPEjHpjdTaAWt41+ii@vger.kernel.org, AJvYcCXhhwmj306LpnGVpGEhaPVs0Hd8XLPLHD1or0gLx3pC0lv4ltqcKvLWs9jD78a1dyy3ub68aqd2@vger.kernel.org, AJvYcCXroOFiRmRjD3JieFBtiU2zVqWj1XoaramuGQdQbNoCFTto7egZc5EWpTcKU0KEOlz6xFOHev12HIg8/8dQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcgsce0Y50ZDyzHci5QZv/9RYYJxtqUAllQ2rBBX3lDt4mQIdE
	z/WU5YTmbNRSQMi64g3P4JJ0maQszLNLPB4TV1Uk0mt1nxtd/oOp
X-Gm-Gg: ASbGnctcdQmyC/6jxXIJrxWvsvZqPD/T/QdaDH91Vn/fKlnkQnLXW1vQwDbqaE1PMVJ
	rK3WTBpiSKIvy/BciLc2utptpe3lzntnXU8LG+PsVR6X4p/uognAlPLI7t78cBNe3XrTXPABdAR
	R4CNif+i3lV8wjr5DYJUpelcMho1OgH+1L6lh93WoODHsJMjO9E3V1f9weWfqXdOGxvM8GOgPqm
	e9z1r7THLuAO9/wX02A5vOh1qo8J26OLIo5R1LK9dcvpjiat7cCk8uHZyVR813t1te2i8GYaaDO
	4qjEf5Z+SmyaInmbNSGVfKm7AmV+ZPNyGH8SNWGLEuijXKYp85RuO21coxr9ouc0xa9/WKS/yRW
	dMrBbXz4PNYs=
X-Google-Smtp-Source: AGHT+IFCXZVt+ZbxzY+RXtoZv0pBDmQxbMpqj21hJ/Pem8fsX9mZWJAC03XuPdYjwoEkBgMl3G0XcA==
X-Received: by 2002:a05:6512:31c1:b0:545:22fe:616f with SMTP id 2adb3069b0e04-5494c3319e0mr6024804e87.24.1741001696480;
        Mon, 03 Mar 2025 03:34:56 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54962196361sm438159e87.214.2025.03.03.03.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:34:55 -0800 (PST)
Date: Mon, 3 Mar 2025 13:34:49 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next v5 10/10] net: gianfar: Use
 device_get_child_node_count_named()
Message-ID: <685cd1affabe50af45b767eeed9b9002d006b0fd.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hgWGIdg2nB92PWQb"
Content-Disposition: inline
In-Reply-To: <cover.1740993491.git.mazziesaccount@gmail.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gbJ1x4BzG26t
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709335.35693@i1TF7B+Qnka1qlUKMJ8N4w
X-ITU-MailScanner-SpamCheck: not spam


--hgWGIdg2nB92PWQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We can avoid open-coding the loop construct which counts firmware child
nodes with a specific name by using the newly added
device_get_child_node_count_named().

The gianfar driver has such open-coded loop. Replace it with the
device_get_child_node_count_named().

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
It's fair to tell the pros and cons of this patch.
The simplification is there, but it's not a big one. It comes with a cost
of getting the property.h included in this driver which currently uses
exclusively the of_* APIs.

NOTE: This patch depends on the patch:
[2/10] "property: Add functions to count named child nodes"

Compile-tested only!
---
 drivers/net/ethernet/freescale/gianfar.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/etherne=
t/freescale/gianfar.c
index 435138f4699d..dfe012a5bc0a 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -97,6 +97,7 @@
 #include <linux/phy_fixed.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/property.h>
=20
 #include "gianfar.h"
=20
@@ -571,18 +572,6 @@ static int gfar_parse_group(struct device_node *np,
 	return 0;
 }
=20
-static int gfar_of_group_count(struct device_node *np)
-{
-	struct device_node *child;
-	int num =3D 0;
-
-	for_each_available_child_of_node(np, child)
-		if (of_node_name_eq(child, "queue-group"))
-			num++;
-
-	return num;
-}
-
 /* Reads the controller's registers to determine what interface
  * connects it to the PHY.
  */
@@ -654,8 +643,10 @@ static int gfar_of_init(struct platform_device *ofdev,=
 struct net_device **pdev)
 		num_rx_qs =3D 1;
 	} else { /* MQ_MG_MODE */
 		/* get the actual number of supported groups */
-		unsigned int num_grps =3D gfar_of_group_count(np);
+		unsigned int num_grps;
=20
+		num_grps =3D device_get_child_node_count_named(&ofdev->dev,
+							     "queue-group");
 		if (num_grps =3D=3D 0 || num_grps > MAXGROUPS) {
 			dev_err(&ofdev->dev, "Invalid # of int groups(%d)\n",
 				num_grps);
--=20
2.48.1


--hgWGIdg2nB92PWQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFk9kACgkQeFA3/03a
ocUnAwf/e1WiKUHI7IJokmxjEd69tjRodEfHXip6VUhjqG9jQnkg1VF0j7ViCQLk
O97jTcDDlEjA8XgIo1/gIWDiLWe2uBRlE5FRwfQhcTnollLbXXYOx/f3T7avRU+a
E0kddnqufnDdJjktO1q7Bq7heVGcqAh7QP/0GP30PKbt236wSC0lGjo7iH1a1nt8
EgOl7L+qqppWvqxzL1qoY0zYERemWmzHcS5rOjSRweCOqDF8uNoIbHVGp7LgMvq2
ElyJ0SBwUDdMQAu8Neu/c6vB21MjarrLFaQKasbv+ZFzfjaxjlMkKL1KbixHAz2O
LXMh5s/s+fqIyssfgy+mWitmDNyNWg==
=nCxe
-----END PGP SIGNATURE-----

--hgWGIdg2nB92PWQb--


