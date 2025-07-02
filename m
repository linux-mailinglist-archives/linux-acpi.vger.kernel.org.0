Return-Path: <linux-acpi+bounces-14906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D9AAF0A70
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC711C01EFB
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75052248A4;
	Wed,  2 Jul 2025 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JWsDJxY/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE3219A8D
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433355; cv=none; b=Kf0ARgHqC1cCR8ddCL70wBPH/z5mVNr2O2u5FTww7AQWT2q1M08GEOdZNqsNjLED/I6xhrMft5zzokGSmiInAKF9Y/46WLoAzmkpGhRsKY4wAVidtVfkw+/9fwdzrCNvjYeT6K1XfTHyNU+qQR4L8u0VWaQtOimC4FpdsO3Eq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433355; c=relaxed/simple;
	bh=SBjQlH46dBB3U+TixQzZp78z+Lc9Dr3istOOhSNwHTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y46l50ZMCN+2fNiLM1AU3LdWozIEwpb5VpBiYkgbCNvC9U2bnJvbatsh8/JqnHs2pjYeChcNeGMYTb6opAHC82G13guEJDTTS69Wo4DVWdk0lfaWwntrBkjXGIYus/F5IBZGN4pasrRn4j9Ew7V8+4CiQhPyb6vCQPAPMrc6Cw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JWsDJxY/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234fcadde3eso52620235ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433353; x=1752038153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/zEjMktz2Q+rhDOD+xT+f8Y23symCCnfKy+4Q372EY=;
        b=JWsDJxY/6RZ+xJReravIEnJDJvvVkT9FPB3NbNviiVibrnf9a+IhalAicubSKGmXbt
         J2kqnorPJ92N3i2VM1j6Gy3oWovht3KObjPPUMKozL+DqQuEczXeovvxWMmwEN3G/iJz
         tV5ZA1YNhiopFPYvp6qniexikXrB37l5Wy+0CupH2FwMgPlFli29XQ9yjmG2fhHzZhBf
         C9rIYGpyKxRYxitZv1+dRr+gPwgqGtsuzqMFaD1zgRCODky6QNeE/B45frC4DuBjsN3h
         IbxpeaVhUXmyc8nx6YMnZ/6NLuu2Sr9o+EfkAQiAlpcqGG72LEO87fh383Cdgb4DNfQS
         kghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433353; x=1752038153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/zEjMktz2Q+rhDOD+xT+f8Y23symCCnfKy+4Q372EY=;
        b=hdk3KbqUoujQZhUWJDKi+u3Yk7R0V91pKAIgwD8D2PtI6cKTmKeLbd83H7q/HAnRRw
         kF1yy3k9K+jnrd70ViBnmoZAyMqJjTOU4LKbb/7ML7Rhq2QB0lM04OYm3bJulUihcdu6
         gfi75e5FJB6xSoaO9f+NyHdxuC7Vb89hXDEeI4PEaMxkyHyILrEK/LeeQblulTMVpXbZ
         YGbidPAHI9ric3ZOM3dEHwjtTVvsip/s0hovCiuKI5weY7iLQLlaYHxPFNzrv5FI1pxj
         kbAwmn90DhiVVaBLBjzSZi8T/tn0VCOqIuF44rLDotLVZNRp+zdwN9/nPOT0mFyIrz7a
         fMuw==
X-Forwarded-Encrypted: i=1; AJvYcCVTNgisMghmjpSApWrheJ4wn4UicI7+YNeRLyADiJk8l+sdy9Owk4Zwl9OXJML25r/YPo9156r9zC+f@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfL8YlNg0kWBr6TD4RnSenFuVRid7w3+t3BDbWMvyhAfReA/E
	rjjBaoo5klrlhGPfmjzrrK2rXfkxgERKtReyYMMsg7DMjuB9MZPkJlff5gEuQXEns4E=
X-Gm-Gg: ASbGncuS8HRpz6Ztn8UaOSaTbGDlioJcd8ZNB5vA6LBAAOZ/lGjOvCFEJd2ACYWMV3f
	bu9s5dXLqNmsmV41kFVt9EUNQo1ZmijomanKMJJRhUkv5/8wkoD7l4VpiUvp/WdLNHPhQx3cKIR
	54Dlsg8po70isfoQ9oJL0aaxg9tYgPSA7AKMlN1VlIYtrXJZyYleQURbecLQYu4ndWNukLAO7t0
	t8gg4aAhqZ+2A9EXJTIMgg+iDpazLUryumLFkeomCafEzqrtolLlyb8xLl+4cZoBe+5wIQOqZS5
	YU8D+5UsbNi6DiiAK56mCNzje6Ss9exsR/odImEiUwzj1cK+uNJOfuiiMtPHos1dSzWiVdnjuwg
	SOQLiClNrDrqjWif3
X-Google-Smtp-Source: AGHT+IEOlCPfn91jehZz17KbPl2V65GbsvXkZwBM5VnlRUrlsareLdZdXrSGHc7tHPZeN4+C2VQsYQ==
X-Received: by 2002:a17:902:e78d:b0:234:ba75:836 with SMTP id d9443c01a7336-23c6e4dbeb8mr15640355ad.7.1751433353221;
        Tue, 01 Jul 2025 22:15:53 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:15:52 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v7 14/24] ACPI: property: Refactor acpi_fwnode_get_reference_args()
Date: Wed,  2 Jul 2025 10:43:35 +0530
Message-ID: <20250702051345.1460497-15-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702051345.1460497-1-apatel@ventanamicro.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

Currently acpi_fwnode_get_reference_args() calls the public function
__acpi_node_get_property_reference() which ignores the nargs_prop
parameter. To fix this, make __acpi_node_get_property_reference() to
call the static acpi_fwnode_get_reference() so that callers of
fwnode_get_reference_args() can still pass a valid property name to
fetch the number of arguments.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/property.c | 101 ++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 436019d96027..d4863746fb11 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -882,45 +882,10 @@ static struct fwnode_handle *acpi_parse_string_ref(const struct fwnode_handle *f
 	return &dn->fwnode;
 }
 
-/**
- * __acpi_node_get_property_reference - returns handle to the referenced object
- * @fwnode: Firmware node to get the property from
- * @propname: Name of the property
- * @index: Index of the reference to return
- * @num_args: Maximum number of arguments after each reference
- * @args: Location to store the returned reference with optional arguments
- *	  (may be NULL)
- *
- * Find property with @name, verifify that it is a package containing at least
- * one object reference and if so, store the ACPI device object pointer to the
- * target object in @args->adev.  If the reference includes arguments, store
- * them in the @args->args[] array.
- *
- * If there's more than one reference in the property value package, @index is
- * used to select the one to return.
- *
- * It is possible to leave holes in the property value set like in the
- * example below:
- *
- * Package () {
- *     "cs-gpios",
- *     Package () {
- *        ^GPIO, 19, 0, 0,
- *        ^GPIO, 20, 0, 0,
- *        0,
- *        ^GPIO, 21, 0, 0,
- *     }
- * }
- *
- * Calling this function with index %2 or index %3 return %-ENOENT. If the
- * property does not contain any more values %-ENOENT is returned. The NULL
- * entry must be single integer and preferably contain value %0.
- *
- * Return: %0 on success, negative error code on failure.
- */
-int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
-	const char *propname, size_t index, size_t num_args,
-	struct fwnode_reference_args *args)
+static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
+					  const char *propname, const char *nargs_prop,
+					  unsigned int args_count, unsigned int index,
+					  struct fwnode_reference_args *args)
 {
 	const union acpi_object *element, *end;
 	const union acpi_object *obj;
@@ -999,7 +964,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
 						acpi_fwnode_handle(device),
-						&element, end, num_args);
+						&element, end, args_count);
 			if (ret < 0)
 				return ret;
 
@@ -1017,7 +982,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
 						ref_fwnode, &element, end,
-						num_args);
+						args_count);
 			if (ret < 0)
 				return ret;
 
@@ -1039,6 +1004,50 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 
 	return -ENOENT;
 }
+
+/**
+ * __acpi_node_get_property_reference - returns handle to the referenced object
+ * @fwnode: Firmware node to get the property from
+ * @propname: Name of the property
+ * @index: Index of the reference to return
+ * @num_args: Maximum number of arguments after each reference
+ * @args: Location to store the returned reference with optional arguments
+ *	  (may be NULL)
+ *
+ * Find property with @name, verifify that it is a package containing at least
+ * one object reference and if so, store the ACPI device object pointer to the
+ * target object in @args->adev.  If the reference includes arguments, store
+ * them in the @args->args[] array.
+ *
+ * If there's more than one reference in the property value package, @index is
+ * used to select the one to return.
+ *
+ * It is possible to leave holes in the property value set like in the
+ * example below:
+ *
+ * Package () {
+ *     "cs-gpios",
+ *     Package () {
+ *        ^GPIO, 19, 0, 0,
+ *        ^GPIO, 20, 0, 0,
+ *        0,
+ *        ^GPIO, 21, 0, 0,
+ *     }
+ * }
+ *
+ * Calling this function with index %2 or index %3 return %-ENOENT. If the
+ * property does not contain any more values %-ENOENT is returned. The NULL
+ * entry must be single integer and preferably contain value %0.
+ *
+ * Return: %0 on success, negative error code on failure.
+ */
+int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
+				       const char *propname, size_t index,
+				       size_t num_args,
+				       struct fwnode_reference_args *args)
+{
+	return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
+}
 EXPORT_SYMBOL_GPL(__acpi_node_get_property_reference);
 
 static int acpi_data_prop_read_single(const struct acpi_device_data *data,
@@ -1558,16 +1567,6 @@ acpi_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 				   val, nval);
 }
 
-static int
-acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
-			       const char *prop, const char *nargs_prop,
-			       unsigned int args_count, unsigned int index,
-			       struct fwnode_reference_args *args)
-{
-	return __acpi_node_get_property_reference(fwnode, prop, index,
-						  args_count, args);
-}
-
 static const char *acpi_fwnode_get_name(const struct fwnode_handle *fwnode)
 {
 	const struct acpi_device *adev;
-- 
2.43.0


