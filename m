Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CCB6818E0
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbjA3SZM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjA3SYc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:24:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3021744A6
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j5so11865674pjn.5
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmqm1KrH8Rx3qerFslFMAYGwIdVV+GEj7SnscFfXmQ0=;
        b=cPqIpB8prS7hDFjj+h2EyPJYy7PzmnnK7RExz1Ok8dR7rRKT+hcVUGsFGHWUlBqJwN
         7TFI8iyfHhoGD4a989XpaHBs/LV8kw/QUgsWAYRqlX1j2J426hfu4JuvWvWp2Ur+aJva
         bIvHdZ3mMBp4tBmotAyHnxK+PkLaI1ltXKPKRM3DZCEAeySNiyDpT3o7bmmnIzIHMSvv
         NHmf9xDgFjhefd/ngOEANI2MN4vf8CxitwuTZvXZT7ThVciVKtcZRlVErvkJjCEEW2sn
         WchYKaK4+/IvPJhKS+PXyhvjlMpYJw11G5D54C68fDhwazqvPkacu5QTTU7uvSoVkfjg
         zARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmqm1KrH8Rx3qerFslFMAYGwIdVV+GEj7SnscFfXmQ0=;
        b=iUcp7FjhJdPKvpT5qQEQdaUNT+FwbMrFit/i/4+vfbwH3a7fWRWPyw2CZv0KDKvCv/
         9Y2nPMPyHSoTIb5cowUpuD+kAu8qdWPzSlIogGvs2387EpveZsqEPE7pnhLiDJ31I1uC
         8G8Sa+deSVAcUhBKajmCHoeGTkMLm0j0DiXPzbuV/tTd79Koaa/uOte2V/6vC6zr1dB1
         7yEE9sfj3Dwk/UE43acjkzuXEaxIBmv6PE2i8wbEPI1i2UPrx4pq1RMMsMgef9OV6NJu
         Va7/251yhj/4AEQzhjbAi9NYeCwDeTVE/IEO+S5q8H4UD4P0ziESvTbEuAROBlsKD88J
         4WTg==
X-Gm-Message-State: AO0yUKUninspzzOA7pe60lZVOGu8Kk7I/nAnqyCejqoolrpC/AmIlUY7
        4rk4i8Dwf4rvfH627GCVRIk6Ow==
X-Google-Smtp-Source: AK7set8mUQ/h8KMYQ2zVbbHUXRL1WVlOMXJhgdTYz7w1If9zAbycA9u/XMnVWA+UBeINzP9AUSP2wA==
X-Received: by 2002:a17:903:190:b0:196:869c:8c5c with SMTP id z16-20020a170903019000b00196869c8c5cmr5258522plg.51.1675103013599;
        Mon, 30 Jan 2023 10:23:33 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:33 -0800 (PST)
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
Subject: [PATCH 13/24] RISC-V: ACPI: smpboot: Add ACPI support in smp_setup()
Date:   Mon, 30 Jan 2023 23:52:14 +0530
Message-Id: <20230130182225.2471414-14-sunilvl@ventanamicro.com>
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

Add function to parse the RINTC structure in
the MADT table and create the required initializations to
enable SMP boot on ACPI based platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  7 ++++
 arch/riscv/kernel/smpboot.c   | 73 ++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index c5cb9f96d404..d1f1e53ec657 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -58,6 +58,13 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
+
+#ifdef CONFIG_ACPI_NUMA
+int acpi_numa_get_nid(unsigned int cpu);
+#else
+static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+#endif /* CONFIG_ACPI_NUMA */
+
 #endif
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 26214ddefaa4..e48cf88d0bc1 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -70,6 +71,73 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
+#ifdef CONFIG_ACPI
+static unsigned int cpu_count = 1;
+
+static int __init
+acpi_parse_rintc(union acpi_subtable_headers *header,
+			     const unsigned long end)
+{
+	unsigned long hart;
+	bool found_boot_cpu = false;
+
+	struct acpi_madt_rintc *processor;
+
+	processor = (struct acpi_madt_rintc *)header;
+
+	/* RINTC entry which has !ACPI_MADT_ENABLED is not enabled so skip */
+	if (!(processor->flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	hart = processor->hart_id;
+	if (hart < 0)
+		return 0;
+	if (hart == cpuid_to_hartid_map(0)) {
+		BUG_ON(found_boot_cpu);
+		found_boot_cpu = 1;
+		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
+		return 0;
+	}
+	if (cpu_count >= NR_CPUS) {
+		pr_warn("Invalid cpuid [%d] for hartid [%lu]\n",
+			cpu_count, hart);
+		return 0;
+	}
+
+	cpuid_to_hartid_map(cpu_count) = hart;
+	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
+	cpu_count++;
+	return 0;
+}
+
+static void __init acpi_parse_and_init_cpus(void)
+{
+	int cpuid;
+
+	cpu_set_ops(0);
+	/*
+	 * do a walk of MADT to determine how many CPUs
+	 * we have including disabled CPUs, and get information
+	 * we need for SMP init.
+	 */
+	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC,
+				      acpi_parse_rintc, 0);
+
+	/*
+	 * NUMA - TODO
+	 */
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
@@ -118,7 +186,10 @@ static void __init of_parse_and_init_cpus(void)
 
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
2.38.0

