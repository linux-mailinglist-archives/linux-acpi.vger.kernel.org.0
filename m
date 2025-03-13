Return-Path: <linux-acpi+bounces-12169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A275A5ECCA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 08:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1093B23F5
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA41FBEB8;
	Thu, 13 Mar 2025 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFAARaF2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81C1FBE8C;
	Thu, 13 Mar 2025 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850420; cv=none; b=YZ/bIMrmNdSMOQ3l1uuRz11aohm12ISZ7aLWF0qduid7PaO/TLs6x0swbq2Qwbg+DBSMulOpDdewnO5eCyj9xh8LQ5bJB05tXIIMyQeMOS0YYzs3/MCd80WFMW01wqI4xcHvsV67G8tN9qDJ/fVySnDYuegoVaeKCNX7MvKSRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850420; c=relaxed/simple;
	bh=8+5R8oAkf2w0knV/jkn16g5f4JhtDgvTITUpMQVzAQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFRZEU7l7baI3r9cm1r0Lm/SBrR6E113Kote7mzuN3HF/KV6N/BETYzLffnFJGZ0SkRuwQGuhPDf7jcCW9RsxWTCNVnvrBF7F0bPndfYhvFwKaRp4UgbgOMNeseZpPhG/ILmUPlTSrM0wWq3V8XCZ9+CRUDv78RlFA+ELHic8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFAARaF2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54957f0c657so596071e87.0;
        Thu, 13 Mar 2025 00:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741850417; x=1742455217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DI6EVYpCVvB4/qiCa4qjIWIjpDvbPkgz7MveeCW3mw=;
        b=TFAARaF2J4gp1tSsDYzTHHIHBFggJLRxOP/xoT3OdOC4BZQbvFOTzTmLvNVLHWjkYX
         tousdCXreQcYFj+YjsxEcwY0MoczJEVmFCjNiThJ5jmH922102ExavnixkozE7aQwiRc
         NeyTcTLNkPrC5Qot9JsNBwG/M/Sb04foo/O+U01lyWl7qUx5WprEvbXZT6/v4MWnz7cf
         NOYAkElkmPBrJa1Rzk+Stmz6Hy48SZR6jMT1kES15gjcCT4LflnkK+At0xT0JtZQJXCd
         wsmU/KBgNbGlb3QxzPswzBRflN0/7qGq1jFD+W1GL0MqMp5LeFo5GIca+hXfjmqb7Tvw
         8m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850417; x=1742455217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DI6EVYpCVvB4/qiCa4qjIWIjpDvbPkgz7MveeCW3mw=;
        b=C6Po9zTO1AdHP9YqgWCongIm5ztEMsPbuPmyUSZzIrBdvrJ7jftGY7yvhWRzWFFLC6
         Pej/fTOtmCp6O2fwytVgfhSMjQCfe9i+ifC4BZ95JUSvuzhWHQ95emEko08TgdH/n6Qh
         wG9qMyQvG0M23+Y+ZvNoYqoLW/YHrF0k2C3EG32AsGBansqSXAnHnJrjqMDSqIAPjEII
         su9ytGg/LB9d+owt6cL6EL8tlrv5nm5G4e6FqUZDSWo/saWNH5Iw0wnbpNVybPUn+CQN
         fR2krbovEwhhn4QUDoIgH1u7AHG99hoFC3hVay/k3Nt1tKoF0RZY4yICuIwskbSOcuYR
         8mqw==
X-Forwarded-Encrypted: i=1; AJvYcCUxla5F1mQHU2MMKyDlJg88uaJHKCY5/423BDUqNuZtkhH7ZObSkrjvmwaSVD/njHp54T/uPV8g@vger.kernel.org, AJvYcCX9orGci0wuK4eqBHbwps2oB/Rkw9tzNeKJSXqCdTj2ewlzhA6Rj5EdytWpyNCy5+GVNDxQkmOeWvyHF4BG@vger.kernel.org, AJvYcCXoM8pmmA02beO9qWYlNAbMdA6WiNiBg/ayh3DBp0HvpqC8LZu1UtJeRiNXCXSkM26KGqGcdeEXHc6M@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXknmt5ExoB4jYx7TX5pFyoAoq1GnxgdweOIKT5A1oIYz1MVX
	ldXcwthyxboIjdooFMiLOSPGHKYz1C2/AU449B0wpJ4wK7A3K/Ap
X-Gm-Gg: ASbGncv2278sJc1ZzTYEGA0aUlYMQID41zRhgijEoGldgxqABzsKgVd2cqwssNscSjT
	MY4eltNl8osCDPOGvmWyf7AZd4VEdVp6XAFUk32ELLuX0CCA2HeX9Djh73AUzAQkZYx9pxw4mMw
	SfqU6JWc8LuCID3NESHTgjh42oWsmZbJLx+55lHc6aRRWI+4iosx0rBjrN0HYngF9IkG+myO5Kh
	QO54/vtVcs372K0B8ubDR1aAiJzXpEdijH/1s+5L1FiRd0sGfwSqAO9E/fvgr5C9SfCZzU8YrpS
	2mVO2roasalZoh92UBuYvylADRHDentlu8b4Snx643VcpcnY1Zg=
X-Google-Smtp-Source: AGHT+IEvKiFXV8bl8B8NCAsPn4Q3j9WyAgKXI6XenFkBx9F27xE0i3dUdEtsIDU3jwE38eBjv4GKFQ==
X-Received: by 2002:a05:6512:3a91:b0:545:81b:1516 with SMTP id 2adb3069b0e04-549ba402659mr516598e87.15.1741850416733;
        Thu, 13 Mar 2025 00:20:16 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864defsm119636e87.144.2025.03.13.00.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:20:14 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:20:10 +0200
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
Subject: [PATCH v7 net-next 09/10] net: gianfar: Use
 device_get_child_node_count_named()
Message-ID: <b587e36467941f27e1273a9cf2cf3b0783bbb5fc.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hGaVRcR8qQ6erC81"
Content-Disposition: inline
In-Reply-To: <cover.1741849323.git.mazziesaccount@gmail.com>


--hGaVRcR8qQ6erC81
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
Revision history:
v6 =3D>:
 - No changes
v5 (RFC) =3D> v6:
 - Drop RFC
 - Adapt to changed function name.

It's fair to tell the pros and cons of this patch.
The simplification is there, but it's not a big one. It comes with a cost
of getting the property.h included in this driver which currently uses
exclusively the of_* APIs.

NOTE: This patch depends on the patch:
[2/10] "property: Add functions to iterate named child"

Compile-tested only!
---
 drivers/net/ethernet/freescale/gianfar.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/etherne=
t/freescale/gianfar.c
index 435138f4699d..d4ee0fc843be 100644
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
+		num_grps =3D device_get_named_child_node_count(&ofdev->dev,
+							     "queue-group");
 		if (num_grps =3D=3D 0 || num_grps > MAXGROUPS) {
 			dev_err(&ofdev->dev, "Invalid # of int groups(%d)\n",
 				num_grps);
--=20
2.48.1


--hGaVRcR8qQ6erC81
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfShyoACgkQeFA3/03a
ocVCbwf9FCSy00O+u7nvyVK4t4iMJveXnv7Wizd/4qGbFZ13SJZkk2aRbDeyn7zz
29StqIw5hnK6KfF3Ss67V/Ha5WzP0+PhZZe6jaqRaTImxaXxT5BKaafgfppOQwRr
hySuGDKqmJ97hmaFRK6j25nBbH4xnWeDvdEafDxQki5NBAo4Fnikw/gQj7XwLe6s
6eQy2aPRkEsSo5jmU5MbI5BObtNrH45Kz0ONCbSSEUJpbRGHbDtWWP0CeVu5UVz4
B2swMKylcJIBSyGDefIuYFwKT+gFUF5knLtW4xNp6VDCZJcoSRNs3tPo4PhtpQzw
7+DynBANSaCE++RJLJEH9o7dUswAbw==
=eoaX
-----END PGP SIGNATURE-----

--hGaVRcR8qQ6erC81--

