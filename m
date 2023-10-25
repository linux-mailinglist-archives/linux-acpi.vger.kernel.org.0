Return-Path: <linux-acpi+bounces-1003-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A967D75DA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875F31C20B18
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB3334186
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gni9otB/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971F3399C
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:26:04 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296A01BEC
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-694ed847889so130653b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265553; x=1698870353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwZ9IOYC0gRC/owt7RZ2EBdGuffYJiDuVuQ5+XRLwVw=;
        b=gni9otB/RxqkdQcBtDhkGtxYXI1WhO6/nBa5LuP10/nNencAljOkoEGMmIzHInY/ky
         oDlR4aIa6BOWPeVwvMeutGJ5V6ffVJCjq9yAVxUgQJ2NWKDBS7IHFKiQ+l6fFBvSh15A
         mZC/WjARqRxm2wTMlRiEvP5OHITXIqMDoeYIdAubOwiSoJbWpW6qqgDG3R3ijHPWgG3l
         RZ7TnvwKTmJTwhe02+58gFnl2LR1WgjHj440rGe69OikbaJsYYesrFvKharIMMus1Hog
         QqV5S9f6vTbimWXy/i5vLDf/0GQKcbKhCidzew7Kz1qBK6XcaGk99AbAHyc/PlHte0Xp
         EzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265553; x=1698870353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwZ9IOYC0gRC/owt7RZ2EBdGuffYJiDuVuQ5+XRLwVw=;
        b=pFh7sKCMDV8Grdl/Q9CidCuFJc6DSYrqNhupMVy/3io8If27a//CV62TxONBSqj9/m
         W6p8AYYBKCNZyaSKcMVKXHCOxy7jMk5nGgnB4m64JbOxeajJkMDbIlq5RvgM2JPmWila
         70BQELnZVAffLKs0j7n4yYgQBnknLuJMABqtTxdn7l7x1ixPN1lgXcSb6aoJhO+ucTcm
         i7adyx5d6QDSHB9bm2PkUCOO0paAOE9P3GgSch2FASrMYGAUep7ijhhBAHmTZ6y6rD7h
         a5mubeqm9z4oRwXxrDV2F2rkATaO2AuZuhkXaLvhxwPaTfzvZ9IKo0iuCIQhf5LZZ2kS
         nUcQ==
X-Gm-Message-State: AOJu0YyGKx1lZ4h82tE/6V7TY+DVYtySqnwvwU1N3HPpS00E1WYTJ9SN
	yx9UFAidTS0HgPJef15CgjH+6Q==
X-Google-Smtp-Source: AGHT+IHkn2z1G+Hl0DvKFF4S04ijeypy9mwQD0HYMK+syY66BONzs/0zW1LpSVQhK3aml5xBfnLnBg==
X-Received: by 2002:a05:6a00:17a1:b0:6be:265:1bf6 with SMTP id s33-20020a056a0017a100b006be02651bf6mr14834736pfg.32.1698265553494;
        Wed, 25 Oct 2023 13:25:53 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:53 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 18/21] irqchip: riscv-intc: Set ACPI irqmodel
Date: Thu, 26 Oct 2023 01:53:41 +0530
Message-Id: <20231025202344.581132-19-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

INTC being the root interrupt controller, set the ACPI irqmodel with
callback function to get the GSI domain id.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f3aaecde12dd..627723d72b01 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -273,6 +273,17 @@ int acpi_get_imsic_mmio_info(u32 index, struct resource *res)
 	return 0;
 }
 
+static struct fwnode_handle *riscv_get_gsi_domain_id(u32 gsi)
+{
+	struct fwnode_handle *gsi_fwnode = NULL;
+
+	gsi_fwnode = aplic_get_gsi_domain_id(gsi);
+	if (!gsi_fwnode)
+		gsi_fwnode = plic_get_gsi_domain_id(gsi);
+
+	return gsi_fwnode;
+}
+
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
@@ -318,6 +329,7 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	 * unsupported. Once IMSIC is probed, MSI support will be set.
 	 */
 	pci_no_msi();
+	acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, riscv_get_gsi_domain_id);
 	return 0;
 }
 
-- 
2.39.2


