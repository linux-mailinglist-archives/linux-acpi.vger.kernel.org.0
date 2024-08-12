Return-Path: <linux-acpi+bounces-7515-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0E94E456
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7971F21F12
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B9A929;
	Mon, 12 Aug 2024 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mwEoQZxj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278EA2B9D3
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424446; cv=none; b=cRWXC1HKuB0XvdH/ff8WfJIsFqXfO9WTonyW2HvIHADP56T1Cs39gTGPVqfyDdkje2leNiet3vFdadqD4Fi+aTKo+tAmxlsDDlglxkXt32slQ75rdRlQ38d7WOxrqsG3ju1QLXCknzrKH1PHHuM0mv1+sEVe1GGfy9tAGdp1PgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424446; c=relaxed/simple;
	bh=RKAOGnY5SFDT70NOv7EmPS7N/KTCn0fTkoDBsaqVdxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPzFmEki1Md7qjUJrd5j9O6u8fkup+ADWciLCz8PTbUWgm2Q6OOraqZknGPzBDsO6EfojJasC9ohNl0ziuS17gv4qaKSlpdf8uUpk12ovNxH0xEEoxqoX+oqBnGFI9MOBsXjbxqg+6zfsyN0xXZlVEtcLUeuItCDws2X0jp39N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mwEoQZxj; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5d0535396so1914479eaf.1
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424444; x=1724029244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbG/jHg21LcLoDzwk6IzVsucBn3jZiDtmvIm1r3v9tk=;
        b=mwEoQZxj1I02s4od1ZXkMlzivk82uZBXh3FxiF3ES5w1nhuk/xVJpRgRlufxX+6kVN
         9AuxFqdkpEyn0BfpnhHyArMErizIJ8XkPjLS1sMW1owggaj5c/XhKnArvn5e0n10w+b7
         xukTMzECjJX1LAnWXQl0aFKBhX+vtbVu1VUT0qIP1Iq0sSLyZE5K0+Mibov3BPUH5pSL
         zYQrsICKT4JuYmEMj5Yzts9Nb4nSDoX/+l4ivogwu9qwziozQu2C7EjyCmvi6M/+7tCs
         PsagMwkkWv9805BPLaYVWiMEAh57HrZGgdgax8x7uVkchD7G4AcAngluptxB2Zvp21po
         AwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424444; x=1724029244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbG/jHg21LcLoDzwk6IzVsucBn3jZiDtmvIm1r3v9tk=;
        b=wI4B5bwRQt2e12VB3lw2wfJShkJhYNQx08ar8Ax9Pt0X0fovoy2AVDiBt0SSsomk/U
         WQRm4CRiwMv3sxl2z7vr07/hHPI/1GtbCm+Mf1L6WouvvSHjyAHH4/nqOdeJ0SulDydq
         Wr8cYQfn/mKrDE90vDlGJQV5QvHBRSfnbSH1t0+bzCxd7GiWXHnYMV3BUpL0orUMcCUA
         qhnU7YSr06vvhrP5AWMQy2NStirYAw7OxD2xjFNNujR8x2E/041s5huN0TPkNJmMMVX9
         xygUcwScHec820pvLFk02bGVwpziNCfruQXUMdCrrqroYiriNNHQknH151tEaUUXs0pf
         6CsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQFxK0mv+wszth5FlpmZj/WJCdc2Mhejf4T+g0ZU3lTrJi4k7A7ebLxsIOtqqwdl4x0KNB3D2A2Dgr65CtI4VxcHNl/kGR1nx8yA==
X-Gm-Message-State: AOJu0Yz2u4DkfPNS5xzJGlrCg//kUknRZ83yuRo0vqK8F91josDgO+zN
	+P1C9xF1WvFJTESsmsfmX2r5rszJ321dq7A8UzmFPA3Ufb4WOqRnkVLTvJR27B8=
X-Google-Smtp-Source: AGHT+IGtpWS7DBc6qnLRa7J1XKsHLrlfePxKw3cHvC5D7SmpvnVph24/oUKeRjRFTeAU1sM99c7TNA==
X-Received: by 2002:a05:6870:1585:b0:260:e7f9:f4e9 with SMTP id 586e51a60fabf-26c62f21db8mr8563110fac.35.1723424444123;
        Sun, 11 Aug 2024 18:00:44 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:43 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
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
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 10/17] ACPI: RISC-V: Implement function to reorder irqchip probe entries
Date: Mon, 12 Aug 2024 06:29:22 +0530
Message-ID: <20240812005929.113499-11-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

On RISC-V platforms, the RINTC structures should be probed before any
other interrupt controller structures and IMSIC before APLIC. This order
is established by using MADT sub table types which are ordered in the
incremental order from the RINTC. So, add the architecture function for
RISC-V to reorder the interrupt controller probing as per the hierarchy
like below.

  ACPI_MADT_TYPE_RINTC = 24,
  ACPI_MADT_TYPE_IMSIC = 25,
  ACPI_MADT_TYPE_APLIC = 26,
  ACPI_MADT_TYPE_PLIC = 27

This means processing all RINTC structures (in the order of appearance
in MADT), followed by IMSIC strucutre and then all APLIC/PLIC
structures.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/irq.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
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
index 000000000000..835eb6eccd53
--- /dev/null
+++ b/drivers/acpi/riscv/irq.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
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
+ * On RISC-V, RINTC structures in MADT should be probed before any other
+ * interrupt controller structures and IMSIC before APLIC. The interrupt
+ * controller subtypes in MADT of ACPI spec for RISC-V are defined in
+ * the incremental order like RINTC(24)->IMSIC(25)->APLIC(26)->PLIC(27).
+ * Hence, simply sorting the subtypes in incremental order will
+ * establish the required order.
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
2.43.0


