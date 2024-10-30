Return-Path: <linux-acpi+bounces-9114-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022B29B6328
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 13:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC89B21313
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C81E260D;
	Wed, 30 Oct 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpPB3Msg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710941E4AE;
	Wed, 30 Oct 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291827; cv=none; b=GIMrP5WdaIF7ZH/ai/TU3TUNk+ET0e+Wa+4XqxuWrGnWQYs7Gx+zyB7k0SysbWsLp3kiK5xnu9s8gnRKZF5uvaai3Fs/qRWCvUFr8bxuS4BaVVufmnPQbMoVweT5hRKNMEdfominRdF3lRBh54PXkuB2wr8231UaoJSkRafJnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291827; c=relaxed/simple;
	bh=lvwwq8+aFwmiSf/8QCpbYGtnBkZJ5CJmM5pqyvdaEAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YTzXN0u8fogfLWNV3G0yC8ENAyRkcTaHqUT+UL1O3V804mdTInBpb9TZwf8hMHBurP6ItHjDfdWGsXeJHUaJWBCtNu1ekOiwC8sPeKREtrAOQTFZqHNncfN08Hrqf0zedYAfE/f0mPX4yNeg3WFnzjWMKU2Ti/aJHZl82qapZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpPB3Msg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C314FC4CEE3;
	Wed, 30 Oct 2024 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730291827;
	bh=lvwwq8+aFwmiSf/8QCpbYGtnBkZJ5CJmM5pqyvdaEAk=;
	h=From:To:Cc:Subject:Date:From;
	b=NpPB3MsgUiPGOaV3xPOlsGWXEssnS87y1Wu7z7gXbzYiSzuNQd0dTDewkMV7C967z
	 Fe/snDNrIAlG0tj9yTIcmNAk2pRTZZMin/JYDfrn1UDcdFCyLFOW3lIkDoDfwDQIXg
	 /i9PtmbVEhTBVol+84gnvmMhVVvZNvMmJNBOgZBMFZaInFhlZkYVWBIDrmFKuZvgTB
	 TCFyZnBt//33m0DZm2XgR5HIZw1i86EQv0JnXBymEXdonAWUZvNLogjLvmwQXzrUou
	 WXSIOALb7WPjaPzA+yDWzvqllSqiB63/aOOjNvtnnerM8/KaMGqThheWoYDS3Dw3st
	 myw9+gLf68JaQ==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [v3] acpi: processor_perflib: extend X86 dependency
Date: Wed, 30 Oct 2024 12:36:40 +0000
Message-Id: <20241030123701.1538919-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The majority of the processor_perflib code is only used by cpufreq
drivers on the x86 architecture and makes no sense without the
x86 SMI interactions that rely on I/O port access.

Replace the existing #ifdef checks with one that covers all of the
code that is only used by x86 drivers, saving a little bit
of kernel code size on other architectures.

There is likely more code under CONFIG_ACPI_PROCESSOR that falls
into this category, but changing those would require a larger
rework.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is not needed for correctness, only as a small optimization.

v3: fix build warning
---
 drivers/acpi/processor_perflib.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 4265814c74f8..53996f1a2d80 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -24,8 +24,6 @@
 
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 
-static DEFINE_MUTEX(performance_mutex);
-
 /*
  * _PPC support is implemented as a CPUfreq policy notifier:
  * This means each time a CPUfreq driver registered also with
@@ -209,6 +207,10 @@ void acpi_processor_ppc_exit(struct cpufreq_policy *policy)
 	}
 }
 
+#ifdef CONFIG_X86
+
+static DEFINE_MUTEX(performance_mutex);
+
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 {
 	int result = 0;
@@ -267,7 +269,6 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	return result;
 }
 
-#ifdef CONFIG_X86
 /*
  * Some AMDs have 50MHz frequency multiples, but only provide 100MHz rounding
  * in their ACPI data. Calculate the real values and fix up the _PSS data.
@@ -298,9 +299,6 @@ static void amd_fixup_frequency(struct acpi_processor_px *px, int i)
 			px->core_frequency = (100 * (fid + 8)) >> did;
 	}
 }
-#else
-static void amd_fixup_frequency(struct acpi_processor_px *px, int i) {};
-#endif
 
 static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 {
@@ -440,13 +438,11 @@ int acpi_processor_get_performance_info(struct acpi_processor *pr)
 	 * the BIOS is older than the CPU and does not know its frequencies
 	 */
  update_bios:
-#ifdef CONFIG_X86
 	if (acpi_has_method(pr->handle, "_PPC")) {
 		if(boot_cpu_has(X86_FEATURE_EST))
 			pr_warn(FW_BUG "BIOS needs update for CPU "
 			       "frequency support\n");
 	}
-#endif
 	return result;
 }
 EXPORT_SYMBOL_GPL(acpi_processor_get_performance_info);
@@ -788,3 +784,4 @@ void acpi_processor_unregister_performance(unsigned int cpu)
 	mutex_unlock(&performance_mutex);
 }
 EXPORT_SYMBOL(acpi_processor_unregister_performance);
+#endif
-- 
2.39.5


