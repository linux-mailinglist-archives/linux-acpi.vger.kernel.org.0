Return-Path: <linux-acpi+bounces-8111-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB396A86B
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F99285CF6
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1201D5883;
	Tue,  3 Sep 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGYiVKCy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F61D3195;
	Tue,  3 Sep 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395828; cv=none; b=Mjoi1VnZlB2jLIkHhXACNfzLKm56h0w3an1ZTjfhWojpVRVkg7C6g7sFz8S85VW7kDKCWQwY1sDU3/sTj00WcP/XGb4GPCzx46UH28h91k9C2jAZnVbmnsTM8Y6Kr+8ECzR6b5QKaUoe5e291YrEmVwgdVrHCXXLNa7u1vkgzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395828; c=relaxed/simple;
	bh=rowiKubLUEKpsIMfOF/UJKXNOL/WqssxE3TBLP8jy5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSSohYyoiH1sB3ZlYewilGiXcaPsjr6dKl8Zngk4D+7N7Jg7ASGLhw35/mWdJN7IO8mXQR2FkIvzGpAu/8FBdS00qAuWZuNXepPlIVGkCNrfS2mgmY57OHB6uschhyN8GyUSWx+5TPO4tashkt76a/hKt5JOpZ9CK/42jNgLcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGYiVKCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9ADC4CEC5;
	Tue,  3 Sep 2024 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395828;
	bh=rowiKubLUEKpsIMfOF/UJKXNOL/WqssxE3TBLP8jy5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGYiVKCyXPsndDIIMExB/0OO9zT3wj0ne50MNGR7E5G1WzYBF2T9LFJG5Y8Jvt52l
	 TT85/Zcke6YxMQJTL35AyVqXfDjRYwlSGOJdZKqurMFStg6ZuZhzc2NZa9MRJmNz8g
	 i/4oUsXbcfm5AvqoWMDDFN2RJnbb0DwDjkAn+QHZkqV5oixYlHKP9qZpNJoLK+hegX
	 aXkKfMrgle67TbtIKI7rqcqswlOxH/q0Ley7/KMuZWSkLjm4Jw2yiS5pv8k/wzT09E
	 LBPe1jjEkjmXrR4ug76ZSILeYTd/zl8aEnMcnDJt+isad+nHyvUuqJ7GKXacXiRm+X
	 mAjwMiW5cB6Dg==
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
Subject: [PATCH v2 01/11] x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
Date: Tue,  3 Sep 2024 15:36:51 -0500
Message-ID: <20240903203701.2695040-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903203701.2695040-1-superm1@kernel.org>
References: <20240903203701.2695040-1-superm1@kernel.org>
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


