Return-Path: <linux-acpi+bounces-6549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BC910BAE
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 18:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E0F2826F6
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1F1B29BE;
	Thu, 20 Jun 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="mUIFHveI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26EB1B29A4;
	Thu, 20 Jun 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900099; cv=none; b=KDo2Jdq5h0Cls97o77p3cBELcN+bnbxEIYLy+HnJALhji6qMKqsztIYCcWkd+N0fFYRsaOC7Du10VLmiOFQbjGQENFKdk6Td0OkW0AcpX6dYUj0CUaYqyuk/nqaLSsdYF7GICt2cf+MgrnjDd7GsnJ+yTSohkv0HwkaXpRanG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900099; c=relaxed/simple;
	bh=+EKV5AxHovF3V+5mH8rAZYNVsw/V8pR/PzLDsahGGlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvEkSnvlER3n5GnFnA6LKxMKwPtRQOk5YTm2jhzDbiHi/pUBvAxWI2AgbQR350Xs4bX20P1ieiX2h8B/xgE+q3VAIA/GahgkGoZpJRVhRYpDV0JDHG7dUZ0sGyNZN0pD2Ap62JWGbWSTPaXGsR5SwHO+VC2jT5BIZFeLHZrpkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=mUIFHveI reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5242e261afb4306f; Thu, 20 Jun 2024 18:14:54 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DCA3C6A7AE3;
	Thu, 20 Jun 2024 18:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718900094;
	bh=+EKV5AxHovF3V+5mH8rAZYNVsw/V8pR/PzLDsahGGlc=;
	h=From:To:Cc:Subject:Date;
	b=mUIFHveIkUT6u7RajyME0O5sYywcrPsHEUaK+8ucCZ2Qa3/GMmozOXdNVWBneBZbU
	 SZqiZnl7TKSk5K6thh6J/pGbMOxgEKYj590ectBdyI2zTyzoZcVePpsW+dpwoeF137
	 YAbvjhW994Ana4yPDKOwRMmCFAORueMLP2H7dBI+vTvH/zUywcwqoBYXpcH2CdlSZw
	 KjLKCH7hoz3CpX+SLLIKbT6EU11KDPyAcjCfsAGDpCRrs2oO6Ub9yL267cBcR6khhm
	 pXGZTGE6OtMe95432TPNFDRbuhvWY9K8YNGeYXSRVBhD65/H8ikME92Al6wBpPsIsx
	 RdU9Ncu1QQiZw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Aaron Rainbolt <arainbolt@kfocus.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Use HWP to initialize ITMT if CPPC is
 missing
Date: Thu, 20 Jun 2024 18:14:53 +0200
Message-ID: <12460110.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeefvddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhgrihhnsgholhhtsehkfhhotghushdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that single-thread performance on some hybrid systems
dropped significantly after commit 7feec7430edd ("ACPI: CPPC: Only probe
for _CPC if CPPC v2 is acked") which prevented _CPC from being used if
the support for it had not been confirmed by the platform firmware.

The problem is that if the platform firmware does not confirm CPPC v2
support, cppc_get_perf_caps() returns an error which prevents the
intel_pstate driver from enabling ITMT.  Consequently, the scheduler
does not get any hints on CPU performance differences, so in a hybrid
system some tasks may run on CPUs with lower capacity even though they
should be running on high-capacity CPUs.

To address this, modify intel_pstate to use the information from
MSR_HWP_CAPABILITIES to enable ITMT if CPPC is not available (which is
done already if the highest performance number coming from CPPC is not
realistic).

Fixes: 7feec7430edd ("ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked")
Closes: https://lore.kernel.org/linux-acpi/d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org
Link: https://lore.kernel.org/linux-acpi/ZnD22b3Br1ng7alf@kf-XE
Reported-by: Aaron Rainbolt <arainbolt@kfocus.org>
Tested-by: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: 5.19+ <stable@vger.kernel.org> # 5.19+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -355,15 +355,14 @@ static void intel_pstate_set_itmt_prio(i
 	int ret;
 
 	ret = cppc_get_perf_caps(cpu, &cppc_perf);
-	if (ret)
-		return;
-
 	/*
-	 * On some systems with overclocking enabled, CPPC.highest_perf is hardcoded to 0xff.
-	 * In this case we can't use CPPC.highest_perf to enable ITMT.
-	 * In this case we can look at MSR_HWP_CAPABILITIES bits [8:0] to decide.
+	 * If CPPC is not available, fall back to MSR_HWP_CAPABILITIES bits [8:0].
+	 *
+	 * Also, on some systems with overclocking enabled, CPPC.highest_perf is
+	 * hardcoded to 0xff, so CPPC.highest_perf cannot be used to enable ITMT.
+	 * Fall back to MSR_HWP_CAPABILITIES then too.
 	 */
-	if (cppc_perf.highest_perf == CPPC_MAX_PERF)
+	if (ret || cppc_perf.highest_perf == CPPC_MAX_PERF)
 		cppc_perf.highest_perf = HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
 
 	/*




