Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03CF6D6BA1
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Apr 2023 20:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjDDSXG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Apr 2023 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjDDSWq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2023 14:22:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6331859C4
        for <linux-acpi@vger.kernel.org>; Tue,  4 Apr 2023 11:22:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso2009161pjc.1
        for <linux-acpi@vger.kernel.org>; Tue, 04 Apr 2023 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGonri/T19XQF2naGXJvqqLnbSM1YN1GWyJxGmsm0G8=;
        b=jlU6cVDRpS7N+hbCajzQ5MBLlupJaHtqzIdkqiPTdgeHP85eBAGnt3IyBNq6jANDpp
         cwqU4j6QhylWaoAD+i+RvRnFnexq1wQ7hFZtqJGwVlBRMJgGNeR4vpKazmlZG0XQ2Zrn
         InczBkrjePyvmC01JogcOj/miAoB9IP8R8uwJH07fk96+hULRShilpkKLxZorAWOWvPs
         4lTqHyEsR8TapU0eESkEuqvZH3dKe12+qtas+XnrbS95Qwlo+rOrfF8OWmXZ214KwCeV
         0u+YSRiu7NhnExNyDKcz1HrlVGKzxl7vbNHloZt2ohNHTePS3ZURQLDXTYnysnOHTTCx
         aDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGonri/T19XQF2naGXJvqqLnbSM1YN1GWyJxGmsm0G8=;
        b=qPMt+0PZUQgbIacf1dRHlMH2P0rqg/jpTIiOPnFHB2gWt0YHJ7ezL6qoczqPt/4oWE
         k8mI6A7z+m2CMPupN+47my90YGSFdIH6KYdVWsNZdVZAr5Qfz120I74m4vyhBQD3l59G
         WFoTwG/Muw+umk7N2cJp6D6uJJ1wB9R/S+pw2aCAG/+QdgUWi8yidIapYHclDlv3AM37
         9W1Q4LUrRB8MMeumNCgurqxuLGe3jKf2qQKfg73Qtc0eeFm8RDIkQhxGCJTaAuLGhbk4
         DOUVeewpHyNIjJessEnFPpjHLb3dGJlvxQX2XtDnCGeRuZqQ6IS3vPq3NsrRH/J8n0W1
         rv9w==
X-Gm-Message-State: AAQBX9dRYLQK06Q8Y8Ovc1/rhVbOT9T4h1KNcmUfNZCJrVkKmE1jKaus
        lHCIo0xjSqVlWqqYfusoP1avBw==
X-Google-Smtp-Source: AKy350ZlBkhsUYFGZoVvsAnR0Ixd22Yfapa7HDI3EV26dD/3aAUWLts/geeosBM5SkSk2DgEm45zyg==
X-Received: by 2002:a05:6a20:930f:b0:d9:7af9:6a82 with SMTP id r15-20020a056a20930f00b000d97af96a82mr90355pzh.9.1680632524615;
        Tue, 04 Apr 2023 11:22:04 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:22:04 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V4 11/23] RISC-V: smpboot: Add ACPI support in smp_setup()
Date:   Tue,  4 Apr 2023 23:50:25 +0530
Message-Id: <20230404182037.863533-12-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/riscv/include/asm/acpi.h |  2 +
 arch/riscv/kernel/smpboot.c   | 72 ++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 2b3e78d5a13b..b26ba911f0a9 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -63,6 +63,8 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
 u32 get_acpi_id_for_cpu(int cpu);
 int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
+
+static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 #else
 static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 				     unsigned int cpu, const char **isa)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 26214ddefaa4..6a854b200b72 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -70,6 +71,72 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
+#ifdef CONFIG_ACPI
+static unsigned int cpu_count = 1;
+
+static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	unsigned long hart;
+	static bool found_boot_cpu;
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
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	hart = processor->hart_id;
+	if (hart == INVALID_HARTID) {
+		pr_warn("Invalid hartid\n");
+		return 0;
+	}
+
+	if (hart == cpuid_to_hartid_map(0)) {
+		BUG_ON(found_boot_cpu);
+		found_boot_cpu = true;
+		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
+		return 0;
+	}
+
+	if (cpu_count >= NR_CPUS) {
+		pr_warn("NR_CPUS is too small for the number of ACPI tables.\n");
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
@@ -118,7 +185,10 @@ static void __init of_parse_and_init_cpus(void)
 
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

