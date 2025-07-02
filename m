Return-Path: <linux-acpi+bounces-14911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868AAAF0A8B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438587A5BE7
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE9420FA81;
	Wed,  2 Jul 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K3lU5Ep0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE21FCFEF
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433394; cv=none; b=BqvEhe+S+4o7mxrHaxJTPG71KCAt77oOl5nxK59ugEAfQrIp12MbqOyAsfBrHlWqQDGaIrUZ3r6wWGVx6pxVc1hvp75RlX8tx87SZa9Xy4kHOvobaJR4IHE1sYW+R2HcDaSZnS8rpeNuVXXq9V2Jg3Ib00KT3v5GmtIIyqBwrdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433394; c=relaxed/simple;
	bh=HmUGIQxKVHOETiXQmbQMVfvnbNgiP89D8IFlOG4Z2e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAltWzx8GfSnfac/6z+swGVwI6C8irn6qQcuuZLNLIOHZAGGs06hjJ7yDQ03kpulpJfSUvFziQwy8tlbujXC5dKNI7uyeBV45BFFM3BXTgIPPIx5pck5/TTPJpY8i3oDcX3KdE0ncT8PK07YxflrUe+zeSmdinQv9ASU4qgTGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K3lU5Ep0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23636167b30so37276415ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433391; x=1752038191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+ya0GtiFk/8ci1A3C7Dw+WSyLS2yytdeeB0s74FDG4=;
        b=K3lU5Ep0Y4F8NeuPHf4pkqkRimPzASxkbkyPhz9fzQrFPgbcbXShsl+y8NVck0vooV
         YA2xLDEj2ifdjA6Y9q4ha2LRYPIuiqbNDb7IDkhXWl7VlQw0bptDFs9VM9VtlHnrnw8M
         dmnC2BYAvsK+jLuGYry/m9sQ6ZtJ2uvkhkc6HIlRct/mOGRqo7cSA5pg5d2WeY3bYpwS
         O4EF4LztoRVRmqG83psrX3C3foc4SDJ8elf7/ASBHwxS1Z636enqfnOxff//a/6zEmYN
         /YWuJJHcfXY7kqDulbQJfzzjZ55fe4pTLT3S4cnb8l1/g6bS5nIj0D4G9Ev4sOUyLSyH
         hSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433391; x=1752038191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+ya0GtiFk/8ci1A3C7Dw+WSyLS2yytdeeB0s74FDG4=;
        b=BCkJJ1Z7pCbympJAUDE88U8bEKlL/fFGWuBloVRlxJ0bmYY+3YcMXA0FWWB7pHk0fA
         2eTy+prsQXKd4v1mreUFOZWx3n8P54MCfbt2pUcmGx7dWLMtOtOI7Ye3KeC2Vox1rtr3
         jdR5xHVfRdfRVIGKDYPBmSuBvIC4Ar6T0nOWR9Kcx3BJljsVlIIUogPnLKdenRXZnTcE
         MoaLxuQFQbShX1+Nf/i/cRYev0M5jcPJ4EP8GleT1/uVMfjhUnxOjlAf8z2+yF3G4U31
         lhyFataYbUhktPg6Xg9+SnVc4ty1PLupOoyBk66jkpsRCs7gn059yzZ32LJIKozk7CQV
         nzyw==
X-Forwarded-Encrypted: i=1; AJvYcCWR+m4mPVYruuAcX2LF+hTywxKproG9y8XfOxBSSQh/VaeOEr/QBy8TwFHuFEbujlc828wQSoxJ3fHR@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUNWsO9jn5w2u6as8rhpgf9sD5GUHl6CvrFx94h1txFZzoChu
	M0lpfF3KhZWUohBR7ZGyh+6Iclh6ciKajuNk9uKKYLVwBJh1dvQdZIxwbim/IQ8qTfE=
X-Gm-Gg: ASbGncs2KaDYbDvjQ4EjCx0xtvfqbTXnrrCowHQ0PCLSO5iynB9sTPHUHSgVoDs6nr2
	PMfBt/ly0Mb0G1AJm1W2TlX6rqGb1MivMoJAbaFKkmPlM6YmoUIQohIa3WpGLXstWsE0W17Mf8s
	Xc/CGO+wr1Avz/Wk+IWg49sxvK392aXwmExKQPEzSgIYWkM0VJJkb3bBQcnqkXDPosJoB/KRki8
	Sexcz7vg8s3Nvh7JAkt8191/v0NlrjCX4eLATNcqfsbG0Wr7c84GWOhF0wnbTJ8ecLJsASJ55G5
	6SHWAa/MxWvZnDV/zOlgwyLSoMP9Pn6amyO5QdhZHFWROoMLbgSfRULW8XX0AAES8iZkQoWR8/j
	6h/f+WfR2SWEwWWiz
X-Google-Smtp-Source: AGHT+IGVPhlwjhXki+/3hyU8U7wHE3TbWpzk5YrsdGI24+SP+ypvFn2VzK1niX3bMdBnop5rpgktYA==
X-Received: by 2002:a17:903:3c6b:b0:234:9670:cc73 with SMTP id d9443c01a7336-23c6e490fc1mr24534815ad.5.1751433390748;
        Tue, 01 Jul 2025 22:16:30 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:16:30 -0700 (PDT)
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
Subject: [PATCH v7 19/24] ACPI: RISC-V: Add RPMI System MSI to GSI mapping
Date: Wed,  2 Jul 2025 10:43:40 +0530
Message-ID: <20250702051345.1460497-20-apatel@ventanamicro.com>
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

The RPMI System MSI device will provide GSIs to downstream devices
(such as GED) so add it to the RISC-V GSI to fwnode mapping.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h |  1 +
 drivers/acpi/riscv/irq.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 2caf049f09c8..9c9d22f5165e 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -30,6 +30,7 @@ enum riscv_irqchip_type {
 	ACPI_RISCV_IRQCHIP_IMSIC	= 0x01,
 	ACPI_RISCV_IRQCHIP_PLIC		= 0x02,
 	ACPI_RISCV_IRQCHIP_APLIC	= 0x03,
+	ACPI_RISCV_IRQCHIP_SMSI		= 0x04,
 };
 
 int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index cc1928422418..d9a2154d6c6a 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -168,6 +168,33 @@ static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr
 	return 0;
 }
 
+static acpi_status __init riscv_acpi_create_gsi_map_smsi(acpi_handle handle, u32 level,
+							 void *context, void **return_value)
+{
+	acpi_status status;
+	u64 gbase;
+
+	if (!acpi_has_method(handle, "_GSB")) {
+		acpi_handle_err(handle, "_GSB method not found\n");
+		return AE_ERROR;
+	}
+
+	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gbase);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to evaluate _GSB method\n");
+		return status;
+	}
+
+	riscv_acpi_register_ext_intc(gbase, 0, 0, 0, ACPI_RISCV_IRQCHIP_SMSI);
+	status = riscv_acpi_update_gsi_handle((u32)gbase, handle);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to find the GSI mapping entry\n");
+		return status;
+	}
+
+	return AE_OK;
+}
+
 static acpi_status __init riscv_acpi_create_gsi_map(acpi_handle handle, u32 level,
 						    void *context, void **return_value)
 {
@@ -222,6 +249,9 @@ void __init riscv_acpi_init_gsi_mapping(void)
 
 	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
 		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
+
+	/* Unlike PLIC/APLIC, SYSMSI doesn't have MADT */
+	acpi_get_devices("RSCV0006", riscv_acpi_create_gsi_map_smsi, NULL, NULL);
 }
 
 static acpi_handle riscv_acpi_get_gsi_handle(u32 gsi)
-- 
2.43.0


