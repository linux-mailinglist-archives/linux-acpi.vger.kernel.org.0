Return-Path: <linux-acpi+bounces-8114-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FABF96A874
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B22B1F24FE3
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF41D6C48;
	Tue,  3 Sep 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efGuMUl8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4D1D61AB;
	Tue,  3 Sep 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395832; cv=none; b=IkGdVR49YpULHe5ezMuMTSDCf9qNlpU3BPrfbUBuVZxZjQlcOyrWNVUhW8r4gK/DhccR75Z4mGOqMHC+XVEJ65f5b9y5Op7kU60aIJgfYP0pLsIn+CUroFt8TDYVN6+4tz3gUMJAvSf4B2K+O8TrEsjdoA35miHf0XNg+P3q5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395832; c=relaxed/simple;
	bh=N2GFaa3eJHSuP/iXB7Y6AJm4+p9aQEYX+joUCXAhIsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqaLgRC0f7lFW15fvID1X3KiLgJcB+xbcccR+k2Ti9HZLJMMLOnVrVZHMVN0o2xMQHbLiu0KnMLvo0tIs5qwTquhN+wHeaygdySwH2jV8R3a6pnEhKkiyjKN4oVu2SrdMSQC5FFV7HyuyzSwxGVgzynxZk/EdWI/2HnsjzA6kkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efGuMUl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8CCC4CEC8;
	Tue,  3 Sep 2024 20:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395831;
	bh=N2GFaa3eJHSuP/iXB7Y6AJm4+p9aQEYX+joUCXAhIsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efGuMUl8biHaNzyy2SQl5XNl7C8ZCtrPtncUqRSYuETZgBI35tcP7CY4jXQ37pyRa
	 Sa7ZWMxrQzbn/v7aB4Xvx7aFFGoQZ+ipjOopRJl7OZfjb/5Zvesv5y4AlLSM3OWvLa
	 ud6g9iDRSGSw9/DOFcks0G3X45adG/wrQ8Z4qba0qA9dVPLzSVcHT/4Pspu+tqysGY
	 BV/NzESS/ThENKCmheMfafRUzjI88f+VBOJzW++bsfTH3GoSVKmibA+o/p3sZMfTwq
	 Vh5WuT/aMht6cVqmMOG3J1J5Gc84mm2D/dQZvD6g6MApmmwJgFTCiFqAf1bctILUh0
	 C5+ytqT6wxSug==
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
Subject: [PATCH v2 04/11] ACPI: CPPC: Drop check for non zero perf ratio
Date: Tue,  3 Sep 2024 15:36:54 -0500
Message-ID: <20240903203701.2695040-5-superm1@kernel.org>
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

perf_ratio is a u64 and SCHED_CAPACITY_SCALE is a larg number.
Shifting by one will never have a zero value.

Drop the check.

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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


