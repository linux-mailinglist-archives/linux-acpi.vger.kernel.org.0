Return-Path: <linux-acpi+bounces-2558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F042A818EBC
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 18:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A320D2874A6
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECA8381A1;
	Tue, 19 Dec 2023 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OwdMO+Dy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBBB41209
	for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d337dc9697so39048955ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 09:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703008025; x=1703612825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaVzwwT2ecLOtMDBM5TdFJiJ9XdFZ6MUpboDwIj/4ug=;
        b=OwdMO+DyVotX9tmk1xRIsraAElYFlr5ThzaBzSh7oPVDYa8hsVFFb6066ici19XRHg
         Y6WBeMXC2BPYDoydWlpIfBi4CgE/GG5YE9CDZHsxTlXlACfJQ8IEDxBwvrcc6hDl+gpP
         +eNPO7GMP+ddTzRoRXZqfLmhnFBJN6IOVi+mCM4crUVLjXyCkuEi38cW/8eHyEfZaVe5
         wCsfexqpWND6NugDDnaHgMaw5FZnfswZAnCRygZ64HnkwiNNvktxEmB5D59MlXtx4g4M
         XI1VbKpv1GGbtTG1FwOusSamDObMBU90lQ4FW/j218mKBgCFCfWDlO0yYAiUworYFrBj
         xmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008025; x=1703612825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaVzwwT2ecLOtMDBM5TdFJiJ9XdFZ6MUpboDwIj/4ug=;
        b=BgyZwkz92aAKABY2Q/UliSCmY0rZYyXQlCGuI9jszd06qSYQValJZy9JZHyrj6BUKf
         X4xuBuJU9s+xX9ciqsPM5QiMhl1WnSFA68T9lkPlwIvI7r4/GpxknUFWSAbax6DoK5+V
         0dkHdGmqYshtI70ARsZQy1XkL1Uz6d2OUkW+OlIBEn7oLwnUd+KnBzdblkruHfORjW5E
         Iu0V2qKNwb/C2A/MUa0DBP5Y9vSDPcI58r5Dbb9oxi/dQ6VDB3L+JjPayQFOBw7PiSyS
         4tzA1V53AxaJDLYKooI9W0vEQy4xjGZy0t1UEj3EmTIjfhTfexILWQaQxyIF9rehfIam
         YSlQ==
X-Gm-Message-State: AOJu0YykFvHRueSVR/AUOtGEhfEzT9FXq4u9ztX9h3f1KOey+83yHcFQ
	BSfBvTfPkLjcVcHT3LBcODyIoQ==
X-Google-Smtp-Source: AGHT+IG5x81QIwdA146e8SSr+Pdh859h/oT2VMGTgxkFKS+ftvwwQnsNNroKYOvMgeiD+AUyeRhwsQ==
X-Received: by 2002:a17:903:2347:b0:1d3:c730:f0a2 with SMTP id c7-20020a170903234700b001d3c730f0a2mr3728002plh.118.1703008025154;
        Tue, 19 Dec 2023 09:47:05 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:47:04 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 16/17] ACPI: RISC-V: Create PLIC platform device
Date: Tue, 19 Dec 2023 23:15:25 +0530
Message-Id: <20231219174526.2235150-17-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since PLIC needs to be a platform device, probe the MADT and create
platform devices for each PLIC in the system.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/init.c |  1 +
 drivers/acpi/riscv/init.h |  1 +
 drivers/acpi/riscv/irq.c  | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index e7eff7ab1474..c6fd4097e8ae 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -11,4 +11,5 @@
 void __init acpi_riscv_init(void)
 {
 	riscv_acpi_aplic_platform_init();
+	riscv_acpi_plic_platform_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
index 17bcf0baaadb..b4b305d83b3a 100644
--- a/drivers/acpi/riscv/init.h
+++ b/drivers/acpi/riscv/init.h
@@ -3,3 +3,4 @@
 
 void __init riscv_acpi_imsic_platform_init(void);
 void __init riscv_acpi_aplic_platform_init(void);
+void __init riscv_acpi_plic_platform_init(void);
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index d08a851ab6dc..f14ea43b0178 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -148,3 +148,22 @@ void __init riscv_acpi_aplic_platform_init(void)
 {
 	acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, 0);
 }
+
+static int __init plic_parse_madt(union acpi_subtable_headers *header,
+				  const unsigned long end)
+{
+	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
+
+	return irqchip_add_platform_device("riscv-plic",
+					   plic->id,
+					   plic->base_addr,
+					   plic->size,
+					   plic->gsi_base,
+					   plic->num_irqs,
+					   header);
+}
+
+void __init riscv_acpi_plic_platform_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_PLIC, plic_parse_madt, 0);
+}
-- 
2.39.2


