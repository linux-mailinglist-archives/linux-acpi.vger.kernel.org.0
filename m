Return-Path: <linux-acpi+bounces-5969-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A88CD79A
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 17:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FB9B221A4
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8741CD2F;
	Thu, 23 May 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiTw7/Sa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3C18029;
	Thu, 23 May 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479259; cv=none; b=L/5CBwuKoT8BgPTYWvempwECM1PLGrpYowWZnrFK6LTk8/bPP3YpWfpeebN5OQMHZFuuMchMw6U2Xm3CJIU5GIq1+b9ZqqDvMGJbIZdzZrd9Gd7NFuqCGD/2mUzoyvKaFEgkjOfQoNSVAsF8S67tHjENt9oabcKOAP/ADbZGaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479259; c=relaxed/simple;
	bh=W29c7LQHWSwTs1cLDmC6925ws2Ed59HyAJ65h7ys/4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7twJvCZr3MeqbrZb3dD5/kfezukbmNROxlpXz93TTCbVFcWZditwtJBVzf4G90grpxFItuT/BAF9rI+c9bUQtqnplIHeeTubrdLNjD/113qszwXhNu8TtKAVqMYyzil2GjBoz9GBAzsiEfve5cBaj3e+FvbFgo5ND4tmjVo84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiTw7/Sa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420180b58c3so57754355e9.2;
        Thu, 23 May 2024 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716479255; x=1717084055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgjORZ1nG8GVZ5mqOBWiHYanFt0bhnov5yW5k3xGY4s=;
        b=CiTw7/SaNLJoa6mqdAKBKZQj0ZdZxcNEmG3MTZup4o8b1PVzbtALUM9sbk7b7MkzpI
         4T9dXfswjG4BKM5XeMs/TDFZN5BI7XKsRhBb8dna/zrOyTedurRp4vFDXPgCBcOwm4m7
         sVs2/J52xTVqgLDTH3yB6uEOsNjrmvot6Vf7MqH8m1Sraqp8GbCcIzWCHFa9hfXsV6Yj
         cMeZ4wkDacIlJ/zLGFMOALKDTYgPxPy8lx3QnRzAS/55kQNXXe2Q/LRQxYbzoQ0Q9GQD
         GEVSTcIX8QNaxDvqPATBo1SFYw+yiiMldoVpYhIwgV6AqWVJcn+qs0TL0uUTE1xQjl9n
         UXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479255; x=1717084055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgjORZ1nG8GVZ5mqOBWiHYanFt0bhnov5yW5k3xGY4s=;
        b=wsu7sEvbwxxHRe2/YAMaSkdAXB38bfT0FDr4JFl1XbUfwk3LW9L/eGj0QNjlwjuHly
         6PABaQijh99/h9dJWZby2wecLaAWxF+Io6UMhS0wtbiFLpgVERLumch7zI5yY2RXtlqf
         M2lRtDgqnY/ipGnNODRotRS5RJ+cT4JnjbSEyNaqqnn+zdKXv4vZeBh5aXzRqv7zi8/C
         zcZbLP770aAENbBOLovTTrXSj22jb5EqodPI2zqhRzewAJWVHTTq1fa521v7NeKn/2dd
         3E47EoyEvOhvl8ZrbdRPGUn1MtR4/eblpUToOLqla+DvDAEidt8g9am1mGdGIiBK6BDD
         +WoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfLA00+rfLoYshPdmMPQgqO1VAXOF94q1mc6Sts67QNPqJ1nR3z+TMudwXnnu+KvuytKsn500cj9qSjCc8snk58qR0o2/34qxiDr9rRf2BZNEqXBXs5zQ9WH3JPYbohUeU6nej5WrP/Js=
X-Gm-Message-State: AOJu0Yx0htenNUOVA11RxvevYURV/raK9XSyFE/1k6Mi3x5iLBJBFZIT
	JQYJjg+ES2xg3GMwj702ipV6SHa9v4bbO9Y1ptAgRmu/8UQPup7ruo+HRkO9Py0=
X-Google-Smtp-Source: AGHT+IH81lEU3NMBlt+vvzk9v3kvz88ZQXtT4eKWWxh5WTsZnioymb6B9Tw+CfR6ch5ExosS2yllBQ==
X-Received: by 2002:a05:600c:5802:b0:418:3eb7:e8c6 with SMTP id 5b1f17b1804b1-420fd2de525mr42805915e9.5.1716479255556;
        Thu, 23 May 2024 08:47:35 -0700 (PDT)
Received: from [127.0.1.1] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5a576sm28569725e9.22.2024.05.23.08.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:47:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 23 May 2024 17:47:16 +0200
Subject: [PATCH v2 3/3] hwmon: (ltc2992) Use
 fwnode_for_each_available_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
In-Reply-To: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716479248; l=1914;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=W29c7LQHWSwTs1cLDmC6925ws2Ed59HyAJ65h7ys/4I=;
 b=hJsNk1qK9bFp/YtyRLaBHH0CpBC3eyYwxgTIyc4EGzGTSOLsTh0zFRQvHVKbK6UTawaCYX+Og
 fw7w7hR9WohDlf33RLnmPUHoRnfzSKZOMX23rnLStdiTmIuAXpCWpyp
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The scoped version of the fwnode_for_each_available_child_node() macro
automates object recfount decrement, avoiding possible memory leaks
in new error paths inside the loop like it happened when
commit '10b029020487 ("hwmon: (ltc2992) Avoid division by zero")'
was added.

The new macro removes the need to manually call fwnode_handle_put() in
the existing error paths and in any future addition. It also removes the
need for the current child node declaration as well, as it is internally
declared.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/ltc2992.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index d4a93223cd3b..3feee400ecf8 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -855,32 +855,25 @@ static const struct regmap_config ltc2992_regmap_config = {
 static int ltc2992_parse_dt(struct ltc2992_state *st)
 {
 	struct fwnode_handle *fwnode;
-	struct fwnode_handle *child;
 	u32 addr;
 	u32 val;
 	int ret;
 
 	fwnode = dev_fwnode(&st->client->dev);
 
-	fwnode_for_each_available_child_node(fwnode, child) {
+	fwnode_for_each_available_child_node_scoped(fwnode, child) {
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
 			st->r_sense_uohm[addr] = val;
 		}
 	}

-- 
2.40.1


