Return-Path: <linux-acpi+bounces-2929-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775188312B9
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jan 2024 07:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1751C2183C
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jan 2024 06:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3889444;
	Thu, 18 Jan 2024 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P6/AfooF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F852BE7F
	for <linux-acpi@vger.kernel.org>; Thu, 18 Jan 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559393; cv=none; b=jCclTdBycDKITgvf5/UwoqVpyIPRaj9LejZyCg7zkC80yXoBRjT5ygwQsLcb0aFY3WPirQFWFbPOGqoZINOEDRloV39bIf7vHhWMtMVLLNiAW8Iry/lHMrkOdrU6K2uyPLgjctBSf7sPiyjw3rqyQ246TpGPbNcGMkYBCPrSoIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559393; c=relaxed/simple;
	bh=pwEogATDnqJCM9ezt5ZHVJ0B7PUv/0/V4PqFK6Nh9zg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=b5cqZRhzqSXeZQqEdvit3RrDBxjmjyUB5B/3iLmw+QTde8RwBb7y9UTErXrJhwoYVn6SeiBe1v1sJuXOYQbtead8Pp38rbxrUo8w1k5t7Mj94f6KLvhil+0YjPdU/XfcJJOzn1N3lYQUU7k5k7unlkul2o8fnmWX/CSo0oBpEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=P6/AfooF; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36199ab6e68so1092325ab.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jan 2024 22:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705559391; x=1706164191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgHlTEiNO6+vqShPGvlPveCet3Ph0raIL9TM7VU3mgo=;
        b=P6/AfooFmxhkhn/6ket0S1LTDr6QOL7GESDNNe23CGEA8wSyy7t3sCrigz54NyHX96
         yudK3lodAw0AlgAcvIJX/fsXhuOZnZMhHTZUjq9QOqQj3W3qH5mk4HIBGCZPA/gsMgqm
         6vQlF7HvnioXLkvCt2exsJnTc07TtKJWaTcmfm0bFLD9xDoxTdREXhhrmpi0PGUAQaP0
         G3h5yc/RI488q1WCAiJtDkclIMUMJoOXNSvZAxxfdxaysVKeHNHfjNFzRuKx7C7RvMn0
         ukULigBlkxJaLJZ7poafB1IBz17UnjrstQrRLiJ0ZA/MP1xB/AjDFv69c5B/PhUOCYBT
         Yw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705559391; x=1706164191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgHlTEiNO6+vqShPGvlPveCet3Ph0raIL9TM7VU3mgo=;
        b=uyGkdaJIyS7jHElcsiDyFWvKG9FDDykck1g1pdmHfyqa2k/4SpBAudNibwLOcrCQJj
         F6raRt5u4JPo2KG6A8NQJkmYW/1B6x+/jquMKPt4WRV3ZZVh2p3tWtb0urAfXLVFHaGv
         Ufw1CK9hf6GLn3BUGCV7rz0xvYpHCTTPgNHsrq2vPQ4IN934wrxYQRXbuwWWbALUPkvX
         J911wNMxrvYY/dtIRW8Leou3qr7u65XZeEFph5DWROm3lNJGNlQuOetUH5foXniNEsyd
         zxMSEjXb3DvWQshrZoGxK8lLa5IFsVdTLa10Va0MQhvI3rP2Sie7MwcyxI/vnRQ7Wjn5
         d8IQ==
X-Gm-Message-State: AOJu0YyfYhFZ4xX7EYvyeNPGPjxisJT+rBZxrENoHZ3LqzquxNwle//N
	unBfS/St/PyrUrTTlxznyvVBbWHm+UC9mvyCFB9L9TmWjMDNUPOFcZfbSVsBUaM=
X-Google-Smtp-Source: AGHT+IFETAZr/4ad3B4EwfQVE+FVlxvx+ZOvCXHmAbfDCoL+OF3DGuwNs6BKA5BEslZBuE07E9VXrQ==
X-Received: by 2002:a05:6e02:80b:b0:360:17a7:d88b with SMTP id u11-20020a056e02080b00b0036017a7d88bmr409483ilm.9.1705559391483;
        Wed, 17 Jan 2024 22:29:51 -0800 (PST)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id bn28-20020a056e02339c00b0035fec699584sm4663269ilb.13.2024.01.17.22.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 22:29:51 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 -next 2/3] ACPI: RISC-V: Add LPI driver
Date: Thu, 18 Jan 2024 11:59:29 +0530
Message-Id: <20240118062930.245937-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118062930.245937-1-sunilvl@ventanamicro.com>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Low Power Idle (LPI) based cpuidle driver for RISC-V platforms.
It depends on SBI HSM calls for idle state transitions.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile  |  3 +-
 drivers/acpi/riscv/cpuidle.c | 81 ++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/cpuidle.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 8b3b126e0b94..7309d92dd477 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y 	+= rhct.o
+obj-y					+= rhct.o
+obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
diff --git a/drivers/acpi/riscv/cpuidle.c b/drivers/acpi/riscv/cpuidle.c
new file mode 100644
index 000000000000..624f9bbdb58c
--- /dev/null
+++ b/drivers/acpi/riscv/cpuidle.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <acpi/processor.h>
+#include <linux/cpu_pm.h>
+#include <linux/cpuidle.h>
+#include <linux/suspend.h>
+#include <asm/cpuidle.h>
+#include <asm/sbi.h>
+#include <asm/suspend.h>
+
+#define RISCV_FFH_LPI_TYPE_MASK	GENMASK_ULL(63, 60)
+#define RISCV_FFH_LPI_RSVD_MASK	GENMASK_ULL(59, 32)
+
+#define RISCV_FFH_LPI_TYPE_SBI	BIT_ULL(60)
+
+static int acpi_cpu_init_idle(unsigned int cpu)
+{
+	int i;
+	struct acpi_lpi_state *lpi;
+	struct acpi_processor *pr = per_cpu(processors, cpu);
+
+	if (unlikely(!pr || !pr->flags.has_lpi))
+		return -EINVAL;
+
+	if (!riscv_sbi_hsm_is_supported())
+		return -ENODEV;
+
+	if (pr->power.count <= 1)
+		return -ENODEV;
+
+	for (i = 1; i < pr->power.count; i++) {
+		u32 state;
+
+		lpi = &pr->power.lpi_states[i];
+
+		/*
+		 * Validate Entry Method as per FFH spec.
+		 * bits[63:60] should be 0x1
+		 * bits[59:32] should be 0x0
+		 * bits[31:0] represent a SBI power_state
+		 */
+		if (((lpi->address & RISCV_FFH_LPI_TYPE_MASK) != RISCV_FFH_LPI_TYPE_SBI) ||
+		    (lpi->address & RISCV_FFH_LPI_RSVD_MASK)) {
+			pr_warn("Invalid LPI entry method %#llx\n", lpi->address);
+			return -EINVAL;
+		}
+
+		state = lpi->address;
+		if (!riscv_sbi_suspend_state_is_valid(state)) {
+			pr_warn("Invalid SBI power state %#x\n", state);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int acpi_processor_ffh_lpi_probe(unsigned int cpu)
+{
+	return acpi_cpu_init_idle(cpu);
+}
+
+int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+{
+	u32 state = lpi->address;
+
+	if (state & SBI_HSM_SUSP_NON_RET_BIT)
+		return CPU_PM_CPU_IDLE_ENTER_PARAM(riscv_sbi_hart_suspend,
+						   lpi->index,
+						   state);
+	else
+		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(riscv_sbi_hart_suspend,
+							     lpi->index,
+							     state);
+}
-- 
2.34.1


