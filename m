Return-Path: <linux-acpi+bounces-14910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2072AF0A88
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6371C00A99
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496CB1FAC4A;
	Wed,  2 Jul 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YecoEpnL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF01F416C
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433387; cv=none; b=XnXR/lxEL89U30CTaOzLlrf6rZU9uxap4Vhndk+oVDw0h3Z8anJucUMiTImA1tqZnigoTFcDC1OMEUlOlpdC4GQmhlxRDcWG48XJebd+ScNPlRrIAZNnpTNAqrYr4/wXbiIPS7O5vtnn8ecSufuEUXPiBjLfn1A6+WXo5UHQK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433387; c=relaxed/simple;
	bh=bDMVpDUTCKSQxIzYquuybqhsrFm52uIQJL3fLHSkHZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtGMXIWxkrU+zEODf8xkeNbuiiuFbNdjPdppmrWqjqfVmu6Cjzy3ahAfJOvSW0cbOokFm2CxTPf9Q9eNPCKyMovYgm3BnDB7djv7nKVnHwIfPYL80dxKIaFYnXmqlWGIFHWau5tKvE81w2xwP6oHG9RW3TAVppVt9bhp2RQ7tUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YecoEpnL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2353a2bc210so37516785ad.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433383; x=1752038183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3TJh+HyLkyeQ1VqRyPxzf43XEd03uT1gCuO+kpCcOM=;
        b=YecoEpnLrkytMEHnkJWuucl5s/p76SZnKG/ov5Rtut0K+WitmUg3fYcgoXd8qG190F
         6wD0J/i+hZmDqjLmHwiD9nCgq0lGxSUmv9Dbpu6ZEJDnK3W9Zb3OhvPOQZYUzU4F3npw
         FY1AJvDTSjPSOX6WQCmhpXZ1TEqLiHyVpkaGfqu5VkDOf0VwjRAGT7iEsdA5Qh5bxqp+
         3+Nlb+zyjWQWFveEClRqmKNlbwASw+g+bJVsmJvHR/B0rSuJcPDT2X4nSeVbshC2Twjt
         /iS1kZkqmMxOIdqySrKzbuYvp78V16YO3SBq/+UWM6d+rK17BwSDmBRDLeaoXh0yjJhs
         urcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433383; x=1752038183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3TJh+HyLkyeQ1VqRyPxzf43XEd03uT1gCuO+kpCcOM=;
        b=dy3DJTMf2MUs1xDe6qdpBHIvnCqmYibDjmPlHVDh3F5xm4jZ6RPbKneTSFY5kEveII
         14zVo/eCJp1I+caqA20znM/03BYlKIieCV7kdu9PJ1gThm9NOCSGtgL9+NgjY4y8/6NM
         s0i2rDdU1SlgLGXSFnsUWVW7TxXLYbka+/YH5QmpdoUBiqwfrgo5mW5bw4jLR3vfh77/
         Z8By5DELO4aafGWZKtRWbHIGP8FtnjfDzqlYCU7TXfLdls8bgoKWiDRqHMSFGcli/Ri8
         rKpxRHSy7qNm0gs6/Dm6MAIqE3bF3/6dav0FAW6dFUhAebPUgKJhX8p4s17mONF2e+rG
         78cg==
X-Forwarded-Encrypted: i=1; AJvYcCXWD5pMwqECY4YNIYVeF6bD1jisLHHlvp+HKac+iHU6C+OICVl+yezM2X7kxNQ/2adj2lV13Aiv1ju8@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRJ0J6kD18DIuX8yfqNe6pi59M4Q3yNggpYWBT4rIBlGwVjnZ
	nL9diJLjnBr0gcKt5o3/OWQjEW4o5BmQlp6JXMe9sY5+WRTclGrdxdsigQWHmCvDeSQ=
X-Gm-Gg: ASbGncuBlLH1TuradTL83//snda0r0dI7CAXs3zxPmJA2LVuOwFwXGMFpN7bHGmw6RK
	FTFVQru98Q6ITsXQoc+LclssDG9ZtFSWaWt95FXLPKeuEd5yW8thiGlWE7qb//Ffld70TgsSikU
	jbARxfImFeLqF2nHemqFpSsnXo9TxJzh9tC25D0h4Y6fjam4v/5Ql0UVbyZjUdhB38aFBjaAwOm
	926yJaSvKB3KNRbXj/kMKv+gP8vufQH6yRUNcDe1C6ISdpqdA69FbgIyC28pxyD55TYe2oRnOfU
	ur0nchp8u9AQ/wi3bFPPztYYV6YYy5DwQbGiFlnaht5i5GgSfLEJT4S+sId0kxB8e0kwxytnop/
	AxrtpEd4BPLw6HYq9UXte9zMNru4=
X-Google-Smtp-Source: AGHT+IGjcdQ5SCYBwX/q8Ua3m2HXtZ+rTtj1lRl52H5ZQqdaEzollbkuxBGMe/8i5xm2XRTqzzD/0w==
X-Received: by 2002:a17:903:1b63:b0:235:2403:77c7 with SMTP id d9443c01a7336-23c6e5708bdmr18551065ad.37.1751433383171;
        Tue, 01 Jul 2025 22:16:23 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:16:22 -0700 (PDT)
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
Subject: [PATCH v7 18/24] ACPI: RISC-V: Add support to update gsi range
Date: Wed,  2 Jul 2025 10:43:39 +0530
Message-ID: <20250702051345.1460497-19-apatel@ventanamicro.com>
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


