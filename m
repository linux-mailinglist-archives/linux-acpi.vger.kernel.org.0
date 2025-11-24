Return-Path: <linux-acpi+bounces-19207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F82C802F8
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 12:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 657D4344B8B
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF792FD67A;
	Mon, 24 Nov 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VeAXF8Kl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E22FB0B3
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983254; cv=none; b=l89orANvsEyZirnzG1eSudloM2JCjNdJrf2/hkyk92wlC1wCq60EV6rGcWXAejuQHNwSfECjfqn4nC726prn8sGP4K0/JDmuekq/o8qsQTyPqkJvGg9ETZDJvlTShVaEbVXLW9Pibeo3RXtHuRDO5F+1Ldg24P3Adu2EuXGKIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983254; c=relaxed/simple;
	bh=7YEJgLhLHBGOy3C+JL6TJ+KzLv0HYHqzTuQIusjVZko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk6Q9E4sLH2Zl133r2vkXV9D1ANtskseha4DhOtiVNlsgAKhq0JPIEkhjYqidwRSb9pSRC5BTnKOPPEfl06ziMGZuH/6T9GZrkonQsyLUEYb/qAsaD2JDju9DRZsj0eTdl0bFf0i8hFb6WC+hPnSlX2D3ofbSFUZ2ZipSUt/EwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VeAXF8Kl; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b80fed1505so4744169b3a.3
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1763983252; x=1764588052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/YH3INfZNi/7p/HTvSIMTi1amPfSFCL3YAc5kVlwhA=;
        b=VeAXF8KlwUmt2O3iclhwvZJwsUbIiJlNXGn+LVkW1FQ2VKfBkbhUITVH6Jz8dnakYq
         g1NIAX+e87Lr1VYpPIK7FCXpVADXCC5vwF6oJdKDeM6yzayNkkX2rg+z7vbAl94sa3+V
         eVOCRN1OTkZ8BJgMBjxVo0vkjuoTF6IVXTbmqVM1urHLoVq1rL1h4r/oumc0Cv/KXY0I
         xceCi1029jk5ryHhadU6V8DAyQTzVGA7/cyBGz8Wd5CP8OGm/dxLvV3OL+Haij7z8GXs
         XVHS0ShEEnUyewaL3MYncBdMM1pV2MfC+3LzWeiVPtBluYtfNXF8mjFNY9icmazzy4Vk
         +KzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763983252; x=1764588052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/YH3INfZNi/7p/HTvSIMTi1amPfSFCL3YAc5kVlwhA=;
        b=nfjImuZHQitrlBJcgqQzm1XKPVfb6qGAWdCWM+/MVso4706ApZbrk53x3mWnuT2TOL
         7VWzXssLqij+pfVWOmDEtUiOLNElfDT0fvkZ/KgOh/ZnsLa6s154v6lOd6WGzEamrtBN
         LH70iEq9OPAkIfy0/lSBycMWgtm8HfTZgI/LEo5DraCmO5EUqQs7dzo/SQSRA04oip43
         5iE7fPKF79PU11OuyGBlKYoyBCu5BX/Xd8PP09IMbDeiEEBgaRdAWqGR/LO5DILZrnZZ
         hr4JfayPLFDfGP+2Sts/048TwIL7gbqDCV33C50z3GZYoC5BzL1AaPrAbJsQCrOBUAr0
         nOhw==
X-Forwarded-Encrypted: i=1; AJvYcCWBNjsoD+Id/12bG7D6FVwyM4a+mJ0MsqjG1GV9Q8gBW3YS/GRwYfmVNy6VNdFMkAEQiH36LX5ECMK2@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqZaOOu14UnVGxL9h5oChGbQhuOc5BgufUdyj5va63K+xRk6u
	MdvODGFWK2+J5nE2h9r+3C3VzkXovmNFRF8uO9h8eCPvnJWlTJ2zFVggbjZOWNNc3Og=
X-Gm-Gg: ASbGncsa+OVG6/RXkJfpf8PeIq8DLsvZCuflx8coZ5iCAK9jVVpHH9cxh2e89L3oanD
	HmdmDoOSSOVbkuqFVSwlx85my08/JyyBqbDRwMKAiwATu9rvCB9hLWhJMpNiEJI+4jps3tHoo7e
	tPmh5sLufdx3MQiJWH5DTIRu8rtEIEKiaDbclbDKrC29HhKEQtLPIbcIf+cJByBKiw93Q6r+WhZ
	kLYnZil8C17VQyBTuqC+hh8EpF4POQYcc4eu3FQZj1kupJGsSXKMqMsT+Em/8T56cxGc9XaJl9X
	vfxzCyHDDjDISn0eUjNzb+84l8LcU5dQCU6VIevs3mbybm/zvsD1LdhnU0ozhIjKRZPYk1k3mhB
	vQT/1IerXqbPiM5U8hiB98PkC9NjLddaDfA4hrydZuUeQtByEUFokGqZCkgsCRqbKxIp+gQT+NA
	Qjhm17pfj9gfrxAP+p254JZGlyn2genR1JsQGp/28nFNlI8vxAeXaKEHtq/A/O
X-Google-Smtp-Source: AGHT+IGZGc3tWp0Um2bSR9nPt8eF9mAT3BnGUwU4ZEsTkum1UKRRw1zIfPBpILMyiu8F/1dNSsfjKA==
X-Received: by 2002:a05:7022:1a86:b0:11b:b179:6e17 with SMTP id a92af1059eb24-11c9d8635b1mr7391262c88.34.1763983251251;
        Mon, 24 Nov 2025 03:20:51 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e5674csm68207847c88.8.2025.11.24.03.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:20:50 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v4 1/1] RISC-V: Add common csr_read_num() and csr_write_num() functions
Date: Mon, 24 Nov 2025 16:50:31 +0530
Message-ID: <20251124112031.170350-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124112031.170350-1-apatel@ventanamicro.com>
References: <20251124112031.170350-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RISC-V, there is no CSR read/write instruction which takes CSR
number via register so add common csr_read_num() and csr_write_num()
functions which allow accessing certain CSRs by passing CSR number
as parameter. These common functions will be first used by the
ACPI CPPC driver and RISC-V PMU driver.

Also, the RISC-V ACPI FFH specification allows arbitrary CSR number
as CPPC register and the RISC-V SBI specification allows arbitrary
CSR number as PMU hardware counter. This means ACPI CPPC driver and
RISC-V PMU driver no longer need to do sanity checks on CSR number
which are now done by the common csr_read_num() and csr_write_num()
functions.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  17 ++--
 drivers/perf/riscv_pmu.c     |  54 ++----------
 5 files changed, 184 insertions(+), 56 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 4a37a98398ad..543a3364f11d 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -575,6 +575,9 @@
 			      : "memory");			\
 })
 
+unsigned long csr_read_num(unsigned long csr_num, int *out_err);
+void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_RISCV_CSR_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f60fce69b725..a75e79192531 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y	+= soc.o
 obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
 obj-y	+= cpu.o
 obj-y	+= cpufeature.o
+obj-y	+= csr.o
 obj-y	+= entry.o
 obj-y	+= irq.o
 obj-y	+= process.o
diff --git a/arch/riscv/kernel/csr.c b/arch/riscv/kernel/csr.c
new file mode 100644
index 000000000000..e96b129c1a99
--- /dev/null
+++ b/arch/riscv/kernel/csr.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Ventana Micro Systems Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <asm/csr.h>
+
+#define CSR_CUSTOM0_U_RW_BASE		0x800
+#define CSR_CUSTOM0_U_RW_COUNT		0x100
+
+#define CSR_CUSTOM1_U_RO_BASE		0xCC0
+#define CSR_CUSTOM1_U_RO_COUNT		0x040
+
+#define CSR_CUSTOM2_S_RW_BASE		0x5C0
+#define CSR_CUSTOM2_S_RW_COUNT		0x040
+
+#define CSR_CUSTOM3_S_RW_BASE		0x9C0
+#define CSR_CUSTOM3_S_RW_COUNT		0x040
+
+#define CSR_CUSTOM4_S_RO_BASE		0xDC0
+#define CSR_CUSTOM4_S_RO_COUNT		0x040
+
+#define CSR_CUSTOM5_HS_RW_BASE		0x6C0
+#define CSR_CUSTOM5_HS_RW_COUNT		0x040
+
+#define CSR_CUSTOM6_HS_RW_BASE		0xAC0
+#define CSR_CUSTOM6_HS_RW_COUNT		0x040
+
+#define CSR_CUSTOM7_HS_RO_BASE		0xEC0
+#define CSR_CUSTOM7_HS_RO_COUNT		0x040
+
+#define CSR_CUSTOM8_M_RW_BASE		0x7C0
+#define CSR_CUSTOM8_M_RW_COUNT		0x040
+
+#define CSR_CUSTOM9_M_RW_BASE		0xBC0
+#define CSR_CUSTOM9_M_RW_COUNT		0x040
+
+#define CSR_CUSTOM10_M_RO_BASE		0xFC0
+#define CSR_CUSTOM10_M_RO_COUNT		0x040
+
+unsigned long csr_read_num(unsigned long csr_num, int *out_err)
+{
+#define switchcase_csr_read(__csr_num)				\
+	case (__csr_num):					\
+		return csr_read(__csr_num)
+#define switchcase_csr_read_2(__csr_num)			\
+	switchcase_csr_read(__csr_num + 0);			\
+	switchcase_csr_read(__csr_num + 1)
+#define switchcase_csr_read_4(__csr_num)			\
+	switchcase_csr_read_2(__csr_num + 0);			\
+	switchcase_csr_read_2(__csr_num + 2)
+#define switchcase_csr_read_8(__csr_num)			\
+	switchcase_csr_read_4(__csr_num + 0);			\
+	switchcase_csr_read_4(__csr_num + 4)
+#define switchcase_csr_read_16(__csr_num)			\
+	switchcase_csr_read_8(__csr_num + 0);			\
+	switchcase_csr_read_8(__csr_num + 8)
+#define switchcase_csr_read_32(__csr_num)			\
+	switchcase_csr_read_16(__csr_num + 0);			\
+	switchcase_csr_read_16(__csr_num + 16)
+#define switchcase_csr_read_64(__csr_num)			\
+	switchcase_csr_read_32(__csr_num + 0);			\
+	switchcase_csr_read_32(__csr_num + 32)
+#define switchcase_csr_read_128(__csr_num)			\
+	switchcase_csr_read_64(__csr_num + 0);			\
+	switchcase_csr_read_64(__csr_num + 64)
+#define switchcase_csr_read_256(__csr_num)			\
+	switchcase_csr_read_128(__csr_num + 0);			\
+	switchcase_csr_read_128(__csr_num + 128)
+
+	*out_err = 0;
+	switch (csr_num) {
+	switchcase_csr_read_32(CSR_CYCLE);
+	switchcase_csr_read_32(CSR_CYCLEH);
+	switchcase_csr_read_256(CSR_CUSTOM0_U_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM1_U_RO_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM2_S_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM3_S_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM4_S_RO_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM5_HS_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM6_HS_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM7_HS_RO_BASE);
+#ifdef CONFIG_RISCV_M_MODE
+	switchcase_csr_read_64(CSR_CUSTOM8_M_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM9_M_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM10_M_RO_BASE);
+#endif
+	default:
+		*out_err = -EINVAL;
+		break;
+	}
+
+	return 0;
+#undef switchcase_csr_read_256
+#undef switchcase_csr_read_128
+#undef switchcase_csr_read_64
+#undef switchcase_csr_read_32
+#undef switchcase_csr_read_16
+#undef switchcase_csr_read_8
+#undef switchcase_csr_read_4
+#undef switchcase_csr_read_2
+#undef switchcase_csr_read
+}
+EXPORT_SYMBOL_GPL(csr_read_num);
+
+void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err)
+{
+#define switchcase_csr_write(__csr_num, __val)			\
+	case (__csr_num):					\
+		csr_write(__csr_num, __val);			\
+		break
+#define switchcase_csr_write_2(__csr_num, __val)		\
+	switchcase_csr_write(__csr_num + 0, __val);		\
+	switchcase_csr_write(__csr_num + 1, __val)
+#define switchcase_csr_write_4(__csr_num, __val)		\
+	switchcase_csr_write_2(__csr_num + 0, __val);		\
+	switchcase_csr_write_2(__csr_num + 2, __val)
+#define switchcase_csr_write_8(__csr_num, __val)		\
+	switchcase_csr_write_4(__csr_num + 0, __val);		\
+	switchcase_csr_write_4(__csr_num + 4, __val)
+#define switchcase_csr_write_16(__csr_num, __val)		\
+	switchcase_csr_write_8(__csr_num + 0, __val);		\
+	switchcase_csr_write_8(__csr_num + 8, __val)
+#define switchcase_csr_write_32(__csr_num, __val)		\
+	switchcase_csr_write_16(__csr_num + 0, __val);		\
+	switchcase_csr_write_16(__csr_num + 16, __val)
+#define switchcase_csr_write_64(__csr_num, __val)		\
+	switchcase_csr_write_32(__csr_num + 0, __val);		\
+	switchcase_csr_write_32(__csr_num + 32, __val)
+#define switchcase_csr_write_128(__csr_num, __val)		\
+	switchcase_csr_write_64(__csr_num + 0, __val);		\
+	switchcase_csr_write_64(__csr_num + 64, __val)
+#define switchcase_csr_write_256(__csr_num, __val)		\
+	switchcase_csr_write_128(__csr_num + 0, __val);		\
+	switchcase_csr_write_128(__csr_num + 128, __val)
+
+	*out_err = 0;
+	switch (csr_num) {
+	switchcase_csr_write_256(CSR_CUSTOM0_U_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM2_S_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM3_S_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM5_HS_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM6_HS_RW_BASE, val);
+#ifdef CONFIG_RISCV_M_MODE
+	switchcase_csr_write_64(CSR_CUSTOM8_M_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM9_M_RW_BASE, val);
+#endif
+	default:
+		*out_err = -EINVAL;
+		break;
+	}
+#undef switchcase_csr_write_256
+#undef switchcase_csr_write_128
+#undef switchcase_csr_write_64
+#undef switchcase_csr_write_32
+#undef switchcase_csr_write_16
+#undef switchcase_csr_write_8
+#undef switchcase_csr_write_4
+#undef switchcase_csr_write_2
+#undef switchcase_csr_write
+}
+EXPORT_SYMBOL_GPL(csr_write_num);
diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 42c1a9052470..fe491937ed25 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -65,24 +65,19 @@ static void sbi_cppc_write(void *write_data)
 static void cppc_ffh_csr_read(void *read_data)
 {
 	struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
+	int err;
 
-	switch (data->reg) {
-	/* Support only TIME CSR for now */
-	case CSR_TIME:
-		data->ret.value = csr_read(CSR_TIME);
-		data->ret.error = 0;
-		break;
-	default:
-		data->ret.error = -EINVAL;
-		break;
-	}
+	data->ret.value = csr_read_num(data->reg, &err);
+	data->ret.error = err;
 }
 
 static void cppc_ffh_csr_write(void *write_data)
 {
 	struct sbi_cppc_data *data = (struct sbi_cppc_data *)write_data;
+	int err;
 
-	data->ret.error = -EINVAL;
+	csr_write_num(data->reg, data->val, &err);
+	data->ret.error = err;
 }
 
 /*
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 7644147d50b4..b41f353ba964 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/sched_clock.h>
 
+#include <asm/csr.h>
 #include <asm/sbi.h>
 
 static bool riscv_perf_user_access(struct perf_event *event)
@@ -88,58 +89,21 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_short = 1;
 }
 
-static unsigned long csr_read_num(int csr_num)
-{
-#define switchcase_csr_read(__csr_num, __val)		{\
-	case __csr_num:					\
-		__val = csr_read(__csr_num);		\
-		break; }
-#define switchcase_csr_read_2(__csr_num, __val)		{\
-	switchcase_csr_read(__csr_num + 0, __val)	 \
-	switchcase_csr_read(__csr_num + 1, __val)}
-#define switchcase_csr_read_4(__csr_num, __val)		{\
-	switchcase_csr_read_2(__csr_num + 0, __val)	 \
-	switchcase_csr_read_2(__csr_num + 2, __val)}
-#define switchcase_csr_read_8(__csr_num, __val)		{\
-	switchcase_csr_read_4(__csr_num + 0, __val)	 \
-	switchcase_csr_read_4(__csr_num + 4, __val)}
-#define switchcase_csr_read_16(__csr_num, __val)	{\
-	switchcase_csr_read_8(__csr_num + 0, __val)	 \
-	switchcase_csr_read_8(__csr_num + 8, __val)}
-#define switchcase_csr_read_32(__csr_num, __val)	{\
-	switchcase_csr_read_16(__csr_num + 0, __val)	 \
-	switchcase_csr_read_16(__csr_num + 16, __val)}
-
-	unsigned long ret = 0;
-
-	switch (csr_num) {
-	switchcase_csr_read_32(CSR_CYCLE, ret)
-	switchcase_csr_read_32(CSR_CYCLEH, ret)
-	default :
-		break;
-	}
-
-	return ret;
-#undef switchcase_csr_read_32
-#undef switchcase_csr_read_16
-#undef switchcase_csr_read_8
-#undef switchcase_csr_read_4
-#undef switchcase_csr_read_2
-#undef switchcase_csr_read
-}
-
 /*
  * Read the CSR of a corresponding counter.
  */
 unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
 {
-	if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
-	   (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
-		pr_err("Invalid performance counter csr %lx\n", csr);
-		return -EINVAL;
+	unsigned long val;
+	int rc;
+
+	val = csr_read_num(csr, &rc);
+	if (rc) {
+		pr_err("Failed to read performance counter csr %lx (error %d)\n", csr, rc);
+		return rc;
 	}
 
-	return csr_read_num(csr);
+	return val;
 }
 
 u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
-- 
2.43.0


