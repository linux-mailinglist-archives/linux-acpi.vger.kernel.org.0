Return-Path: <linux-acpi+bounces-18522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FCFC3491C
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FCB3A963D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B582E36F1;
	Wed,  5 Nov 2025 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="o43YTN0A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F72E1EE5
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332487; cv=none; b=XW0z3mxC/wfWLOh7vFoPp0oMaCFezfHH8kOpOw37p4utcm3AUD9g9SckyQkGSTrnpsUzn3yIA21dXfxbUWwnG+qy37R04zxpZrPjdrGFPutL8pHk0xykcboys7Xk6dkuJMkPHlFtdqhHgKQfo9q17VB9hX0nrhlEIX/pw3J+tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332487; c=relaxed/simple;
	bh=ZzrngTy8GvyLzYtwqD4FoT3jMmWGmQZFcpmlX8gaDnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3G0SH3kL5Qjs+csE6rw18tOOqisoA6KCSnaLoOTe4WbdNVApwoui7FGT0FjXPEOztVLyICckd1x9v26Tw5DOz7+i4XXYKSUuQBpePK7bM8zipFPHosFA7Agwsa5Sfvim3sK1UrXRTz21juwRuN/W+uSR998CDDi2YleMZ1iu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=o43YTN0A; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4711810948aso45375175e9.2
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 00:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762332483; x=1762937283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OAyY/i3h/xnNvRM460Hy35E4MkdMx/5c8tuVEvyWsY=;
        b=o43YTN0AzrHjFLs9lsFByT0SoGKhWKxOdNpfFxSvvbjWTa3uySGDs08TSOWJvcRufU
         Y+kqP+aNKdR+aCRUmkHTwkIahQqoR4sLhqXS6jOF50iycKlvQPDYP9zJO7F5VGvsKl1K
         qlJ1grQ1GDfNzDpaz7pAhef/xV1PgGrFTIDS6qEvMZCjlIZkS96CwjejrSlxWwFeXnqQ
         htZL2zE5O72oA3m5ug7GPbM5eDGSLZqjJoIV5mkatkT8rlJfoaNAuPDmQ3//7J7pqiJs
         gQqbXU9y/w9PQWNUylh8ybS+qPHBBHI60yuqhjeUkJeU9X5c0H193gHKiWxy33QE9U1p
         HnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332483; x=1762937283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OAyY/i3h/xnNvRM460Hy35E4MkdMx/5c8tuVEvyWsY=;
        b=wbdF290Kl8blqjTxAcWIivUnpFzZ3uzHL+pdrz5M0Z4XQ28Gq3HKOWNVzwTFNR2Wys
         6ZoETYj1d5QaPlmaNugf6cyAlZiPhwQ97UK8IT7SA7zAqAQp0gtkhXttAQs5Ny8DWLOf
         MWmP0M9NQv9Vh3yZWBuf1m248esHXM5veZXfRERYSIEw2zu8iqwvlOD0Uik+4RtMFR99
         WOAgLvUttb4JBkZLUpOxuWyOp5g4vO3sPHPPH2wgf6BR8BtQ3KKLmTHyF0qUaPNZVZPu
         4NIkH7moC0qwusDkC3atGPV7hB/SbKjN29XQynI472TWeqmHyk6OiRvc1Hf3+47HZGTm
         iuFw==
X-Forwarded-Encrypted: i=1; AJvYcCXfWc0SHRUL6HvoPLx8r9bWmPDf/BBi++lYRmpXrfFuZs0JDNnFTbwEQFjzCZzGQRA+tUGe2uP7jvP3@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGSC32/ca89Er43WLAYDCJxLl44WTskACkQu5KmbdO7bC30mz
	1nNsQImiDqRxkQKqnuFyl/GzSDjCKol98zGbnmoPKoXA/rMEk+yu33ZLhxHgUrpS+pw1S0olpBw
	Nz+orbRaagQ==
X-Gm-Gg: ASbGnctuedIxVLHHCFwm2fYnnf4DJ5h1lUgTfNfJlbGI51KPQkKf35lQ1q9lM7Vnp3b
	EsUnA6chXx0dTll8173BiX6c+aACNOreU53RZBq3T+T8AyP25bxJdsTunSQxsosF4jW94R9zk/6
	5k9joUy7sqUFrP5XV4t6RdOOm8TjzRHDnICp7Mu7v1zwi3gnYEF5qgxIz1RvZoMJ/7sJCWJ4zN2
	9HXLZvRYwYYvSEsoMBiCGYA44iI5ib7Ho0C8CgwbmNmU0kgi/08pbvUMfX0ne4C5j8rVr0l9zY9
	tQqCHu7/nQgvBhfr6V5+ZpaK6QxQDuhEavC6RCcll9PeANP6B0eulmuWjiv3RXJWZCmfcnsoq7f
	SjQVVAzsIvg/q4ljcHEVfu1yCrzyeOyYebhnbm5cqo6oWOid73mcK2Y9UGvKvJezVhyVLRg==
X-Google-Smtp-Source: AGHT+IE2WPCD4GiDlUt+MHh5JCpQNRYBZvuFk64K36d4NGc/YsH+GIeCl/xuZLKboh+Y80dVw4T4ug==
X-Received: by 2002:a05:600c:821a:b0:471:1765:839c with SMTP id 5b1f17b1804b1-4775cdf4770mr16644615e9.20.1762332483098;
        Wed, 05 Nov 2025 00:48:03 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:4e71:8371:5a52:77e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9315936f8f.34.2025.11.05.00.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:47:58 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 05 Nov 2025 09:47:34 +0100
Subject: [PATCH v5 3/8] software node: allow referencing firmware nodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-reset-gpios-swnodes-v5-3-1f67499a8287@linaro.org>
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
In-Reply-To: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3759;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=wXlmW1dk+PI/4eJ8ubrNkh/VoKzD6+wnAicAUbt2Xl0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCw8x+G6l9pwkekwRY/FEtaPs1gOr5eb2k6K3c
 JU1HAMzFCKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQsPMQAKCRARpy6gFHHX
 ctMwEACfSzKb9DlWHXQfZWFRpCFeH2jLvNwW9DNJfuYb+rf0QlGnT6Jz7YlqOd158PxqgkPr/ex
 enpcuNGArvItmP1v/6Z0wykrf0piX2jCCzNbLhZTO3DJSFih4T3CtUeUL3proU7k3MWgLpLJO26
 Xe+Op1urBq4s9P+nvXF3BKfa7iVg2u4ZdBmBsD7B/JHtI8bE6k/qqRNMW0m5v1TS+Ec8XVDoUV1
 ra2xpriDkrkhl3ViTeD+Mp9TJDdUUxgIHs79X9xi2/98m6dVKmbhkUvcKCA9t26G2FPzgBoCiTk
 wxUa9gVTC3R2oWFD4tvk1I/f7Bv16rEJvu02TMhdXZiR+g8mFBBDA07TziYEFaGHv9e74ZZtPN1
 i2q/6OzEVae7f1Rd1HWmLvZSMo+q8omo0kb5J098AG97EtyCgenP4DcxDVUHkXN0SvqppdN1F5C
 U4aEUAb5P99akn5mA3S1TEdz3VDcx4RlBkR2Y10IFgLH+FrLfmpGnVlEnYO8ZWJF2BDE/zLbrR8
 vyZAPuwMpYKEtEByscVLYLEVdksQE5MQDKODWBHiP3dVbeWPUxKn2ldsy3pwMiAfgaVV+w3bUUe
 jIUoE4Dum8VmIZFSMnT5X/5srL7wihcYsiaY+vEhfoLtJzXDIp2mERaQfVxMBrwdEgQFsKjmIa8
 zVy3d5nHN0U7+Yg==
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
will assume the fwnode pointer should be set.

Software node graphs remain the same, as in: the remote endpoints still
have to be software nodes.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c    | 24 ++++++++++++++++++++++--
 include/linux/property.h | 13 ++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

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
index 50b26589dd70d1756f3b8644255c24a011e2617c..272bfbdea7bf4ab1143159fa49fc29dcdde0ef9d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -355,19 +355,26 @@ struct software_node;
 
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
 
 #define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
 (const struct software_node_ref_args) {				\
-	.node = _ref_,						\
+	.swnode = _Generic(_ref_,				\
+			   const struct software_node *: _ref_,	\
+			   default: NULL),			\
+	.fwnode = _Generic(_ref_,				\
+			   struct fwnode_handle *: _ref_,	\
+			   default: NULL),			\
 	.nargs = COUNT_ARGS(__VA_ARGS__),			\
 	.args = { __VA_ARGS__ },				\
 }

-- 
2.51.0


