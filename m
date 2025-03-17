Return-Path: <linux-acpi+bounces-12303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E3A656D6
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 16:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8313116DA44
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408A81A8F79;
	Mon, 17 Mar 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7yyAIfw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BB18EFD4;
	Mon, 17 Mar 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226755; cv=none; b=Oz+kauonX8eUWdgr2wMRnsqAcVOVej/hfr8xmu2iNtfMQpb2unzSRL96jcWLw43KbS5qGf3kVv+dYV2w+wauuXqxW6JFn15055SG1YtGgZXxflUaBoRpIFy6c0YnFddKDGWTLu3IWwSWgMWV5fwLFUa1PgmK8p5Xg6TXbYPFvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226755; c=relaxed/simple;
	bh=OGQkmyXOL35hKkBO69DLUu/I8HPGPktH92dHDZFr1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5vujJG6DwsnFgiCGRGgtfbHU7NvzvH0vpZCa6Hbl/dp03RvZaGHrr9TP6TOVZPYh0pKR8CoYJdTQvOFDVXAc0ZC2SEGZYVGfAuwTho1VtrkYNgzK6yUkgbIrIL++eLcT4xdDgm6wYoMdQQgw7KhBbRLwPO+kxh2bYKIUG3HlD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7yyAIfw; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30c461a45f8so38256161fa.1;
        Mon, 17 Mar 2025 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226751; x=1742831551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhq+kH+X05mUcX1Ap2GbPha12Vb9rFmptZREzPwZw0k=;
        b=h7yyAIfwTDXAJNZTQoIbNSrguGP4XQXl89VBPtp6y7wyQNqOr4UOuuGRvIUwtd4+HU
         lio6hSoWK27OG7z/3h/XBIVvi3b7T72G7dIv3jaxdrfTbh/iVpXetmJ+ETHeugp/iu4U
         b/QAui2OCHRIBLR2xTGQxlzMNMUJ8qLO86Pi9FBM5jBPXKS50wzb/D/x1nk3sd6kiJZn
         sBypg08MqBk4Jv6iFNznDQGJrZkCH5sZLldq0ArV+nVY2kH9Hod6yYAuObgA/JbA4u6L
         4vR5gNL9WgD/Gs7GLf/C5FH3+Hb/wiNQlipI74UqixAJdHRuF8FMOKmvoU/6WcDcaNGk
         iBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226751; x=1742831551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhq+kH+X05mUcX1Ap2GbPha12Vb9rFmptZREzPwZw0k=;
        b=Uy8VsqIEIlEmpxGcPddm5PM2JbmBJR5bTft7OGiz+NV+S++PfuSO41lcjpJQRD4iAv
         Dg+FAmJYYaM/mveGJcs3cu4GIrPoOrV8ciaS9GWHLL4hsTr7nMIw2liJvKIGFu2eFGXc
         vn5XlrTP+ETlJjq9ZpI5/FHbFLg3xmuk64+xPNPT40x5dpau7Xw8U8eorvTP8itd8uJN
         EtJljzgRfuT7koh5r0MT2w40u+VZDNwU7dGR1E5ANgXK9q+lNJsDplaR65ZcvBskFyHR
         nHCm36HYLZ6qWZGeVLTXgMIym1OwFZBj2Jjfof5bGNaZXHu/SWo0huhaESp8m2vE4cXe
         qxXw==
X-Forwarded-Encrypted: i=1; AJvYcCVwFFuM9fG4hURz+9MKt1P5twD7I377IQbnACJKeurSLBi0U56kKwIle2Al7NsTpHgV+NLRG58ms1Cc@vger.kernel.org, AJvYcCX+HP0X3/mq4SsBNRR09ToboDNrlOVGaU1qXq/fYrmhMvDcOeEBPubUr5yVtsXfYiQ3RYiJisjS4ZXka8Z9@vger.kernel.org, AJvYcCXqiAEBYdgWhAhNFVlinw9OiVi89z4k4iyGLXbfBq984wGuwIJQVo8Aopnw5weANto6fiSbDCRy@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKUUFTvUqLbK3En96MFhLH1sJphBUdYkHNfNyeP3eDCVpq/ze
	exrlBExyTk4QGHB6Mc1cpg6ehiKRbS6sm5DfVbcfqRiQOFBhfVBP
X-Gm-Gg: ASbGncvi6hLHYo3SdrsZRMdpbW0zApY4LUrItvC14GETAgaKmkA2gupqTySH8sFfTrV
	BnAWlMUw0v0l+3mFVItEYcKJEx8A2j4s5d7haEWXsZErb4/2XISI8BLhNrfJK8DX3cSbbn82kDQ
	i8WbyQ5S6JBNCzW6cyKgxb9ipRRvUFj02jcFyOIe1D0UrqbR9huST2tQKLpxqOxOt4/krjcICox
	g+KBFaSH54CNgRsUHDkKukf285zTnWxkrI9piiFyylsoXoVhamjpcc0tMwN2yJmE7i6RBeDRRJo
	fMwPwLmYEaA7qm5+KGcceiqftDK58ZAmkUecveinB/CRU7mpEmk=
X-Google-Smtp-Source: AGHT+IGP8VDfLvdRHqupcyGY3jxaeZE5NMXtcA2RJMTkKbc2npNWVjBiXR6Dy5pmtZ78eWJwHB/b0w==
X-Received: by 2002:a05:6512:3e17:b0:545:2a7f:8f79 with SMTP id 2adb3069b0e04-549c3902c47mr8375280e87.16.1742226751200;
        Mon, 17 Mar 2025 08:52:31 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a8ec9sm1366286e87.236.2025.03.17.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:52:29 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:52:25 +0200
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
Subject: [PATCH net-next v8 09/10] net: gianfar: Use
 device_get_child_node_count_named()
Message-ID: <95b6015cd5f6fcce535982118543d47504ed609f.1742225817.git.mazziesaccount@gmail.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+bpOqBC81XVIei51"
Content-Disposition: inline
In-Reply-To: <cover.1742225817.git.mazziesaccount@gmail.com>


--+bpOqBC81XVIei51
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


--+bpOqBC81XVIei51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfYRTkACgkQeFA3/03a
ocU6fQf+NqTVEuJIrVBVRDWbyUAld54IR/HPsJ+BOnWD4It8e5tZgefm5rl18SYl
heFnxZbk/pwj/KpENcarv8gnNUAqTcCSBYIWyAbIGyI0vKUTsCtaHokC9gLfWLAR
8SehIKhYpoRfjEKsf/l9WpJ1HzsJDX95jRy1+ATzkkqO/Qa/3WxRY2oyh1pNaM5N
7alYgqT1RmDYUnkNHGoqDOuh1fc64jQQ8F36+vFyp0R78Cm3ZHMh3UjUJZQX9Hf4
Ep/26COg3LpSGFDRrQ4WqwTeGFyJiRJyEOKDzm63LVo+dmYTmYHdWRz2mfKfwZ3B
Ckcz8vM4IWUWTHe0qKzebEQTwHaqdA==
=9Pxc
-----END PGP SIGNATURE-----

--+bpOqBC81XVIei51--

