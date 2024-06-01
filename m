Return-Path: <linux-acpi+bounces-6118-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633918D7097
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 17:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF0C1F223CA
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4971527A3;
	Sat,  1 Jun 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="O7PYt8L0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA371E520
	for <linux-acpi@vger.kernel.org>; Sat,  1 Jun 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254284; cv=none; b=T4EGV9IKuA9IdVyIOmJ9//p3rxOK+HMO9I2ehy3wMLguaymrvkMw/N64pNZGhLsi4bgvcT0h3Pi8n29OmJgSyfztWXENikfnXd1vW9w1mF78STEJi2wrXyCrJaU8Sb+j1cw7Rujvw9TdfT4z5phlo9cVW0uqskiugqx019UElJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254284; c=relaxed/simple;
	bh=E/skCHGNmdvJjDbFpcdffugM/MM2UFUg2zxVjQ3qBJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nzw9anK3pmyPHPSxpdFJeAL51yw9vtK4p4U3416DEsdl5T7a62PtTuqMGXeD/d7F1smqDyEmfjqxFfm3G5iwrEe2Dwo6ODczxILuioc/PZeuP443sr6/KYn+tlE4z9fOUzv2AD31nQCk2cMHj1LLm4hKToapFPeOKh5DoedsxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=O7PYt8L0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-701b0b0be38so2791710b3a.0
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jun 2024 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254283; x=1717859083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XPxdT6K3q9avtvxcOF9k8RyQ+CxCpXPedgopG0VTh8=;
        b=O7PYt8L0hk/lo9IKdQq8YW8H+gDp6HttrRP4TbGvh0QAprsSNARoE5kcwKCsaUx9pO
         NXEpnxBLwR6uyuczUXojiQaLqxAIs84b/i0+u0WVQcC3OriNE1GtVfXWAOjv0dgqFFN6
         VqlV1edEQZyK3rMPwfYi8iai/MnIzm6fETy9V1t1qm6w8oqzK1VZGRrDd+QwLOHowvIN
         0nyRaDnPYUHRrjyw8wadICjCuxPoGZAks2kDpZVYi4Xvwf40iDbrBwlorsVsh2V8Dg12
         Hn8MAbmoKmm8PzSttwMOYgmyqPQEwq6D1gYun85X67lPdOSUDB6WmF1xGJ2A1/x+kg20
         Zo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254283; x=1717859083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XPxdT6K3q9avtvxcOF9k8RyQ+CxCpXPedgopG0VTh8=;
        b=I/czASzy8eF6HV2VNGq10wurLnc2mjgMqbmv+J5wLs2dEFZ5qCRRHhv3y7RTWmjScd
         BU+SN4mghB3+lyBG3/wixr1x1Zf+tlHRJgLaiKpBqmPC/2dECvUCRFzasFRd3w0xB4BI
         yudL2b1c6fCRiO1sXLWM0vUV5eU4MSQYEnm5+XtVxhmyG5uFQt4eQwvvRhz7LhRv1hsy
         JsrJM9oAMkqT+XvPDAvJpL2oR/D5NpasouL5Z1h0Mv1sNMRYZNzk3gbwZaFzaM990tKG
         YsIBjSfKUzgUAyLlWb9B7DcYJZTgOm9Ug2hNcJnbxy5vqmhHCl+tJaIMR5Wcj2ZV1TEy
         yVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX/RlQnErTSCFbg7MafLZE1it0xeOlKwaXqozRK4ERgbMpebdyzZ1YlqhsaitBHfuxYkjoKkALd/yxyjopvySGEgM+KSZtXeGyug==
X-Gm-Message-State: AOJu0YyW28k1cepEmGUSu21t1dTYRKJkrkx/ckKmjz03ge09hoMU7mAp
	db4hMfXzQljgc3ErUnRAuAM33X2fcsGUnK6xiV85s+TUuBJJjpgrQ4JJHFi/ru0=
X-Google-Smtp-Source: AGHT+IHSPHHuLlxYdhrhdQ1SLxLogYrmPMkhydYeNGjzqhZ539L1iLkZwGvrDzW2O9+TbFzfxEzXhQ==
X-Received: by 2002:a05:6a20:3946:b0:1af:e3f1:9af7 with SMTP id adf61e73a8af0-1b26f204cfemr5557418637.36.1717254282646;
        Sat, 01 Jun 2024 08:04:42 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:04:42 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 03/17] ACPI: bus: Add acpi_riscv_init function
Date: Sat,  1 Jun 2024 20:33:57 +0530
Message-Id: <20240601150411.1929783-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new function for RISC-V to do architecture specific initialization
similar to acpi_arm_init(). Some of the ACPI tables are architecture
specific and there is no reason trying to find them on other
architectures.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 12 ++++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/init.c

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 787eca838410..8d0710ade8c6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1457,6 +1457,7 @@ static int __init acpi_init(void)
 	acpi_hest_init();
 	acpi_ghes_init();
 	acpi_arm_init();
+	acpi_riscv_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 86b0925f612d..877de00d1b50 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o
+obj-y					+= rhct.o init.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
new file mode 100644
index 000000000000..5f7571143245
--- /dev/null
+++ b/drivers/acpi/riscv/init.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
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
index ab3f2880d209..0c6d9539f737 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1520,6 +1520,12 @@ void acpi_arm_init(void);
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


