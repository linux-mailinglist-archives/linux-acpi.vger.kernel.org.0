Return-Path: <linux-acpi+bounces-20790-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMbvIRtwfWmzSAIAu9opvQ
	(envelope-from <linux-acpi+bounces-20790-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 03:59:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF540C06DE
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 03:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60543036D77
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 02:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105CC331203;
	Sat, 31 Jan 2026 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mpfL96Hx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062F334685;
	Sat, 31 Jan 2026 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769828313; cv=none; b=rD4swDoMz5rdWK3eCnsapzCcuaiuTLcdAZXnY5BWBHXEAGmSm3Ac9qmZgg4HIwOnk9S5O+DrEbJ9mYP43GfevZ+GABNaGjE6CUAQXn2+Z9XYy4yjtCko6NRNOe/0O4uMMsCfAe3Ae5bJ3l/iGScasnsRD/jj0osA1PQSyv8iHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769828313; c=relaxed/simple;
	bh=Dqkwnz4JyEy4loQ8EYMnImJvtidGxEflCqTxc7JXwS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ki1PEAK+X9vxJO4UlyYqj+f1cVSnAMk1ShZ3lho9ihvclFiL+5oXyDtvsZQnbDEngBGDONJA/vDGAaTVVzKxqmkEV0NUcl4bhm+if7UvdTYAi6NDZVqHVUc2XIpEC/aNl5Kfg9OhyrIeqRxPa1ZxKjbyVeWRyJ/q9BFi/63c6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mpfL96Hx; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7XHWaZHFKtL0PySE53UufCAynSolWQJ0darNOPXOVKA=;
	b=mpfL96HxwL15BL2vpD0Fd+Rr/YzpTjSvOSWcR8dQvMGyTlzNyAhjwBhWZ0zgQuXhKy2g7PFAl
	D5fxNjfzgsaPgrhtx3U46DOF+bN22CKmS/GJ8wMT2pWKqycvFBbiIxyy6KU83SYgc2go2iQe/47
	5tvkLmWkP5aEgdZtMAuMdxc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4f2yC74Hj7z12LDp;
	Sat, 31 Jan 2026 10:54:27 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 437C240539;
	Sat, 31 Jan 2026 10:58:20 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Jan
 2026 10:58:19 +0800
Message-ID: <73bf9b60-7a76-4648-98cf-c37901eb7b0a@huawei.com>
Date: Sat, 31 Jan 2026 10:58:18 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Enhanced autonomous selection and improvements
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <pierre.gondois@arm.com>
CC: <ionela.voinescu@arm.com>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20260129104817.3752340-1-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260129104817.3752340-1-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-20790-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: DF540C06DE
X-Rspamd-Action: no action

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

On 2026/1/29 18:48, Sumit Gupta wrote:
> As discussed in [7], v5 was split into two parts. This is part 1.
> - Patch 1-3 from v6: Applied by Rafael for 6.20.
> - Remaining patches: Included in this v7 with review comments addressed.
> Part 2 (v5 patches 8-11) will follow separately.
> 
> This patch series adds sysfs interfaces for CPPC min_perf, max_perf,
> and perf_limited registers, along with supporting ACPI APIs and
> improvements for the cppc_cpufreq driver.
> 
> CPPC autonomous mode (auto_sel) enables hardware-driven CPU performance
> scaling using Energy Performance Preference (EPP) hints. Currently,
> there's limited runtime control and visibility into CPPC performance
> registers.
> 
> This series addresses these gaps by:
> 1. Exposing min_perf/max_perf registers via sysfs (as frequency in kHz)
>    to allow fine-grained performance bounds control in autonomous mode.
> 2. Exposing perf_limited register to detect and clear throttling events.
> 
> It also includes code improvements: new APIs for reading performance
> controls, a warning for missing mandatory DESIRED_PERF register, and
> extended epp_perf support.
> 
> The patches are grouped as below:
> - Patch 1: Add cppc_get_perf() API (independent).
> - Patch 2: Warn on missing mandatory DESIRED_PERF (independent).
> - Patch 3: Extend cppc_set_epp_perf for FFH/SystemMemory (independent)
> - Patch 4-5: APIs, sysfs for min/max_perf, perf_limited (independent)
> - Patch 6: Doc for min/max_perf and perf_limited (depends on 4-5)
> - Patch 7: Update cached perf_ctrls on sysfs write (independent).
> 
> ---
> v6[7] -> v7:
> - patch 1-3 (v6): Dropped as they were applied by Rafael for 6.20.
> - patch 2 (v7): Added new patch to warn on missing DESIRED_PERF as
>   suggested by Pierre.
> - patch 4, 7 (v7): Removed mutex from sysfs store functions as
>   policy->rwsem already provides synchronization.
> - patch 4 (v7): Added validation checks in store_min/max_perf.
> 
> Sumit Gupta (7):
>   ACPI: CPPC: Add cppc_get_perf() API to read performance controls
>   ACPI: CPPC: Warn on missing mandatory DESIRED_PERF register
>   ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
>   ACPI: CPPC: add APIs and sysfs interface for min/max_perf
>   ACPI: CPPC: add APIs and sysfs interface for perf_limited
>   cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
>   cpufreq: CPPC: Update cached perf_ctrls on sysfs write
> 
>  .../ABI/testing/sysfs-devices-system-cpu      |  44 ++++
>  drivers/acpi/cppc_acpi.c                      | 214 +++++++++++++++++-
>  drivers/cpufreq/cppc_cpufreq.c                | 207 ++++++++++++++++-
>  include/acpi/cppc_acpi.h                      |  40 ++++
>  4 files changed, 500 insertions(+), 5 deletions(-)
> 
> [1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
> [2] https://lore.kernel.org/lkml/20250823200121.1320197-1-sumitg@nvidia.com/
> [3] https://lore.kernel.org/lkml/20251001150104.1275188-1-sumitg@nvidia.com/
> [4] https://lore.kernel.org/lkml/20251105113844.4086250-1-sumitg@nvidia.com/
> [5] https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
> [6] https://lore.kernel.org/lkml/20260120145623.2959636-1-sumitg@nvidia.com/
> [7] https://lore.kernel.org/lkml/66f58f43-631b-40a0-8d42-4e90cd24b757@arm.com/
> 


