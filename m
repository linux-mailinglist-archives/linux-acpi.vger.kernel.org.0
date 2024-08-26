Return-Path: <linux-acpi+bounces-7838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B056C95FB55
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B064B22F65
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A219A288;
	Mon, 26 Aug 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOlBUwL7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9523199E9F;
	Mon, 26 Aug 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706845; cv=none; b=E//+wA1YX7BtBuyNSlbjerRwwPZ1JwzW6JaYYdDd8dR5I66zByyvKPib4D/Lz86/lrYJZLdGF73uQheR0Lj48az9rtgRjHNdrbZ/3TDPVDk5/38eN90/VXEUlGw2Gtc7ZSHV9pin4FlQ97fsPu/FPHeBEk9LAG1AgI/37MAFakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706845; c=relaxed/simple;
	bh=RMDMGszvUWn5SrVGmTs7hWGKDK2jZ3EwU42B5/wG5n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv1JHf22L3shJlmVQemIg40M2w/Ffzbj+kCdocCbWpDB9bxZJNWt1RZl/wbDw0AFPyf8i+Fx2IW+Dd25LeLA8GxwmyyEtdVPPqudQqllVQFksVAzUlMpSNVLyFy5Nx6MlM/CPMezUztTOzm3bDGizBcvbhROXhmZwHzbTxpMhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOlBUwL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60AFC4AF60;
	Mon, 26 Aug 2024 21:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706844;
	bh=RMDMGszvUWn5SrVGmTs7hWGKDK2jZ3EwU42B5/wG5n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOlBUwL7f1dxM6z96OuzKNBVtGFPmBhvOMVft2FhGjDIkdsP3XfR4+AhlM0oiStIW
	 967CCUDjELulh4QGAU4xlnflFGqfC2uDiWBGmsaf90J9YVoO56t0AwULzhJwyXnAFA
	 ToDJV7BNFlZotsvjV4xDa82DIZqbatCApfhG2t2mczNfRyDtU4O+g3jkEc4WY9EeVF
	 S8MIv4vm1cD7Kyrew0MrTNBYStsNNUTl3hTc+pQrbNXXFhOG7JQuYoJDhlYk49vifO
	 TpX3GBNhQqjYK96hdWtsMMpb1jqRR/LvsGLPCIfi4X1JmO0WIgvwNC8H/bJX2z3WZP
	 /bRvlYEhdz5Zg==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/8] x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
Date: Mon, 26 Aug 2024 16:13:51 -0500
Message-ID: <20240826211358.2694603-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826211358.2694603-1-superm1@kernel.org>
References: <20240826211358.2694603-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

To prepare to let amd_get_highest_perf() detect preferred cores
it will require CPPC functions. Move amd_get_highest_perf() to
cppc.c to prepare for 'preferred core detection' rework.

No functional changes intended.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 16 ++++++++++++++++
 arch/x86/kernel/cpu/amd.c   | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index ff8f25faca3dd..7ec8f2ce859c8 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -116,3 +116,19 @@ void init_freq_invariance_cppc(void)
 	init_done = true;
 	mutex_unlock(&freq_invariance_lock);
 }
+
+u32 amd_get_highest_perf(void)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
+			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
+		return 166;
+
+	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
+			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
+		return 166;
+
+	return 255;
+}
+EXPORT_SYMBOL_GPL(amd_get_highest_perf);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1e0fe5f8ab84e..015971adadfc7 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1190,22 +1190,6 @@ unsigned long amd_get_dr_addr_mask(unsigned int dr)
 }
 EXPORT_SYMBOL_GPL(amd_get_dr_addr_mask);
 
-u32 amd_get_highest_perf(void)
-{
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-
-	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
-			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
-		return 166;
-
-	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
-			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
-		return 166;
-
-	return 255;
-}
-EXPORT_SYMBOL_GPL(amd_get_highest_perf);
-
 static void zenbleed_check_cpu(void *unused)
 {
 	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
-- 
2.43.0


