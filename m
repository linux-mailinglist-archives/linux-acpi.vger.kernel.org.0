Return-Path: <linux-acpi+bounces-6342-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D3905B6F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C62B28A9B9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FA33BBEC;
	Wed, 12 Jun 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KaAWPsH0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9361D547
	for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218115; cv=none; b=Pl0zUPSJAQR31k6r5Pq4QklFrGeimbM3esoTxz16Iq0kNLgKOmMXPszXPkXB+aucsoE9jAarbkGOaClk2QCruF+X4GOkrhqqNYviFANuDikHuKyKCZBDH6ZSpQvDrD3/Vm5HZpY7sYv0Jnlx2niVgYYEAUcih7TdikJYmXxxmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218115; c=relaxed/simple;
	bh=zzetqvw9rE3z6luIaQuIn5l8rk0hobL8f1wgIozEpBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3gK0Wly9vFNW8xFdQodHPmxiNzdWdbfmeykY5DSSFIzcdHptlwzHTx5kiMcGLprQg1+9YjH+4iSJ5WFf5KUjofx3oPfy8Fap6M69mBjpl8bcvH0V86H6JFiOiGwxY20J70z+3azsYXnJHJc91ZJJ7lSKf1j1u7vRvpH8GFKeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KaAWPsH0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35f1bc63981so853479f8f.1
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2024 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718218112; x=1718822912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cmew680A86e6P0TJ/CSWiTzW4h4Q5bXUMWdZRLFG580=;
        b=KaAWPsH0iWi05MR3CjibinOnyUfKs6Vrjk5z1YFfhxvwb4xtWBQvS8mgsDpFbekVuZ
         VVrEqT456Ak+f14gxTiYuTHpVVoyqkPUzJ5o9b8Snot4o3ExzEOaGq7DAC+a/DzZMu3C
         yWjBZmYlHa0zo6d6nXxA/HP0Q3udWAFi8baG+z45q2782bletBp/HuBzgQDlSlU6N4no
         RE8ihe6S4vVLxO4lfCjjQwRHaAcgdxQU7dN7jkGWLI+c/Zuz+ugpsT7Vgo98RB2G4SER
         xFyOS81/IFleLfNRTnVTvMYgOVs+IgmckIZjRp39l+18sNi0gDkEeKzD7WcVVUQYcF0I
         Y6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718218112; x=1718822912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cmew680A86e6P0TJ/CSWiTzW4h4Q5bXUMWdZRLFG580=;
        b=o4BVSmkYZ0dAVvxo75k8KZ60lw7IaREbeYI4oiP/zicZuM55iCZbd6ubwTlgHXDpsC
         oqZwacVezXu8xJNv8PHBGEd/JVA5gzGjoMKu48Lc7MK3AAb0TmnP0BxF8Jw7xo/LC/CX
         eap9SxJQR0nkuxLaaBnDb6ebSph9lj8ersxjxZfIleoOYB71MN1ji7+t68O24OTTWJNk
         VUrAaN9fRexjCkYecf+JfYbem9EorPBU84RvYuSDmdR3XIgrET+8GKO5hgIKJAUtD1mu
         v6mVEsH9+NIw8oafTuugwTGlLgFlcFDkwLo4M6noGiLA5RRDSODoc90TuLKDsMIJU6NS
         MVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm2Uqc1j6w46PuWtSD9APV7P0JV1cpyR+c6AeqPfgAV/ImFn1EMIpsspi7lkpUgBrKP0w7ylK3dHv5p0NWKtl+CMDP+Tdap/UMew==
X-Gm-Message-State: AOJu0Yz2ptLygN405eI15gb1a3H+TLo8DPemF4hDudCGM5kzoDr870oi
	Ld6LzdPRXZtFHXaJ/q9LiMAUoB5e9MuYeJjanocaK/0S2J4f73zOuOB4Jb44fkQ=
X-Google-Smtp-Source: AGHT+IGxdz1Bzt3Q1KQfzBP7LkJlIATQ89AuIi4xcYpUyaYS13i760yEF6S1V720g/EmquCWrHrsvw==
X-Received: by 2002:adf:e646:0:b0:35f:e890:fbe1 with SMTP id ffacd0b85a97d-360718df02amr480736f8f.19.1718218111541;
        Wed, 12 Jun 2024 11:48:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc1c77sm17147058f8f.95.2024.06.12.11.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 11:48:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: put gpio_suffixes in a single compilation unit
Date: Wed, 12 Jun 2024 20:48:21 +0200
Message-ID: <20240612184821.58053-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The gpio_suffixes array is defined in the gpiolib.h header. This means
the array is stored in .rodata of every compilation unit that includes
it. Put the definition for the array in gpiolib.c and export just the
symbol in the header. We need the size of the array so expose it too.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 4 ++--
 drivers/gpio/gpiolib-of.c   | 4 ++--
 drivers/gpio/gpiolib.c      | 4 ++++
 drivers/gpio/gpiolib.h      | 3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index bb063b81cee6..69cd2be9c7f3 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -976,7 +976,7 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 	int i;
 
 	/* Try first from _DSD */
-	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
+	for (i = 0; i < gpio_suffix_count; i++) {
 		if (con_id) {
 			snprintf(propname, sizeof(propname), "%s-%s",
 				 con_id, gpio_suffixes[i]);
@@ -1453,7 +1453,7 @@ int acpi_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 	unsigned int i;
 
 	/* Try first from _DSD */
-	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
+	for (i = 0; i < gpio_suffix_count; i++) {
 		if (con_id)
 			snprintf(propname, sizeof(propname), "%s-%s",
 				 con_id, gpio_suffixes[i]);
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index d75f6ee37028..49d533df2cd9 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -103,7 +103,7 @@ int of_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 	if (ret > 0)
 		return ret;
 
-	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
+	for (i = 0; i < gpio_suffix_count; i++) {
 		if (con_id)
 			snprintf(propname, sizeof(propname), "%s-%s",
 				 con_id, gpio_suffixes[i]);
@@ -676,7 +676,7 @@ struct gpio_desc *of_find_gpio(struct device_node *np, const char *con_id,
 	unsigned int i;
 
 	/* Try GPIO property "foo-gpios" and "foo-gpio" */
-	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
+	for (i = 0; i < gpio_suffix_count; i++) {
 		if (con_id)
 			snprintf(prop_name, sizeof(prop_name), "%s-%s", con_id,
 				 gpio_suffixes[i]);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0ec82ac7f0f4..ed620442f32c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/acpi.h>
+#include <linux/array_size.h>
 #include <linux/bitmap.h>
 #include <linux/cleanup.h>
 #include <linux/compat.h>
@@ -89,6 +90,9 @@ DEFINE_STATIC_SRCU(gpio_devices_srcu);
 static DEFINE_MUTEX(gpio_machine_hogs_mutex);
 static LIST_HEAD(gpio_machine_hogs);
 
+const char *const gpio_suffixes[] = { "gpios", "gpio" };
+const size_t gpio_suffix_count = ARRAY_SIZE(gpio_suffixes);
+
 static void gpiochip_free_hogs(struct gpio_chip *gc);
 static int gpiochip_add_irqchip(struct gpio_chip *gc,
 				struct lock_class_key *lock_key,
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 48e086c2f416..a75635891c6f 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -90,7 +90,8 @@ static inline struct gpio_device *to_gpio_device(struct device *dev)
 }
 
 /* gpio suffixes used for ACPI and device tree lookup */
-static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
+extern const char *const gpio_suffixes[];
+extern const size_t gpio_suffix_count;
 
 /**
  * struct gpio_array - Opaque descriptor for a structure of GPIO array attributes
-- 
2.43.0


