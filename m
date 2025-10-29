Return-Path: <linux-acpi+bounces-18329-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98922C1A738
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 14:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CE81A2609E
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224343446B5;
	Wed, 29 Oct 2025 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ypmVihT+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEA345734
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740937; cv=none; b=G/XpPp9m29gt5EAeUunm/BeT5LyniEwwC8/CzyCpiNLbUfwAuGdVGCHClTE98nP3qIjGT+7Y4Q2ZTWModrkFVciLBgP2AOlvIKUY2pWHbM4WMGoRuDtY08cgePruPLZ63I4wpwgcHI54Y/U+ZXW+F/YbYZP91iCQTFcfvXX0xMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740937; c=relaxed/simple;
	bh=r4EN4cUQhmdttwT8J7A/ALIumhx3T83c2IIKI9j+cTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMFDRV6rj23pkmulDk/YkBM+lEXOqLsJpF85FG54jjSfesfInp48JM+Q5Eg9x8iZR8+lbRAHXSD/R7AAoAXEQghQKmF5r/wuel4hUvT8cxR3dP/fGTHHbVw7tdChMKSAXnuoq5N8MSbC5xh3Dbnsk2H9ZMcMZsKx1Ue73DyILBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ypmVihT+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dd559a83so26339275e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740933; x=1762345733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0T7W22CJyD3WK78vbrBChBctKIHWzgfiMVfymB9+2M=;
        b=ypmVihT+i3Lws/bpouqKIY7pAphwoJm6zjvzC0GtgcY3I1D8xjuE1s1u/umO8W/FDy
         zyu2uU++Ku8FU9Z5Zdac+fMIzFrrNiB4TltgoE7mMvi6BCZJOyOn29qpbwM5waRAibkb
         /LAn+oZEjO6KHh2ahkk+l5axFwnfAQmaTGVM0nLnwqpUTWTfgxNc9z5kiOGAVk1+hTZI
         S/AJ5p3Ga4qmow+l74piRC9q7FDzCg7mNHwoxyzgmOn+NKiXvq6fsvU1RAA4jVv0yJOC
         JdDQkaPgoUwkWwZgzcPk8t6V0WqYz4jNAYfe+Ve4rW9ybykv2CDjQdfMclp/pKvnbUs+
         NnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740934; x=1762345734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0T7W22CJyD3WK78vbrBChBctKIHWzgfiMVfymB9+2M=;
        b=TjLAbEv0Y16ZJP062iCgh/Atei+enefSl42ctj3KyM4PTL72o5QoFav5edEo/fzskl
         Yraa8nqESojlpHlejcF+qbeME/r8MbKTsD8hYYeqUamu0tvPL757thfccxNEhXUJH7mg
         hP85yxTUTTupcsPMxOOdRTAE/EgsprdbcWB0LsKCC1hwftyo7Q445Uz1AaAu02kpngD2
         NEHKllbW4OjVpbsiOwUJlf+xPxXJ+STwjpE7QyIvdIWJq+qyDhw3RJLCwVqLqvoWOWnD
         qduEHP6vU7LSyA4ikfCNL0tX0/ArF1G3v/qVm8RlY0R9k8Xo0jveR7ugOKtMRn3+kyok
         hJVw==
X-Forwarded-Encrypted: i=1; AJvYcCVr/ozVxrWKm3YQqUtXEtO3Kvs4Q9azkJy2G99J9M8vdnZlpvlRYOW5HXlTgO3x2RYDm0kiOYoqUsPE@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfAaXzPrpdPdwieiWk0ql7qi93afesJyVHSU0rjN2QcBUEhTL
	MiqxGHU5qdksJWEW1BLc5F6ZfTksnDQHVb2yDcxBhMb9SqjgbwjJadt34N8m+SHe0p8=
X-Gm-Gg: ASbGncti3NvJ56dKmdboPj7OhVWBqJPrORAd5H5pd4lc+LoJ72DwtCUFwVyyUoEJLFi
	Mil2OhptNRcjq7SxqI9uvM8Xqt+hF0VqVAFrP1ACtZuHMcxk/CbtYDZpO3Fg6FbvzYVZSnIQPOy
	6xR1GL6WgbCplIoO6unC1LhvTWy60ucf9DyNmgF8ABCg6iGtoFZvHhJD3OdeMAhAn7U4LEThRi/
	S6fWLPK4DVxtLMbgHCl/Go17mzJjfWka5JfuvY62bfg/dOVJD2lbBWSA2q0useom4CY7RfnGfqY
	HUi2M6ySnG3cIMbsfptmfgaWQYE4dNdLZxKodAKQ9CmTt+ZeUsVCr14u+UbNbvZAHG9aTTKi8ix
	9gRMNZ3IXMIYvCzA3WE9kLpPDnEzpmLA6EYNaL9T/YOuE9vkoE6SzfLQTl27sQXBjd7flgg==
X-Google-Smtp-Source: AGHT+IHhGdiwetSWYDCCixJ+vXAkD6pjOHz9Dc9Qp9sQJVBipevjCg8vZIWpzFdaT96sDMNDQxJ+4Q==
X-Received: by 2002:a05:600c:3b07:b0:475:dba3:9ca with SMTP id 5b1f17b1804b1-4771e1f59ccmr23510325e9.39.1761740933570;
        Wed, 29 Oct 2025 05:28:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:37 +0100
Subject: [PATCH v3 03/10] software node: allow referencing firmware nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4794;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=724+EoY2pKjkgvf7fb+DRalEW8uhDizNctnroZBQlZ4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh96TGxDUekua45vs7lzh2KmmmRwVQUE2tlz
 0DVF0IlogGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfQAKCRARpy6gFHHX
 cnmcD/sEumUlXRnqDNWZNKosIV9jDSGycAi8t907Lrlyl3V39+GQnbcUw10omO1ndr5KTRWZUX+
 xvnl8mPxq+Yjw3z9R8YJqOnhGSqAdjdVhjQnmS6qAiqdCmTGb/2c9DnLGKeLydAuxFDBsT8YVkm
 dXhyMPUDAuHxDdxsIwOy0DPQqMnsRK4vs8Ox1uYG14j25bNBXckHo/nLwrfpeEDKKrPSIv/LVA9
 g2T2l96Q8wmt2sq+21+s27v1otcBseNCJQf8d8k0z3oux/AFN8dztvYLZLmoc505/r+eTJZ/SQy
 NGxNNxTbKdf74hUY/0B+/sqS81m0SROQcSk2wesW1RfK/YgXoeHUwx/Nn8SmP9QNqkYbZUnjivZ
 aYgFLbloXqgamxQsAWfAah950FPvHfFS8FKM93O8MMkvo+R94F9Vv8kt1aEtlteumYiYbF8sqL3
 Z1SYZUmlmsq2xgQpw0Niqbsw1hzwwyYHs87PusP4BppeOcCayAXEf5ZZOzpfAR0I1FU7r/1gDfI
 DXcm+hpol/fkCNTy5eLEAii93Joh2z2evOaQlznmEErYAJKFjSrfWMwr+ruhytvRMH0KioKQ92z
 l6JBhjkRKomZEJOk10TZNO//2cGyohXZUcS5zRimO79QWygw+WxPCjWIYUMFvjRNCpk9qmwmnqt
 EaQIJoJydIjzagQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

At the moment software nodes can only reference other software nodes.
This is a limitation for devices created, for instance, on the auxiliary
bus with a dynamic software node attached which cannot reference devices
the firmware node of which is "real" (as an OF node or otherwise).

Make it possible for a software node to reference all firmware nodes in
addition to static software nodes. To that end: add a second pointer to
struct software_node_ref_args of type struct fwnode_handle. The core
swnode code will first check the swnode pointer and if it's NULL, it
will assume the fwnode pointer should be set. Rework the helper macros
and deprecate the existing ones whose names don't indicate the reference
type.

Software node graphs remain the same, as in: the remote endpoints still
have to be software nodes.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c    | 13 +++++++++++--
 include/linux/property.h | 38 +++++++++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b7c3926b67be72671ba4e4c442b3acca80688cf7..8601d1612be31febb6abbbe1fb35228499480c56 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -535,7 +535,13 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	ref_array = prop->pointer;
 	ref = &ref_array[index];
 
-	refnode = software_node_fwnode(ref->node);
+	if (ref->swnode)
+		refnode = software_node_fwnode(ref->swnode);
+	else if (ref->fwnode)
+		refnode = ref->fwnode;
+	else
+		return -EINVAL;
+
 	if (!refnode)
 		return -ENOENT;
 
@@ -634,7 +640,10 @@ software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
 
 	ref = prop->pointer;
 
-	return software_node_get(software_node_fwnode(ref[0].node));
+	if (!ref->swnode)
+		return NULL;
+
+	return software_node_get(software_node_fwnode(ref[0].swnode));
 }
 
 static struct fwnode_handle *
diff --git a/include/linux/property.h b/include/linux/property.h
index 50b26589dd70d1756f3b8644255c24a011e2617c..66640b3a4cba21e65e562694691f18ecb2aeae18 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -355,23 +355,35 @@ struct software_node;
 
 /**
  * struct software_node_ref_args - Reference property with additional arguments
- * @node: Reference to a software node
+ * @swnode: Reference to a software node
+ * @fwnode: Alternative reference to a firmware node handle
  * @nargs: Number of elements in @args array
  * @args: Integer arguments
  */
 struct software_node_ref_args {
-	const struct software_node *node;
+	const struct software_node *swnode;
+	struct fwnode_handle *fwnode;
 	unsigned int nargs;
 	u64 args[NR_FWNODE_REFERENCE_ARGS];
 };
 
-#define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
+#define __SOFTWARE_NODE_REF(_ref, _node, ...)			\
 (const struct software_node_ref_args) {				\
-	.node = _ref_,						\
+	._node = _ref,						\
 	.nargs = COUNT_ARGS(__VA_ARGS__),			\
 	.args = { __VA_ARGS__ },				\
 }
 
+#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)			\
+	__SOFTWARE_NODE_REF(_ref, swnode, __VA_ARGS__)
+
+#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)			\
+	__SOFTWARE_NODE_REF(_ref, fwnode, __VA_ARGS__)
+
+/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
+#define SOFTWARE_NODE_REFERENCE(_ref, ...)			\
+	SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)
+
 /**
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
@@ -463,14 +475,26 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING(_name_, _val_)				\
 	__PROPERTY_ENTRY_ELEMENT(_name_, str, STRING, _val_)
 
-#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
+#define __PROPERTY_ENTRY_REF(_type, _name, _ref, ...)			\
 (struct property_entry) {						\
-	.name = _name_,							\
+	.name = _name,							\
 	.length = sizeof(struct software_node_ref_args),		\
 	.type = DEV_PROP_REF,						\
-	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
+	{ .pointer = &_type(_ref, ##__VA_ARGS__), },			\
 }
 
+#define PROPERTY_ENTRY_REF_SWNODE(_name, _ref, ...)			\
+	__PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_SWNODE,			\
+			     _name, _ref, __VA_ARGS__)
+
+#define PROPERTY_ENTRY_REF_FWNODE(_name, _ref, ...)			\
+	__PROPERTY_ENTRY_REF(SOFTWARE_NODE_REF_FWNODE,			\
+			    _name, _ref, __VA_ARGS__)
+
+/* DEPRECATED, use PROPERTY_ENTRY_REF_SWNODE() instead. */
+#define PROPERTY_ENTRY_REF(_name, _ref, ...)				\
+	PROPERTY_ENTRY_REF_SWNODE(_name, _ref, __VA_ARGS__)
+
 #define PROPERTY_ENTRY_BOOL(_name_)		\
 (struct property_entry) {			\
 	.name = _name_,				\

-- 
2.48.1


