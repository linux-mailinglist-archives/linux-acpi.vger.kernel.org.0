Return-Path: <linux-acpi+bounces-2928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836288312B6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jan 2024 07:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7C728379B
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jan 2024 06:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797238F60;
	Thu, 18 Jan 2024 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZvaI7+Pf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A6DB65C
	for <linux-acpi@vger.kernel.org>; Thu, 18 Jan 2024 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559388; cv=none; b=l0K6YTxGnqRk7GwfHifaGMjm0tpcp9k2fejpAQxlgVFFRK9yxQZhgocAsX+SdguCVZlQ+IkDPK6S8LX7h15bkvxoui817tdpszq+Z26UcQAhK4rvpgBiWGhVa2pfsudvih4MSwBI/p7a9fEsu4cf9TDlRBAAeaWZPwEzTtBCsyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559388; c=relaxed/simple;
	bh=4KmNYGZaQ/0eFb7+g3r7FVQTT3Vg5/Epy+DsR7imRXw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=cpxRpbdo7jPr+VpfQmKL2/TwhWgDTs0OplNfQlK2VlG5R0/PIqkGIUkka7RDSzYMToU3cOHnasRRtCvWj9kJLpp6A4ma5Qfag/AQyG3/O6pPvDlK6bNJno71exOp0NJ7rh8rpT9Ak0UA1LcqSUaxq1T4C/a/PD+tDFyceeSFWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZvaI7+Pf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36199ab6e68so1092205ab.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jan 2024 22:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705559386; x=1706164186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVSbOzgJs1igIWqQu9lDLW42aL5tdwTQfAgqMSjQkJE=;
        b=ZvaI7+PfPpMNJsNpPTK2WpoiI+vbIyGVTyxMSY6Oc1j0SLuZesKlO3DVFREeVuVR9U
         Meu87ib/7Ffuo1NZKHfKuLogGiJp22+eZ6a21W35staHohUT2EfIePssbIaDerjOuES8
         KUCCdPTo/ISnRDYWmwgo9r9E6EKG1oAJz+u4+eWtkKlbyYtQrrmPE0P++CaoAeGM22Xb
         5hdY8dwJPbXkx5Orwun0/xiZmoDj7rNJynfyJ6ao88FmhDp7b6VCT6e7BZgmhg6bDu8+
         ewdEaJ1yh22TEZ6R7SbiBgtJrQdK03skW4lX+6VcMtAyUxg5cHpQNpSEeDFhsbeKZY64
         eg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705559386; x=1706164186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVSbOzgJs1igIWqQu9lDLW42aL5tdwTQfAgqMSjQkJE=;
        b=iVU53+L/WFzS9kKD+2IaJlgyPKDs/9y9w7qHZmVjUuyPRglNoNFPdmKBVEIs7ItajV
         uDHwvpCUmPvUGI5/GVk+mXF8PJdy2JYavxAvmCY+EK1/aPjdteL2CAy5F6GLxeq8/mG7
         nnXxw1cT28et15aOhBXuo5n7RxhyQ87iDQTSdyHIhV5WWC2WAmaxWFJ3f7Vy/oMxfE/t
         8+SrdIQSy6I5zT+Vk2WbR2dQzAppxkBQTdcOU5/TKcVZUbCaW93PHaDo7ZC5qfHsSv7f
         W9eYguJJcxPhHAHJXktYeuShWUijh5FfJUlypOmpTLRzsHDwaLYqEAcemN69/WNTsY6u
         G3WA==
X-Gm-Message-State: AOJu0Yw9dP5czbXDQ5BWUKXJsOsYZdU7sEsW/dFrHgSkWuUImhvzG71t
	PO1PB3GpfvJCkPI+uhABfGQiXrQxDSFvE+CfP3XUhabHjBwsgDgvOUVb2xSRS/c=
X-Google-Smtp-Source: AGHT+IHGQHjpLDXAypTn1Zx6QEntcYHv7EtMpW/QZNfiHZ98kua3F5Js0zUATDQyTIczTGIi34cWCA==
X-Received: by 2002:a05:6e02:18cc:b0:35d:6be7:55d9 with SMTP id s12-20020a056e0218cc00b0035d6be755d9mr1647457ilu.0.1705559386085;
        Wed, 17 Jan 2024 22:29:46 -0800 (PST)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id bn28-20020a056e02339c00b0035fec699584sm4663269ilb.13.2024.01.17.22.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 22:29:45 -0800 (PST)
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
Subject: [PATCH v3 -next 1/3] cpuidle: RISC-V: Move few functions to arch/riscv
Date: Thu, 18 Jan 2024 11:59:28 +0530
Message-Id: <20240118062930.245937-2-sunilvl@ventanamicro.com>
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

To support ACPI Low Power Idle (LPI), few functions are required which
are currently static functions in the DT based cpuidle driver. Hence,
move them under arch/riscv so that ACPI driver also can use them. Since
they are no longer static functions, append "riscv_" prefix to the
function name.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/suspend.h    |  3 ++
 arch/riscv/kernel/suspend.c         | 49 +++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-riscv-sbi.c | 49 +++--------------------------
 3 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 02f87867389a..076f8a9437cf 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -55,4 +55,7 @@ int hibernate_resume_nonboot_cpu_disable(void);
 asmlinkage void hibernate_restore_image(unsigned long resume_satp, unsigned long satp_temp,
 					unsigned long cpu_resume);
 asmlinkage int hibernate_core_restore_code(void);
+bool riscv_sbi_hsm_is_supported(void);
+bool riscv_sbi_suspend_state_is_valid(u32 state);
+int riscv_sbi_hart_suspend(u32 state);
 #endif
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 239509367e42..b20f2cb5879f 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -128,4 +128,53 @@ static int __init sbi_system_suspend_init(void)
 }
 
 arch_initcall(sbi_system_suspend_init);
+
+static int sbi_suspend_finisher(unsigned long suspend_type,
+				unsigned long resume_addr,
+				unsigned long opaque)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
+			suspend_type, resume_addr, opaque, 0, 0, 0);
+
+	return (ret.error) ? sbi_err_map_linux_errno(ret.error) : 0;
+}
+
+int riscv_sbi_hart_suspend(u32 state)
+{
+	if (state & SBI_HSM_SUSP_NON_RET_BIT)
+		return cpu_suspend(state, sbi_suspend_finisher);
+	else
+		return sbi_suspend_finisher(state, 0, 0);
+}
+
+bool riscv_sbi_suspend_state_is_valid(u32 state)
+{
+	if (state > SBI_HSM_SUSPEND_RET_DEFAULT &&
+	    state < SBI_HSM_SUSPEND_RET_PLATFORM)
+		return false;
+
+	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
+	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
+		return false;
+
+	return true;
+}
+
+bool riscv_sbi_hsm_is_supported(void)
+{
+	/*
+	 * The SBI HSM suspend function is only available when:
+	 * 1) SBI version is 0.3 or higher
+	 * 2) SBI HSM extension is available
+	 */
+	if (sbi_spec_version < sbi_mk_version(0, 3) ||
+	    !sbi_probe_extension(SBI_EXT_HSM)) {
+		pr_info("HSM suspend not available\n");
+		return false;
+	}
+
+	return true;
+}
 #endif /* CONFIG_RISCV_SBI */
diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index e8094fc92491..a6e123dfe394 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -73,26 +73,6 @@ static inline bool sbi_is_domain_state_available(void)
 	return data->available;
 }
 
-static int sbi_suspend_finisher(unsigned long suspend_type,
-				unsigned long resume_addr,
-				unsigned long opaque)
-{
-	struct sbiret ret;
-
-	ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_SUSPEND,
-			suspend_type, resume_addr, opaque, 0, 0, 0);
-
-	return (ret.error) ? sbi_err_map_linux_errno(ret.error) : 0;
-}
-
-static int sbi_suspend(u32 state)
-{
-	if (state & SBI_HSM_SUSP_NON_RET_BIT)
-		return cpu_suspend(state, sbi_suspend_finisher);
-	else
-		return sbi_suspend_finisher(state, 0, 0);
-}
-
 static __cpuidle int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
 					     struct cpuidle_driver *drv, int idx)
 {
@@ -100,9 +80,9 @@ static __cpuidle int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
 	u32 state = states[idx];
 
 	if (state & SBI_HSM_SUSP_NON_RET_BIT)
-		return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, state);
+		return CPU_PM_CPU_IDLE_ENTER_PARAM(riscv_sbi_hart_suspend, idx, state);
 	else
-		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
+		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(riscv_sbi_hart_suspend,
 							     idx, state);
 }
 
@@ -133,7 +113,7 @@ static __cpuidle int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
 	else
 		state = states[idx];
 
-	ret = sbi_suspend(state) ? -1 : idx;
+	ret = riscv_sbi_hart_suspend(state) ? -1 : idx;
 
 	ct_cpuidle_exit();
 
@@ -206,17 +186,6 @@ static const struct of_device_id sbi_cpuidle_state_match[] = {
 	{ },
 };
 
-static bool sbi_suspend_state_is_valid(u32 state)
-{
-	if (state > SBI_HSM_SUSPEND_RET_DEFAULT &&
-	    state < SBI_HSM_SUSPEND_RET_PLATFORM)
-		return false;
-	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
-	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
-		return false;
-	return true;
-}
-
 static int sbi_dt_parse_state_node(struct device_node *np, u32 *state)
 {
 	int err = of_property_read_u32(np, "riscv,sbi-suspend-param", state);
@@ -226,7 +195,7 @@ static int sbi_dt_parse_state_node(struct device_node *np, u32 *state)
 		return err;
 	}
 
-	if (!sbi_suspend_state_is_valid(*state)) {
+	if (!riscv_sbi_suspend_state_is_valid(*state)) {
 		pr_warn("Invalid SBI suspend state %#x\n", *state);
 		return -EINVAL;
 	}
@@ -607,16 +576,8 @@ static int __init sbi_cpuidle_init(void)
 	int ret;
 	struct platform_device *pdev;
 
-	/*
-	 * The SBI HSM suspend function is only available when:
-	 * 1) SBI version is 0.3 or higher
-	 * 2) SBI HSM extension is available
-	 */
-	if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
-	    !sbi_probe_extension(SBI_EXT_HSM)) {
-		pr_info("HSM suspend not available\n");
+	if (!riscv_sbi_hsm_is_supported())
 		return 0;
-	}
 
 	ret = platform_driver_register(&sbi_cpuidle_driver);
 	if (ret)
-- 
2.34.1


