Return-Path: <linux-acpi+bounces-7840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E095FB5A
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A341E1F22FFC
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 21:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE019CD02;
	Mon, 26 Aug 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brrNHkBd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF919CCF4;
	Mon, 26 Aug 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706847; cv=none; b=pnjUVvEphN6vplHhm88qX6hvrAmaM1EKn5PmMdxxt8u0l9ek5MuhpeBrD1RhNdfsyqYdxUh185zZH0Qo4pIMWzty897wAUqc3b4L/+p2nJNdvumctKRTy3EWkTs/gvDlgpvmuQJOMWi1hXCpFts4NLQmb7JASOMN8zsbjUL2bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706847; c=relaxed/simple;
	bh=8JbbZmmWdd0t2niiYJuglfiAJbNZ1lEzfLsYW1gZrg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otQLl0GeG2O5A8onUJWW9ArdCVtlVKkdU25xyz91qvunzZHc9jtKLtg13TPP4kn70d6aR4gl9NoiakzJ9E23oNAfsEAMS/Pj+BH0fiOKRrIVAB0wt8lQpsc4hvxTFEQUqULAEakCEyrfQwTMxxGgE8WAuyem9ofT3yTbVxu9AS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brrNHkBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F68C4DE0F;
	Mon, 26 Aug 2024 21:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706847;
	bh=8JbbZmmWdd0t2niiYJuglfiAJbNZ1lEzfLsYW1gZrg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brrNHkBdrnvs/NQ90nEZamzQ9H1sguuseFRvNknbVoZaYgxU5m1slJqcGyw1+h/43
	 4fxPYHlVbJbAQm38mH549G58eOaEusi39lSIRBlf2dxgWYvApA+n/edeWbq+ZSpLzb
	 srVkYUvkUtRW36yO2r/8qcwwC8dkCY+2RWdZ1OLOyBlfM70NcZ5VxZchjFdtBnW686
	 QqIKjWlyPapSu+P/yPOrIeW/edYkaieaJUxsSdEe27ASWI5cmy22qMUquziSBjJobv
	 9whCOOQkqUt6qmvZ7/iHbGafUkmS9uV+qWt3+nlustagGPAsqNDqC3pRp1vaSrIT0L
	 jnGfZJHs/9I+g==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 3/8] ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn
Date: Mon, 26 Aug 2024 16:13:53 -0500
Message-ID: <20240826211358.2694603-4-superm1@kernel.org>
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

If the boost ratio isn't calculated properly for the system for any
reason this can cause other problems that are non-obvious.

Raise all messages to warn instead.

Suggested-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 1d631ac5ec328..e94507110ca24 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -75,17 +75,17 @@ static void amd_set_max_freq_ratio(void)
 
 	rc = cppc_get_perf_caps(0, &perf_caps);
 	if (rc) {
-		pr_debug("Could not retrieve perf counters (%d)\n", rc);
+		pr_warn("Could not retrieve perf counters (%d)\n", rc);
 		return;
 	}
 
 	rc = amd_get_boost_ratio_numerator(0, &highest_perf);
 	if (rc)
-		pr_debug("Could not retrieve highest performance\n");
+		pr_warn("Could not retrieve highest performance\n");
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (!nominal_perf) {
-		pr_debug("Could not retrieve nominal performance\n");
+		pr_warn("Could not retrieve nominal performance\n");
 		return;
 	}
 
@@ -93,7 +93,7 @@ static void amd_set_max_freq_ratio(void)
 	/* midpoint between max_boost and max_P */
 	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
 	if (!perf_ratio) {
-		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
+		pr_warn("Non-zero highest/nominal perf values led to a 0 ratio\n");
 		return;
 	}
 
-- 
2.43.0


