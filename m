Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15097699C3B
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Feb 2023 19:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjBPSXj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Feb 2023 13:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjBPSWz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Feb 2023 13:22:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E4E505F8
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 10:22:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k13so2983797plg.0
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k9kFgHhGrniFtz38iNTmjHDIue+Ed5Mfkw3G0DBXLc=;
        b=kK5aVj5XXgADplAjlm4YI2+at0WD39rzqE/oIyTucqgfAxPxz7s7VY0dLKzFQG5tS9
         ohX9Fg8TbtfoL8ktTHsnWOfizVCmB8RTZWvbpQ3KV+LgYLfvrtpdXcpHf793sUDvzNMg
         lrBMnAjwcfhd9iQm5CeiEPB3lza3dy4hn9W8Tsx6uN7FO+cuhc1xO65+BQY6JS50/PmX
         ak8JWUQbkP69ZNG5odZ2HxxwPL4oirSxHRqb9SJ1QeT06nvilKmAjBuqESK7HvhO7Oss
         K77HkI2Oy23RBT+GMy9TTpF9xWGTHgx/4UNeOUZ28D/80kgEFkadRcIz47s4KDKFKP6k
         svHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k9kFgHhGrniFtz38iNTmjHDIue+Ed5Mfkw3G0DBXLc=;
        b=eTE8vqikYCH3NRCdATbmomghmd2z5oHOTNMNmaCPcWVYuteN2lI96a6BRgh4edLqC6
         g5nYhmLSFlMA8m3Lycz/ht9Wsc23Sr/UQqlbuS9jO+LguLPM5AVxL+Lv/wZOqYPH/hSs
         n2yyLbD4nQ/To4+3C4BmHvSe2WsfmgUh2WlSdGGPcZHfeYFQQywbZt9++H+7eSMO5Ja8
         2PDSEU/tVFIcZWRmc1dXuTUZ+re47hkGIaAf95VaHerFo4aP5jPD6bTdxf0Z3PiAvuJN
         aVJlAATy9+ZSPXtqXXeGvJ0lbNBtGh+9cfo/oOFOo//bQCkvE+PH2RJP/duabUo2Er7U
         AvDg==
X-Gm-Message-State: AO0yUKVVx0yjbmarmcGI9r37OF8Cq07uDfxZU6CVnmZ5acmqLrXHuvqP
        TFavzZX0PxBzvlDnXpDDzvyjaA==
X-Google-Smtp-Source: AK7set9c+aWEKO1Pw1h7Pzh7UhGNa//RafytfZpTPnUB+L6FRIQe5YzjjBo8BOJIm3kXdNQRXY4WEA==
X-Received: by 2002:a05:6a20:8f04:b0:bf:73d:485e with SMTP id b4-20020a056a208f0400b000bf073d485emr7842207pzk.54.1676571738700;
        Thu, 16 Feb 2023 10:22:18 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:22:18 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 18/21] RISC-V: Add ACPI initialization in setup_arch()
Date:   Thu, 16 Feb 2023 23:50:40 +0530
Message-Id: <20230216182043.1946553-19-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
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

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/kernel/acpi.c  | 113 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c |  25 ++++++---
 2 files changed, 130 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 13b26c87c136..35e7b24a30c8 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/pci.h>
+#include <linux/efi.h>
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
@@ -26,6 +27,118 @@ EXPORT_SYMBOL(acpi_pci_disabled);
 
 static unsigned int intc_count;
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
index 4335f08ffaf2..c2ee7f4427a1 100644
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

