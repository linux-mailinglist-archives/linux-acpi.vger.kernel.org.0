Return-Path: <linux-acpi+bounces-14907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395A9AF0A78
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E114E3B34
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EC5219A7A;
	Wed,  2 Jul 2025 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TkeEvLIW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9B226CF8
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433362; cv=none; b=a+W74qJnDtqSEzHW5xlR9sDAjsMSCpJNOLDEKEHbU45aVaS2RfQvb7QNYxjqg7GqaQMvUmcB831NkH1Cs//yRkGIoQlitNnTgGu24yoaGFyqAxEfv+ykYjTitQ+QS+fqvusJo2VrfbNTZX+eVOi2mhD/PGWMRK0IPedlHocrqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433362; c=relaxed/simple;
	bh=jN6vr49WydQekpKegVkjH3kRWbiat3b6Jw7xzzte404=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jat90a+YrWgWT3A1UOUIQpsfHAhs7Ea6W1RJ7QuYz4uZq7g/FQ292dNKppCtkMgzmPJ3nSEXmRAE7lg7UDKIqMOogrryYLbTMnxk+7mpud2qKtNRMDfW+dWXEwDv8IQ880FHw46ARvWBKUkXAEOcQ1btg/c9PehRPB9MNuViJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TkeEvLIW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2363616a1a6so34848725ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433361; x=1752038161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmlL9kMvvcYcWlU45z5MYmmVSDmE1amNKft2tyH29n8=;
        b=TkeEvLIWFDN+/Cx7PbRqqnWqGlFU9US+Q4PiaWrRD9Y76t41oG3Laeb507aBjoY0Ei
         sADyFMM2mrrlv3IK0NPUFJsgqekO15ClMFT0wW5U2lO/LV/wrudF4x8YbncksRcGkw4Z
         wzKhrzPifSPxhqex94PS5/bUtj0vk9zYC4k/aOq8yLo3iX9oOCnq/x2LWsqxme+83kyw
         lsPA99a0dLUvaA1sra0BRGmiKA3oWAChSuKmOh3QZpmRVsCdVO54gSWUR3c3TUYkOqN+
         TPk4lyaQgKHIAgkuIW0HPmu7tQEDnrNv9oMba0HDWyE/qSSemVmEZYaAdgyyOISMi1tf
         qqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433361; x=1752038161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmlL9kMvvcYcWlU45z5MYmmVSDmE1amNKft2tyH29n8=;
        b=VAXyUASFoIPZphU4+6VH6eIE8a0JCcpgklwKPnmacu+aunQlN4E7ahIRza6gNRa1mE
         aokkejg7T70IMD1f0a34Frthydu8aWJabSzGRYyCTuvebufZdoruntuVh92OSWQ+9iPl
         NV70u0yeSkyiUJyb1lf8eKoEA7nFgnA+bMYMa3AJ5vKFUe8j34oGgwCzpYlrzJgxwd4y
         VW4g1FGNFKSMuykt6VqSVnS188wZvlJswH/VNjJN92DsGTy1++Ky6gAkQX/GH7QVgXQd
         5+VS4WQymqxMG1HQiEOCIej+IU5Dl8zqm5H+lF0TGxcoE5Eho5FeLy5rS7mrIeblhhQp
         yroA==
X-Forwarded-Encrypted: i=1; AJvYcCVKtUpoYm+hwICFkbTKnJkgy542PsU9lh78UpLOHI4ywvKdqu+CDoBO8dgsk9SVbRZR2nLwKlEW6yIS@vger.kernel.org
X-Gm-Message-State: AOJu0YynNZix6glREIfzmIdjlThVV1NgNAlgfu6a2AEnBlpSbXVgtqCB
	xBpdYuc3cV8pjP3Po2YnDz9ggfleqT5y7C1o66eZmXmwXfFSqSgs/uvUI+GV0qi9S0Y=
X-Gm-Gg: ASbGncsiTpXVI6YT4BcYZgh+BeY0mumabjl4ilqrC9gFiMDMMFQSHvpxNGcDRkl34UY
	Q6eCXobV4mQtGOtenN1rw2FRQNeNygWEFqF3hLHgPhptKnOBMextmRgqhvRpo1XmBR1e5yYSO6j
	Mel7djLSdCmvDpTBHDnS6rcPVduyQQrz6SuE9fQbOiQszyoPjNH0UHyfLnQFB25g3gf7iueGCik
	l8gqQKLsz1ATXI+rMVyQVEVnT1urFFYxcQWbvBR0twqrEo815e/vlu6lfWWKdCOxQwt+/gI22f9
	dcYBF5Sym6KKIc5VnKbMvOj/n10l8Q5uYzXwDf+RFD7h0BNPs7pQ3tVtEqXCn6gga+eP2MoU5XT
	w4nXDmNQ0dS1lU5lJ
X-Google-Smtp-Source: AGHT+IE1P7SGRwHhgK16MRfDAXrEX7DH1YLnpHg6sa/GNFGZg6KWOiAXLcWOV6zX2nV96zG+z8muGg==
X-Received: by 2002:a17:903:3c47:b0:235:f143:9b07 with SMTP id d9443c01a7336-23c6e483a2fmr24735045ad.5.1751433360617;
        Tue, 01 Jul 2025 22:16:00 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:16:00 -0700 (PDT)
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
Subject: [PATCH v7 15/24] ACPI: property: Add support for cells property
Date: Wed,  2 Jul 2025 10:43:36 +0530
Message-ID: <20250702051345.1460497-16-apatel@ventanamicro.com>
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

Currently, ACPI doesn't support cells property when
fwnode_property_get_reference_args() is called. ACPI always expects
the number of arguments to be passed. However, the above mentioned
call being a common interface for OF and ACPI, it is better to have
single calling convention which works for both. Hence, add support
for cells property on the reference device to get the number of
arguments dynamically.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/property.c | 22 ++++++++++++++++++----
 drivers/base/property.c |  2 +-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d4863746fb11..d08b0ea5c915 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -882,6 +882,17 @@ static struct fwnode_handle *acpi_parse_string_ref(const struct fwnode_handle *f
 	return &dn->fwnode;
 }
 
+static unsigned int acpi_fwnode_get_args_count(const struct acpi_device *device,
+					       const char *nargs_prop)
+{
+	const union acpi_object *obj;
+
+	if (acpi_dev_get_property(device, nargs_prop, ACPI_TYPE_INTEGER, &obj))
+		return 0;
+
+	return obj->integer.value;
+}
+
 static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 					  const char *propname, const char *nargs_prop,
 					  unsigned int args_count, unsigned int index,
@@ -892,6 +903,7 @@ static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 	const struct acpi_device_data *data;
 	struct fwnode_handle *ref_fwnode;
 	struct acpi_device *device;
+	unsigned int nargs_count;
 	int ret, idx = 0;
 
 	data = acpi_device_data_of_node(fwnode);
@@ -960,11 +972,12 @@ static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 			if (!device)
 				return -EINVAL;
 
+			nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
 			element++;
-
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
 						acpi_fwnode_handle(device),
-						&element, end, args_count);
+						&element, end,
+						nargs_count ? nargs_count : args_count);
 			if (ret < 0)
 				return ret;
 
@@ -978,11 +991,12 @@ static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 			if (!ref_fwnode)
 				return -EINVAL;
 
+			device = to_acpi_device_node(ref_fwnode);
+			nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
 			element++;
-
 			ret = acpi_get_ref_args(idx == index ? args : NULL,
 						ref_fwnode, &element, end,
-						args_count);
+						nargs_count ? nargs_count : args_count);
 			if (ret < 0)
 				return ret;
 
diff --git a/drivers/base/property.c b/drivers/base/property.c
index f626d5bbe806..6a63860579dd 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -578,7 +578,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_property_string);
  * @prop:	The name of the property
  * @nargs_prop:	The name of the property telling the number of
  *		arguments in the referred node. NULL if @nargs is known,
- *		otherwise @nargs is ignored. Only relevant on OF.
+ *		otherwise @nargs is ignored.
  * @nargs:	Number of arguments. Ignored if @nargs_prop is non-NULL.
  * @index:	Index of the reference, from zero onwards.
  * @args:	Result structure with reference and integer arguments.
-- 
2.43.0


