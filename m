Return-Path: <linux-acpi+bounces-995-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 193377D75CD
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82713B20B09
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80AF3418A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZPLmnXDK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE7328DD
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:25:16 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF961D4F
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-694ed847889so129877b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265507; x=1698870307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxzCTJ+m1lwBq+RMy/cftySc6UneYPqTwJF8JhbniDw=;
        b=ZPLmnXDKPZLMM7hvckqFB2ntxJxslVmafoVfCnIBGcAkzqfeTNJuG9pmeNldNV76HJ
         0HpfULSlA8evJEUByNoND/DmGd3FIeaXHbNI1pxyaqpjdaY4X3tF7H0XvCO9qvP1Drng
         cbIwFP8L62WWzSzWSKl4P/oK3fD1+t28RoGlCUrH1AlKHXUUbBdVGphLg2lo73kpxRv4
         xITjhtKRagCg+enUe+XhHCl23XZovrVZ9wWYR7+bzcUc8nXi7UrjAhUm2JqsVuCKnIAA
         R2qdeVwXrTTqZ+XRyU3kDZDy0ksm1dhBzVS0snoB8lC2C9/KjyPCnDY29sZPMsD3qGZw
         pqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265507; x=1698870307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxzCTJ+m1lwBq+RMy/cftySc6UneYPqTwJF8JhbniDw=;
        b=h17N6jBSIHUR4Fz6P+lIBPi6V6xvYl2Jb3Uca5cBDxGTNuSgl3oZK3dGkyuZ5t4sW2
         IH4ebzBXgXRJK2G/wcvl7Yl9nLrpwRuYaNmHJeP1JrC9FcWwaAjvZhV/ToL0m1D5FxAd
         U02XGF6a2objrxW3NcGHdnUSc8iiAWFUn/mW/jFdBQcY5SxDigthJIubkYxBjUbABKm9
         Yy386VnEHMKI0CxKtZNdsj4Hmxrf84jURJXAxiU+nnO2e33W56V6Wiv4Lt2CJkg6KGG1
         c9bdgamoulnJ9Kmgc5zL15pKrjikueUf+mJOzB3P5iH/zh2D7qq+pMo9KPPOkQUw2HwQ
         NUQw==
X-Gm-Message-State: AOJu0YzZAf0FXwAaERfYyY4nX3yyHX0ExHDlPu8LDeliCp9bV0m/uuE7
	JQcqsFLoDAXYKs/N7OH3l9eTDw==
X-Google-Smtp-Source: AGHT+IFKGK+9x6obxjzCs3/eR+3q/3iIQzNNW6EXTTk1GAvemcOrYvQgO6IFBiNDzQzfVY0iJ8I2bw==
X-Received: by 2002:a05:6a00:2d91:b0:690:d4fa:d43d with SMTP id fb17-20020a056a002d9100b00690d4fad43dmr14404404pfb.6.1698265506987;
        Wed, 25 Oct 2023 13:25:06 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:06 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/21] ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
Date: Thu, 26 Oct 2023 01:53:33 +0530
Message-Id: <20231025202344.581132-11-sunilvl@ventanamicro.com>
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

ACPI MADT entries for interrupt controllers don't have a way to describe
the hierarchy. However, the hierarchy is known to the architecture and
on RISC-V platforms, the MADT sub table types are ordered in the
incremental order from the root controller which is RINTC. So, add
architecture function for RISC-V to reorder the interrupt controller
probing as per the hierarchy as below.

RINTC->IMSIC->APLIC->PLIC

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/irq.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/irq.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 8b3b126e0b94..f80b3da230e9 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y 	+= rhct.o
+obj-y 	+= rhct.o irq.o
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
new file mode 100644
index 000000000000..36e0525b3235
--- /dev/null
+++ b/drivers/acpi/riscv/irq.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/sort.h>
+
+static int irqchip_cmp_func(const void *in0, const void *in1)
+{
+	struct acpi_probe_entry *elem0 = (struct acpi_probe_entry *)in0;
+	struct acpi_probe_entry *elem1 = (struct acpi_probe_entry *)in1;
+
+	return (elem0->type > elem1->type) - (elem0->type < elem1->type);
+}
+
+/*
+ * RISC-V irqchips in MADT of ACPI spec are defined in the same order how
+ * they should be probed. Since IRQCHIP_ACPI_DECLARE doesn't define any
+ * order, this arch function will reorder the probe functions as per the
+ * required order for the architecture.
+ */
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
+{
+	struct acpi_probe_entry *ape = ap_head;
+
+	if (nr == 1 || !ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id))
+		return;
+	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
+}
-- 
2.39.2


