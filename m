Return-Path: <linux-acpi+bounces-6994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B49C938526
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 17:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278C8281310
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E288168487;
	Sun, 21 Jul 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu+lGlhW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C861667F6;
	Sun, 21 Jul 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575166; cv=none; b=LJr/gcCca3j3TEDcaTiT0gQmrQVxG/maH3aLf9uby779d8Ah7C5SwMm+WvXg5PX3bIFjzBQncasw3/g9uz8EdR0kkIalxu58mCr1N+C7HpvQoZ4SWALUSw7Ly5zmTZLTQu5WKCjl29KrMmBXmEPQgnPP/BjgdSqGYyxvSwBdL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575166; c=relaxed/simple;
	bh=NQLwlzM1GB5s/6zaH5GM8OvbL7Is75uW2H1eYJozVs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+OtDLpn+SJoThJu1/AhGL5W2ow0O9Dx/dfmrrteDfMJhCIDWlqy785i8xygWY3mIvyuT0aXfd+mS2v0nQX5SXUa8xNc2b5wTHpuiRFXApVZnCRFdkorHQwUSXkmZf1XHTBjQ9pW9vzltvKac2cOYX48GvZO++ZLUjurMFDlYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu+lGlhW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a79f9a72a99so809111466b.0;
        Sun, 21 Jul 2024 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721575163; x=1722179963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/Pf1euXJ7YiFp6MxoAI1+nAX1xEOLbJWGLNA7qyCg8=;
        b=Iu+lGlhWlQh3WyNSx4DpzObWI9eOTdPdDVq7EV6ol42WYV0t2GuwTUu3fs7Hqmyd6V
         BM+Zjz9IAIzQz26buAye7CzrdDyRv/mfMMkAulbzozro017nIf4fh2l36lK6MrQ24hf4
         TJ6mRflQGg3QEwzJdsYzZM5z4AT2LINGdKfQkUf81BEx+Ijul+bTD4V++QwycKrYIBqY
         fU+W7RU7ohzSG5ph5Cz5m6PjRoy1+Mn1HPyxFDnzVPo8fSgyCO9eNbwsxQVL8kKQAkIe
         oeXnDI2In3srsWKo7Sx56qg8TUUwiXJTu5AgYI1XG2l0+vl+Pz74bb6zRHIIUwS1Ya47
         ErqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721575163; x=1722179963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/Pf1euXJ7YiFp6MxoAI1+nAX1xEOLbJWGLNA7qyCg8=;
        b=XkkBvnf+McK+5Lpl7JlstmgyGYoazdUNQbucSxqtHg6uWi98BWrDBmfyXxdv+2moRf
         SpE8Bm2lsvz1wexW00arhDGTx3zo8ZDvdeSIWAjcDi0hrCWy+hXUQO9JyLuzQE9H3Oa6
         fFKRZJqHLlPVS8DnaG+i+VZS17wCI7FrYBDueD0f5dZhtE7BPcps2bw5AI/EiNFO7mN+
         8u5Dk4EyMtKtkHkR1GkrPGLZ7TPcTRSHSr4vZP3cJDdxLGuiyN5BEm5+sJVbDVkLdPoA
         +qBV+ZvgFQRoZvTACBn/3SQg00uWqQdajkxciObNNYJs8W2o6CcoDtsULLizyXtWwq3e
         JP7A==
X-Forwarded-Encrypted: i=1; AJvYcCUtJ1g6wRKC9nLHM6OSITZWKmdHo1BL5O5zk2U3z2PcJYp/6C0SpY9UEEjQwuplMMCFwktUJ5GiBExTM9TStysw7wmtSBCmxRIzGRQjwllgNljebxnPo+dkN+dyuMtqUGyGarOaV2ra/SxUGuEICAWMCw1V8ii6uArjARUIMFiks0e7rQyxhOaT9s5tydZgQdVfjdu4ohOuHd7gdYor
X-Gm-Message-State: AOJu0YxC+/MRcN39IRw5AktLHdRE6b6NJXkzZZFEkFthr7bU81OCWsZn
	xi9Fjs10RGChbByLWJkpEbtNed3XOS9rO0HbZ6zq8VCGI9h5rm5c
X-Google-Smtp-Source: AGHT+IF5poCMFJoB1QBA50RVZf8sIrkQwalXR8cSF3JoqUpvJkktDE0ENejC0z1/gU5kvlPaLR/fFQ==
X-Received: by 2002:a17:907:9727:b0:a77:ecf0:84e5 with SMTP id a640c23a62f3a-a7a41b0534bmr475210266b.14.1721575162600;
        Sun, 21 Jul 2024 08:19:22 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-859e-243c-21d1-9ff6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:859e:243c:21d1:9ff6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78603dsm302270366b.8.2024.07.21.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 08:19:22 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 21 Jul 2024 17:19:01 +0200
Subject: [PATCH v2 1/6] device property: document
 device_for_each_child_node macro
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-device_for_each_child_node-available-v2-1-f33748fd8b2d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721575158; l=2059;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=NQLwlzM1GB5s/6zaH5GM8OvbL7Is75uW2H1eYJozVs0=;
 b=mau8GXUvako8cDiI6eQz1SkIMsNpRk/Se8mFBQSXfOKpnevqV8V4yJSJGwSEmp1A2Nh+MJlPh
 AhzzO+KxkaZDgIzRKhYQ6mhyuXJBBffATc20B9c3jcXSb2EeZELZR6O
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

There have been some misconceptions about this macro, which iterates
over available child nodes from different backends.

As that is not obvious by its name, some users have opted for the
`fwnode_for_each_available_child_node()` macro instead.
That requires an unnecessary, explicit access to the fwnode member
of the device structure.

Passing the device to `device_for_each_child_node()` is shorter,
reflects more clearly the nature of the child nodes, and renders the
same result.

In general, `fwnode_for_each_available_child_node()` should be used
whenever the parent node of the children to iterate over is a firmware
node, and not the device itself.

Document the `device_for_each_child node(dev, child)` macro to clarify
its functionality.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 include/linux/property.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 61fc20e5f81f..da8f1208de38 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -171,6 +171,16 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child);
 
+/**
+ * device_for_each_child_node - iterate over available child nodes of a device
+ * @dev: Pointer to the struct device
+ * @child: Pointer to an available child node in each loop iteration
+ *
+ * Unavailable nodes are skipped i.e. this macro is implicitly _available_.
+ * The reference to the child node must be dropped on early exits.
+ * See fwnode_handle_put().
+ * For a scoped version of this macro, use device_for_each_child_node_scoped().
+ */
 #define device_for_each_child_node(dev, child)				\
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))

-- 
2.43.0


