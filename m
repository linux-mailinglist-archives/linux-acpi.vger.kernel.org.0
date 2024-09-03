Return-Path: <linux-acpi+bounces-8115-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7534496A877
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209DF1F25346
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCEE1D7E3A;
	Tue,  3 Sep 2024 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixVAwutH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515661D7E33;
	Tue,  3 Sep 2024 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395833; cv=none; b=ZZjhQu+QE/F8DXIk7TSmaYTMpAx7Kp6djaC2T4Wt68YtoNnqLAzJz1pMD/2ecPck3unBjDiUstvqqfmciaV+0BXBg2FF1WcesqbLMM4mGOV00FDVYzJuCy0bLRqXAQ1sVGfHmq1rJ9WE6jtFk3+JIkDpZpVSCCP2JOMweqyvt28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395833; c=relaxed/simple;
	bh=SN+VV989YznpmWRMUK1wgF+lwg7k+mPg1elKKPJ0iac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HncE93jDq70Rl3Qk6vGnLn2amwIqoHMHIGBht6tXGDAQUFcoQU7QmS4meG18kmCFgtqNo3ve8EZY4C3yaLR9D2RaPL/Ugi/dGQqmWPgmXZ2GKf5FuGINzFA3RHsOkxTmrKCaj1C/IffLMp3iIYBoUhkBYK1pL/XUFb6xL2lBjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixVAwutH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EFAC4CEC4;
	Tue,  3 Sep 2024 20:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395833;
	bh=SN+VV989YznpmWRMUK1wgF+lwg7k+mPg1elKKPJ0iac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixVAwutHtL02xbnB8qO49uB5L9k/IeqpEv6thuYVKgvqq7Bszpr9kxLEeJAy+Ro1X
	 3gjUDXh5j3mYVmTk5RmiyFvnnotmSfDu9ce4d9BYlj9c6WPQ+yczGyL2R0U9SesMzC
	 jDZDaanpr5ePw+Umt5zHKkQIeLJb3QdKK+i687viytt/nO8+UjXh+fIO1CBK37bd96
	 3trnlhnCUyiVReYP/2iD0Y/zYcH4Ni57LOxQq/4i09DepYFlHmXVGNLB6vLM+cIn+A
	 Ssm0YVmUmN9PL6HQAotODYWIibwE5BZa2Rw0ChUzG7s4zHvjqWPLsRO1GUuN7MEiv+
	 xrdCJg1tgZsPQ==
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
Subject: [PATCH v2 05/11] ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn
Date: Tue,  3 Sep 2024 15:36:55 -0500
Message-ID: <20240903203701.2695040-6-superm1@kernel.org>
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

If the boost ratio isn't calculated properly for the system for any
reason this can cause other problems that are non-obvious.

Raise all messages to warn instead.

Suggested-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index e65c77afab318..f0328ce98a8fe 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -75,19 +75,19 @@ static void amd_set_max_freq_ratio(void)
 
 	rc = cppc_get_perf_caps(0, &perf_caps);
 	if (rc) {
-		pr_debug("Could not retrieve perf counters (%d)\n", rc);
+		pr_warn("Could not retrieve perf counters (%d)\n", rc);
 		return;
 	}
 
 	rc = amd_get_boost_ratio_numerator(0, &numerator);
 	if (rc) {
-		pr_debug("Could not retrieve highest performance (%d)\n", rc);
+		pr_warn("Could not retrieve highest performance (%d)\n", rc);
 		return;
 	}
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (!nominal_perf) {
-		pr_debug("Could not retrieve nominal performance\n");
+		pr_warn("Could not retrieve nominal performance\n");
 		return;
 	}
 
-- 
2.43.0


