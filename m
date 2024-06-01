Return-Path: <linux-acpi+bounces-6125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A498D70AF
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C151F24611
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2024 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C311154449;
	Sat,  1 Jun 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YRPUBAwz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F2153560
	for <linux-acpi@vger.kernel.org>; Sat,  1 Jun 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254335; cv=none; b=kZUMybHcm4UfmeJ3jjeQ/jUzyO7d0tLcp8yUKa4Ohlq1J96AiUPJ+2mtbF6BcKTplE+sQuBTNUu8XYHXSO1lQJh2a3xzYOkYYn94PEIUDDBLqvSbN590VLs3PiUR8JJkc17z+hqnAOCetxN1+iAUCiKMUfKv9hfgQzdpkzU7s0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254335; c=relaxed/simple;
	bh=WZ0YdhfhgqeeWdtO9JpwOCiBLPkx/74G9wavBJNzooo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ou7tPJAR9R28FBqzw+LM1rIaEms6C6mA75gkxzEEYTS5y/SeowLN7P3IgJtnThBXL0m9iEsWZ8GfVPQ/YA+pkfiRSmiy/FrzLAXeFkQcugdAh1Q1vkFuXwhXqpb5Piy3+txFiCUgGPQ1qzmrtY6zaOHb8X5gvF3e2wZ0nN3qZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YRPUBAwz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-702621d8725so62481b3a.0
        for <linux-acpi@vger.kernel.org>; Sat, 01 Jun 2024 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254332; x=1717859132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xxd/snqLqM7e5ONTmxzheAfPAEAmi9DZ2uBd4oJ/FYs=;
        b=YRPUBAwz6CSjNyy1Y2lg+liZZGrhR/Zcw0J0HPcJjJR43oEyp8ibnDvicf8DdNO8xR
         Jt7eyuqfB8WS60zg5jEA2sp4tGDBRSZLCe8/uLlNtd8cqnt2ZlP38V3oRPQliY+3b3ex
         aLuHdNfMySxKwGO0enVmozlu7pp82TGlfShpMhoe+dm5AoWbFxbMRyg/rRDI/ydwiaGe
         DQbdPQHfhykvmNf/JIpOU+ls/hu6b11Kyy5hgPcCO95xg7X8D9QJzWm0+bhWqDMWfeTd
         GcP9W0Hsk9E704wYieJiULKOeKX234UyGn3Kncv6bxGpeOxHOJanWhD7TQfjXPm94IWH
         ysmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254332; x=1717859132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxd/snqLqM7e5ONTmxzheAfPAEAmi9DZ2uBd4oJ/FYs=;
        b=ZdPJVa80JZ3uHWdTRd+EJG/PPOoSe83kJIySII3U7ChCpeyWNSyeXPWX4OrkMBdwFH
         fQlEDrPOGa4ctdVUk8n7tZU5OUgGOFe6Au+MqZXa+CgqYLV3EBrvitO2VYhKNzr88UO1
         daFDuIHMrNRDWNQZcAcWGX99ATXv7ZADBFrlgDe6efCoZ859yrxYPeuVGdmvv9A9IhWB
         Q7hAGnrrJCP/9FahaUISAbSSrD4XXUDYJ589VPSwhqhqVa0OuTN3I9TnOrAIziwtAphB
         dIWocfPgiQVpHNRMgzmTGrI+vFoHge1xtDEFwjfGEZ5I7U/z6S64aEc2+F6h94FB8ySo
         9oqA==
X-Forwarded-Encrypted: i=1; AJvYcCV1dOW5Q0SwHWNfvRIP+olzsQL7aSOO+iN6gIadbffbU+vqC+PZfbEo2HiQcS6pJNY9t7Zbe12vlB/yWmLTYvkgOvvOPLyWQkMOTQ==
X-Gm-Message-State: AOJu0YxS5BAldh4RzNb58LDqzRQ7BzfHdRIYvpGzag8jtRrkwHN6rhF2
	FVMjrV5pnCoWOsRZrThZ+HXJvJ1vRBInSi0JsRJ+wISa7EKF/nerzOSQ0ZSqoyw=
X-Google-Smtp-Source: AGHT+IFZLKdJXzy6Jd5qCfRWhIlRvV4goiwxMiN4v1BoHBszSCe89m9zjL1yy7W4W+xKrhKM387PnA==
X-Received: by 2002:a05:6a00:2d11:b0:6f8:ddfe:8fc4 with SMTP id d2e1a72fcca58-70247803d99mr5506971b3a.19.1717254332202;
        Sat, 01 Jun 2024 08:05:32 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:31 -0700 (PDT)
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
Subject: [PATCH v6 10/17] ACPI: RISC-V: Implement function to reorder irqchip probe entries
Date: Sat,  1 Jun 2024 20:34:04 +0530
Message-Id: <20240601150411.1929783-11-sunilvl@ventanamicro.com>
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

ACPI MADT entries for interrupt controllers don't have a way to describe
the hierarchy. However, the hierarchy is known to the architecture and
on RISC-V platforms, the MADT sub table types are ordered in the
incremental order from the root controller which is RINTC. So, add
architecture function for RISC-V to reorder the interrupt controller
probing as per the hierarchy as below.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/irq.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/irq.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 877de00d1b50..a96fdf1e2cb8 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o init.o
+obj-y					+= rhct.o init.o irq.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
new file mode 100644
index 000000000000..f56e103a501f
--- /dev/null
+++ b/drivers/acpi/riscv/irq.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
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
2.40.1


