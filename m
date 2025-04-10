Return-Path: <linux-acpi+bounces-12941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50304A84213
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 13:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D4B7ABE7F
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 11:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0D0283691;
	Thu, 10 Apr 2025 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exyy5lWN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264EB1F0E39;
	Thu, 10 Apr 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285933; cv=none; b=ehPbvULHupVJxTk6B40zF2JaqFs8I9bE+4GAChCKm2wwLH6AMLIcf/b5dslS71wYzl4D1T4UHIlYgfcVqJoBXs7zD16WYEzLxv32o1zN6WA8B2ZUGhyG/WtUzclR+J1xmAN1RLPrkjyuR6xytOCy32sXVZbPpPA05l7GaZfeQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285933; c=relaxed/simple;
	bh=DxVcMRML2H41J7R4wgbVQO/G4dfCUcZYQKdJ+mRomt8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mwwUhnPQTBReUmz57JOR9PkDNeghjW+1S6TpDtjhD69TGQx3r5qkyOC25qwhCoeeZ24wMXTHmaTzLunmKxFybUbuCDM8cwi6+bNisKELvlMmc3aOZS8dbfUbO3/mZG72Di6hcjbh4D8zFDNP020TjEvVySvM3GXAPzicyA7cAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Exyy5lWN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54af20849adso767824e87.1;
        Thu, 10 Apr 2025 04:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744285929; x=1744890729; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gz8iDaKPJnnJFHqBn+767ICwsMBT3pbftU1Ov0aGJv4=;
        b=Exyy5lWNIQPLMgCfCGGecqvHjwtx061YaemeYmQnk7TW0GonVUmMzctzmjWVyym+vo
         Ue+SljNBwOdVhh37MyHRxmo4qfWnY/U+W1ufEWBA0UAoV5UpwcNsFHuOIO/TlgxCiqOi
         Vf4SWSQD+tteMIdQFOUZOZML2f4dgU/8SFvJidoEQ9sDVZ5plJw1NPH/5HW+21eIoxfa
         O4C9wqSKvBGKL01czkp0zSmd2R1BGuYkdPNaiSIaLMIe9vIYNjYxFkuGTv+2TaF6oFYN
         JiQn4rYsXH8jFuSxJIf5mkOYFa1prZBwr/oOA+JcnsrV69uWCPCcrA1Fwrn7YjluCbGS
         OmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744285929; x=1744890729;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gz8iDaKPJnnJFHqBn+767ICwsMBT3pbftU1Ov0aGJv4=;
        b=stBokGu3U7jjvX2zHyTLD/ACVbOaiokSQBkk5UXP+8U56VigTNjbkfkhr+zJHZKzb9
         0qBXE81qTSkiB7BNJ6pn4ygfMVillPXzE2kvRSOUGKfmrqxs79XQzKt/X/K+3gT3XLnL
         ze/tnB0WManZuxLVGP4Ble+FKpBHwzd12DIUYZYKCiKHFECfeWJriw6yA3/MXjQxOvzd
         PviGi1BP9Hz7pA44qM78AfE43cTwXUg4wAzi6pnJgx3gKv6Y9/0j+NdT6O88MVyia125
         KUtUB73lcmV3Yz6obBhWY2nfqkqYdPSPuZf9H5pZZpbdDcb0eBJMOp/shVzbE5svYbV6
         z6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXClKrh8HdUylSndT83aXMV220Q3Qb0tyaExYQNQvssE8HZCiGeP427f0QuRc0B3pR4UnTbKZsPmrfD@vger.kernel.org, AJvYcCXMqMaQ2p80rZVyZSlUqrd/iteoO85Q5ZSGWBKoeF5LXAwyNpTUGHCeJMCwrom0Ku7J32gbew+jnVr3aQEH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37nmTyR0juKfsJC/MctXoSmiH3U7MWZDsunA8U8GpGYRWmaXX
	HmcS3nlKWT/I4S4kbwSgpmXIdMfxk1EdhNncmg/XG2hBgwHOZo2e
X-Gm-Gg: ASbGnct/CNVI3QpjIKLhwyphsc5/P0kT5lwhQRiY1WyBw3PVUYTsMTMUgz/PW0rGW4x
	D4JAUj9HIKVn6DmbuE2AX0g7oKm3QSe6Xf5itOwcAYs/CDQwTl4T07FrI4hyydq5LYk25gsBQnb
	XkLHtkdYwkW/Yqr0eNEhnhTCTJ1pVHgaxbhiSQna7Z23HTQdTqrTUsLfsfwF/4KYPOf/eb393lj
	J0JfXq1ssMUWvDjAoChiQoROx4E5pW4XR5cVdHIoK+DOBCc7PCm5h8xsIoQmgLiejz27S54YEB8
	ltjbWvoYiM/+LDAo0+KW86vDtd+tSlIa6CSfvuYfEK5o+Fs=
X-Google-Smtp-Source: AGHT+IGOfbC9H3oM7GGaxbYZr8AyLgjLFjnYONagnIhbPpWt8QpO9xZbx5cMSJ0EqzgRE2HXq2uP7w==
X-Received: by 2002:a05:6512:b22:b0:549:744c:fffb with SMTP id 2adb3069b0e04-54ce8a5919amr816604e87.23.1744285928908;
        Thu, 10 Apr 2025 04:52:08 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d510b43sm129897e87.201.2025.04.10.04.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:52:07 -0700 (PDT)
Date: Thu, 10 Apr 2025 14:52:00 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] property: Use tidy for_each_named_* macros
Message-ID: <Z_ew4DN0z71nCX3C@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zeEDt/v4zh7Xzd52"
Content-Disposition: inline


--zeEDt/v4zh7Xzd52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Implementing if-conditions inside for_each_x() macros requires some
thinking to avoid side effects in the calling code. Resulting code
may look somewhat awkward, and there are couple of different ways it is
usually done.

Standardizing this to one way can help making it more obvious for a code
reader and writer. The newly added for_each_if() is a way to achieve this.

Use for_each_if() to make these macros look like many others which
should in the long run help reading the code.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
The patch was crafted against the IIO/testing branch, and it depends on
the 76125d7801e5 ("property: Add functions to iterate named child").
Hence I'd suggest taking this via IIO tree (if this gets accepted).

 include/linux/property.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 3e83babac0b0..d937502a22d6 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -17,6 +17,7 @@
 #include <linux/fwnode.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/util_macros.h>
=20
 struct device;
=20
@@ -169,7 +170,7 @@ struct fwnode_handle *fwnode_get_next_available_child_n=
ode(
=20
 #define fwnode_for_each_named_child_node(fwnode, child, name)		\
 	fwnode_for_each_child_node(fwnode, child)			\
-		if (!fwnode_name_eq(child, name)) { } else
+		for_each_if(fwnode_name_eq(child, name))
=20
 #define fwnode_for_each_available_child_node(fwnode, child)		       \
 	for (child =3D fwnode_get_next_available_child_node(fwnode, NULL); child;\
@@ -184,7 +185,7 @@ struct fwnode_handle *device_get_next_child_node(const =
struct device *dev,
=20
 #define device_for_each_named_child_node(dev, child, name)		\
 	device_for_each_child_node(dev, child)				\
-		if (!fwnode_name_eq(child, name)) { } else
+		for_each_if(fwnode_name_eq(child, name))
=20
 #define device_for_each_child_node_scoped(dev, child)			\
 	for (struct fwnode_handle *child __free(fwnode_handle) =3D	\
@@ -193,7 +194,7 @@ struct fwnode_handle *device_get_next_child_node(const =
struct device *dev,
=20
 #define device_for_each_named_child_node_scoped(dev, child, name)	\
 	device_for_each_child_node_scoped(dev, child)			\
-		if (!fwnode_name_eq(child, name)) { } else
+		for_each_if(fwnode_name_eq(child, name))
=20
 struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_hand=
le *fwnode,
 						  const char *childname);

base-commit: 1c2409fe38d5c19015d69851d15ba543d1911932
--=20
2.49.0


--zeEDt/v4zh7Xzd52
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmf3sNwACgkQeFA3/03a
ocVs8gf9HNLhPeFbElbIIkLElgK2I3M7WUg3zsSnfgZyaMfze2uIi9gRqv7EyVXU
SyJhQU0FXuou+lx+irbLsMGqxctNXi4gWwu4VzmxsKGJvhM1MaDnrVrqk4IRXgy9
heLW+dFsvEM5wGrOcSweDpFqHvBgbLRKqXcg2QadqPs+ZI2H46GMg3F5m4hhrTtM
1RFs1X1PnJAg/P8SkylDjiicpuACXRmr4ajqrGa0sCALgP0yW0uDIhJFAkebjD+w
yX1AR4Zkqhq08um8LCbW/sVuId3KzmK88yd1Liiv2UesS83YEGyKV9gbaHms3nuM
vG2QPBv1DiRLLYfUMu/8EgzBBvQcow==
=Tg3R
-----END PGP SIGNATURE-----

--zeEDt/v4zh7Xzd52--

