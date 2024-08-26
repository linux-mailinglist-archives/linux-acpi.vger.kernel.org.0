Return-Path: <linux-acpi+bounces-7837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E895FB51
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 23:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136FB1F22DA5
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4861613D53F;
	Mon, 26 Aug 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KddIm9DK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053EA28DC1;
	Mon, 26 Aug 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706844; cv=none; b=VtMmiBe0VdXjZl2q7Bppyym4v3WFLpgvBdG4d03rhVsjrl5kpY7n32dWhXs2YlCns6OugOH38No4YGZmCtEVj6gJZY45YVNwZJuJ1M+33xNEXOGrTPBtxsPBcLfpCOWN53/n6OYqsh3gmHymrD4mgQ0uJReyq+2WA/Q8VcBnTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706844; c=relaxed/simple;
	bh=uLMVArZ6y0tlxqv3+lKj7kR71rCBGeCWWF4hC6WxrGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMQw7BjIt/rYPp0zAEVUSsB+kFceh6SKGEN7kSdM7r9yd0+sr5OjzDiQA9gD/pjVufdDJZ4t+HVkKsDcKdVH9/0scl/Ik+mZ1QjF6NYlAwssA8NftJx9I19gTHXc7zlrgvj2O9wSrTpVwWwwjmtsx07m7UH2VEJBabXR6F/mvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KddIm9DK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB3AC8B7D2;
	Mon, 26 Aug 2024 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706843;
	bh=uLMVArZ6y0tlxqv3+lKj7kR71rCBGeCWWF4hC6WxrGk=;
	h=From:To:Cc:Subject:Date:From;
	b=KddIm9DKI8h3oXexJgaFSaQBBBcvi9Ru3ACvRrVPFbyBniL6nYjdYkfSrUlN5et2r
	 Nk5NhBVVdTiS/PRjCsTFGTYsOArY2ygC0obFIrtaVhyug7XKrzWWCtPlgm7BilFrih
	 n//G/VYPq3bJldGZ4CZQsqauqchTj5YM8xM+1vWfypTtQC+ttQi3/pOYF3kyP+lckj
	 OHXBE1Fs4svx8thQa2Gvbq4q/MoUluWbnpcjjFzt30yRWbcTMbPoJ1qqPINm4QZNL/
	 Bqy/LdbsDLTY39tIIUZkXV8qrDbXeZ0aruhEYH/KGxWG7tkSz5TYSs5dJBtfq7HIdd
	 Ysx5I6dl6YLzw==
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
Subject: [PATCH 0/8] Adjustments for preferred core detection
Date: Mon, 26 Aug 2024 16:13:50 -0500
Message-ID: <20240826211358.2694603-1-superm1@kernel.org>
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

This branch is based off v6.11-rc5.

Mario Limonciello (8):
  x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
  x86/amd: Rename amd_get_highest_perf() to
    amd_get_boost_ratio_numerator()
  ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn
  x86/amd: Move amd_get_highest_perf() out of amd-pstate
  x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
  cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into
    amd_get_boost_ratio_numerator()
  cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
  cpufreq: amd-pstate: Drop some uses of cpudata->hw_prefcore

 arch/x86/include/asm/processor.h |  14 +--
 arch/x86/kernel/acpi/cppc.c      | 159 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/amd.c        |  16 ----
 drivers/cpufreq/acpi-cpufreq.c   |  12 ++-
 drivers/cpufreq/amd-pstate.c     | 132 ++++++-------------------
 include/acpi/cppc_acpi.h         |  10 ++
 6 files changed, 203 insertions(+), 140 deletions(-)

-- 
2.43.0


