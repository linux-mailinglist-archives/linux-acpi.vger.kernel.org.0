Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C16A98C6
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 14:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCCNj7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 08:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjCCNjX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 08:39:23 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1988E5F6D4
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 05:38:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id i10so2649862plr.9
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 05:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnWMRVmSE/FRN1G4jePLo7NyPHxO3nOfwGFEZAQeYgw=;
        b=AG/Tf51+s22adpeRGvtvyn8utYIGCZCOngUStWWIN4Xvgcjf9OT7yemtdcuDE9RF73
         Tp2l5evMan993UfOjExmWatX1Ej6KbCl21v/LybejXpIcTUMKt65Yc8taUjveX6u48Te
         1UFN6b3oiLuPxRLljwFChqMEPCWO3uCiRB4XQ8VZZjRMqpHyhS+wKyBI8w993vl3rxYs
         AXb0qEGrWMbN89nZ5JRoB/PYsUA/yWnhiHulSKHbq5h8+VF+/HFRkoUp1T/41VLNGEBY
         WMRc9UqlSwE4zk2Z+8oReKckCgw/IkBYNrFQXQNBSnPj961BIKn43KCLUezicY1o3EUf
         Gtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnWMRVmSE/FRN1G4jePLo7NyPHxO3nOfwGFEZAQeYgw=;
        b=aPmvgxjZvCzDtJkln66BE/23KYTydcukQZtBZtbSU8ji0HS+hmnbbErp/RPJx5enLe
         SJVpLed5uHh9gV4QL/mZhXn0Wu0psYYKmNI7XIhgG6eCoGVjMVXs/X0KwIkvsmk3hDk6
         0ujXzjtsroyWg2PE6XrCBy6Hqfjx/M6+OT5+x8g516lqmXDkLRD739zbZm4XS6Iec5G3
         DIzCu+/NcJkWEwtqfo5EqoS6+nJFeECaNPb/KknBJ1RqX9YZp6joxTRg9Bsjp+opINgn
         +dpONBB7aVCZrFf03nyTG4elH2zRGLY/mHNREq3Q4kudgDyv4zYT0ghobZ3kiz3iXWSU
         n9Lg==
X-Gm-Message-State: AO0yUKVxIymV8iukuY0nIqnqlxuRslmdsYzzC6YxvtT1tX8J8oaznS2N
        5+ekoNxsptc8uNakvPDRKtJ2LQ==
X-Google-Smtp-Source: AK7set+V51+07N8qgFm1g2lKLOWif8Yck9PdXztlJ+r/xz8awvRzgCb/QA45Sz9lhXFjogmhYXfMNA==
X-Received: by 2002:a17:903:124a:b0:19c:d550:803e with SMTP id u10-20020a170903124a00b0019cd550803emr2225851plh.57.1677850701885;
        Fri, 03 Mar 2023 05:38:21 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:38:21 -0800 (PST)
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
Subject: [PATCH V3 18/20] RISC-V: Add ACPI initialization in setup_arch()
Date:   Fri,  3 Mar 2023 19:06:45 +0530
Message-Id: <20230303133647.845095-19-sunilvl@ventanamicro.com>
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

Initialize the ACPI core for RISC-V during boot.

ACPI tables and interpreter are initialized based on
the information passed from the firmware and the value of
the kernel parameter 'acpi'.

With ACPI support added for RISC-V, the kernel parameter 'acpi'
is also supported on RISC-V. Hence, update the documentation.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../admin-guide/kernel-parameters.txt         |   8 +-
 arch/riscv/kernel/acpi.c                      | 126 ++++++++++++++++++
 arch/riscv/kernel/setup.c                     |  25 ++--
 3 files changed, 147 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..047679554453 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,17 +1,17 @@
-	acpi=		[HW,ACPI,X86,ARM64]
+	acpi=		[HW,ACPI,X86,ARM64,RISCV64]
 			Advanced Configuration and Power Interface
 			Format: { force | on | off | strict | noirq | rsdt |
 				  copy_dsdt }
 			force -- enable ACPI if default was off
-			on -- enable ACPI but allow fallback to DT [arm64]
+			on -- enable ACPI but allow fallback to DT [arm64,riscv64]
 			off -- disable ACPI if default was on
 			noirq -- do not use ACPI for IRQ routing
 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
 			copy_dsdt -- copy DSDT to memory
-			For ARM64, ONLY "acpi=off", "acpi=on" or "acpi=force"
-			are available
+			For ARM64 and RISCV64, ONLY "acpi=off", "acpi=on" or
+			"acpi=force" are available
 
 			See also Documentation/power/runtime_pm.rst, pci=noacpi
 
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 8b3d68d8225f..9b6841700e30 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/pci.h>
+#include <linux/efi.h>
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
@@ -25,6 +26,131 @@ int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
 static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
+static bool param_acpi_off __initdata;
+static bool param_acpi_on __initdata;
+static bool param_acpi_force __initdata;
+
+static int __init parse_acpi(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	/* "acpi=off" disables both ACPI table parsing and interpreter */
+	if (strcmp(arg, "off") == 0)
+		param_acpi_off = true;
+	else if (strcmp(arg, "on") == 0) /* prefer ACPI over DT */
+		param_acpi_on = true;
+	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
+		param_acpi_force = true;
+	else
+		return -EINVAL;	/* Core will print when we return error */
+
+	return 0;
+}
+early_param("acpi", parse_acpi);
+
+/*
+ * acpi_fadt_sanity_check() - Check FADT presence and carry out sanity
+ *			      checks on it
+ *
+ * Return 0 on success,  <0 on failure
+ */
+static int __init acpi_fadt_sanity_check(void)
+{
+	struct acpi_table_header *table;
+	struct acpi_table_fadt *fadt;
+	acpi_status status;
+	int ret = 0;
+
+	/*
+	 * FADT is required on riscv; retrieve it to check its presence
+	 * and carry out revision and ACPI HW reduced compliancy tests
+	 */
+	status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		const char *msg = acpi_format_exception(status);
+
+		pr_err("Failed to get FADT table, %s\n", msg);
+		return -ENODEV;
+	}
+
+	fadt = (struct acpi_table_fadt *)table;
+
+	/*
+	 * Revision in table header is the FADT Major revision, and there
+	 * is a minor revision of FADT.
+	 *
+	 * TODO: Currently, we check for 6.5 as the minimum version to check
+	 * for HW_REDUCED flag. However, once RISC-V updates are released in
+	 * the ACPI spec, we need to update this check for exact minor revision
+	 */
+	if (table->revision < 6 || (table->revision == 6 && fadt->minor_revision < 5)) {
+		pr_err(FW_BUG "Unsupported FADT revision %d.%d, should be 6.5+\n",
+		       table->revision, fadt->minor_revision);
+	}
+
+	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
+		pr_err("FADT not ACPI hardware reduced compliant\n");
+		ret = -EINVAL;
+	}
+
+	/*
+	 * acpi_get_table() creates FADT table mapping that
+	 * should be released after parsing and before resuming boot
+	 */
+	acpi_put_table(table);
+	return ret;
+}
+
+/*
+ * acpi_boot_table_init() called from setup_arch(), always.
+ *	1. find RSDP and get its address, and then find XSDT
+ *	2. extract all tables and checksums them all
+ *	3. check ACPI FADT HW reduced flag
+ *
+ * We can parse ACPI boot-time tables such as MADT after
+ * this function is called.
+ *
+ * On return ACPI is enabled if either:
+ *
+ * - ACPI tables are initialized and sanity checks passed
+ * - acpi=force was passed in the command line and ACPI was not disabled
+ *   explicitly through acpi=off command line parameter
+ *
+ * ACPI is disabled on function return otherwise
+ */
+void __init acpi_boot_table_init(void)
+{
+	/*
+	 * Enable ACPI instead of device tree unless
+	 * - ACPI has been disabled explicitly (acpi=off), or
+	 * - firmware has not populated ACPI ptr in EFI system table
+	 *   and ACPI has not been [force] enabled (acpi=on|force)
+	 */
+	if (param_acpi_off ||
+	    (!param_acpi_on && !param_acpi_force &&
+	     efi.acpi20 == EFI_INVALID_TABLE_ADDR))
+		return;
+
+	/*
+	 * ACPI is disabled at this point. Enable it in order to parse
+	 * the ACPI tables and carry out sanity checks
+	 */
+	enable_acpi();
+
+	/*
+	 * If ACPI tables are initialized and FADT sanity checks passed,
+	 * leave ACPI enabled and carry on booting; otherwise disable ACPI
+	 * on initialization error.
+	 * If acpi=force was passed on the command line it forces ACPI
+	 * to be enabled even if its initialization failed.
+	 */
+	if (acpi_table_init() || acpi_fadt_sanity_check()) {
+		pr_err("Failed to init ACPI tables\n");
+		if (!param_acpi_force)
+			disable_acpi();
+	}
+}
 
 static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
 {
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2d45a416d283..7b2b065a9f70 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -8,6 +8,7 @@
  *  Nick Kossifidis <mick@ics.forth.gr>
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
@@ -276,14 +277,22 @@ void __init setup_arch(char **cmdline_p)
 
 	efi_init();
 	paging_init();
-#if IS_ENABLED(CONFIG_BUILTIN_DTB)
-	unflatten_and_copy_device_tree();
-#else
-	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
-		unflatten_device_tree();
-	else
-		pr_err("No DTB found in kernel mappings\n");
-#endif
+
+	/* Parse the ACPI tables for possible boot-time configuration */
+	acpi_boot_table_init();
+	if (acpi_disabled) {
+		if (IS_ENABLED(CONFIG_BUILTIN_DTB)) {
+			unflatten_and_copy_device_tree();
+		} else {
+			if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
+				unflatten_device_tree();
+			else
+				pr_err("No DTB found in kernel mappings\n");
+		}
+	} else {
+		early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)));
+	}
+
 	early_init_fdt_scan_reserved_mem();
 	misc_mem_init();
 
-- 
2.34.1

