Return-Path: <linux-acpi+bounces-14233-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB97AD18F9
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 09:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE6F165379
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5A1EB9E1;
	Mon,  9 Jun 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8HlIFrp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61621D88A4;
	Mon,  9 Jun 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454018; cv=none; b=O54ktigAlVpzvy5Q7hhAAXsNiMm56Apdof6SUJZiAd6gC/WIDEEE4n7sA+cI1EIJlh7djNZojrAWLYM/DzOYo23zCC7kqpG3TSaqvSEo5vhaoqn4xbJFgBArEil11wwywOoF1kh/l60krv09F9kunfjUd4VNf5GCWzwsO26EC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454018; c=relaxed/simple;
	bh=P/Tlp7nhzT5E7hujRZb9+kc9Yn5YzUCWa6Bd2jJDM84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qgDxWbYj0S0f5ENljhUZzc+Wqg2YiNNoIaHdv2pIT26A5Osjvte4bDz3tL47XIqHtBsDTuWiCS0el6jCHfp3bqNgId0Y3XDb3LprF3TJ8uDLbh0JnXuyqEzTs2U5SzqLXlt6gFwlSfPAUYsB9aX86BYv5elHwUQ4JDSvZfmOO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8HlIFrp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5534f3722caso4507932e87.0;
        Mon, 09 Jun 2025 00:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749454015; x=1750058815; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8asJYVLLmvRF9jXuFG3YILtPbir4Lwv4+fdRPoHv0Q=;
        b=B8HlIFrpEpe30BjcaJa0nQlLeLS2BlrQMhgO6WLDQFP/o6jFGiUtnfQ+KRH1xKhVjg
         +Rj0BdzWupMIsajzdkzgUvFSLt53AZyRgc/kHZJEbwrQW5av68ms0OEBj3ZNuQIQWHmf
         rX8OpCTYRuR0of5lZP4cdRfTHRtynFtaGCblSmEVLfzoVZfZnaV+gp+SVWK3F8JZf8+3
         ymL0OZ6FCQF9TSWu9F6W3CzO4Ffu4BcZQkUL0/hBE/kxnoPlu0CkrqGjhtpYNwi8RAHq
         +Eb0LNzMpmbC7xr4uHSi4g3vsiWR+WI7deoq1JvLs3eKkqmqWwbc9CgZHIPcEzALC0bg
         F2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749454015; x=1750058815;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8asJYVLLmvRF9jXuFG3YILtPbir4Lwv4+fdRPoHv0Q=;
        b=lXoRc25e03iBBdWmfRa2T7zWi1eYTz2DKgZD/merPw6RAtgAT3xc3tSx9fAuQrF7O/
         palrra/V1Ffn3WSPtLy7ZIzhL3hFnlHZm93FV4RnkkZrllcLWOEAk5199m4UCPJTHriP
         M0h1dl9G0U/DH0/vPhK97LB9bpsRulfcV2Hq8B8NHtZaeah24dxDQrdhR6zlSP7gbHah
         03hAd/ZG22HfZGY4dXScensOXXR8nKW9IjlUuUo2l94jNMV1ow3Py35174/O5VgDudJf
         Uw28fsBlpCLHIc9ui1riU6REhakkf6ZxYr13MkFKOpWeJ9/DTb1m2gol2jfoV7WJ2SA0
         VJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe7pqO5lRHjj5oBvQiHLgrXGXgDeE/EdqnE/evUqwKvk0720tvpJ9QXv9/IQ7A1GVQvh/+w2lsyLsx2ofM@vger.kernel.org, AJvYcCXupgK2Engx7ndc6Y0HUn3DnOBboFVU7Sipg4ij6ZUPl31tWI6CuDPLZnaGrCBqVRQNihpvPZo6I7ZO@vger.kernel.org
X-Gm-Message-State: AOJu0YxPC7fGgqaF9tspcqwmaQVpsnFOZ84XHFN6OK5vVBDG6/r4iT5A
	0Zz5dEhBZUOz4+kNQLtFh2Jrwg9UACOY6lICJj7v4R57+md3oecwsHYp
X-Gm-Gg: ASbGnctAqH89bWjTfOTvKWjIG11FKYW/c+37SqSNZZ2WVIpCrgfntVJ0SWJUpdQPcfb
	CFrT3zK1oKPAnL/MIFspNdRwtKx6tyVtB8HZGMMmeuPLHQg4HgwjVBUbGkixlkB9iL1TIECcHtt
	2yOJ44QZQt7K2UHcttJSsJDkS8w9kD4+bTLJuilvlX/KiQ74uJ5vey/B1sJmDpXuQ3y2J3TGWtG
	YISrflP8kctvbNpM1QG8acTPP86O/63tK/OPQIsIRoNR1IVfVpcOhAz+YY8sqQTleFNILMhLtqH
	S2s7uoj1FCIf03kd0ZEu9sGFcHM7E+m65mM4NFC4iJVPgheXqPfl3oYmcmFv2MH+
X-Google-Smtp-Source: AGHT+IGW56BoLbRFAxmxey5wtHGtaDKmI9atARqYrwyMXCJU139FNdmXwAm7mP63FR+IeGDv7Zzvmw==
X-Received: by 2002:a05:6512:31ce:b0:553:510d:f46b with SMTP id 2adb3069b0e04-55366c01635mr3125341e87.32.1749454014625;
        Mon, 09 Jun 2025 00:26:54 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553677222edsm1008009e87.122.2025.06.09.00.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 00:26:53 -0700 (PDT)
Date: Mon, 9 Jun 2025 10:26:47 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH RESEND] device property: Use tidy for_each_named_* macros
Message-ID: <c98b39a7195006fdd24590b8d11bb271a72a0c8a.1749453752.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u0ARGKVMgDyOvbMB"
Content-Disposition: inline


--u0ARGKVMgDyOvbMB
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
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
I am pretty sure I forgot to re-spin this earlier. Well, better late
than never :) Link to previous mail:
https://lore.kernel.org/all/Z_ew4DN0z71nCX3C@mva-rohm/

I suppose this can now go through a proper tree, because prerequisite
patches were already merged to v6.16-rc1. (Assuming IIO is not the most
natural one for this.) CC'ing still Jonathan so things aren't left
hanging in the air for him :)

---
 include/linux/property.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index f718dd4789e5..82f0cb3abd1e 100644
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

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
--=20
2.49.0


--u0ARGKVMgDyOvbMB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmhGjLMACgkQeFA3/03a
ocWtHAf7BPHc9gbQSZUO0ZzJWEf0yxwzmNRt7brQfQiZ/N1UVTb6VY7WlNk1qhZp
0ScDlxnkLG4YFN32O5mxCt83jAuFjfrSVGU07v06ypxnv6/0uKEj2bqf7LEv+pSj
kv2EsUkgVXsH+yD7d+mdzbAz8mXZ+cvxGL4a0OewO9Ow4HHauGz8/owcwVaHag8T
e54BD2C/eiCQBM8cqO+EFHf5cdqGL6gRdqikeYeEveX8khE+qrIQZ1A/Xu2Qt7sN
x+57Qto/4JBQ5bICJorhCuYbxpbNZFHJRSsk2no9CiwXlQmex1as4WLgicHULYOi
Pqumqom3Fz7xW0eVoZYLTPhcUxNNkA==
=ZegS
-----END PGP SIGNATURE-----

--u0ARGKVMgDyOvbMB--

