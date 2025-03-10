Return-Path: <linux-acpi+bounces-12000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5C5A59567
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 13:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A85163AE8
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 12:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF4229B1D;
	Mon, 10 Mar 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQJyaen2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D62288F7;
	Mon, 10 Mar 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611454; cv=none; b=KAh4PDYuidlH5Up2NJ/GqZ65/8EupeD9TWT25bbbE/sJLP+NtxEEvnqO8jkfy1rvpfFXFhZWzunF1OKAe7/+EqZfB+lVoRB4rEtd2tgTy8Lrj0N8lVvC2W9ztvTtUogpbO27yJ82tkjJruDc66C5/vAYu3ke6H+39SMeNdceT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611454; c=relaxed/simple;
	bh=XusGCXjnLrO4NIpb4V870oB4yFDARgNHjuBdPCvCho4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+rzD9/xcMSOyM9Vlj2tBMIjdmiahR/Pzvhc69d9r4tuQczkRlacWyxRQ6epomgYM1tV++9c2zj96O3fUSFor7/pnatmWvZh1nlUcFjfshn6aH7AGTFzCSkNESm4h4dtt5CBNj5Lpvl0N8Zf7HEs5MxBBrlyDHFUSTFDELmrgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQJyaen2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bae572157so41846021fa.3;
        Mon, 10 Mar 2025 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611450; x=1742216250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fpwBD3x8iSJEU67vP+98+iDTZb39NqeaJlJjG/XKE/4=;
        b=mQJyaen2Zc8q9CW4NkbTp/UCFB4Rl36rrp92iocTn2fdUhA+hns0i+xwEzYFkMEFf+
         5+SoxbdTJfVHqgHQAAct/fijfQT4tB+NNPhDa14L5p6UWd9jOdHqCyh+khbgOZpdDZHk
         eUYQclPy++PgxQCLGFp+XTGjnzRz5PrgW0q3XyN3TpXvNDOpHKGdGdzJnwzYXiyZas21
         GthUDdpISM0YXdjYnDsd2RHSzbQGDGqDMwcgWzqx515RLBBEr7+8y/zhbGe+Cfx5YOz6
         G4U4acn56BXBHkRJzltjO6YPIpELklRi0ki8cZEOczeyg3aCyZGXzc59ORgk/hmWz0gq
         eByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611450; x=1742216250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpwBD3x8iSJEU67vP+98+iDTZb39NqeaJlJjG/XKE/4=;
        b=U51Jz5ade3x3gNPfuMbOhKxjR53ed+TUfTyw05cKgceVjZrCcC/4B4VP51AadPQHFk
         5yf4vjz/YgHaWXYQLze25WhdM9gIiEwpUf7wBJohi8wWgHHAr5rGJz8IRizWKs2dO7BK
         tIh4UKZtOgDj+zKc7wmNtW708djdkvzPmBRtThgHsTJfK1mPcQer700eo4B4PVlpG21h
         yzRAkpwy+Vx1xw7wK2UA0DJWKmtRQhakyOn+jlTQJBgbKWF4QmN89B4HYr4d6H+DeNWC
         p2DeJI/5qUbbfQlwBsOe3qVgx7Ik6IxJxviRVBeEFtOhTgivFSrDmiANh0MmMnP6RJms
         Qsjg==
X-Forwarded-Encrypted: i=1; AJvYcCVjOexvvCFodMPZMT3y6GbM1glh6Xv/gxVA9fUqXXd/yQzPl/H3dOOJnrfHqGZ5O4J1v/dsqENwDBnY@vger.kernel.org, AJvYcCWZzZ7HNdXG87wZ2fEciydGS5A2eG3ZBjWR4IEqZxkFPZUfehJHeM+dqNldICG553QIeNKBEjVE@vger.kernel.org, AJvYcCWoF7dfpzss8gQDJTFWlhtlVn52wHGK6xYTAyPRL5Xo7C7QLOU2DGSeNktZ3B56G/FJD0oktHrw3ZL58Tfu@vger.kernel.org
X-Gm-Message-State: AOJu0YxvITheEUjXhgCBWj+97TA0JSq+1oD0mFKLCqKy0NEBpi+nagmw
	mIb9rZ1Oyivqm2ZTEHeP1WuZw5SEw0elqL4qD+ZfXkOj+mELj9Y+
X-Gm-Gg: ASbGncu/gjHZyWrfZp6gxwyjDbprAvLc5xVGSGmhJy8L1uGBGY1S4AG47xiwRzEZ1u3
	4cTrzIk38fHVcCPTEpTOz9qYxC303HsEzU4zt7h7mjkj6MY2XY3f4gLTrOwz8ADR717pAghk+fZ
	J/AN8ISChB5zHOS75RZ0fZjnGsR3Njki20QcQ+8wRvYUemvzQWWrAPrbqojU1MTjaItsK0MpKJU
	H8hvGwqm4m4cjhWuZT15yMhQTq8vM4lZnB7Z9wlRtGkAU1POeaCCzO+NBR8t5/OCij4dcjB7JeZ
	t9TCgAcoHSBNp9J87nsSCe47y29bmFa+yvLEjdqUP15Fv1AuFH4fitejSe1Urw==
X-Google-Smtp-Source: AGHT+IGI+4SKzYIDDI/CqOFuISbqcvk/INtbWwZopqKeLbrpPLP1v3bcrvM01tlRht/FIloSf5xc7A==
X-Received: by 2002:a05:6512:3d15:b0:549:5b54:2c68 with SMTP id 2adb3069b0e04-54990e5daccmr4642748e87.22.1741611450194;
        Mon, 10 Mar 2025 05:57:30 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bcf98sm1451461e87.128.2025.03.10.05.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:57:29 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:57:26 +0200
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
Subject: [PATCH net-next v6 09/10] net: gianfar: Use
  device_get_child_node_count_named()
Message-ID: <1c4b9b4ceb1995bce76a0ddef0e04ad0d1d81190.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uEr4BMf2amfewQlJ"
Content-Disposition: inline
In-Reply-To: <cover.1741610847.git.mazziesaccount@gmail.com>


--uEr4BMf2amfewQlJ
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


--uEr4BMf2amfewQlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfO4bYACgkQeFA3/03a
ocURZgf/YbQQKWUSJXQpAgQKTcEKSgAD9+XsUFtJSYEsmId2FVEx1a+TAwB6sis2
MuasJQ0Viv4XGR2JGAI195m/vrM7LrBC3RDcPi+lVUBRS/Hd1Bihgb1GB2yHua1B
RhAGCB7ykW48AdsrdmDzrsyM5G95Q4LYR/1JFxsz67CD/gjEoxXTqVYz7Kh6Bm1p
tKUrm7haOBT/0kUrAzzcsteqQUZ28DmHn+2e4M8FNtC1Lb7b5CJJ4plECo3j2AG2
Sk6VByw/WmkYeeoG3ft8an0iUJwuya8WZ+OtpTBoCFi3iFwas3uYTNspfd+c0cUE
12C4htU0Lt/iXOHQn7ZL3j+LFZRPmw==
=QxV8
-----END PGP SIGNATURE-----

--uEr4BMf2amfewQlJ--

