Return-Path: <linux-acpi+bounces-7844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6B95FB66
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC77280F6E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47BB19DF52;
	Mon, 26 Aug 2024 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRTI9ZHS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53919DF4D;
	Mon, 26 Aug 2024 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706852; cv=none; b=Pr3MAdWUUjUhKOzkOiSBlUCI4qaUaDI19R/cjtF78Qd5gN3NZvqvk96qYWy4kGAvYzUUAaoGfb9XqLCRgZ5P8igb7sxx+eBOsYu+is0xLAhuSFYiJJ+DNcZqcG4HZd7+nogst61Kyj7jfaI3MHAV+QyZqgzmQoEnTaTeYtsDivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706852; c=relaxed/simple;
	bh=uLtdEH/FuQxQoDClWlfBImx0hkxxg7PVSYyuZWqCLZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhv49XxGb+44HLRdy8iqFesLcSDHm8BcVwAJA5mUfNyHxd1ZM43ocifSyDot3dtPih25MQxDbcdPWjWGyNaI/zN/FvbBCE2Jcz6To0OiEBUxuA+WgNeEnXbR3jMQyZvl4xJVQ0tAFYy6Kzc/lpskdWAf9sGFNmMTFIaFhsTCYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRTI9ZHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEF7C4FEFE;
	Mon, 26 Aug 2024 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706852;
	bh=uLtdEH/FuQxQoDClWlfBImx0hkxxg7PVSYyuZWqCLZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRTI9ZHSQtN2H62kv6KB/C9fMM7rki5eqT87/BDTgc+xuc5wdC0Mgst6I6gyj0jo9
	 UF9Hdn3TlXpNucJhr9KKw5NVNGK7clp14ndv4v39vKx+mWmwhY+uKUem7+QyBkZg3K
	 HcLR/YE3cFAdfUkGpcOpr3v6b3NvLj9IkOLwsL/Ffyh8Pio8jOyi4soqjAa4jFl3Dz
	 GhZnueHT1ekUyr4wbsNEvzYWSXy+GwNuh572D/X8wXvXSC1fu9kiMNA2UU5As5ZvZR
	 /2C/EHjn6ELfqx3OmubqIlHFLQZcQu0SykDBVtqOHXUx/H3PA+YYu7a91oKle6PtIr
	 CxOjlo2T+ZJOA==
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
Subject: [PATCH 7/8] cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
Date: Mon, 26 Aug 2024 16:13:57 -0500
Message-ID: <20240826211358.2694603-8-superm1@kernel.org>
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

Don't take and release the mutex when prefcore isn't present and
avoid initialization of variables that will be initially set
in the function.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 75568d0f84623..ed05d7a0add10 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -798,17 +798,17 @@ static void amd_pstate_update_limits(unsigned int cpu)
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


