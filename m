Return-Path: <linux-acpi+bounces-1004-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CB17D75DB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F396828130B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8634186
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QEHaA3wc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2ED3399C
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:26:09 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685910F2
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:26:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso121837b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265559; x=1698870359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iZbx/IhbkeIBI8+FFzeu8yqPtMDZXtB3E1NSIPmMj8=;
        b=QEHaA3wcgswZPYvKtFvfe/69k4FY46ERnR8WMgXV1IMqoelcM4rz2XqdzfkYCJXcHA
         AZeXQv7QoKGxqZ8ztRXRHR9/meSUBV06R56NGZ0Bg4afony776+cS/GP0IMhMqcGOPeR
         BXmQXbwU0ap+UQ2w4s/WYEtaHQZTbJ+E9qp0/JBGXAVRiliE31C9a2pEb9jGPqDb//5F
         i7Gi+IZmFLPOhb5//zueDpHn2Gg8GUHChn2TdeHDV+4lyzpfvEf+quAO5gN25dyGVvVN
         XDNQQ+hvzvrwbpVPDQpk/iwr8m3MuhroNohrJ9lv6idIL4D5Op4XIlq/P3lu0wHBCkvV
         CU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265559; x=1698870359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iZbx/IhbkeIBI8+FFzeu8yqPtMDZXtB3E1NSIPmMj8=;
        b=ZL+ybJ4wX2DQScqjEMcYts6dIonfIoUlSw+AqWjnjxVnYKG3pWxLPB1Qrvt4H/a5B8
         24bbRhUYJseH9E3R9DH8ePBWvADAPtEQWKXOrzSZdpPCa5NqLEr0IgkKOCoFtNIMfcai
         /V0eqXhFo2aESr+PMUkuraVJ8/EdKqiWhokawi2cES+z+XrbuHqtlSYDBVcNCmIc7Ovi
         dYDu8gCXLPY/Eqm9BqQegY54GKeQcQ87lXkfmwBhOLXdpLB3RH3AQXYCfjrmTiiph62p
         SyQciR0mrNoHWgbi684EvJxGCJSAeHCiXQHpxT6xrPSpCaWwshHGzDvNiUobUeLc4oxp
         VAVg==
X-Gm-Message-State: AOJu0Ywm475xUvQH92IKwjqOI9vzjHsrXLO9S46cALkSBj7py6DEFizP
	vEkzX88eOp2HICtWF9PG8eRiQQ==
X-Google-Smtp-Source: AGHT+IFsNPal98bQ9F5MiljlxhKf86YWd9QVm8kQWxT7ZeiK3cahwXFdqVcGHEG00PzdPooHKx2sEg==
X-Received: by 2002:a05:6a00:1798:b0:6ad:535e:6ed9 with SMTP id s24-20020a056a00179800b006ad535e6ed9mr16898802pfg.16.1698265559236;
        Wed, 25 Oct 2023 13:25:59 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:58 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 19/21] ACPI: bus: Add acpi_riscv_init function
Date: Thu, 26 Oct 2023 01:53:42 +0530
Message-Id: <20231025202344.581132-20-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

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
index 9eace6c7042e..f7ac0caf04cf 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1417,6 +1417,7 @@ static int __init acpi_init(void)
 	acpi_hest_init();
 	acpi_ghes_init();
 	acpi_arm_init();
+	acpi_riscv_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index f80b3da230e9..c4d679b1359e 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y 	+= rhct.o irq.o
+obj-y 	+= rhct.o irq.o init.o
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
index 19c3dda9c2ed..c408070ac52e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1527,6 +1527,12 @@ void acpi_arm_init(void);
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
2.39.2


