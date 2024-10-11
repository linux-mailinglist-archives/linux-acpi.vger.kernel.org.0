Return-Path: <linux-acpi+bounces-8706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59123999C89
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 08:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED563282F4B
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 06:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933BA1F9433;
	Fri, 11 Oct 2024 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGC9FBHy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6C1946C8;
	Fri, 11 Oct 2024 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728627635; cv=none; b=EctbyRdxBmOZ/D5eoRxPeC9xTRAhKXLt1S+QCvBl2uXcRsDcaJqJmYUVmCwI4oNwU21VHw0f9EL6T0wHVdNw4OKhGuOFkBQ0wYnGRynQTu7Tuzt2nknetfwXmVDoHUIOk1C04A8y0Rw6OfqsChijrh3sCliwP/KpScPPa34it+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728627635; c=relaxed/simple;
	bh=SI2hcQuoaANcbdW3t8XnQIgiBQ4D52QHze1gyZFwP/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djEGFpBASmUntUebzcOdEOn7POvia7tyr6J4WqNLBWOxV1Ec5P3dns4xmnhHLNG68mji9lcKcQiG5ejKBITxv18JU3d3QDVmqR8ztUJjWX5zfbdaZHUYDDVbOvonPXrOV9lI41xbq/3YhYSmbgVA4ZItU+qPGqcMGj8yWW87ofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGC9FBHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C147FC4CEC3;
	Fri, 11 Oct 2024 06:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728627634;
	bh=SI2hcQuoaANcbdW3t8XnQIgiBQ4D52QHze1gyZFwP/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGC9FBHyCnKhza0hnGW+1RC1rgO9ROLFtJhAT/KWLYlyM6sXhDk/ucA+WKhpgT15P
	 w72+ZsG+tqh3uM8PW3Abo18P5lKVDvXoI6PGqx8m/tI4GJ7rGnC/gV5ofi5q27+xPE
	 Z6o0eqXtKMgMNc+ZVifuwmkkOr5hCo/m6kzozIR7XBK+fnTLPtfAOU+osr23qB+wUy
	 TROxE/SHwqW2r/OXQxjpJQQWdQd1OGStoVBe7dx+clepBs5XypeNudNqip8B8Z+cen
	 SoJGYvRE2P8ntljokTUOmkz7NM2LWZehrZ6nP46m7neBDXxko168G1q9tJkmGQcTEz
	 sxY9U0UChL6BA==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] acpi: processor_perflib: extend X86 dependency
Date: Fri, 11 Oct 2024 06:18:19 +0000
Message-Id: <20241011061948.3211423-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241011061948.3211423-1-arnd@kernel.org>
References: <20241011061948.3211423-1-arnd@kernel.org>
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
---
 drivers/acpi/processor_perflib.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 4265814c74f8..9a959a963a79 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -209,6 +209,7 @@ void acpi_processor_ppc_exit(struct cpufreq_policy *policy)
 	}
 }
 
+#ifdef CONFIG_X86
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 {
 	int result = 0;
@@ -267,7 +268,6 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	return result;
 }
 
-#ifdef CONFIG_X86
 /*
  * Some AMDs have 50MHz frequency multiples, but only provide 100MHz rounding
  * in their ACPI data. Calculate the real values and fix up the _PSS data.
@@ -298,9 +298,6 @@ static void amd_fixup_frequency(struct acpi_processor_px *px, int i)
 			px->core_frequency = (100 * (fid + 8)) >> did;
 	}
 }
-#else
-static void amd_fixup_frequency(struct acpi_processor_px *px, int i) {};
-#endif
 
 static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 {
@@ -440,13 +437,11 @@ int acpi_processor_get_performance_info(struct acpi_processor *pr)
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
@@ -788,3 +783,4 @@ void acpi_processor_unregister_performance(unsigned int cpu)
 	mutex_unlock(&performance_mutex);
 }
 EXPORT_SYMBOL(acpi_processor_unregister_performance);
+#endif
-- 
2.39.5


