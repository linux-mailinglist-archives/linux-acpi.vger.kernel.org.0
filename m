Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D656818D8
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbjA3SYZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjA3SX4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:23:56 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F453D0AF
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p24so12518772plw.11
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USVS3mywTvdLvSTJeGXikExLlXPpzcs14a2ZRggZ7wY=;
        b=AdzPUrbp24xrj0FAMDk5+9RcVSjZCso58BavKvUv8Y2Jv3EBQs5Tt0/nPExBhQxEPI
         j1Ik71BoJYr9yc3WpMmfgQ24R7V4dmBuWpXBIo3eGXjF4q7GziPZ/dui+mh0CyZyuHvm
         eppGpPrLfUiliaq4Tkv0jgfObfdOkbx9KN4jdMMYleuS3fqZS1d61qS2s25o6BIth0Sh
         cmtfpu8dJcz8pmxvK+S5DqQKX/c9I0Hayd5E7TlqjRKz2eIdmONgZbi5uObiinByYY2S
         FGXOHytfliaegYVhWjoHeGGIm+SJdYaXtUrnp5p8EdDnHKzCdKJG66bYpTCn93ACKM9n
         QA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USVS3mywTvdLvSTJeGXikExLlXPpzcs14a2ZRggZ7wY=;
        b=nLxrCRsvGSpGtOAOY0oyg1jAntBHhLL2arT0h+zT8+SksgOO0Pz3dMP/umOcfrMcnD
         mwv+oF1J7/C09hP5esmp8uYgyBTC7YKnFSHJ6jVuPm9veitu+S4ro/Qd4GXt20clYUK8
         vFPLKyRz9taLcmrE1fuWvHQLyoZLTnKqJjBeoFxKQDXkGqkvBMJviPk1zWDZuUN4xM6i
         +K7KwGy1ugiJ0x1j22LnpoiWy84MBrbU0BhjrkSFwKljW4GM3F/XCaLc1sDWjjxfgvG6
         VNRU8aF0AYncsNECFjD/LZW9bqoplcPAnKiWQzxfeHpVuE1Uk+7bGlGqEC+wD9O4IJMG
         Fd1w==
X-Gm-Message-State: AO0yUKVwRB/geX3Mc/TMPGnmLzelQ0qoJkGNAAmVwwnHPlddLWf/RYZn
        4Ubwyu2EkVMr4sD6WDwFkIm20A==
X-Google-Smtp-Source: AK7set/iIY4N9lMJIQuuLqIcFatEy8RspvzQ7ycNCuigstyEk6Y9hWi2TzCwIFuNa78QmQWe8UUyAQ==
X-Received: by 2002:a17:902:d4c3:b0:196:49a9:bf26 with SMTP id o3-20020a170902d4c300b0019649a9bf26mr20839616plg.15.1675103000228;
        Mon, 30 Jan 2023 10:23:20 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:19 -0800 (PST)
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
Subject: [PATCH 10/24] ACPI: processor_core: RISC-V: Enable mapping processor to the hartid
Date:   Mon, 30 Jan 2023 23:52:11 +0530
Message-Id: <20230130182225.2471414-11-sunilvl@ventanamicro.com>
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

processor_core needs arch specific functions to map the ACPI ID
to the physical ID. In RISC-V platforms, hartid is the physical id
and RINTC structure in MADT provides this mapping. Add arch specific
function to get this mapping from RINTC.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  3 +++
 drivers/acpi/processor_core.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 8b9babaf3f25..c5cb9f96d404 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -15,6 +15,9 @@
 /* Basic configuration for ACPI */
 #ifdef CONFIG_ACPI
 
+typedef u64 phys_cpuid_t;
+#define PHYS_CPUID_INVALID INVALID_HARTID
+
 /* ACPI table mapping after acpi_permanent_mmap is set */
 void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
 #define acpi_os_ioremap acpi_os_ioremap
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 2ac48cda5b20..889f495b3481 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -106,6 +106,31 @@ static int map_gicc_mpidr(struct acpi_subtable_header *entry,
 	return -EINVAL;
 }
 
+/*
+ * Retrieve the RISC-V hartid for the processor
+ */
+static int map_rintc_hartid(struct acpi_subtable_header *entry,
+		int device_declaration, u32 acpi_id, phys_cpuid_t *hartid)
+{
+	struct acpi_madt_rintc *rintc =
+	    container_of(entry, struct acpi_madt_rintc, header);
+
+	if (!(rintc->flags & ACPI_MADT_ENABLED))
+		return -ENODEV;
+
+	/* device_declaration means Device object in DSDT, in the
+	 * RISC-V, logical processors are required to
+	 * have a Processor Device object in the DSDT, so we should
+	 * check device_declaration here
+	 */
+	if (device_declaration && (rintc->uid == acpi_id)) {
+		*hartid = rintc->hart_id;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 				   int type, u32 acpi_id)
 {
@@ -136,6 +161,9 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 		} else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
 			if (!map_gicc_mpidr(header, type, acpi_id, &phys_id))
 				break;
+		} else if (header->type == ACPI_MADT_TYPE_RINTC) {
+			if (!map_rintc_hartid(header, type, acpi_id, &phys_id))
+				break;
 		}
 		entry += header->length;
 	}
-- 
2.38.0

