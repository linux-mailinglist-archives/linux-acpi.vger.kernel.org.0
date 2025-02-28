Return-Path: <linux-acpi+bounces-11637-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44428A49FAF
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35047A32A6
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCAB276027;
	Fri, 28 Feb 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR1MaukA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F60275616;
	Fri, 28 Feb 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762127; cv=none; b=B8JjK4ifmFr94PF5umE542WZomqGJlQJA4ewghnUBMcYRmj5Xyc6Uy6qNUjjoAKVQA4KJX4cPF+byAXfmQCGjtFoizyCGZNC3z1Jx9TcmQZtEOMPyCTXsDzJzUWKS52Aqb0g1mMsbmPRd3a6jKHE0LzWKLXecuLDDrTi5bbwKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762127; c=relaxed/simple;
	bh=6XEOJB505K33H8aJjMeYDJcIiEn/SVvHReqGvw7hxRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDcoDxNsVqAmUgMrRrElRPnpeBqdBGSK4+qgjBN7BsrYAVv4tcM+p9FdK7UIX5g0WJ4+mURqr58a+8Y1Lpgbk5BfJwxxaHBHCn1SUodwpT7WSvxa/MINihDH8VzSguisrV7JQh4GeBhB1L5Ta1nNsLVC1da3zv8nEhEO7lq7Fmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR1MaukA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4A8C4CEE2;
	Fri, 28 Feb 2025 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740762126;
	bh=6XEOJB505K33H8aJjMeYDJcIiEn/SVvHReqGvw7hxRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MR1MaukAeBZiy3KAbVt0Fikssh0RyxOTRLLprp1yXrturcKHkGG8dzII8jcser9gf
	 vpF5aQC1R1GJq+fvpB6BtaGtVcVQrf5kxEybVF7kZxDwU59VWqFgbmm1IAUwQyVA6k
	 Jqp/p5PdoqcZr3A2Hk/dnXrHEdduTXsj8SLoOOPNExcdBDgidDsLIlafOXYXiaysR1
	 RMlSgwzndu8BJnRZ7C3NTD+tFxL/rT8OnItGjjetCZTiiK5cdPv/aV0K9bmA2vRTs2
	 LD9od47X49PHIhPH5Nt0swe+Enfaf/M4SRcsC8km8Gytq5t8uEGuvs9oWLvMGh9Yt6
	 mYAj5LlOc6sjg==
From: Mario Limonciello <superm1@kernel.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: platform-driver-x86@vger.kernel.org (open list:AMD PMF DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org (open list:ACPI),
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/3] platform/x86/amd: pmf: Add balanced-performance to hidden choices
Date: Fri, 28 Feb 2025 11:01:55 -0600
Message-ID: <20250228170155.2623386-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228170155.2623386-1-superm1@kernel.org>
References: <20250228170155.2623386-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Acer's WMI driver uses balanced-performance but AMD-PMF doesn't.
In case a machine binds with both drivers let amd-pmf use
balanced-performance as well.

Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
Suggested-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: "Luke D. Jones" <luke@ljones.dev>
 drivers/platform/x86/amd/pmf/sps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 3a0079c17cb17..d3083383f11fb 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -297,6 +297,7 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 
 	switch (pmf->current_profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
 		mode = POWER_MODE_PERFORMANCE;
 		break;
 	case PLATFORM_PROFILE_BALANCED:
@@ -391,6 +392,7 @@ static int amd_pmf_profile_set(struct device *dev,
 static int amd_pmf_hidden_choices(void *drvdata, unsigned long *choices)
 {
 	set_bit(PLATFORM_PROFILE_QUIET, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
 
 	return 0;
 }
-- 
2.43.0


