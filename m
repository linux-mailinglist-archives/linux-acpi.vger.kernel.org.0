Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8F6A98AC
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 14:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjCCNix (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 08:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCCNi0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 08:38:26 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9199F3C22
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 05:37:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p6so2743347plf.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 05:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZDqAIiQh1iz6zpk7hAy2IsEozk94KbzxqCS/Vkjh5o=;
        b=n9umgm4XarNc8gsfjp46IzZiTpAtE1BOvMr6t0GaPEd94V3o+dimvJdd2NYqtOt78O
         Wk+cZPGvnjxrCP3dVWSfVY9zKY3X8tqXfP3UdsGlTOPWW154spoB+PqEfdHwPD4Qpb/J
         7LRu60H/NBGrMRCOkbBn+Dr0fJMKGQRJPePyLQ6anbUECkmPLh70AerRQEj8aUiZrnG5
         u5fn27T3NYKQvJGj2iKX0KpqsKqK1amngKRdJ1OkVxEawrTVxLYuoc8z5OBzyFIm9Uwj
         YfO0Nnzktsu7Kdq4Wb/adAasHPg9ygDntDuGxorrprkG3NkNqIi/oSuy4LdlkhpXJtu0
         CcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZDqAIiQh1iz6zpk7hAy2IsEozk94KbzxqCS/Vkjh5o=;
        b=qJL6sdoylK5qgPM7x88fqnXIhVp6Ep28E3C7wjks4e+YR/A6qDZiIVbYcrS75Kh9sY
         uE0GPTpV4VchlnBsFxlBaOkU1wO42GsYGsqM0HEt5ESWRo+rCDd78LZwyYZ2ee+ZT5RZ
         GYDhP8jke0i2buDo2vBmMXWQZ52BiSmjcRH5/Oe/+FR3HV1UhHfAuW6Dl2j2t74kDp7G
         afydvrdajHq3cwDH1gPsg7ORrpKPs/f0Nw8GSdrrk4wKX16CPc6ecYR+6/UUIokSpvFb
         JZE/ig3ohF/lhR6lUp4jY+u6+XVWCzR4yqi0GNDsfEZ5Y6dkZrBmP2v7m1CFbVyiiK7f
         25Yw==
X-Gm-Message-State: AO0yUKWQeG4auSgoIvYNdnc/SrZc8XnKxB6Jr8KyS3iUjguN+b12W0ZN
        45Dxed47BRFB2WDFDv7Qr4SFeg==
X-Google-Smtp-Source: AK7set8J/vYbwyD1m4XRQ3AgWGRchGR8NoRHsIuocp3J3fFoa1b+Rs9bDGRjPxWCAPErZncQBtxuqg==
X-Received: by 2002:a17:90a:db92:b0:237:44ad:5124 with SMTP id h18-20020a17090adb9200b0023744ad5124mr1650183pjv.42.1677850673253;
        Fri, 03 Mar 2023 05:37:53 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:37:52 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V3 12/20] RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()
Date:   Fri,  3 Mar 2023 19:06:39 +0530
Message-Id: <20230303133647.845095-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303133647.845095-1-sunilvl@ventanamicro.com>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
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
like ISA is provided by the RISC-V Hart Capabilities Table (RHCT).
Enable filling up hwcap structure based on the information in RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 59d58ee0f68d..478dbf129922 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
@@ -13,6 +14,8 @@
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
+#include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/errata_list.h>
@@ -91,7 +94,9 @@ void __init riscv_fill_hwcap(void)
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j, rc;
 	unsigned long isa2hwcap[26] = {0};
-	unsigned long hartid;
+	struct acpi_table_header *rhct;
+	acpi_status status;
+	unsigned int cpu;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
@@ -104,18 +109,33 @@ void __init riscv_fill_hwcap(void)
 
 	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
 
-	for_each_of_cpu_node(node) {
+	if (!acpi_disabled) {
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
-
-		if (of_property_read_string(node, "riscv,isa", &isa)) {
-			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
-			continue;
+		if (acpi_disabled) {
+			node = of_cpu_device_node_get(cpu);
+			if (node) {
+				rc = of_property_read_string(node, "riscv,isa", &isa);
+				of_node_put(node);
+				if (rc) {
+					pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
+					continue;
+				}
+			}
+		} else {
+			rc = acpi_get_riscv_isa(rhct, get_acpi_id_for_cpu(cpu), &isa);
+			if (rc < 0) {
+				pr_warn("Unable to get ISA for the hart - %d\n", cpu);
+				continue;
+			}
 		}
 
 		temp = isa;
@@ -248,6 +268,9 @@ void __init riscv_fill_hwcap(void)
 			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 	}
 
+	if (!acpi_disabled && rhct)
+		acpi_put_table((struct acpi_table_header *)rhct);
+
 	/* We don't support systems with F but without D, so mask those out
 	 * here. */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
-- 
2.34.1

