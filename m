Return-Path: <linux-acpi+bounces-18430-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D0AC2AC84
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A49D3B1813
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FD22ED167;
	Mon,  3 Nov 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y/czTzP1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E197A2EBDC7
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162545; cv=none; b=XTdEg0+cGOvplI4LNSnX/1pqnUksRs4vy+Al0UOFGrg/6IG2KICiF0k+INYBL9kmUH30KgQeDUqtsIr6WT/VWQZzvk9/jnc7Ljiac6zdlxVDUY5zAzE3TAuE6Wld3cNa66mrzsh/ZdfCkyxtFFfnPL/5LMuVEfoOrkVNCg+vw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162545; c=relaxed/simple;
	bh=8nCe1ffODQY7b/ZHkOseEFiGz2HUald40nRLcY5llHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbTee2fL6Zpi6EJCTtkm5ECoUFHA+CJ4bOBX3/1Uh6yRTP7vQUKRQs3nOsiooODDlvBbGKwmXCYr4jWxkjlVoIoDZxZmQp2nM1cKf2fzDQdWIqM8YY5ZJUDC+XsnvkW8QqfjpoC9a8vwPhvlRTR0euJtSMR8SDJIAsCsAky4Nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y/czTzP1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4774f41628bso2310515e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 01:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162542; x=1762767342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZmi0yPQjmv78bZP2daRDqMBsZVUhhJlneKShWpZEfY=;
        b=Y/czTzP1B/SDnkbu0p8m5QjNF/Ya89FVAsdjPsttKYxxN27EaqKSjO+Sf3bvgwZsT9
         kkt90t9AkRK6q4RTErZJL6K0iFbi5f4sVLe9HvWFB6WWlja1duelfAXVpYg1XI6rUk7j
         WNIrKBHDgY46YYCbHwTNgjMfPZZVBEy9woajK9SFV1j87Iz0SPbmXeV6dSBchcaqHN01
         OvXbRovBs9cKANjAscnnHJND3QaQ04gTti9nsZrOUpuSnwy15z/CG0xTrJyUSOmfk2Lx
         ES2WNxZwEiv+r9qLAgLPjmtKnCcs8Ar32Uh7xD/EFGQH4Y68PIh9rNNZlP2ZjYl3Nqyv
         r8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162542; x=1762767342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZmi0yPQjmv78bZP2daRDqMBsZVUhhJlneKShWpZEfY=;
        b=grCWPwvKrS3bj6eZHNqe9py6I50eX/HG9J3HbdSFGkrXyhAO41jl28G5UsubjQPyF9
         fwsq8gOkOuZE9IgKbddjImWn3o25k/QoB/SB+lz0a8JGbVxxwU/QflyFBxNdsYEkV2NH
         Xh13hoAeAcUuQV/6WLGJvUkPh8Wo+cYu+O0VlGWJpmJvzoMRsv48E9aY89ZaJUmaboeq
         2t7V1ASVGHNhiCajrPZ77+lqd+7KiZtJyCdpcm5TfjNtcZxwcEll2YjclN9qUzcXMxdI
         ZpGKAXpTWgOVOvOMQVhRMWToDVfGfK0U5s+XpArJZV/cS6sX7hnis0NgOXdQ9JysAMyY
         cReA==
X-Forwarded-Encrypted: i=1; AJvYcCUZu+fTgHxhLv4+oeW/SqailQmjTb5SVHkt8KwWrwO+Q9m9Z1FvxP9+GOSVglMkljExYSsts1robPq1@vger.kernel.org
X-Gm-Message-State: AOJu0YydO+zTn8gnLOhHiXcg7x82cPK4OyeccMKAZ1D+6F6aZ4c0sx2S
	L8D/WOAnVW9F2dWYTuzTgrUIlp+e6kHwXvAcXUW7LfH4wneITfiCjxWHKl+dAMd9nb7Bhqal72j
	lp3Djay8=
X-Gm-Gg: ASbGncu1+A4n76kIBbbJ5mzc3PYkedNUougOH9Lus4qrw3KuurBb9FtoiSQQnHYKhyj
	EQO+yZSX/c69iFOXq8jx7Hhft6+7bxnWNTrEOWR9Ux7ea+iR0XSFsb//WRPi4Ui2ynJWtpSHP/z
	RRCK8ebGghDR2Z1E7CFCoNDIJcxUpi+kR0Di9ZFmjrRtJuOg7KkFbiMfzf/sLnGud1LlwtCDBm1
	6IY34X3OWa3LGwC3OcnVQWEeJ5+n8s4dKnAZM95wRYBH+g2eodQ3KFeL8lcr/Z4xc6J3pc9CvMi
	M6FKwqKz6XXmt+BUroQutbfbvpt3+4BqrS2syZavzXNLvqEG12XOl7aZa+rwYmesGYsXOi6F1fv
	OxUn/15egdyO6RJoMp/hEseOP67DtfGux+7GvetXPWfk9E13yA2Xc1DeNTZnckjdwlmjT98ap2o
	pjY742
X-Google-Smtp-Source: AGHT+IGdxLPcE/K4/TO8131mt2+C/2dE32uptfqFQg1949jUeNNU8hczBSRsKhCcvHdC003ivqXO6w==
X-Received: by 2002:a05:600c:8189:b0:475:de75:84c6 with SMTP id 5b1f17b1804b1-477262a941emr130475275e9.12.1762162542063;
        Mon, 03 Nov 2025 01:35:42 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:23 +0100
Subject: [PATCH v4 03/10] software node: allow referencing firmware nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-3-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5545;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=CglNdrfCAaq7YvMmTB5KvNkJJjQ/bxZIXxu5hpYZKbg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdkuicPAmqOkm4mg7hCWcWFbVQvHI1UcTJro
 zg2xp7uiUiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZAAKCRARpy6gFHHX
 cs04D/9t2nPBHfuVddQoRnJ+7j78sGCQlrTSC3o2NPGXnBw33tJ52caABoIpb1CzxceZd2q7quy
 ZTpC40BS2+5tXAA6Sbu38xHEiecjF3w44iR9C3kyCrzGxwPELzwSKteY0huiClhbhNMsglhiVL8
 16gSYCPp7emqDteyCJt7pyGGu/6lD6Q/Y4qhRT8AE5B9jnCN2SZ4dKg6fEy+fUNnRUX9V6FpF26
 N3YnwbGG0qrGB0O4Cuz6XUL4Ub2ITSDOLcDgO3Bp6Iy0pa6WpBM1zpY6ExIQ2e6I1+Z8rFY3gFq
 rrd2g/odePfia34k/RZ85B304zGDEzSUysRrrKxEpcWYE9ywYMde/1XubjqzenUnovjuTLEmXOC
 VVcusguW/7WKq7ZM4WTZGnRFg9qQ/ThOW28pmo8kXazAMOAJuSQpwsXSQirwP3gAjBE4ILzH7R9
 HLpWU7+l2ZAHJwq4mAbVX9/Tyth/gha3Z+FyYYZEWvStWjeyg8AtkZjROF3W5zjjLckd1150s9T
 f0BFCbENuiq2QNQF/4+W4WryPtbdMjFTflg2ke2+6M07Oh6XSa0FHnga4xpcUZH2qsKjLA9eCzl
 /A87E/1wLbyAQ36Y9DbzSONVdYqdlV2f1DH+xCk54RAAnWe32LdZLGaj4lCPZZz5e8kRXfw0WnB
 cc352eOSp28LEyw==
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
 drivers/base/swnode.c    | 24 ++++++++++++++++++++++--
 include/linux/property.h | 43 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 6b1ee75a908fbf272f29dbe65529ce69ce03a021..44710339255ffba1766f5984b2898a5fb4436557 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -535,7 +535,24 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	ref_array = prop->pointer;
 	ref = &ref_array[index];
 
-	refnode = software_node_fwnode(ref->node);
+	/*
+	 * A software node can reference other software nodes or firmware
+	 * nodes (which are the abstraction layer sitting on top of them).
+	 * This is done to ensure we can create references to static software
+	 * nodes before they're registered with the firmware node framework.
+	 * At the time the reference is being resolved, we expect the swnodes
+	 * in question to already have been registered and to be backed by
+	 * a firmware node. This is why we use the fwnode API below to read the
+	 * relevant properties and bump the reference count.
+	 */
+
+	if (ref->swnode)
+		refnode = software_node_fwnode(ref->swnode);
+	else if (ref->fwnode)
+		refnode = ref->fwnode;
+	else
+		return -EINVAL;
+
 	if (!refnode)
 		return -ENOENT;
 
@@ -633,7 +650,10 @@ software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
 
 	ref = prop->pointer;
 
-	return software_node_get(software_node_fwnode(ref[0].node));
+	if (!ref->swnode)
+		return NULL;
+
+	return software_node_get(software_node_fwnode(ref[0].swnode));
 }
 
 static struct fwnode_handle *
diff --git a/include/linux/property.h b/include/linux/property.h
index 50b26589dd70d1756f3b8644255c24a011e2617c..2d838117b7912b5aaff75318f9e7ad256039f2e7 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -355,23 +355,40 @@ struct software_node;
 
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
+#define __SOFTWARE_NODE_REF(_ref, ...)				\
 (const struct software_node_ref_args) {				\
-	.node = _ref_,						\
+	.swnode = _Generic(_ref,				\
+			   const struct software_node *: _ref,	\
+			   default: NULL),			\
+	.fwnode = _Generic(_ref,				\
+			   struct fwnode_handle *: _ref,	\
+			   default: NULL),			\
 	.nargs = COUNT_ARGS(__VA_ARGS__),			\
 	.args = { __VA_ARGS__ },				\
 }
 
+#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)			\
+	__SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
+
+#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)			\
+	__SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
+
+/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
+#define SOFTWARE_NODE_REFERENCE(_ref, ...)			\
+	SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)
+
 /**
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
@@ -463,14 +480,26 @@ struct property_entry {
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
2.51.0


