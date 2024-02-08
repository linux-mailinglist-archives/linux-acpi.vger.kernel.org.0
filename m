Return-Path: <linux-acpi+bounces-3285-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD84384D913
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 04:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F5283F5A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 03:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83DC29402;
	Thu,  8 Feb 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GlQLaGXY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1A2D61A
	for <linux-acpi@vger.kernel.org>; Thu,  8 Feb 2024 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707363874; cv=none; b=JCuT5ADdle3CwjW82Ry9Gdtf/QkkHyJETDYqOGN5EJxbCLt8c6junwNl+f4RlLZD4peevJCttKbICEhXvMLcRs19Uw+eJ4v4xngx0phBh4KsijHPK33UFd1ksnEmkKwZjzC4MsLsPmI04UGLdNcEQ6vrNWj/MWakuoAc7ohYmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707363874; c=relaxed/simple;
	bh=h873gLctRW8xU6R1RdKXOdSD9PHPPLIdSv+c8clPrfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FO0XZ/M4U68jdrg6zggkvoKoqnPqirWWzMaKPR+h8u4T836fAXwVV2wbs5Xt8ZGrevO0HNpx1Z65sqSpMhcG65fuuG3g8kFIL+1An2mCOQicHtOJq6DJJAAdMVpPCdxE9w3AXC2jAk49dCyIQuwx+CQia/FhaU552ObFtLDETCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GlQLaGXY; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e12f8506ccso627776a34.2
        for <linux-acpi@vger.kernel.org>; Wed, 07 Feb 2024 19:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707363872; x=1707968672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgQFqqRtn8DN2VavanqDsLoINugSVlcio4jRu34SR/A=;
        b=GlQLaGXYk9ej3DnIoe9JFklpUjDFoAO9tQGDIfgiFj0gmssY2bGpFQzqbqG3Gs/9aH
         OeneEmuR6vyMaWDGpclQYTxtgyrvu6Vb1XRIfkKnpCjewXDEPIMhl0V7/v76QKHM31KN
         EGr39GLJJLsd4QFXrXvIx8mBIkFO9+7DVr0yFsqfEME7RCHoC4GosboI7/EmY6uw8RXt
         5RNUALNJx38etXIY60ZebB6HoHIQLU1cvxTBEoa9dUm+kUrEh2oSL/NQQ5ByvMNrpFSh
         bq/6tSnxrEPe2xAgl+lQxioXHQg2UrGnHlsqozbiTYL/SfcQiCyAhb3eH973p3SWFueA
         CI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707363872; x=1707968672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgQFqqRtn8DN2VavanqDsLoINugSVlcio4jRu34SR/A=;
        b=C6sbrXyBc98QF7I/rKIui6iHd7AcPRDMH0dGcnRlWkXPA72n1GLSABKRhi/gXifoRw
         EtZwde4+v/2IP5y/aia6E7V0K3lf4MRJa8yoHw00JUm312zg3qHxm/r73GztDy30DFJC
         u5TUZAmDAfNkbW5QsioWF/R6lHqvKv5yW+5wRtg0623tk4SOzLuC/VxLR7qwrVmOujKk
         fU3Vt57pSIa41fB92Cwddz0Rn1qhp3z1TvRJ1JCXe6BC0sPwqn3s2Q3H7uzRZQC0DQdD
         jvg/0n9p/tPuPwld703kmoR7uP4YiUeVRjEk14fzp9mLyeKoqXr0chfFCxngqwVwtrvu
         2u/w==
X-Forwarded-Encrypted: i=1; AJvYcCVuUfuGxemd17I0Kt5C94Vw9b2zeqXI7BZLBjEC1ABENVF+mLWqhRokpno0kuO+qkGT8VqeRQY2O5RWTx6B9PR0JglvhLTTYvMLbA==
X-Gm-Message-State: AOJu0Yy1iL202elE6DD2SCHEEVcZuON0h/AJ/FzF/bMCPZO4lK9VRCVY
	vxyjKqb3b2NK2pHUbHct5OKaPIpUKfrd/8zM5Z6BFwe6ySPzKcqnm0rMAgVmtKk=
X-Google-Smtp-Source: AGHT+IEfZsi4VFdiHkosdFblRNJZ6ug/fDhuHf9RN1g49321kfYYXE2DyiQ0S/JGPMdQKZlCivRcjg==
X-Received: by 2002:a05:6830:14c7:b0:6dd:eb91:81da with SMTP id t7-20020a05683014c700b006ddeb9181damr9033857otq.27.1707363872124;
        Wed, 07 Feb 2024 19:44:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOfWQSg4aYubBJ9v3sf9Cx1SR3gQ2gpcdir88xRdk68u5pP4oK8imbfLZtAw/e0q5aRsjjXtLVxtju5iS1qOvlx8NRGMSwAW3tGs99IOYolVgEtm9KzcsveTydkdp/BYWRlutNgxRYrIaBwm6nnZJSnOcvAHg8hN49lxk3zL2tOZLy0jYnhaRga0RaWFVxNA/c3M/0qmNK+QOoLrpnYPlmmZ1RxI95mPPlIClf3HJRtFki6TGfMDf1VYkwSMHCECZ96wV3A9CP00Qs6uEtkwxk/b7kVe6MUG/vRe58892WE07AF5eJXhUPEgpVl11u/gUkn7bXi1G7WoRkYKfY3FRl7WLSCJRjs6nmkeW+EfUDOhW6f8KMql2ywNLY6Kf75Bi7R9zr8iQb1eQStYVlWsOo8yuZ02LsvWTPWypu2gLagYLq9rD2UP3MZ4SMkK+J5vZvlF/0
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id g10-20020a056830160a00b006ddbfc37c87sm443595otr.49.2024.02.07.19.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:44:29 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 -next 1/3] ACPI: RISC-V: Add CPPC driver
Date: Thu,  8 Feb 2024 09:14:12 +0530
Message-Id: <20240208034414.22579-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208034414.22579-1-sunilvl@ventanamicro.com>
References: <20240208034414.22579-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cpufreq driver based on ACPI CPPC for RISC-V. The driver uses either
SBI CPPC interfaces or the CSRs to access the CPPC registers as defined
by the RISC-V FFH spec.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile |   1 +
 drivers/acpi/riscv/cppc.c   | 157 ++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 drivers/acpi/riscv/cppc.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 7309d92dd477..86b0925f612d 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= rhct.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
+obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
new file mode 100644
index 000000000000..4cdff387deff
--- /dev/null
+++ b/drivers/acpi/riscv/cppc.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Implement CPPC FFH helper routines for RISC-V.
+ *
+ * Copyright (C) 2024 Ventana Micro Systems Inc.
+ */
+
+#include <acpi/cppc_acpi.h>
+#include <asm/csr.h>
+#include <asm/sbi.h>
+
+#define SBI_EXT_CPPC 0x43505043
+
+/* CPPC interfaces defined in SBI spec */
+#define SBI_CPPC_PROBE			0x0
+#define SBI_CPPC_READ			0x1
+#define SBI_CPPC_READ_HI		0x2
+#define SBI_CPPC_WRITE			0x3
+
+/* RISC-V FFH definitions from RISC-V FFH spec */
+#define FFH_CPPC_TYPE(r)		(((r) & GENMASK_ULL(63, 60)) >> 60)
+#define FFH_CPPC_SBI_REG(r)		((r) & GENMASK(31, 0))
+#define FFH_CPPC_CSR_NUM(r)		((r) & GENMASK(11, 0))
+
+#define FFH_CPPC_SBI			0x1
+#define FFH_CPPC_CSR			0x2
+
+struct sbi_cppc_data {
+	u64 val;
+	u32 reg;
+	struct sbiret ret;
+};
+
+static bool cppc_ext_present;
+
+static int __init sbi_cppc_init(void)
+{
+	if (sbi_spec_version >= sbi_mk_version(2, 0) &&
+	    sbi_probe_extension(SBI_EXT_CPPC) > 0) {
+		pr_info("SBI CPPC extension detected\n");
+		cppc_ext_present = true;
+	} else {
+		pr_info("SBI CPPC extension NOT detected!!\n");
+		cppc_ext_present = false;
+	}
+
+	return 0;
+}
+device_initcall(sbi_cppc_init);
+
+static void sbi_cppc_read(void *read_data)
+{
+	struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
+
+	data->ret = sbi_ecall(SBI_EXT_CPPC, SBI_CPPC_READ,
+			      data->reg, 0, 0, 0, 0, 0);
+}
+
+static void sbi_cppc_write(void *write_data)
+{
+	struct sbi_cppc_data *data = (struct sbi_cppc_data *)write_data;
+
+	data->ret = sbi_ecall(SBI_EXT_CPPC, SBI_CPPC_WRITE,
+			      data->reg, data->val, 0, 0, 0, 0);
+}
+
+static void cppc_ffh_csr_read(void *read_data)
+{
+	struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
+
+	switch (data->reg) {
+	/* Support only TIME CSR for now */
+	case CSR_TIME:
+		data->ret.value = csr_read(CSR_TIME);
+		data->ret.error = 0;
+		break;
+	default:
+		data->ret.error = -EINVAL;
+		break;
+	}
+}
+
+static void cppc_ffh_csr_write(void *write_data)
+{
+	struct sbi_cppc_data *data = (struct sbi_cppc_data *)write_data;
+
+	data->ret.error = -EINVAL;
+}
+
+/*
+ * Refer to drivers/acpi/cppc_acpi.c for the description of the functions
+ * below.
+ */
+bool cpc_ffh_supported(void)
+{
+	return true;
+}
+
+int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
+{
+	struct sbi_cppc_data data;
+
+	if (WARN_ON_ONCE(irqs_disabled()))
+		return -EPERM;
+
+	if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_SBI) {
+		if (!cppc_ext_present)
+			return -EINVAL;
+
+		data.reg = FFH_CPPC_SBI_REG(reg->address);
+
+		smp_call_function_single(cpu, sbi_cppc_read, &data, 1);
+
+		*val = data.ret.value;
+
+		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+	} else if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_CSR) {
+		data.reg = FFH_CPPC_CSR_NUM(reg->address);
+
+		smp_call_function_single(cpu, cppc_ffh_csr_read, &data, 1);
+
+		*val = data.ret.value;
+
+		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+	}
+
+	return -EINVAL;
+}
+
+int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
+{
+	struct sbi_cppc_data data;
+
+	if (WARN_ON_ONCE(irqs_disabled()))
+		return -EPERM;
+
+	if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_SBI) {
+		if (!cppc_ext_present)
+			return -EINVAL;
+
+		data.reg = FFH_CPPC_SBI_REG(reg->address);
+		data.val = val;
+
+		smp_call_function_single(cpu, sbi_cppc_write, &data, 1);
+
+		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+	} else if (FFH_CPPC_TYPE(reg->address) == FFH_CPPC_CSR) {
+		data.reg = FFH_CPPC_CSR_NUM(reg->address);
+		data.val = val;
+
+		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
+
+		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+	}
+
+	return -EINVAL;
+}
-- 
2.34.1


