Return-Path: <linux-acpi+bounces-7845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48A995FB6A
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4871AB23E36
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE219DF92;
	Mon, 26 Aug 2024 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC93JVPk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DD19DF82;
	Mon, 26 Aug 2024 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706853; cv=none; b=icPiRRf7RHQUwR2FSNDrVbFfREY17eRkg30Zd85PDopZrZ3QJ3F1yMFMXD75KmNLUBuKDS+plDsx/yQwiFpNd+JS92eDcSvJxaikq6z1pTXnbLvQh50jTUphfj6y8EN3ffvjqQ99QF2FHSVCSvzxBAxfK89zQRxeWSTgrxfH11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706853; c=relaxed/simple;
	bh=/ftcgDwz/nWWyTslIh+d25Uxgj0lFGTkhwvF2OIiRu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shc0FUUSQ5uEUqR3ZNFb1T27yjyzXfehErBzmX5gBRNcqMzDBY79xODkKDtk7ME380e8DCqroJ9i/smawATcAxijVSxMGDNTg0M6sCdAVcd7+N5TUpNNz8cebW5zd3zUlIsClJi6iKcFYyOg7rjwGBE8wFlCwUSpOpYDkti7P2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC93JVPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426FCC4FF45;
	Mon, 26 Aug 2024 21:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706853;
	bh=/ftcgDwz/nWWyTslIh+d25Uxgj0lFGTkhwvF2OIiRu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vC93JVPkZ2ImvCxQZ0FZtPjSAQe2dhdVVAuSVVXMe411x/o2lH+Ee13+anIK6wVbi
	 EkMAh5RMCpZ3FuYSJZHdpKXfhvKbf+jvr7EkyuVauNZJ/zMAcdTSVSENh9sc4zvZX/
	 kjsKdNOyQEBU+dIYRxJY6MrCegR5AZJ0YrhglqdxH4mAU4XIywXKGFkWQCo8HmK0Qs
	 +jpPa8hKU1kF1HhKJvdxQ1egZsINxPgQ3hVlwsjvUnSqafuGDl61t25iaiWFQQMFL9
	 azkuQ/a588RgYcqaa4x8dq7dYHBILk6OjCuaZgMR2mTxAAm4nHHqdgbgSxjf2v35fi
	 FIcSPH1LOld+w==
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
Subject: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of cpudata->hw_prefcore
Date: Mon, 26 Aug 2024 16:13:58 -0500
Message-ID: <20240826211358.2694603-9-superm1@kernel.org>
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

As the global variable is cleared when preferred cores is not present
the local variable use isn't needed in many functions.
Drop it where possible.  No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ed05d7a0add10..257e28e549bd1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1112,12 +1112,7 @@ static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
 static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
 					   char *buf)
 {
-	bool hw_prefcore;
-	struct amd_cpudata *cpudata = policy->driver_data;
-
-	hw_prefcore = READ_ONCE(cpudata->hw_prefcore);
-
-	return sysfs_emit(buf, "%s\n", str_enabled_disabled(hw_prefcore));
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
 static ssize_t show_energy_performance_available_preferences(
-- 
2.43.0


