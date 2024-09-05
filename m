Return-Path: <linux-acpi+bounces-8175-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E496DFA9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2EC1C23CD2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0995152787;
	Thu,  5 Sep 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWXWfkh3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60ED2A1AA;
	Thu,  5 Sep 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553817; cv=none; b=S+lR/9EEh1oplp86KMp9ImCTEFr84RsdtHTU7g6IPJ+ANpn6nGmf4IroNgIZEJ+p+I7/6fsmUDUekPk37f0kq/H6Q2wd9/vwqkJjiVFBARrGm2WwiCG7vR2TNWsrbgem+4GqXhlQIwwEbVOidWz+tL7VGGHYSIPqJXDKEBYsjOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553817; c=relaxed/simple;
	bh=aGSV/IXaaRkWTZNeNSyIH1EiufpI+oKBGif8O/p8MsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJV3Cl7SO+8taFCWxpZElMawpDOalJGbMcmHYAwXK0GJIRbXeBM0dOWsuuZqugq72jGBrYu7/DuZM+lU/quD2aE1uU7RuNVNTcXc8HG1KKZoWI8uQP1DMflJkXrSLSPUJTWfsnIybMZO4mp+3Kbtt9HX1UUE/fcyPB+BwGD/6qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWXWfkh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAC3C4CEC3;
	Thu,  5 Sep 2024 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553817;
	bh=aGSV/IXaaRkWTZNeNSyIH1EiufpI+oKBGif8O/p8MsY=;
	h=From:To:Cc:Subject:Date:From;
	b=lWXWfkh3G/3E+N6xEFslPdSMmp+lUljGl1KnaypN/IJSpRPAi1Ylya2UCyKL8aU6f
	 vlPQ4X+AazAVKVq04b4niVglm0ysJzLVxTAf/wN+dVpHE4+c+X9DehWgee0EROcOpA
	 XHg7W08fuJXxk59DvmAdye7CnSEotb71HJqFLeKGWY8PviJd9onPNnQRp1lmZidPc9
	 8RrM6C/34Cdw5jYDte7DbqH/F/qCRs99xTTNG8eC5firjA5jrSe/j0d6mnsl166dYt
	 QNu/5+18tJFlpZFft03SRRFhgbv5nt16s8RP5Nt3efvT0QXyoXdYBVuvGCC6i4UywT
	 z12YOxANQ1vMw==
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
Subject: [PATCH v3 00/11] Adjustments for preferred core detection
Date: Thu,  5 Sep 2024 11:29:56 -0500
Message-ID: <20240905163007.1350840-1-superm1@kernel.org>
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

v2->v3:
 * Pick up tags
 * Fix LKP reported issue
Mario Limonciello (11):
  x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
  ACPI: CPPC: Adjust return code for inline functions in
    !CONFIG_ACPI_CPPC_LIB
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
 include/acpi/cppc_acpi.h                    |  41 +++--
 7 files changed, 241 insertions(+), 146 deletions(-)

-- 
2.43.0


