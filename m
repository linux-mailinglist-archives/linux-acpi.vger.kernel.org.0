Return-Path: <linux-acpi+bounces-8110-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10296A869
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE637285CA8
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC21E1D0177;
	Tue,  3 Sep 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC0WgDsN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3419F132;
	Tue,  3 Sep 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395827; cv=none; b=Y+nCIiVJ6aguPY7EZ2lxk3jFWokzHTr9ElhwXTR5MKCsOV6QjBXYkmY2i7Z6bAFOFjdmHb8sokZKcAOuaZ4GvH3i1JgkFLdOF3MlBR4XQOg03hjEIVaGPzno6axPG7sF5h6ocUgadM2oIDvwDibw1N3FEcS/POKfVoOb3CkiqoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395827; c=relaxed/simple;
	bh=JDK9jg/SbMlAoF2a1ygffMEeZkGe9IXThs5FRWGMB5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2o2uNYP9y+L6E4/GzFxTr431n8idHhIcrJfssRQKDPsrPmNsx16+rRCwuIa4IXyCvby0eHaeB3lHWSZ+cLnT9QZLb9mTzwAoZQsCBbUeqWOabfRPKiwsMuXFvHomdXS5FKg8qn8dUffiNntA9DnXOex5BKfuuDfPmn2oVSISLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC0WgDsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F864C4CEC4;
	Tue,  3 Sep 2024 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395827;
	bh=JDK9jg/SbMlAoF2a1ygffMEeZkGe9IXThs5FRWGMB5U=;
	h=From:To:Cc:Subject:Date:From;
	b=MC0WgDsNIK1x8/DoQQGDe2UUPDsJoGYC3D4/VKyNp/aG7EX0+wC4UXV5rryXlSkwq
	 nNYThS+Hd4Tg/+43caCrmHqQRXYRXu8hbOike5JO++aogWC+0SGGUtj8kfKG8ve6Uj
	 RQLBcmWVt+atztxIPcD0YSynaulXYVa6flujwLRkAj//DsgLSf7RXYm9Ffx32WSUmd
	 v85HP3Vq1r6JS6L46Fokm/lTloq8lDPwS+4wuEY3OguH4Hf9VvciajoqKAR6T+QY9k
	 qVqhrFscyYadqr/RBesDZUZ6em2/Xq/LXRH6DF4HopfX51OYY9b9RmRyUiLo4vw58P
	 kIvPAX++PSkhw==
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
Subject: [PATCH v2 00/11] Adjustments for preferred core detection
Date: Tue,  3 Sep 2024 15:36:50 -0500
Message-ID: <20240903203701.2695040-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Preferred core detection is fragile in that any CPU that reports
less than 255 for any core is assumed to be a preferred core design.
This might not always be true, so it's better to check all CPUs and
see that varying values are actually reported.

Furthermore, preferred core detection isn't used by acpi-cpufreq. So
incorrect frequencies are used unless amd-pstate is active.

This series moves preferred core detection out of amd-pstate in a more
robust fashion.  It also removes some tech debt of hardcoded values for
platforms that are actually preferred core platforms.

This branch is based off v6.11-rc6.

v1->v2:
 * Add patches for documentation
 * Add patch for existing wrong return code in header
 * Individual changes described in individual patches

Mario Limonciello (10):
  x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
  x86/amd: Rename amd_get_highest_perf() to
    amd_get_boost_ratio_numerator()
  ACPI: CPPC: Drop check for non zero perf ratio
  ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn
  x86/amd: Move amd_get_highest_perf() out of amd-pstate
  x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
  cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into
    amd_get_boost_ratio_numerator()
  cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
  cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore`
  amd-pstate: Add missing documentation for
    `amd_pstate_prefcore_ranking`

 Documentation/admin-guide/pm/amd-pstate.rst |  15 +-
 arch/x86/include/asm/processor.h            |   3 -
 arch/x86/kernel/acpi/cppc.c                 | 172 ++++++++++++++++++--
 arch/x86/kernel/cpu/amd.c                   |  16 --
 drivers/cpufreq/acpi-cpufreq.c              |  12 +-
 drivers/cpufreq/amd-pstate.c                | 128 ++++-----------
 include/acpi/cppc_acpi.h                    |  17 ++
 7 files changed, 230 insertions(+), 133 deletions(-)

-- 
2.43.0


