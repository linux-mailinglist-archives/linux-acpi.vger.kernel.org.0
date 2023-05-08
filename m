Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB76FAF3F
	for <lists+linux-acpi@lfdr.de>; Mon,  8 May 2023 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjEHLzU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 May 2023 07:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbjEHLyp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2023 07:54:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645C444190
        for <linux-acpi@vger.kernel.org>; Mon,  8 May 2023 04:54:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaec6f189cso29522625ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 08 May 2023 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546841; x=1686138841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2h3vevkYkVu6ki2VA7HPdPz/xuNcH/E20UC4Fi6w3o=;
        b=ZZntHeSbVEpN02Cc+DEk3iz4bVfHnuRM7WXQFLS0RRgrCwNBHq8sayu889D7P++r3l
         1gAWSEh9mwMM1kV8cZ4wLRQO6IgX4yBBIXJiz9RrSkfYghpY3CmVSdAcHA9dEq3URnX/
         QpFe+mOoaH7nAoQtsuoqkZzYKMeL3KF7pKgtxQiTauaupMtTSAz+NKn1LgASFO5wXbUi
         EcqgjxB7hqnvV7G1mrA8dhh2WIDT5/evRVQiT1GKkkpgK3LN02qAuAAKd90NpRQ113F1
         OffZEST/D6geWJCn+4z4IOeEejiohuTr/piTkuJSkGofxieZm2iKwTRYMQijgLtpweAr
         cTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546841; x=1686138841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2h3vevkYkVu6ki2VA7HPdPz/xuNcH/E20UC4Fi6w3o=;
        b=IingvYKyX9zwkzk8KWQK0Ld8xsMyBeV5dEmaonSsMJ5H7q1cSIVtgNtRNLp6eWp939
         iQRX4qJEEn5HFKWRex3dPuSwHLgXMlwKSLNjwObbLvxx3gSTL+xV3tV8SvKErfT59G/K
         Ns2IBqL3+1l0GtL9jMifIKBWU259+bPGSUt5dr9cpp/be8MLR29LPDJVcMI2BK0GoRCZ
         CydYK3bORwCkknqXMBlUgQbo+at7h58293otRu/D5JUvqXk1X/Fr6IEmCKX8v0RDk2wf
         s4vwUnd/IFarZnzjPMpJaoLfrn5hMMhE3cwSxHQe1cfleBgypBGQGaOLjcNznJnBSBbh
         HHwA==
X-Gm-Message-State: AC+VfDzeqQR9GyWAIwXChq8vTUp0cT77CV9GUjKjPAf1sKGOQxyFSldA
        KE0L6FeEqr67y3yXBgN/rc5RJQ==
X-Google-Smtp-Source: ACHHUZ69ugSarTSAMXC6f5oL9jNd6KuCehtnlrYptJAQTMRmfWkWaZ+k5Pb6dtDwggIXeWsz/yggPg==
X-Received: by 2002:a17:902:e74c:b0:1aa:cddd:57f2 with SMTP id p12-20020a170902e74c00b001aacddd57f2mr12752642plf.25.1683546840856;
        Mon, 08 May 2023 04:54:00 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:54:00 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V5 08/21] RISC-V: ACPI: Cache and retrieve the RINTC structure
Date:   Mon,  8 May 2023 17:22:24 +0530
Message-Id: <20230508115237.216337-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508115237.216337-1-sunilvl@ventanamicro.com>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

RINTC structures in the MADT provide mapping between the hartid
and the CPU. This is required many times even at run time like
cpuinfo. So, instead of parsing the ACPI table every time, cache
the RINTC structures and provide a function to get the correct
RINTC structure for a given cpu.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/include/asm/acpi.h | 10 ++++++++
 arch/riscv/kernel/acpi.c      | 45 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c     |  4 ++++
 3 files changed, 59 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 9be52b6ffae1..6519529c8bdf 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -59,6 +59,16 @@ static inline bool acpi_has_cpu_in_madt(void)
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
+void acpi_init_rintc_map(void);
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
+u32 get_acpi_id_for_cpu(int cpu);
+#else
+static inline void acpi_init_rintc_map(void) { }
+static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 81d448c41714..89e142611c84 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -24,6 +24,51 @@ EXPORT_SYMBOL(acpi_disabled);
 int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
+static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
+
+static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
+	int cpuid;
+
+	if (!(rintc->flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
+	/*
+	 * When CONFIG_SMP is disabled, mapping won't be created for
+	 * all cpus.
+	 * CPUs more than num_possible_cpus, will be ignored.
+	 */
+	if (cpuid >= 0 && cpuid < num_possible_cpus())
+		cpu_madt_rintc[cpuid] = *rintc;
+
+	return 0;
+}
+
+/*
+ * Instead of parsing (and freeing) the ACPI table, cache
+ * the RINTC structures since they are frequently used
+ * like in  cpuinfo.
+ */
+void __init acpi_init_rintc_map(void)
+{
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) <= 0) {
+		pr_err("No valid RINTC entries exist\n");
+		BUG();
+	}
+}
+
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
+{
+	return &cpu_madt_rintc[cpu];
+}
+
+u32 get_acpi_id_for_cpu(int cpu)
+{
+	return acpi_cpu_get_madt_rintc(cpu)->uid;
+}
+
 /*
  * __acpi_map_table() will be called before paging_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 9fb839074e16..a44c7fcde12f 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -21,6 +21,7 @@
 #include <linux/efi.h>
 #include <linux/crash_dump.h>
 
+#include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
@@ -293,6 +294,9 @@ void __init setup_arch(char **cmdline_p)
 	setup_smp();
 #endif
 
+	if (!acpi_disabled)
+		acpi_init_rintc_map();
+
 	riscv_init_cbo_blocksizes();
 	riscv_fill_hwcap();
 	apply_boot_alternatives();
-- 
2.34.1

