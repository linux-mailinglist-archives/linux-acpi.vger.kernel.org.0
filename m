Return-Path: <linux-acpi+bounces-8176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFEB96DFAD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382801F2188D
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171651A072F;
	Thu,  5 Sep 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZbC8adR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3F1A0722;
	Thu,  5 Sep 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553819; cv=none; b=b0Sj6OAB3LxJ5gZNafKyH+ns9+0Q7ic0nDhdVMQzJUuwNGW9Ien0sr82WFEa9t6uTszI8/sniYvsij7dqpI1U0B/jw4FuwlRCMSRGUE8rO36Q8Z+gg+TEKCTmta0jN23h5FXs0M9ZjY9XI+ylycVC6EDOqC6SVAt73UQWYiCEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553819; c=relaxed/simple;
	bh=rowiKubLUEKpsIMfOF/UJKXNOL/WqssxE3TBLP8jy5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHV3OTGgkERvY9M5gZKmgc1UlCW9hGPuYVWZfryuLuoZzVpWTV2k9+N92NF8Qf9USaLcIhhk+ct9us4/4pjzi/y65tnewXH8ZySWcefPbYHarIyI5oUxOO8K461jI+Ttbfwx6zskl5NtTpN2gv6P9Vsy3pDGqeaZ/cWk8KsWlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZbC8adR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EABC4AF09;
	Thu,  5 Sep 2024 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553818;
	bh=rowiKubLUEKpsIMfOF/UJKXNOL/WqssxE3TBLP8jy5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZbC8adRirAH8S6GArZD+fWf4Nz97gwlRtguq346tRcvRxq+v6tU6Bu4ilc0wpFM5
	 dDF61ulI08eDK00LaN1WaV+aWLO/yAUSaueb4xxhXMOSOUvPa53PFMxT3KW6jBaOWd
	 r+kc0qY3ZO2rY22sZul66sanhJhwO/ZYHms5Pa60b4YP7tSFBOuMkkLeWgBG5Ns5YS
	 oAAYbqopBA9OdGSThIXI5A90dXpE5HzFJPW6a3XdLx7Ka4HR06I89a/E3Z3FBYRqk6
	 6WGto8QuI0gr1RBV/pJwON5WdUd4b2D2xEL98vB0JpKkKoxhPluISSLGifGhiYOiKT
	 R95Whdwni3Hvg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 01/11] x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
Date: Thu,  5 Sep 2024 11:29:57 -0500
Message-ID: <20240905163007.1350840-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240905163007.1350840-1-superm1@kernel.org>
References: <20240905163007.1350840-1-superm1@kernel.org>
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

Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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


