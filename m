Return-Path: <linux-acpi+bounces-8184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A8096DFC6
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E1F1C23B74
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23081AD24A;
	Thu,  5 Sep 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDBnH6uM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677919DF4F;
	Thu,  5 Sep 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553828; cv=none; b=AaNTyW+zSEzD4TvCwnuGaVEu+embesScZcr1PfzsdUgtXUMvPVDzERQTVgoyls2Na89mFDSxDNEExMIfZF/g+6a9S7C7JJX+BapMop/+n/2A9dj28zsvTMfUhQeYWHVTD/hEbTbRMkF01vxbT46mVN0GVjmqfjkjcUZDdF0glyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553828; c=relaxed/simple;
	bh=+sHrHnLT2FfYkGdEfPvMGy5X5VchYsR5Qb+fThI971s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePE7aIES5+m8ug8vuAJZCE6hdrKBHLUX0+5+zuA2V1PhoBkLYk/3V91I79sjdejMgZVufTwibSwt65Hs6aJisQzS25yu8e06/FGpzJ3PgoHUeYDjbCepbzLUn+I+2QOvy7LhiOrFItof4yFc/pfus3OxLcFwMQG6jJ7e3MQTqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDBnH6uM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40559C4CECC;
	Thu,  5 Sep 2024 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553828;
	bh=+sHrHnLT2FfYkGdEfPvMGy5X5VchYsR5Qb+fThI971s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDBnH6uMKXrNppDFxcEi30uU1d9AUGQ8jutZRjvtXvmS78neX2sE7GVQYrZ0fXEaK
	 KsFVUKDApoKvFDRu/01w16dAfCJ9cHzM322GBdl+NQAlAb3kdqC3UU49PRGdyfg0bG
	 Lipd6KhoUvMm5QylDKb67VoYYj2NrHoLqO9cJs4nJ3bTHTMXdDHQZ2WOYRnpXAMm35
	 zw9Pl2NqWod14s7TFL1Q3lWd2c/cgKb5jxeIJJ4agOCp+lzVGx19bcav1Zfm2oYPqf
	 UaUXdz5rjPiccD4NwIZ9QcVL5Ee40P4yAHx8u+9zb8i9OWlQ5bNuogwTkFO0dtnsqp
	 /O0ZDeGetTl/g==
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
Subject: [PATCH v3 09/11] cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
Date: Thu,  5 Sep 2024 11:30:05 -0500
Message-ID: <20240905163007.1350840-10-superm1@kernel.org>
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


