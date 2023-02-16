Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9870699C25
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Feb 2023 19:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBPSWc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Feb 2023 13:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjBPSWL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Feb 2023 13:22:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6BF50AFA
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 10:21:42 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b5so2936623plz.5
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8gLVy86DoWbnyaOmwt3yk4bIOk4obRTX8YOySNU6bM=;
        b=VpdtjEii+t5cvC5ibTSbTwjU4Vx3GiWKkzTOXqXjUr0YDKlzh2RTmRhrfafw6GTtsc
         YTQqnR6kqj6GRIgl9yX/vR6IHxTBJo7vdDNEj8DswgI7MPqnnTKk6CnOzErmcN5CCH2b
         ZwMNZtNf6oZbN7d+YG/54CFyPCKr7rLx8eQKziHq+F0+XPYQXsrOqlge5KMGhUXVQVMo
         nT8fZ/aoGGnmZ86ZY/5kHh7e+61wbBNj1IkEy+Sk4r9srBbf2euRVlaJls3S5LTMegLN
         dC+DQ9pSlYuPW3W5SR4Zgw/zMM7vqJOQ/chaI5xf2TMznWD+BoyMvGkFM9XtER5brYcS
         3B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8gLVy86DoWbnyaOmwt3yk4bIOk4obRTX8YOySNU6bM=;
        b=6c6iSxNFcuSVKw6A77yO4LUvYBfi5EHrFAYgjEzEHomC8y6CFbCMzkiRlBwoNgHnhA
         ZZgN34//vkbTyaDN6S9m7xyUIgeAsN0lmWTZnL5lIBXL9wBEN1N59aXLeuPZITHcD0wo
         6Hs5XwiKviuCWHoRWCgi7tVfEl6SvZl4n5KGTljtipYCGQtvm/snaJbocjCJClsz2ur7
         cEGQxZt+y/Atg9rMtYj//8aAOUsby9Q/1mmRRs5nEGWeiEjbw9aHta+qJ9hC/bypK6P0
         /ppMZ9ro3XIORGfx9onxr3gNeoH/ibkdKVFBVgHhm8MV2HAvvtVTwhxgF+9VfP2Sn1dX
         2GzQ==
X-Gm-Message-State: AO0yUKVrmns+X43EeMGelhMumOM1xhq0lydhd0huHhxzl+cT0Coo501W
        iQhP3FZgNm/WMpBn308IN2fvJA==
X-Google-Smtp-Source: AK7set82OpBoXgv7SeiV1Z4RhXl7WcwMoJmnfTKXKVRwepNnMNF/4KU9sf9ovobJziBAs+uVZziTXQ==
X-Received: by 2002:a17:90b:1d87:b0:233:d4fd:38a3 with SMTP id pf7-20020a17090b1d8700b00233d4fd38a3mr7710027pjb.41.1676571700518;
        Thu, 16 Feb 2023 10:21:40 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:40 -0800 (PST)
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
Subject: [PATCH V2 10/21] RISC-V: smpboot: Add ACPI support in smp_setup()
Date:   Thu, 16 Feb 2023 23:50:32 +0530
Message-Id: <20230216182043.1946553-11-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Enable SMP boot on ACPI based platforms by using the RINTC
structures in the MADT table.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/acpi.h |  7 ++++
 arch/riscv/kernel/smpboot.c   | 70 ++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 7bc49f65c86b..3c3a8ac3b37a 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -60,6 +60,13 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
 int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
+
+#ifdef CONFIG_ACPI_NUMA
+int acpi_numa_get_nid(unsigned int cpu);
+#else
+static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+#endif /* CONFIG_ACPI_NUMA */
+
 #else
 static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 				     unsigned int cpu, const char **isa)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 26214ddefaa4..77630f8ed12b 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -70,6 +71,70 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
+#ifdef CONFIG_ACPI
+static unsigned int cpu_count = 1;
+
+static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	unsigned long hart;
+	bool found_boot_cpu = false;
+	struct acpi_madt_rintc *processor = (struct acpi_madt_rintc *)header;
+
+	/*
+	 * Each RINTC structure in MADT will have a flag. If ACPI_MADT_ENABLED
+	 * bit in the flag is not enabled, it means OS should not try to enable
+	 * the cpu to which RINTC belongs.
+	 */
+	if (!(processor->flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	hart = processor->hart_id;
+	if (hart < 0)
+		return 0;
+	if (hart == cpuid_to_hartid_map(0)) {
+		BUG_ON(found_boot_cpu);
+		found_boot_cpu = true;
+		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
+		return 0;
+	}
+
+	if (cpu_count >= NR_CPUS) {
+		pr_warn("Invalid cpuid [%d] for hartid [%lu]\n",
+			cpu_count, hart);
+		return 0;
+	}
+
+	cpuid_to_hartid_map(cpu_count) = hart;
+	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
+	cpu_count++;
+
+	return 0;
+}
+
+static void __init acpi_parse_and_init_cpus(void)
+{
+	int cpuid;
+
+	cpu_set_ops(0);
+
+	/*
+	 * do a walk of MADT to determine how many CPUs
+	 * we have including disabled CPUs, and get information
+	 * we need for SMP init.
+	 */
+	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_rintc, 0);
+
+	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
+		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
+			cpu_set_ops(cpuid);
+			set_cpu_possible(cpuid, true);
+		}
+	}
+}
+#else
+#define acpi_parse_and_init_cpus(...)	do { } while (0)
+#endif
+
 static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;
@@ -118,7 +183,10 @@ static void __init of_parse_and_init_cpus(void)
 
 void __init setup_smp(void)
 {
-	of_parse_and_init_cpus();
+	if (acpi_disabled)
+		of_parse_and_init_cpus();
+	else
+		acpi_parse_and_init_cpus();
 }
 
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
-- 
2.34.1

