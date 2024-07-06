Return-Path: <linux-acpi+bounces-6789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C803792946F
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B0283325
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1776B13B798;
	Sat,  6 Jul 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0jsVnRS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891A13AD06;
	Sat,  6 Jul 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279438; cv=none; b=oewNi7Y8jGE87RxobgColeONX187XoI2fI5PRgaSjD/p7CkBakFaKrDj731ew17QVvF4FhLGrBuqrODFXXDmKWojLYdXC33zF2YHoD8awD9dTvCUWqxF0AyrpBrUB6vTeG7VqaGarm5xGltWOEy9OWoaQBVyH9SVRZLIl11cFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279438; c=relaxed/simple;
	bh=7+6Z0APHavEMWbcX1CrJj4Il3cLB/Qq2MtDoHz0G0Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsTWJmQCIXyIzLCFNsGy7WDrtE03Th69NQSr2NjQYpEZYW/TzcvrNxwnWa8HH6FoeuPEKf/qpV/3OadssU5e81xFg3vaNgRXiVDZ4kq8uvljy0ZS2rap93aQ4rvcU5pmfkyXnNzSw02bRN892dj2IwWDRHGV69RVK5zVcTzUGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0jsVnRS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so32579611fa.2;
        Sat, 06 Jul 2024 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720279434; x=1720884234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vonvdo4buTi8Kek3AF2MBmwqbEkxs8m01cZABzJaEc=;
        b=P0jsVnRSmh4Fdw9M2GU0TpiQV5aQ1IJ/MkbuUF/Uw/yJL3SfuygNVqMp5TYWww8Qvy
         0x2RL8VTvNedQ3V8id0LvDiiC7J1E2B62RcfthU59WwYvuUepb/zt0wn4yzr/lo4nnPq
         fyArHxJZjqEDEPCeofAtC9GDcn7wBBXtQ0V0lrx0TiIZ9/k7/iD310/6PWJud2/XEIox
         Gku8Ha3koWyCBuDCVJrSVyoikmd7rv0TIvLtcsCq7M1ERTLMzRVjkGd8WD6Dve8obFtK
         Sjx2rfJEmIZuX0PUYHqQniwWHqhrHIBtkJKEJhB7m4OYC1qyfdMDmRVBgdF/32v/eDSa
         e+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720279434; x=1720884234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vonvdo4buTi8Kek3AF2MBmwqbEkxs8m01cZABzJaEc=;
        b=b4LspPmTQSODlAyqaja0zqcDGhD/ifFzOjAIIFixX4nIJX8+Cj5JYtlk8JWevSCsPa
         n7j9bVdAcflj2FjfFnnuGwL0aRnkU+Jctuz5d8raWEWYHJC20XsNGjC9cu661VSn+1Qk
         lLXCYInKv4n0Rfinq0xa03/YQ3GTrFWKJY6paYRatZ5C/CLvncgSqzYvcyzBsww58BE7
         lI4igKcHUfPvKVJOsX61dvPAtA2wIRUDB293uJrhBuF5pRi8wW/oU2SVc6Kr6CJji7IF
         2chygIA3/YuqbHrD1Ax+DEN+dkgCv2tnKkT2lrSp4PlajOL96mjy1G3jhh8mkxDCDSKX
         1dyg==
X-Forwarded-Encrypted: i=1; AJvYcCUgCtL1DPRbg/iTCwBKx191LPi2JMCZlx2+z2S9dadnyq8dxh7qQwGfnlAXkcM4BSz2y/1CrnAWKJ4Mv2rtNuDKfAOxhyg23rDgHwd3EDGCoKyqL59UZO9ny1WqPLZmRIDjIdal+x6bmTGOGEgem8cr4+ESVSgpJQfOk7OxeG6XtiC7vcPf+4Qrc9TYCfIHqr6WahmuolvX0MmO7ILC
X-Gm-Message-State: AOJu0YwnqM/sXL9CVFl9sEOIZoteNQhrD0MFFNA+qFgCTs0smcBw1tm4
	Q4uaDcunAPs/gwxC7PTuwITsT5RYKH1EjM/re1IgA70bUfOh0AZM
X-Google-Smtp-Source: AGHT+IEWCoiG5MnGrUnj5UnoDy02MYCZUmysm6Wu8MxysqIvfh/76n1gkocfimi5zpgGIOZP09yCEQ==
X-Received: by 2002:a05:651c:c2:b0:2ec:5621:b9f2 with SMTP id 38308e7fff4ca-2ee8edd33edmr49536161fa.41.1720279434153;
        Sat, 06 Jul 2024 08:23:54 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679ed376cdsm6421593f8f.114.2024.07.06.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:23:53 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 06 Jul 2024 17:23:33 +0200
Subject: [PATCH 1/6] device property: document device_for_each_child_node
 macro
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-device_for_each_child_node-available-v1-1-8a3f7615e41c@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
In-Reply-To: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
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
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720279430; l=2008;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7+6Z0APHavEMWbcX1CrJj4Il3cLB/Qq2MtDoHz0G0Fc=;
 b=Y6hFK7KTaGbWVOlWICFvFipwEEBFAf0YclD7EeQp5JBtkmCNbSRA+aUo1WRqLA/jOsQy5Bz9o
 MGkYVLJqmycBqsIVGJRJOX6UrnjCQKgbRAKXJYxJHkBJEzPzfUA9Ekk
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
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 include/linux/property.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 61fc20e5f81f..ba8a3dc54786 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -171,6 +171,16 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child);
 
+/**
+ * device_for_each_child_node - iterate over available child nodes of a device
+ * @dev: Pointer to the struct device
+ * @child: Pointer to an available child node in each loop iteration, if found
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
2.40.1


