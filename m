Return-Path: <linux-acpi+bounces-7508-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D0494E447
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A694281E55
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D4C6FC1;
	Mon, 12 Aug 2024 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ivTerrKN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632610A11
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424402; cv=none; b=ppsvI8MdsaBLKP5veD+uTROumCON+FhFGbrzU1n9ACiVI2Du2wZ4LWgV9DaPcNQ6aNrJTZlEwu0owh1A4FIFtMEnUb0Pqwl6gMeF4VOI99o6/usRq+GbkI0lODwRrIV5QeRl4gRwuw1OKNA38OYTIPR2KLNUvzkxEXGyQaUSPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424402; c=relaxed/simple;
	bh=/NjNF2gM7TvKKHeRf2SUhc4H3zCep0Sq72OK0O5um8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbj0dUofDu/XcH2yC9LJnxPpSK2DbMjNMvKos09FJm/MXucND585jj2H2HtZPfDcpyFKqhyOXTMJdw91r16mFNlRggv5Bx38TSJF5HYRQtVZDwH8HyMWIBum8hGCw5TAqA1SfUCO900sP0pFbG5kJqO/O6n8hOUKCkVRxoEPeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ivTerrKN; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7094641d4e6so1876958a34.3
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424400; x=1724029200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH+4pIB9prP9kOEprexbBfphBFyJQXg0yq2xsmagq1s=;
        b=ivTerrKNNS6WArC5x33F/kCeZPN5TzZe/Ir6m3js0N7gW5mNsEqnnXvkz4B+5n7kk0
         lWSCZ69kwuVYIv7/TtNBu5q5JQUWOTd0TgpVr9mGW3LMQXw3G3Ax7BymOheqMySmzitE
         M1OWrJ1F1906ltefFffZW11duYc5+AlpAUqtC2ZqmJecDRxoP33Kr+V2upaefQ1KK5tc
         IOtfTbyBDG43QG6ZP5wN8fqK+wpaGSkHw6YXXz4HoHSDpqU44G06WVfk/zh14pvX3GuA
         le4DPF4SPkfX8nhELfo5i7+/na2evVuHgKBDgtuNtBAEuAsTrjosVFL/Gs6tL1ptMAr1
         bGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424400; x=1724029200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH+4pIB9prP9kOEprexbBfphBFyJQXg0yq2xsmagq1s=;
        b=K4cWvbH3aVCaYPl5jGjV8JtHKEEXSTIZ84V0gBFcsC3T2gHB7nVtSkMJckMHhdr1Xg
         lbFyPW7fuHOnM8s+tCQ3aclZq/2+Fci7Dp5HSq88cFlasPjBsymjKlbyo6eO0oQ3R8Ny
         /hhl1hSUn0I0sj4W/k+BWPDtmtVyUl5tef8hmqz6QzzPRQS94KSPCPf0bTpEhEbOIpii
         QBKuFRZVfuFJbBxrKb/mBPT2qlu8dgKXE3u5EzQmCrC5JH9vK4K5uO1v1CVkO6zhT3J8
         7D/3MJU0o51T57opzDmd0ir3+jBMrmm2S7y6SbDO5W9HeH3f2c7AMEe2b1T1fwFE8esI
         p1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCSA9w2NwFqxf7PU/z+BWCRacTtwBhYn7t56rtKVc7MjEZo8PxlLdkZ9+raXH61raPYWlvczPJRy8FTZwowJKrfrDKUV8mhy3X1A==
X-Gm-Message-State: AOJu0Yw4aDSRxBDeKDGJbTRsAewWhyt+BZSBBmPRXpgAXQCrZh+JTzVL
	LGwKyDUaBWv+9wP1/aQb8WlbJXbFyauzs7Rwq1KnywASMBUJycjl6x8hT8pwNEI=
X-Google-Smtp-Source: AGHT+IHrAlknP9L5C6h6kRrSytyVyD8ukh4CBeZCWs5vO7PGS1mxPUN26YUu6El93VBg0yE0hzkTrQ==
X-Received: by 2002:a05:6830:6c0f:b0:708:8c07:c646 with SMTP id 46e09a7af769-70b748745c5mr11624369a34.33.1723424400027;
        Sun, 11 Aug 2024 18:00:00 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.17.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:59:59 -0700 (PDT)
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
Subject: [PATCH v8 03/17] ACPI: bus: Add acpi_riscv_init() function
Date: Mon, 12 Aug 2024 06:29:15 +0530
Message-ID: <20240812005929.113499-4-sunilvl@ventanamicro.com>
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

Add a new function for RISC-V to do architecture specific initialization
similar to acpi_arm_init(). Some of the ACPI tables are architecture
specific and there is no reason trying to find them on other
architectures. So, add acpi_riscv_init() similar to acpi_arm_init().

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 11 +++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/init.c

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 284bc2e03580..48d277657203 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1459,6 +1459,7 @@ static int __init acpi_init(void)
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
index 000000000000..a875a76aa44c
--- /dev/null
+++ b/drivers/acpi/riscv/init.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ */
+
+#include <linux/acpi.h>
+
+void __init acpi_riscv_init(void)
+{
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3fff86f95c2f..892025d873f0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1531,6 +1531,12 @@ void acpi_arm_init(void);
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
2.43.0


