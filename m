Return-Path: <linux-acpi+bounces-5934-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB98CBD9D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 11:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4E7B21EDD
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCDF811FE;
	Wed, 22 May 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5r6mYzE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437580BE5;
	Wed, 22 May 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369500; cv=none; b=fnFD+R1uzJqSDP5D2APpeRNlFyKvZl0fBPwLU4mIuKg2pap7LnyTpN9mvK4dQrQOLolRIGKLeaVriS9Pi7FsRox8u6dkqpq6cZk21TiwVRjtPkyoNqjI+70G85fMDihz1Ij/3DwUM7Y0L3t8Q9Gu1eCgerZgtpBwSqe+lRDazUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369500; c=relaxed/simple;
	bh=gJ0Rue8CIZyFI5vYaIOIDGhFikGz+fvLwhXk8VedQ4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/nfGFmr64JpNaefN8I2L5bRw6rM9UkbfAV3/BpsZgUC0VBhzb3TJZfpR+UeGssUf4Uojrn9468SAuVrW6ZAO0mKETLwpSoevbGzHerIKYm2+9x2aReDepYcpDxD/hEi/qRqaZ6sz3FeHS7eupYzxVW+cqWjVQV8IJfLQYqYEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5r6mYzE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso11045731a12.2;
        Wed, 22 May 2024 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716369497; x=1716974297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hS8QMYPX9HU5iZYVx3xj9uGjra02vQn4uMTO3p8AL04=;
        b=K5r6mYzEc+YSf4uuURpEE4QKV7ehLV3HEzMlKwl1Lh+oCSmsfrkvRTmk2uwqfRz8gw
         bP33phRu/IbNtqIcC+bRlWs9MSimYVhx4tGAUERTp0AMNyaDCgaBV1tBuQyOMxRpVvWl
         rcw0CzpxMcvrCxjl4tQN5aEqWS7Q5tRFO0RMPti07KOX2H+y5T3+4YvbznzXWyqYT3DT
         QY10HWMQFz4imaKIrai4QL3WjdeK7qD6QOyrRPGIpmWNGAV/7WhVytxcmqCCtOUJNuWZ
         VqS31oZUnnpKDsL21SvpLPeZixxFzxAnTB+pYfkbuH4rKRI7Jk9yCWWEq3E5hcaQO6hq
         acyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716369497; x=1716974297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS8QMYPX9HU5iZYVx3xj9uGjra02vQn4uMTO3p8AL04=;
        b=pVtYxARtGl5nQ9+Itb+onY6qU+ajgQautohlLQrQnsPV/kD3b+fXZh70hWB4tZrYTB
         g/BWW9g85/5SVfM5Pm/zBT6emf7KggDlldGdJIgvb04zBKjJjZNA76NnV77yhABiHvq1
         1rcf0wWLfTLZO0/LFFPyo3QIMZ4F54VYcBVmi7yaqI9WJwBltvMtv8+MykzL9lp3A1fa
         lahc1BclxZ8qsJsdj4BbZMXq+0nZLXVWBq9JvPrd8ZucWNInxeyp9jQiHZY30mqGAAlf
         CWOmcVPmlg3ILA8HK63sJgaMUk8qM5/fE1NJl9Sr6Jns+7S64UOfFrEQe9dsPgRHiNL0
         V/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXi2jO230Ny7ROueWv4KI+ibdheTs+wtD6XQPptx8C4kRE5qUYhLt0WVOGsZQzVMdydGflhOskSmaaLe6g0CLSbapRS+G5JUzxfnzcLnH39kmtOyUJrQulhmYIdHAYc+ghNP/MGyNdgypI=
X-Gm-Message-State: AOJu0YxaBXyQWfYfsatv14B+fwy0ULpyn3bzAVYmBV6CA8UnC7l/PjS8
	8tVnYw4I5/Zvb66h3t9AlTXl45ro/44XwzQoc93eo84+yoC/3kDm
X-Google-Smtp-Source: AGHT+IF/8OxWhDUzjhGymfGdtzuojEnUQciyaHavmrRUL77vmxFvNHu12QGy36TR9eglHTPzQgnaZQ==
X-Received: by 2002:a17:906:f8d6:b0:a5a:2aed:ca2b with SMTP id a640c23a62f3a-a62280611ccmr92560166b.28.1716369496750;
        Wed, 22 May 2024 02:18:16 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cec3d9b5csm836678066b.16.2024.05.22.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:18:16 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 22 May 2024 11:18:08 +0200
Subject: [PATCH 2/2] hwmon: (ltc2992) use
 fwnode_for_each_available_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-fwnode_for_each_available_child_node_scoped-v1-2-1188b0da12dc@gmail.com>
References: <20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com>
In-Reply-To: <20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716369492; l=1624;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=gJ0Rue8CIZyFI5vYaIOIDGhFikGz+fvLwhXk8VedQ4Y=;
 b=wQ3arPrlq5jG+PHOk8g6UYSech0Zs3LjLnOqv1Zq9azk4RcV6qXWM4uz27Ag7lYIm9qToKnPd
 MgBAG71LnogAwtuBRihcB19SRjRzZnPPxmCE8GJsjuG7k8cQxl6C5qD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The error path from a zero value of the "shunt-resistor-micro-ohms"
property does not decrement the refcount of the child node.

Instead of adding the missing fwnode_handle_put(), a safer fix for
future modifications is using the _scoped version of the macro,
which removes the need for fwnode_handle_put() in all error paths.

The macro defines the child node internally, which removes the need for
the current child node declaration as well.

Fixes: 10b029020487 ("hwmon: (ltc2992) Avoid division by zero")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/ltc2992.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index 229aed15d5ca..3feee400ecf8 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -855,24 +855,19 @@ static const struct regmap_config ltc2992_regmap_config = {
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

-- 
2.40.1


