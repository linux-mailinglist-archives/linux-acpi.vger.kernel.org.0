Return-Path: <linux-acpi+bounces-5033-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCD18A5870
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 19:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4231C20C02
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB5086248;
	Mon, 15 Apr 2024 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ER/WmwXm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B4839FF
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200525; cv=none; b=Fy3PxzGRRStx5mo1ofIC8EgjemrM3eh9HrkuC8qNz3hR00ZCCpBobGVt+FGrrs3vuvzAGLljBIKMsDxKPk6WWGR/x38c1txIYopRou6F83ss7Q1Wp765EodGY2jAguwh0AWPHa6YJ7cncNH1miw+kddnaSnjQcpz3ebXCMmDvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200525; c=relaxed/simple;
	bh=6c1KPNfbsnJq9DUvTTQzdZQPzyBy24eoF7S1WvCF6y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JI/WX255BlGGPUyaRxfE/IGD2uHeQ7p2XRrsiDOVcm9RBOD6pyjnUIJpAbXP4VuPcrTlChr67wUQNnN+Q33kd8BO1ueUB2fWvC5+1FSHA2ZFxLW9i/yTanc314H8wuJzDV91A6lE5REHhs6r/6rH3cSQPqw/RlfTuuBe/vEMGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ER/WmwXm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso2891894b3a.3
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200523; x=1713805323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teU93TtwDbXbcibIb7AXZv+o/BW+BbmtaOdYSVoKyTI=;
        b=ER/WmwXmBdMEr36nrxErZvolaNMxrOahPL/iWV15IB0Mvo6yOhqVFB53zyUyTysuUT
         vcfwQjfAiE2sNMJmRiaZjt4SDPos4+Q3Jvy1/55xTJa4DgpkHQUm455gWew7WB9EJ1sW
         PnVvJ0sw5chzxr1jBbOizKzvm0ky9eHloxT0NiEPK6kSHBJfopGtPjNRUbb1XOR04dK5
         9+bWNgmgDpzwoTVmAf/AzBKSju777e4d6dRtjxEik1P48d4HPyzPgQT+LELrxKI9sTE1
         SDiviKEjnRntF7q8CwUVAuWS9IZCDvSDTnvb1H8TTl6vu8uJo/lRVqvPNPLggJQDjJE/
         dsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200523; x=1713805323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teU93TtwDbXbcibIb7AXZv+o/BW+BbmtaOdYSVoKyTI=;
        b=NQS+cXqoCfxuysbmJpn+0cAnZ+hbkkBEOaw3/WUd5FEeHi64BOIQZLgjQLyaypljzv
         v7ip5Kcef1+I+f7OnyoYDyNLqGQVwYlUhtYNJ99BO/eUCBvigfcqIIsQr5QEv2/dv3bH
         6U7fCZklFR3m2x3dedRxHrRwvQBLtKuQ3OqWJUSBYFp2oCK1RYLUHPaTQmk2uLDfVQNs
         lAh5vnaqauk/qLluq3nzrNY/eVtEdWoEmizcLpD4Mc+sYcz1uqG7XauAtojryT7x0Eo4
         eHlIdN9gy2CM913fkrJR4ZE16siVTO2IFUnk3tqX0/sktUExhh9XsNIZ4z/S7n/Za/5P
         xiEA==
X-Forwarded-Encrypted: i=1; AJvYcCWjyRkd5tU0wHhEQU8x3PIYO8p1RMPi5+twRNwrhFTu9FUybLqQe4WCGrMkwFFIB+LpKuGkRcrPlIWvyMcYLqLz5l8v2lwQCjUGbg==
X-Gm-Message-State: AOJu0Yy3RIT4Ndw103PNxHNesICOeFwNLO+3ZnsqAzRIY4Y/JqaNcne7
	QJybAT8vkNkzlkcKhAJXXcJHJeVesWraUCNT+qLdfCIA/IOy3CLWvsAbCTjfqx0=
X-Google-Smtp-Source: AGHT+IHIdjpEtA26gjeeDnuLKQpBt+rlByzg0zdHDQS2GYQedk9D3DuzAQNVqthcjh2+Xm9tW86rPQ==
X-Received: by 2002:a05:6a00:3985:b0:6ea:e31e:dc75 with SMTP id fi5-20020a056a00398500b006eae31edc75mr12713019pfb.5.1713200523442;
        Mon, 15 Apr 2024 10:02:03 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:03 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 06/20] ACPI: bus: Add acpi_riscv_init function
Date: Mon, 15 Apr 2024 22:30:59 +0530
Message-Id: <20240415170113.662318-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new function for RISC-V to do any architecture specific
initialization. This function will be used to create platform devices
like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 12 ++++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/init.c

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 844c46447914..17ee483c3bf4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1446,6 +1446,7 @@ static int __init acpi_init(void)
 	acpi_hest_init();
 	acpi_ghes_init();
 	acpi_arm_init();
+	acpi_riscv_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index dceec808cfab..42d351859aeb 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o irq.o
+obj-y					+= rhct.o irq.o init.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
new file mode 100644
index 000000000000..b5807bbdb171
--- /dev/null
+++ b/drivers/acpi/riscv/init.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+
+void __init acpi_riscv_init(void)
+{
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 914ecd22ba64..f8f92aaf97ad 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1525,6 +1525,12 @@ void acpi_arm_init(void);
 static inline void acpi_arm_init(void) { }
 #endif
 
+#ifdef CONFIG_RISCV
+void acpi_riscv_init(void);
+#else
+static inline void acpi_riscv_init(void) { }
+#endif
+
 #ifdef CONFIG_ACPI_PCC
 void acpi_init_pcc(void);
 #else
-- 
2.40.1


