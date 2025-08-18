Return-Path: <linux-acpi+bounces-15778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B7B297F1
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB269188A7BE
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A4253B56;
	Mon, 18 Aug 2025 04:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LenEERFY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37E26CE21
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490364; cv=none; b=H5XAkG2e9Tlboj5EKOlrAA+o3dibY4CiiXTHrf9dK2xpQY1PzXZHaYB0d5dgqyvUQ63ydzRBVVUmoetgbk42JE0uvnGeOy8EmlcIcGrV2NXoMwS5Hry25MaWOw0PdllM9sTFJl4Hfq70SQsn1sBc4Ut0Fm4JXcQjPBnj1uBV20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490364; c=relaxed/simple;
	bh=DvHxs9+w7ltOfoA7/NhOym7TCg3DX9LBOV49nSbNPeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bc8riw589sEt3eppIa0HUjZ2hlrZFVbpuLD2y7GS5BYXnBA9z21Lf1cVBZgtVnzn8P48g/+ada3qfHhdD2yMYpovezxB43cNgYYHbH39kXRAUbNkHk9KggR5wI+ixwj2FufUOX2JNIeODjosFtjRPzhbabLupcaSonGNk4WElMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LenEERFY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32372c05c5dso229601a91.0
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490363; x=1756095163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puANNupOfTPwupiCwBFR/x6cxjL9cWmUBZsMBIE26AA=;
        b=LenEERFYzuQ5AG+K53/dPwiEgjuLOYkSiElCnF0TB+TQlB5vTL4ltKpBibzVDGdUWV
         M5/R4V4FUrhK0pj/WLx8eLFB+Td7E+KzODmb4+Zrqfrft0+G6b2mSuuTJrm64EoT5k/d
         fH9+R8XtyshqQCsZSNmdUAZDAQ5VkX6jLS2Ty7+8SchGmkP6rXDX9UOxARAuxJnoZvwy
         9EeTDXor0zxCVhPVMEfevZxDPGif/xHzIuAn5UGV5kWCSUzA3MKIUNem2xc+Of9CyEUC
         0IGK0XuXbcpm4TfCRHZoX2ih3vTs46ncySWAkPjhLdROL1APb8we4cKbvqcdM9/uTRqX
         Pa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490363; x=1756095163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puANNupOfTPwupiCwBFR/x6cxjL9cWmUBZsMBIE26AA=;
        b=DLPD6DUf5oOoi3dL9ryCpNq/Jtsk4SXkfcQM3hUHPc4n28VAVoBF7X+qLBo+TdlX34
         EgvdJvcq490yE4kr9Z25ZqlFeu7C/ES3lvzeOEhfnCXTbUnE8DTjl95NPfNo7VWBMoDC
         eYBE4b3ORCcxLknGyF7nFTNJEHREadcVky9FMpp/J80fI5W3uZBeUyf/OuRWgbpqq4iZ
         TSpEa3AZkCDhTknnMEY57fNF6icf9hgbjs8Peka2kqME6HqQClzwBzoGgxQw4mnqTY/I
         JmvGsXdfYZklj8C7CMp3EfQquaQ62FD+UJQ3rPX6gpfhu86Ya3ELgC8XSYcTIMJ5uFL+
         jbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWph0U4K8abdD4JmYzFHrmUL63pbC5HBQ9mtkZfkws8IQktLjsenbLxBMH6HDvIh+HtbyUEtwC6HJGp@vger.kernel.org
X-Gm-Message-State: AOJu0YzATqmhlqkOptr4uz77S/uAogekMiiHJLLCBe0BiS8bO/znXfPb
	oH2eUqt8eeqwkDrsNaJlTS3Kmp6FGlGZjRJO+n8uOQz6/BADratX7Alm03E7g+yIGP0=
X-Gm-Gg: ASbGncuSJ/iX3jK5HpdjrYUIKggpaehjgjFVHaecQtmHPwm7uIy8NuxclErGygmnjOf
	t1K7JGHAoXBIa9xaUSJp1nfekt+XSj4a3b+43vO8TjnPPbOKiXZVh3uw2HbW4v3P7Lw3rS7Hk7G
	1nlo7Bmxl2x82xSiPerW+nND2SfCFvt3akbcfwKxyW8aagSCMAHhmeb6Jwgt+cRpJdHhew3otpi
	rnVfw1xrD3HrKJyiFndbzec+yDB/74lvWNPQD/Rpaq6jqAyPtKYTsjHFqMHiBPlA1ia2VV0VM9C
	N73msh36CPGac0fjKYRh7uwd77tmD21j4qevQzRSbsx8tnrNEmo64iThHPC2kBmf08cgvlC+ffH
	y9zWahL+xumTTJKK1bB9veIIa0JPSXGPz0jqOY2aY4AxO6EMtm+j4OQ==
X-Google-Smtp-Source: AGHT+IEC3gS3fhyc6UCaYhWEA2S/aXsvy2asvBmFcLedoY4ZJ0Vv6Zyu/0geFA+k87d1XbbA1zhDRg==
X-Received: by 2002:a17:90b:52c6:b0:31c:15d9:8ae with SMTP id 98e67ed59e1d1-3234218df88mr16496712a91.33.1755490362422;
        Sun, 17 Aug 2025 21:12:42 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:12:41 -0700 (PDT)
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
Subject: [PATCH v10 19/24] ACPI: RISC-V: Add RPMI System MSI to GSI mapping
Date: Mon, 18 Aug 2025 09:39:15 +0530
Message-ID: <20250818040920.272664-20-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
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
index 7ec592fe430a..e29ded3416b4 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -32,6 +32,7 @@ enum riscv_irqchip_type {
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


