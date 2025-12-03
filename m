Return-Path: <linux-acpi+bounces-19396-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E89C9DA36
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 04:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C303A12FF
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 03:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DBB24466B;
	Wed,  3 Dec 2025 03:25:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E923AB98;
	Wed,  3 Dec 2025 03:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732333; cv=none; b=lnFVatdHNRw0qhLfdYVHrQQoLBCDqqDg7PzPa3HmnW0vp1yLwLtlLm3IH5gUFlpjy4p/8hHY2V3Q5M2QgobuTVzDj5x6+EkzmHu/W+YkNrgY+77xdU9jqGO6hzBqNBi/goD8N2bW87Wg6VydrC5DJUCq5q0GZ23S8SirUml7LxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732333; c=relaxed/simple;
	bh=doRtcNjmH0RXg2fgHNyBfeLeq9VONQyiFn0hHM+kyWs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IiuHCLsCI5jrAjTbBl0oA5Rw6g9ygzxxAkLZBvayegHhsqyCh/2tE6Pgu0jZGqpcgPTJqX2Tz2OquQbm25MgxkCEa+YLlv4dZILJOJxEKi98bSMWJSlq7hyT6Nsa2DGa1OpHg89UEn0FyE/xiJEFPoxBdgKVa4v/xLeO9jjIts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dLjdw5Y6fz1K96F;
	Wed,  3 Dec 2025 11:23:32 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 2626F180043;
	Wed,  3 Dec 2025 11:25:23 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Dec 2025 11:25:22 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <yubowen8@huawei.com>, <lihuisong@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v4 0/3] cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs
Date: Wed, 3 Dec 2025 11:24:19 +0800
Message-ID: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
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
v4:
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

 drivers/acpi/cppc_acpi.c       | 45 ++++++++--------
 drivers/cpufreq/cppc_cpufreq.c | 96 ++++++++++++++++++++++------------
 include/acpi/cppc_acpi.h       |  5 ++
 3 files changed, 93 insertions(+), 53 deletions(-)

-- 
2.33.0


