Return-Path: <linux-acpi+bounces-8119-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFD196A886
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105BF1F21BE5
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A87F1D9D92;
	Tue,  3 Sep 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9yzVWRv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9AB1D9D88;
	Tue,  3 Sep 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395838; cv=none; b=tfU64VXEaStu7HvboHOJYyvchRxGNtW4wWinGBeyG/dKW7x1ZZIfL+yiIwlNdfwIe5pj30hRdkozYUgB+NhS390wKYX8CmrhvBZhv4uWVMVX9MnVFmTqLbHKCzrFszPDYQ3+4zMEHDxMHBxD1giLgRVOIn0P6bP07Euubjq1li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395838; c=relaxed/simple;
	bh=+sHrHnLT2FfYkGdEfPvMGy5X5VchYsR5Qb+fThI971s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g20v2zc5kbb81MFPlaswt6XF7fI5LC8La53U9CC0FCsY4GRr6947R001hZNY8diYfusJzZXB98JY5047XZZq4L8o6jMKxdVLzC4BX81UzPcF9zCMlKUDOy8DeDNZLhkM+dOcgPHEhFdwoRbZHpkQ9+MuXMvAMl0ihm8X0LatxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9yzVWRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF86C4CECD;
	Tue,  3 Sep 2024 20:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395837;
	bh=+sHrHnLT2FfYkGdEfPvMGy5X5VchYsR5Qb+fThI971s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9yzVWRvD5bA0OqDOH2gW4LztVJwbkUP6yLnmj6BDeK7o3ef+LgHi68aL77NQig0Y
	 X6yBStqfXlpO5/gJpYBlOPJOwq1rl69fkbefVcY5TPYhBwmB1RMV2KHrVfedzy3ktW
	 didvJO9hKwJ3AoYXfWnWYcsLjqp9IeHtUB/z9ywkg2dI1hTiZyym5xPZBbpwgHzqi+
	 iHpH6xno4r2nt1RZkoQFh2R5C5BxS9NG2H2LEp56pS8nozLYwry66JkWCE09JIDiG0
	 zs+uWj1rVUXYy0en+jYWe/OU8k2y+H5k0eEklWk4K8mx1W7g47as8Kl8POgEJCsWna
	 qynpB4cO1/wzQ==
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
Subject: [PATCH v2 09/11] cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
Date: Tue,  3 Sep 2024 15:36:59 -0500
Message-ID: <20240903203701.2695040-10-superm1@kernel.org>
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

Don't take and release the mutex when prefcore isn't present and
avoid initialization of variables that will be initially set
in the function.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3ae41af6f041e..9312d4e40994f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -797,17 +797,17 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	int ret;
 	bool highest_perf_changed = false;
 
-	mutex_lock(&amd_pstate_driver_lock);
-	if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
-		goto free_cpufreq_put;
+	if (!amd_pstate_prefcore)
+		return;
 
+	mutex_lock(&amd_pstate_driver_lock);
 	ret = amd_get_highest_perf(cpu, &cur_high);
 	if (ret)
 		goto free_cpufreq_put;
 
 	prev_high = READ_ONCE(cpudata->prefcore_ranking);
-	if (prev_high != cur_high) {
-		highest_perf_changed = true;
+	highest_perf_changed = (prev_high != cur_high);
+	if (highest_perf_changed) {
 		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
 
 		if (cur_high < CPPC_MAX_PERF)
-- 
2.43.0


