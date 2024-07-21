Return-Path: <linux-acpi+bounces-6995-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B121193852B
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0032812DA
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F916A38B;
	Sun, 21 Jul 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjMf0l/Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557D168491;
	Sun, 21 Jul 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575169; cv=none; b=QoWC4w3VCbSVkXhp7MjqPaQZWU+FnU1wUnzklezr1C6eynBWcp1cX4P7uYkcm9ettLWQ0yjzJCoFnvVCrsvXSdAtiihInuYD3Z57Qn+dAycIrTUV0zJ5+Uf2XKW92jTuaADQNsXX5NQkRwJspsF1++MmbQLC/dHQnV6eDsZdNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575169; c=relaxed/simple;
	bh=qmJK3LZuSa0Q8co0FeH63oXHSEAWVIOtnWvvKF0X9Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XWviVc+WIDMpGlhGuZPwDklHT2zIJKFmvv0p2On+5O9WYT0rD/V3OzTjfrbNgKs73uN2vDyXcGswacsTbLu6DWAuy6HSrZ0HhBZDVoN27y4DWP7k/ROCUqC9f2MtLaPZz+5+7ZuPtusSOZIDvSgw7C0ol3FAyG20kLUu3lElNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjMf0l/Y; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f04150796so103272e87.3;
        Sun, 21 Jul 2024 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721575165; x=1722179965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLo1DCjLzPkM82LXiwcToVtcKJJFQ6JlMuEebWdypGk=;
        b=fjMf0l/YzUeo1qiDn+60d1gZ+3U5B5F9XCb+Bkc0XlB1B2O2jGPoqXSg2V2zAlnmV2
         H0qlHMgakPkRQrk3RXFGHx0gEDo3b2soum1AQKfea1WuA44HVRrKdGI1K9SLZMKKp4Tt
         MGXnZdfpTglGT8aJCT++U6g9PO1x2HbDHbMbAnl9qGHSSSjtakQNsOAuimLq9H0IzYa5
         Gm3Uet11JnUn+nAeqJrkX54dOMJwxkvjfvYwUXGrc7zeik/B/HFmQZUnDfd4AFcDYCPn
         appRVHbYTpwBJA1TWwZ4ntoUu9+1WA52f9uFUEzdcWsfnKbMuRG+i1uWGJHjR2u/CT5g
         BiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721575165; x=1722179965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLo1DCjLzPkM82LXiwcToVtcKJJFQ6JlMuEebWdypGk=;
        b=Kx8LIHXXouhwzW9rrAsSu1n3Ajl/6Jk2zXXFDm6r7Nd74Hzw1Yxc6T30AePnGCbcA7
         /BmJFTvQGQlZiZEk5lEIu/Fy/CgBGavs/+OxjA3BwN8tXRuC54NsRvsQAm5+K55yOQMF
         Pk8keIVySvNck0UiFVBYj7Ygejz55ATVrZXVyYTXc9KpoZ2U/i6ZogX3J7sazXS8hhEa
         mXjImztwHbUAUjZGuXhjjLNuiMaspU9St2STFPQkN0I3yX943qyNwcB9Cq833x6y98xE
         cgZk9WWkRreX2eyQ+3vT0TffMykhRLsTtBIapWT8FfBtoKHptG4Lodere4oIw2uucT0Z
         mhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb3VxGsXM6bK28pE+HbsNVInwipt/HrA7LHctf/uM2/SgdjCDBVANFGXfd2x3mMWKui7P19ASdBNG/bm8XnVYjcGFSTkGd7qnpchwZ+w+gz3YpmnyWsBbqUhWctn/RH+HDJRlH6mNF4lh3r9YIJ0nv7kXwWcAESByBs9f0KlsaLhHmrPhzWZDhDfPKJnyLFnFk3PiiDBIz3zxGydqr
X-Gm-Message-State: AOJu0YxYW7PRy1PY2BgP/U+51+VHXItsvms9R4qNTfEIhSGVB05CXx4l
	6ZNZ/QIubVNMLblMTsJBMEDSu9sIc45zIqZ68mv1jieUIm3X1PPfkKZqD6w+
X-Google-Smtp-Source: AGHT+IFky+8Xq3MfILxGzTgpCFEIBmcdXggGjBm2n6+4RWT8GKM2DUZln/cW2pbRLRatbPCgoyfd/A==
X-Received: by 2002:a05:6512:2820:b0:52e:9c69:b25b with SMTP id 2adb3069b0e04-52efb748b3amr2667915e87.28.1721575164455;
        Sun, 21 Jul 2024 08:19:24 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-859e-243c-21d1-9ff6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:859e:243c:21d1:9ff6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78603dsm302270366b.8.2024.07.21.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 08:19:24 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 21 Jul 2024 17:19:02 +0200
Subject: [PATCH v2 2/6] hwmon: (ltc2992) use
 device_for_each_child_node_scoped() to access child nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-device_for_each_child_node-available-v2-2-f33748fd8b2d@gmail.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
In-Reply-To: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721575158; l=1962;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qmJK3LZuSa0Q8co0FeH63oXHSEAWVIOtnWvvKF0X9Vg=;
 b=EOAWx1KMuMlIc+Yg6IQBT3vDliOEmMWvAD5kHoGeSHqA67yup3gB9zEr4K50S2w+sr91FEDzB
 iZmNWBEOAamC2D2/OlNOofezTrsbmVUUTtCQ0WlI8JqdBTFhoVtVZrs
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The iterated nodes are direct children of the device node, and the
`device_for_each_child_node()` macro accounts for child node
availability.

`fwnode_for_each_available_child_node()` is meant to access the child
nodes of an fwnode, and therefore not direct child nodes of the device
node.

In this case, the child nodes are not required outside the loop, and
the scoped version of the macro can be used to remove the repetitive
`goto put` pattern.

Use `device_for_each_child_node_scoped_scoped()` to indicate device's
direct child nodes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/ltc2992.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index d4a93223cd3b..541fa09dc6e7 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -854,33 +854,24 @@ static const struct regmap_config ltc2992_regmap_config = {
 
 static int ltc2992_parse_dt(struct ltc2992_state *st)
 {
-	struct fwnode_handle *fwnode;
-	struct fwnode_handle *child;
 	u32 addr;
 	u32 val;
 	int ret;
 
-	fwnode = dev_fwnode(&st->client->dev);
-
-	fwnode_for_each_available_child_node(fwnode, child) {
+	device_for_each_child_node_scoped(&st->client->dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &addr);
-		if (ret < 0) {
-			fwnode_handle_put(child);
+		if (ret < 0)
 			return ret;
-		}
 
-		if (addr > 1) {
-			fwnode_handle_put(child);
+		if (addr > 1)
 			return -EINVAL;
-		}
 
 		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
 		if (!ret) {
-			if (!val) {
-				fwnode_handle_put(child);
+			if (!val)
 				return dev_err_probe(&st->client->dev, -EINVAL,
 						     "shunt resistor value cannot be zero\n");
-			}
+
 			st->r_sense_uohm[addr] = val;
 		}
 	}

-- 
2.43.0


