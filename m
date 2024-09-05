Return-Path: <linux-acpi+bounces-8179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025C96DFB6
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF231F237DC
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C650C1A2C26;
	Thu,  5 Sep 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOBw9jGW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A51A2C14;
	Thu,  5 Sep 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553822; cv=none; b=t/n8WvELJhViCkOjdsmTBYKdpwoKBR90hsMQImff0BdUr5rPjFLs+KdTe4dJL955LHfBqk/ZHyCo4U7r0YAlv7rqXPDQXM2ruS00gG5e+JR8QeGaEB6OstdX8Zho1+uf5eJ9i+uhrnpZd45VymkbyKx4YJ3ga6UO+AhYhUAWmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553822; c=relaxed/simple;
	bh=Zt3i+cvHegpXXitpCTq/1E918OQsdv+WUjbGkfVqzaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP7BtSOjwC3/OXE1lTRWEFTvjd2bqD7JWH4szUpwqeM3BI5HhHCIycJVT9NcChNecvxmQZp61E5bf/+7X3ExDLQyTaZnSLIvv4eK9xSlIii9LTdJNYZZGn6An6oDWDXlEaeBiJleBHUF4kmdBodbOFwu6WXJb8ItQS3UAQGdFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOBw9jGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290D7C4CEC3;
	Thu,  5 Sep 2024 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553822;
	bh=Zt3i+cvHegpXXitpCTq/1E918OQsdv+WUjbGkfVqzaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOBw9jGWBy6zH4mf7er170DBKItNU2UaaG4P/92GcBFXTjwYd70aDDdHQ+CcFgFUF
	 k6SifQsr9Y/BmL+dV2e02RXQnCHzxkt0KHKJ8UmbhtrcIM23KWtANvbc6v4kunvuge
	 RSy7uiJI+sfZ9dntVp5xjpncb1XvfQzJGQH2KaMf/y42Mdi+reQSF4G6wm2V0Mctwj
	 H+VAsAHF+12/bQLQm++BylRbk8zdTiNG+rQeVzO2pxZrNG2eY2i9V/7RI2u1A5NXVe
	 eqilM77OgaCD+XuUJKdT4tHdzuNVMc/JtsQwRG53YuS1q5lqi7CBr473l4kRDwH9al
	 E6b3vcWhar2XQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R . Shenoy" <gautham.sheoy@amd.com>
Subject: [PATCH v3 04/11] ACPI: CPPC: Drop check for non zero perf ratio
Date: Thu,  5 Sep 2024 11:30:00 -0500
Message-ID: <20240905163007.1350840-5-superm1@kernel.org>
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

perf_ratio is a u64 and SCHED_CAPACITY_SCALE is a large number.
Shifting by one will never have a zero value.

Drop the check.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.sheoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Correct typo in commit message
 * Pick up tag
---
 arch/x86/kernel/acpi/cppc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 660cfeb6384ba..e65c77afab318 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -91,13 +91,8 @@ static void amd_set_max_freq_ratio(void)
 		return;
 	}
 
-	perf_ratio = div_u64(numerator * SCHED_CAPACITY_SCALE, nominal_perf);
 	/* midpoint between max_boost and max_P */
-	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
-	if (!perf_ratio) {
-		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
-		return;
-	}
+	perf_ratio = (div_u64(numerator * SCHED_CAPACITY_SCALE, nominal_perf) + SCHED_CAPACITY_SCALE) >> 1;
 
 	freq_invariance_set_perf_ratio(perf_ratio, false);
 }
-- 
2.43.0


