Return-Path: <linux-acpi+bounces-2556-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E56D818EB7
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 18:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA2AB253EA
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB52237D3C;
	Tue, 19 Dec 2023 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DGBDP4yY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ABA40C04
	for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ce28ac3cso15520775ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 09:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703008014; x=1703612814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0uCfTOZnl72LckIuFeuzwRvzQWn6/C5y85H0bronQc=;
        b=DGBDP4yYm2TSIA7nVLia33bztGvzZ3Fa/2Jp/k3giNwLELuBKMcWqyw/WI5AmaR8pr
         f1Osq8dGQVCMj37qVzdmKnkgHHLdH6g3/3b+Jm7v4EwPULSB8Zx2i0/iETSakv0pghl2
         QYzkp0jFl3EaQPufPzIouPhfAcSNofr9LRjS53eWuoEDZj6E7JmRwo/hdyckqGRaApn+
         Qz4JY93pT9v+RaY+qPFRsKP345EIC/JOiWib9tXbPPBcns7YEghvsBhKcWttU3SnI/wH
         xkDarqvK7AFhB/NP646BLCZYRorrp1hC86KgoTAJ9WfMHne5iEiclwY0GzoCvlYPBP3S
         kkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008014; x=1703612814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0uCfTOZnl72LckIuFeuzwRvzQWn6/C5y85H0bronQc=;
        b=F7bs4fDR9r5dieA0EuJWp5fhMqEUkvNHH2bOJelHFg/iXOlwc6Rhu3hViEZecgnhnx
         EM0CvxQ4mZGdA/yo3mlZ8WnutnZIkSG9SgYpQa0d5FEjbiit+VqcS3yqISLJkzZorkT5
         SHzQtlyC5V5YMJcwh+twWyhuLp0C+CkcyqbKcQWU6GTpqXcocbiBDUqU7HoVo2Ibo+Tt
         olyXFu4dr9u9XksBCqYi5pkQlX+lrg+aelhhIsh4AQ1lAAeQeSehhYfJoKBGv7L5HNbX
         6Xg6roxkgSw58BAnboFjw9ZM27PgIqXv7E2K6ueHeqgthuDNtAVFHc8nxKVo72V6tGrE
         7BzQ==
X-Gm-Message-State: AOJu0Yy0J3j7+7aOhlsM/2uhK1cLzs3XIHIH0+o0Cf/cthnUchn7a1Fs
	iNk2PKvborIQYBxlBWQe5FP1gw==
X-Google-Smtp-Source: AGHT+IHZcNfZ6die569wXMawkOkuZhvwuWzaoZMFwyoh6VY7ifl9VotSBnjv3TBcYle+Wo3ta+ExQg==
X-Received: by 2002:a17:902:e5d2:b0:1d0:7c28:f806 with SMTP id u18-20020a170902e5d200b001d07c28f806mr9507684plf.3.1703008013802;
        Tue, 19 Dec 2023 09:46:53 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:53 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 14/17] ACPI: bus: Add acpi_riscv_init function
Date: Tue, 19 Dec 2023 23:15:23 +0530
Message-Id: <20231219174526.2235150-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
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
index b6766bded765..60dc1f1e9351 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1536,6 +1536,12 @@ void acpi_arm_init(void);
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


