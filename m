Return-Path: <linux-acpi+bounces-15381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EF3B13806
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF5716350F
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED00B2571BF;
	Mon, 28 Jul 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cW8SE6Qr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55B262FF1
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695836; cv=none; b=qi83yWkZba0BL/1SDXFNsHeyUf09lwg1nPPsAIfblXwc6/l7XV+bI6Gu3F06WEA1AKj5+DRPOl6smZoTp5RRZAJNDQIXy4+ocL/QHQAZvLHKTn47VkVZIWH9YfM6msL6pI8oTmiWhXI78iB5wOVWP2255Yhl+wCnKGeYg13pmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695836; c=relaxed/simple;
	bh=bDMVpDUTCKSQxIzYquuybqhsrFm52uIQJL3fLHSkHZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhVZlzDSx498ziNkWO/FulchX5RkxCk2KFj+KA4UWGXU8hjzlU1WFmlLrZrdUWjJAx/fFACpeHMWOiMkOT6uJeQcYGeo4b/6lziiPY4I0GxCwCN5uJohV+/ZMRsi6sRbDJaS2dykdewjh1CPcZ74uCAk4ws/6g/yy+oTwLWq8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cW8SE6Qr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24049d16515so2045325ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695835; x=1754300635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3TJh+HyLkyeQ1VqRyPxzf43XEd03uT1gCuO+kpCcOM=;
        b=cW8SE6QrSmkYw5KbPGjctVwo/AqaY3FoTHFy2GyanNBJCjrNZ/NptlzqrH1bEDiRTs
         5GCumIP6310khyD0Rem4HsW/ArDHzNQFRXr193xTTx8OoyCqnSa7Hd8pkCRmmkRr+Nd8
         u9e+GeJzWcc+4g5lTgiBYtn7cE369cmOz2tY7l79NkL+YrVN4L4XtZa/+JNH9L8rWoOj
         mKaOyGfmHZCwifnRWzzOaDEWrqllNH2i18AcLPeyYtpi1SNIkmByEChgzAuntqsahc9H
         DGHKnbeossk3pqDK9D4Uqx/Fq/jc1wLWI7BXlsImvtwu27KsPcQINzY+TosLr9bSKA3j
         lubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695835; x=1754300635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3TJh+HyLkyeQ1VqRyPxzf43XEd03uT1gCuO+kpCcOM=;
        b=RnlmnG+1l6+PnFqhrp1o/BMonS66yXjjre2vfGSJnRQkfy56wS0j5QrSkP3yaSOQos
         oMIHj7DyGh7HqNVoIWD54CnvxXnM23RSs00bYP62vZRGnMxEgnrW3h9Vvx7r7AGZ31m1
         O1p/F2CT4ZpbGmAcE1rpiOr5fpX0uMrqRjkJf3dmvVV0D5HQh7y6qU2EWRuOR4kyU+zT
         JwR1UxSNbDQdna6t/Jzq5gAxxTzY04GGnw/WjIxl97/S+xoqozU7by8JWUNUqga2Eefe
         nIQniEmi+XKFH9Gf+npfLNU53o/rTj/Ad+kBClII9TH/1YRICJw2a5IXl2/CCLMDyo8s
         736A==
X-Forwarded-Encrypted: i=1; AJvYcCULY0dEvwLcb48yTwx5jGJEvfdEYQ0hNVvCudxZjOCV3LyQ6M/Y8mUqDaJptQD+p9I/t1ZGfCb+xlSb@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUaSuaBvk9c9Zf/F0Z+rC0WkXOQ7wldJDrGewqJCn4Mr/u7+C
	VF7Ko6BwGxaYkzIOJE4oT11XbWfoep390V4hc4ehsbwUuZaH0CwNLtJ9SrWoqFoUTms=
X-Gm-Gg: ASbGncu4fVmnpbzUa9epyE5LXO4tABHZZTg+IXfOZhHg8stBpoKuOen148rvCvdxQja
	NRwp+/Kn3On38R3Ews0VWt3z3lxxgiTwi8vs4b3KfLe9rT/bTwMF+ZQi7HrphgGyeMjxlwaPV0/
	DCNbV+9yLjk1xzOffZ6t46tQhEVFYrIdf0/VeAk5QCjuW4at369s5tsRm3BMeydspQBzeGOCNU1
	L4oRCZqkF6Knv+1OYtbzoNl/yluBbGLcjgRLLCPaKZn3xsaWi5IJb1R21k7dAOXCbRNV+ZhcgTA
	56JnjCbv3AEtTqYXjC/0Ri7BBbz/c60G1mUcYEVcMq3C5XcqB4av1rn37WZP1Tt9bxxPc02slBE
	bYtSJFpuRXUgPNaoSVc3iQi4jbiP2lHTynyvySRKHmUuQMnHU3tRsJaOISLWd
X-Google-Smtp-Source: AGHT+IHI2M7ktVDfnRXlbMOQx8cI9hQctNhXTmp4VHflXoE3OleDRvbaoO88+G60sLgtIf+JGimi6Q==
X-Received: by 2002:a17:902:f30b:b0:23f:f983:5ca1 with SMTP id d9443c01a7336-23ff9835e51mr55263795ad.12.1753695834472;
        Mon, 28 Jul 2025 02:43:54 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:43:53 -0700 (PDT)
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
Subject: [PATCH v9 18/24] ACPI: RISC-V: Add support to update gsi range
Date: Mon, 28 Jul 2025 15:10:26 +0530
Message-ID: <20250728094032.63545-19-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

Some RISC-V interrupt controllers like RPMI based system MSI interrupt
controllers do not have MADT entry defined. These interrupt controllers
exist only in the namespace. ACPI spec defines _GSB method to get the
GSI base of the interrupt controller, However, there is no such standard
method to get the GSI range. To support such interrupt controllers, set
the GSI range of such interrupt controllers to non-overlapping range and
provide API for interrupt controller driver to update it with proper
value.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h |  5 +++++
 drivers/acpi/riscv/irq.c     | 38 ++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 7b038f3b7cb0..2caf049f09c8 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -40,6 +40,7 @@ unsigned long acpi_rintc_ext_parent_to_hartid(unsigned int plic_id, unsigned int
 unsigned int acpi_rintc_get_plic_nr_contexts(unsigned int plic_id);
 unsigned int acpi_rintc_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx);
 int __init acpi_rintc_get_imsic_mmio_info(u32 index, struct resource *res);
+int riscv_acpi_update_gsi_range(u32 gsi_base, u32 nr_irqs);
 
 #else
 static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
@@ -74,6 +75,10 @@ static inline int __init acpi_rintc_get_imsic_mmio_info(u32 index, struct resour
 	return 0;
 }
 
+static inline int riscv_acpi_update_gsi_range(u32 gsi_base, u32 nr_irqs)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 33c073e2e71d..cc1928422418 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -10,6 +10,8 @@
 
 #include "init.h"
 
+#define RISCV_ACPI_INTC_FLAG_PENDING BIT(0)
+
 struct riscv_ext_intc_list {
 	acpi_handle		handle;
 	u32			gsi_base;
@@ -17,6 +19,7 @@ struct riscv_ext_intc_list {
 	u32			nr_idcs;
 	u32			id;
 	u32			type;
+	u32			flag;
 	struct list_head	list;
 };
 
@@ -69,6 +72,22 @@ static acpi_status riscv_acpi_update_gsi_handle(u32 gsi_base, acpi_handle handle
 	return AE_NOT_FOUND;
 }
 
+int riscv_acpi_update_gsi_range(u32 gsi_base, u32 nr_irqs)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+
+	list_for_each_entry(ext_intc_element, &ext_intc_list, list) {
+		if (gsi_base == ext_intc_element->gsi_base &&
+		    (ext_intc_element->flag & RISCV_ACPI_INTC_FLAG_PENDING)) {
+			ext_intc_element->nr_irqs = nr_irqs;
+			ext_intc_element->flag &= ~RISCV_ACPI_INTC_FLAG_PENDING;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
 			    u32 *id, u32 *nr_irqs, u32 *nr_idcs)
 {
@@ -115,14 +134,22 @@ struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
 static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
 					       u32 id, u32 type)
 {
-	struct riscv_ext_intc_list *ext_intc_element, *node;
+	struct riscv_ext_intc_list *ext_intc_element, *node, *prev;
 
 	ext_intc_element = kzalloc(sizeof(*ext_intc_element), GFP_KERNEL);
 	if (!ext_intc_element)
 		return -ENOMEM;
 
 	ext_intc_element->gsi_base = gsi_base;
-	ext_intc_element->nr_irqs = nr_irqs;
+
+	/* If nr_irqs is zero, indicate it in flag and set to max range possible */
+	if (nr_irqs) {
+		ext_intc_element->nr_irqs = nr_irqs;
+	} else {
+		ext_intc_element->flag |= RISCV_ACPI_INTC_FLAG_PENDING;
+		ext_intc_element->nr_irqs = U32_MAX - ext_intc_element->gsi_base;
+	}
+
 	ext_intc_element->nr_idcs = nr_idcs;
 	ext_intc_element->id = id;
 	list_for_each_entry(node, &ext_intc_list, list) {
@@ -130,6 +157,13 @@ static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr
 			break;
 	}
 
+	/* Adjust the previous node's GSI range if that has pending registration */
+	prev = list_prev_entry(node, list);
+	if (!list_entry_is_head(prev, &ext_intc_list, list)) {
+		if (prev->flag & RISCV_ACPI_INTC_FLAG_PENDING)
+			prev->nr_irqs = ext_intc_element->gsi_base - prev->gsi_base;
+	}
+
 	list_add_tail(&ext_intc_element->list, &node->list);
 	return 0;
 }
-- 
2.43.0


