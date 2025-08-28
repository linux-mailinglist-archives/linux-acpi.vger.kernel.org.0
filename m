Return-Path: <linux-acpi+bounces-16136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13556B39B12
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843701B27F4B
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E730DD23;
	Thu, 28 Aug 2025 11:09:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7602E371F;
	Thu, 28 Aug 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379390; cv=none; b=t5gs2AMzdDIP3EnC227ZO2PytQhTPexSVM/TjI56/LqNLB5fQq2zkz1tEGYrrDU8kkq/fOnHzXGbdRBBz4MfkPEScAqvmC1TU3ydOEAN5XWpjnSfgcqb5/z+1jMYDGFSvU5V9yx8Pf9PH6zyqazxAh7vtUnd8u2UA77/oSp8hjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379390; c=relaxed/simple;
	bh=+k4eAvJpmjns5X1DgKnXte3sMig9v+VmdsKLWI7eltU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fr4LiTG0pHD+HC8Bd0bdvYiK/5KrChkPtWI1SgO2pFpC6/a6KIwkKwjct+huvJrDEaD2hlBjXimkDukOQQTV4BsNqD38EszrEqmrnSEP5D5tXrxkg5yMnMVUbRoMgYe1dzCd4Gril0f2jqlZPZOH2BRtS7OaoewVnRiHGAdmBy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cCJYT4l2RztT9q;
	Thu, 28 Aug 2025 19:08:45 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B8E8140123;
	Thu, 28 Aug 2025 19:09:43 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100006.china.huawei.com (7.202.195.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 19:09:42 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 0/2] cpufreq: CPPC: Rework FIE warning prints and cppc_scale_freq_tick()
Date: Thu, 28 Aug 2025 19:02:10 +0800
Message-ID: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100006.china.huawei.com (7.202.195.47)

Reading performance feedback counters on offline or low-power idle CPUs may
return 0, which is interpreted as -EFAULT.

This leads to two issues related to the CPPC FIE:

1. When booting a subset of CPUs in policy->related_cpus (some CPUs under
the cpufreq policy is offline), there are warnings of "failed to read perf
counters for cpu" during the CPPC FIE initialization.

2. On our platform with the CPC regs in System Memory and a power-down idle
state enabled, if the CPPC FIE is registered successfully, there are
repeated warnings of "failed to read perf counters" because
cppc_scale_freq_workfn() is trying to access the counters of remote CPUs
that enters the idle state.

To solve the above issues:

Patch 1 removes the warning when the CPPC FIE initialization fails to read
counters on offline CPUs and changes the log leve to debug.  This can be
applied separately.

Patch 2 moves the update of FIE arch_freq_scale into ticks for non-PCC regs
and maintains the existing mechanism for PCC regs, such that reading
counters would be triggered on the local CPU only.  This inherently solves
the issue in [1].  We have tested this on Kunpeng SoCs with the CPC regs
both in System Memory and FFH.  More tests on other platforms are welcome
though.
[1] https://lore.kernel.org/linux-pm/20250730032312.167062-3-yubowen8@huawei.com/

Changelog:

v2:
- Update the cover letter and the commit log based on v1 discussion
- Update FIE arch_freq_scale in ticks for non-PCC regs

v1:
https://lore.kernel.org/linux-pm/20250730032312.167062-1-yubowen8@huawei.com/

Jie Zhan (2):
  cpufreq: CPPC: Don't warn if FIE init fails to read counters
  cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs

 drivers/cpufreq/cppc_cpufreq.c | 64 +++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 25 deletions(-)

-- 
2.33.0


