Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BF6818F2
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjA3S0D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbjA3SZf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:25:35 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972AD46D5A
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:24:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so11990991pjl.0
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhwY+WHgnWrppFtmwiM46uOiQrz563HB2faXGIghFSU=;
        b=iInNpQ7clh9Xhn73EhLGThPE3LzvgxolaEMcMBFaNQcU0FyFUCrytg1AoN6qx54NGV
         tuUi0Rpk82IhdjSzcQlpvC9xnBE8caYnPCYVgCWf12zwykeR0GLxp2+KWVUsIC5wYGG2
         tIgSyV5SLs+I8l5zLzzXHedeWug+DUd9Q8tzkSIlVrVJ06ujBh1K6SVIw96N8Y0dsUhg
         hjXwJr155I9BE2EEWoGASofgJkoKIEKq285EiImlHB3RMkZ2n/U553ecRygzNNXMdV/i
         YyYa8Vk40KYiz1AMOsip0jMKX+M0e/Sr5ZJ+HUXowwqIp+//AZjG/e3HW9jpCtLgRF/y
         9oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhwY+WHgnWrppFtmwiM46uOiQrz563HB2faXGIghFSU=;
        b=kaZ5NXrENmjiISn7JvwtclGsg/l7uFPvCerj5IC3A/295CDIoIvsB40u2B11ZvW1Nc
         K3byHHzbshejbKLoo9HVo2WO25fTQETATeIQUIKL/HBOUbvMatHAvCgrJfjNJ3jsf3Az
         CKECYw8rjTKoHC4WrGEagb8Tt5vwwO8O7naI+WzuFacVjAw65S6fs9irkbifnvWezxdw
         tv+PwSlZjAsFsNdY5A97W9B1WMpqyLiP51259glmM72A12haHHPpDpZxaFTF/myNVf1M
         tp6uHq33/VNYGkyqZPIMvnN9aqppZy3CY2z3iet0XSk3WJ+WJ6E6qtKsdQnMNd6u8+z7
         e3jQ==
X-Gm-Message-State: AO0yUKUtjREmCXewqkltl0493NOvnBBIvZfifqmDlIrqCgGilC+zU5wJ
        Ict1qLkSbKfhsv3wNgh+La3ay2oz8C5Yhsub
X-Google-Smtp-Source: AK7set8OI+5RJViJJd8quwMebJkruqM9mvugGA8nhl7tcJy8x2139ul4d8jSgUZ1k15UpaedB8w/4w==
X-Received: by 2002:a05:6a20:9387:b0:b0:3329:c395 with SMTP id x7-20020a056a20938700b000b03329c395mr13317445pzh.30.1675103041308;
        Mon, 30 Jan 2023 10:24:01 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:24:00 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 19/24] RISC-V: ACPI: cpufeature: Add ACPI support in riscv_fill_hwcap()
Date:   Mon, 30 Jan 2023 23:52:20 +0530
Message-Id: <20230130182225.2471414-20-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On ACPI based systems, the information about the hart
like ISA, extesions supported are defined in RISC-V Hart
Capabilities Table (RHCT). Enable filling up hwcap structure
based on the information in RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/cpufeature.c | 45 ++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 93e45560af30..c10177c608f8 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -6,12 +6,14 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/errata_list.h>
@@ -21,6 +23,7 @@
 #include <asm/processor.h>
 #include <asm/smp.h>
 #include <asm/switch_to.h>
+#include <linux/of_device.h>
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
@@ -93,7 +96,10 @@ void __init riscv_fill_hwcap(void)
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j, rc;
 	unsigned long isa2hwcap[26] = {0};
+	struct acpi_table_header *rhct;
+	acpi_status status;
 	unsigned long hartid;
+	unsigned int cpu;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
@@ -106,18 +112,38 @@ void __init riscv_fill_hwcap(void)
 
 	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
 
-	for_each_of_cpu_node(node) {
+	if (!acpi_disabled) {
+
+		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
+		if (ACPI_FAILURE(status))
+			return;
+	}
+
+	for_each_possible_cpu(cpu) {
 		unsigned long this_hwcap = 0;
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
 
-		rc = riscv_of_processor_hartid(node, &hartid);
-		if (rc < 0)
-			continue;
+		if (acpi_disabled) {
+			node = of_cpu_device_node_get(cpu);
+			if (node) {
+				rc = riscv_of_processor_hartid(node, &hartid);
+				if (rc < 0)
+					continue;
 
-		if (of_property_read_string(node, "riscv,isa", &isa)) {
-			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
-			continue;
+				if (of_property_read_string(node, "riscv,isa", &isa)) {
+					pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
+					continue;
+				}
+				of_node_put(node);
+			}
+		} else {
+			rc = acpi_get_riscv_isa(rhct, get_acpi_id_for_cpu(cpu), &isa);
+			if (rc < 0) {
+				pr_warn("Unable to get ISA for the hart - %d\n",
+						cpu);
+				continue;
+			}
 		}
 
 		temp = isa;
@@ -248,6 +274,11 @@ void __init riscv_fill_hwcap(void)
 			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 	}
 
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		acpi_put_table((struct acpi_table_header *)rhct);
+#endif
+
 	/* We don't support systems with F but without D, so mask those out
 	 * here. */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
-- 
2.38.0

