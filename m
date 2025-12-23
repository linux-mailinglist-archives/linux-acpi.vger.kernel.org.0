Return-Path: <linux-acpi+bounces-19795-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDBDCD8604
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 08:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 169A03010ABC
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF63730AAB0;
	Tue, 23 Dec 2025 07:23:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2661DF755;
	Tue, 23 Dec 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766474625; cv=none; b=DpGyys08EyngH4McAAvtH9LJH6aKK0wGobTRAC3bxeIz403+KGNO53PhL/Cg3dOhUTNr2ag9a3sqT3IucZobS/SLamDMKeA7zK2Ly7yb+dAhQcYSXlJNffZ7kBGdijTm8kdktg+M7blUzah9gK0OngtDYOvWMhfjrXUpx5AWXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766474625; c=relaxed/simple;
	bh=oLqq5nZ91lN8lwALdp6EaXOIgJSSXKiUCl006eQMyhg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ued8RUlqqsd8ByjxswfCZeS9PRNRyzpcnFvaMb35gS44RyHuZSSZ715qG+HWkPWTUNvy6QzFwemq9PJNtcBPBw4pM4KTPjzgPzku28bsZfU84NGZZrgiq4rC6znpaQwDVXyfamGu+QwFd9Ik3c+4I1t+vniUWhl/JyAb6Ek0WEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4db5y82R4YzRhRM;
	Tue, 23 Dec 2025 15:20:32 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id EF12740567;
	Tue, 23 Dec 2025 15:23:38 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 15:23:38 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <yubowen8@huawei.com>, <lihuisong@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v5 0/3] cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs
Date: Tue, 23 Dec 2025 15:21:16 +0800
Message-ID: <20251223072119.3372582-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)

Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
scheduler tick but defers the update of arch_freq_scale to a separate
thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.

However, this deferred update mechanism is unnecessary and introduces extra
overhead for non-PCC register spaces (e.g. System Memory or FFH), where
accessing the regs won't sleep and can be safely performed from the tick
context.

Furthermore, with the CPPC FIE registered, it throws repeated warnings of
"cppc_scale_freq_workfn: failed to read perf counters" on our platform with
the CPC regs in System Memory and a power-down idle state enabled.  That's
because the remote CPU can be in a power-down idle state, and reading its
perf counters returns 0.  Moving the FIE handling back to the scheduler
tick process makes the CPU handle its own perf counters, so it won't be
idle and the issue would be inherently solved.

To address the above issues, update arch_freq_scale directly in ticks for
non-PCC regs and keep the deferred update mechanism for PCC regs.

We have tested this on Kunpeng SoCs with the CPC regs both in System Memory
and FFH.  More tests on other platforms are welcome (typically with the
regs in PCC).

Changelog:
v5:
- Minor cleanup of cppc_perf_ctrs_in_pcc_cpu() (Thanks to Rafael).
- Add a function description for cppc_perf_ctrs_in_pcc_cpu().
- Pick up tags from Lifeng and Pierre, Thanks!

v4:
https://lore.kernel.org/all/20251203032422.3232957-1-zhanjie9@hisilicon.com/
- Allow either non-PCC or PCC scale_freq_tick callbacks to be registered
  for each cpufreq policy.
- Factor out cppc_perf_ctrs_in_pcc_cpu() and cppc_fie_kworker_init() for
  the above change.

v3:
https://lore.kernel.org/linux-pm/20251104065039.1675549-1-zhanjie9@hisilicon.com/
- Stash the state of 'cppc_perf_ctrs_in_pcc' so it won't have to check the
  CPC regs of all CPUs everywhere (Thanks to the suggestion from Beata
  Michalska).
- Update the commit log, explaining more on the warning issue caused by
  accessing perf counters on remote CPUs.
- Drop Patch 1 that has been accepted, and rebase Patch 2 on that.

v2:
https://lore.kernel.org/linux-pm/20250828110212.2108653-1-zhanjie9@hisilicon.com/
- Update the cover letter and the commit log based on v1 discussion
- Update FIE arch_freq_scale in ticks for non-PCC regs

v1:
https://lore.kernel.org/linux-pm/20250730032312.167062-1-yubowen8@huawei.com/

Jie Zhan (3):
  ACPI: CPPC: Factor out and export per-cpu cppc_perf_ctrs_in_pcc_cpu()
  cpufreq: CPPC: Factor out cppc_fie_kworker_init()
  cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs

 drivers/acpi/cppc_acpi.c       | 48 +++++++++--------
 drivers/cpufreq/cppc_cpufreq.c | 96 ++++++++++++++++++++++------------
 include/acpi/cppc_acpi.h       |  5 ++
 3 files changed, 96 insertions(+), 53 deletions(-)

-- 
2.33.0


