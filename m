Return-Path: <linux-acpi+bounces-7295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF9947D26
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F0EB21398
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F761547E7;
	Mon,  5 Aug 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAigkIgp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1113BC2F;
	Mon,  5 Aug 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869415; cv=none; b=IdPNtiUxue5eB+UZKXv/qai4Njdc8CuHDItxN5jJ2VGtlNWt/VywdvfTekK0d7PXYfCvWlvqdui0ltCbrTseBPzTzJFfo0HjcM1LoZvAQTL2IeaCsZS/MluKK5VVhwKCXDJCXz6bk458iBaiCtVwbYYNcNbZW3OQVonN27mPihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869415; c=relaxed/simple;
	bh=NQLwlzM1GB5s/6zaH5GM8OvbL7Is75uW2H1eYJozVs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=upPvXPPkb9fgqZmCLjog5gxEmpO1cdTWq3C3STGdC0Tf4t/8NNdhBz1wV4D/6KT27wIP0f+KqHfSGHdWUM/Lz4DlhvN0prKb9/fj+h5Nps70GHo2tzTXB8MXi0N2bU/joUn5N6x23bl4j3TNBz9uwgph3IRpeew1nQEHzRHK8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAigkIgp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7ab63a388bso674774366b.1;
        Mon, 05 Aug 2024 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722869412; x=1723474212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/Pf1euXJ7YiFp6MxoAI1+nAX1xEOLbJWGLNA7qyCg8=;
        b=RAigkIgpjMpibE7alcLDvb2wEgrQWYkM7fVUPKcCIWHyDyQe3R3v3jK8mX/ZnRQN3A
         pVD/NzpqTi8FtdCNmVCPbrIxS2yiPNHFUg57kcgiIKVmg24xipTL5177wc5UAepZnwCH
         0BVxrYfyARsS2RxtBzJvyVJII+VTibdZ/AeTtat1NC1lplqhW7KxB7kQLTodLVNrsDHw
         oyWMjfywAUSU2XxKSDtp9UMYZhfDhH6C8GbX/N4n7w+09mU3Ilk8vXWyAV/vaJcCXuUA
         a/4c9KcInisTb/UTMFxuoFJjdQYnuEuNVRXK2da5Zeo83md0HDcH+cjPgAQkxBngh8Yr
         V+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722869412; x=1723474212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/Pf1euXJ7YiFp6MxoAI1+nAX1xEOLbJWGLNA7qyCg8=;
        b=LJEnixIf+GGM9yLPier3c/AvrEx1LJDuie7CKrQOvWrBh/v2OKMqZunNbyDI6N6/vg
         U+KVDALHNO+ss1ZeOWkXIY7ySAZo7RzPhyXCQy5Du57wax6sTPM1XXNI4pYgYmZMT3ku
         f4QmtepmNALvRVlrzU41clTqu7qRkj7Tp4VxARCVilG07rmaNkT1ZazPG+DqlP5sIl4F
         TfCO5flaMY10E7O3pwzddPTY3A2NEZvEiQ2UHp4iohT8QaTGFQHEMPUAWrCjR1g9BGz6
         xXJ2W9dCsZlgCFidXI6ejMHXuWgx2dt08X4TJmPcVWS6J5qMDv8FeHfXLVdvXLeQQK0P
         FX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIxOMUtzEmTwiy1SqASgxuxKsEtAkxkFzmhuxUbWGxJybXZlKHW6Gf3+CGhkQ04baXkPzcF3Hl2AGuqkT9G9BY8Oz6iA6rLfiagnMixVpMrA30xRU1za5qhcWzWppPbZH3VWWM8io4lWLdNw3TgWHaPQR1Gy+yfutxI7MOtRtH6mtzJbZ1LS6HYOIzUk8lQxib4svrJwLjdR0wMlwy
X-Gm-Message-State: AOJu0YzcKCK+WOhQldmydWyrYI5h3gtjIXDtpJvoelGfQ6YQoJn1y3Lk
	VrWYZEnL0BisCrY9z6U5POKCj0j4PJcla2/46cNTHTLOs7vQZMuED5/amNMn
X-Google-Smtp-Source: AGHT+IEDbJou22J+zOGy5K2QFRts0CEmsyS1Phed3skqUDq3b6QGzQ9H+yC1KwjA8cOMqODaEcnWpw==
X-Received: by 2002:aa7:c348:0:b0:5a0:f9f7:6565 with SMTP id 4fb4d7f45d1cf-5b7f40a665cmr10356907a12.21.1722869411474;
        Mon, 05 Aug 2024 07:50:11 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b82f308sm5004088a12.63.2024.08.05.07.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:50:10 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 05 Aug 2024 16:49:44 +0200
Subject: [PATCH v3 1/4] device property: document
 device_for_each_child_node macro
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-device_for_each_child_node-available-v3-1-48243a4aa5c0@gmail.com>
References: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
In-Reply-To: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722869407; l=2059;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=NQLwlzM1GB5s/6zaH5GM8OvbL7Is75uW2H1eYJozVs0=;
 b=YTm+p+yPM/MLAI5/anEJ/hAw9x6NoZ+VGsIgLGhMXe1qq6uOerpMh1f2KzmuT/PZLTjdft3Bb
 hTnTMXMbJszCyuwaS7Ys+sTk1rdez/275nQfBN9yZpy03dEgRTz8KFS
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


