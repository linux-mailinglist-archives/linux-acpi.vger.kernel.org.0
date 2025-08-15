Return-Path: <linux-acpi+bounces-15740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F1CB283AB
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 18:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27D11C27A54
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6973090F0;
	Fri, 15 Aug 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JAi/H0AJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7475309DC4
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274469; cv=none; b=u3Z+Li4zOXrmcTcrx19CpECW0xiUV+jOl770S4rYiFyheIdW+TpNp0716xNChvFYAl7GJwhpvqCvAxs7KF6RJMCRlCazKOeNXaSEOzaWsxuEg9QotGocYMfU+e9IAYGan/YpgEZHNfmMRoORgDsxDLIG4zyKb/OqllCJfENBDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274469; c=relaxed/simple;
	bh=T1QpNuOdiWs6941e5prDO9WlMGEkkPLF5NXHBCGcB5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmEiVKUF4byw7HQWwlJ7tyXvkpkFKcZTSmji6lfaRkq2wP2SAFdUA2p1inS2zmfKE1BncGpHwvG6uaMhTU5wVghdXwVXS98Mr8xDaqeH0wpRUWY4IwWO/EITl8xfcKi2m1aFSnkPXptmOg8UzpNJZkQDGQkRvCj6rPd3kcwjbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JAi/H0AJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso2266534a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755274467; x=1755879267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4iHoKb5/CVM5O+sLozrOKzzqGiO66LNhTf0IYPU4Wg=;
        b=JAi/H0AJBWBCK81MDJUEw3dH8pInJH7y+Z9NaLK3FAmtC5UIfpbv4qIWdzTfelXUeT
         egj0aVNh82IERDvomTAooFiXz+x9Nhgjq+5+lNzZUPmrhFlXUNmmz6onruhLQPGrcjdn
         QCKr6I8r3OXxZVgBrXcuSNe5rExf8Z0n+1sB1PQwvVuRLpmKKiAYlXi0cQHdvPzKbO7w
         P+FdD++bcyFYcbrDExH+2vRZeuLROkZvcB5pI/NaZaqgoXmLAGWFDCHSKeqG8O5SY38b
         ca17E6PudDN1MP6H9R6CREHFnYARSdrQR0mA8bP4lyZJDJEqwAJDQOyYhhtBhyXTpEb6
         fmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274467; x=1755879267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4iHoKb5/CVM5O+sLozrOKzzqGiO66LNhTf0IYPU4Wg=;
        b=e50CarAyRlfC4NWK444ajqWya2F2VdRU7kQIjZYYpPvtfK1eolEMeEJAv+jewGwpeh
         tJsRmlm5c3h2WQJUg/Q43Z9EBxgNvbmeTOtDHFtiFx5o1PtF8V/3kNqOUo4fSGGTwTa4
         BYPXaqvaIN4raoRbHeraHt0H4oI10+4ab0TPk9hvLaaeLFAH7Udcjck9GxSqbS6zRCOM
         TlUUiByEeQMbbvOU7hrnqzFUkrxAt0YXGfS915xK9ZNwHxzNWMPWVDL7MT9/zP0DXSqt
         uU4X3BIjqgYh7yzHGU93QtQYVPGpViGI1AKBHjlqQe1I0lSoiT/+Clx5wVM5fnQm6SRq
         sJcA==
X-Forwarded-Encrypted: i=1; AJvYcCUGTnM0sVwGlbCkdOeRPFpk6aqnHcVUpyIDOKK9SlBKzIG6s5Xo0iR6bMAprmEP3FaiTsAzroc6evnR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0mhqX6NU7XnSG1dc1tNAAc+nRTjdcNHrA+1Vq0dm0Tl9AvEek
	kzhZ9COFjTgxAM4dUTWeuwmq38l8J6gJpBztOO6X59QvRQAURPp+9nUF+JyErXVr8WQ=
X-Gm-Gg: ASbGncs9PVCKFZdNTtB6CEX9CbDsVHsjvtATeMNax5zL2z4UsAwJWY2FGcA/dwR7yl3
	BohfG/hZKkY8dCoUusErvmQpSh1YzAvVGkwU921TSiqR5zorEVaN9uRv2QXpuDViPL7vkCbGkjT
	a/c/vJqvl7CueOHa66kZqOGecclSfNhx6aMeyh4BAzLetGsyIpEmVMpOvXvXVg8l4lnWzFj+mGm
	4Ir01EBjEdOBzw9PJ8I6uvtLVoR7Mz6W2RNsARLQZUIrhLLKYStpJr46EYnXXKH8DIeeWP4P8sK
	3/DY4r7fv1raPnKHpyWEIioMUjLylBSAO2Vc7y+fRGn940Y79DDkY+20oqWHzNuKn0m38VCA0DY
	sdDNn9UVSnpvzJTSL91SFjdjkZB+qy5etwhTPF2ziPdhThZPx83QjKqQ=
X-Google-Smtp-Source: AGHT+IEvE3XunmQ6g5DwmNL67QUHipfXjliMH6NwsiC1TmJEoBdtx3OHYqsReipBxm6VZq27yymkGQ==
X-Received: by 2002:a17:90b:3d84:b0:321:c893:d30 with SMTP id 98e67ed59e1d1-32341e72d50mr4693455a91.15.1755274466692;
        Fri, 15 Aug 2025 09:14:26 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331123409sm4645605a91.20.2025.08.15.09.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:14:26 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/2] RISC-V: Add common csr_read_num() and csr_write_num() functions
Date: Fri, 15 Aug 2025 21:44:06 +0530
Message-ID: <20250815161406.76370-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815161406.76370-1-apatel@ventanamicro.com>
References: <20250815161406.76370-1-apatel@ventanamicro.com>
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

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 177 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  17 ++--
 drivers/perf/riscv_pmu.c     |  43 +--------
 5 files changed, 189 insertions(+), 52 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 6fed42e37705..1540626b3540 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -575,6 +575,9 @@
 			      : "memory");			\
 })
 
+extern unsigned long csr_read_num(unsigned long csr_num, int *out_err);
+extern void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_CSR_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index c7b542573407..0a75e20bde18 100644
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
index 000000000000..f7de45bb597c
--- /dev/null
+++ b/arch/riscv/kernel/csr.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv: " fmt
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/printk.h>
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
+	if (out_err)
+		*out_err = 0;
+
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
+		if (out_err)
+			*out_err = -EINVAL;
+		else
+			pr_err("%s: csr 0x%lx not supported\n", __func__, csr_num);
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
+	if (out_err)
+		*out_err = 0;
+
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
+		if (out_err)
+			*out_err = -EINVAL;
+		else
+			pr_err("%s: csr 0x%lx not supported\n", __func__, csr_num);
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
index 7644147d50b4..aa053254448d 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/sched_clock.h>
 
+#include <asm/csr.h>
 #include <asm/sbi.h>
 
 static bool riscv_perf_user_access(struct perf_event *event)
@@ -88,46 +89,6 @@ void arch_perf_update_userpage(struct perf_event *event,
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
@@ -139,7 +100,7 @@ unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
 		return -EINVAL;
 	}
 
-	return csr_read_num(csr);
+	return csr_read_num(csr, NULL);
 }
 
 u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
-- 
2.43.0


