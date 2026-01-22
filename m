Return-Path: <linux-acpi+bounces-20504-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFu3NWThcWk+MgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20504-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 09:35:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB7632A1
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 09:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50E4E5C0F87
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00215330B2D;
	Thu, 22 Jan 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EjQ2gqNN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D4299927;
	Thu, 22 Jan 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070516; cv=none; b=hQdvkZ8gis/T1NqZZOwKafjrxnExCakf/MSIlaIV32h2ajIv/6VkxFWwg8A/XSNMbgLmnsuYGPrag+qnLqA1swMMuy5s0SndWQUoD/6zNmUeOwlexsEflINRW1nJeVQ0MRUPzHRz5glY49HgRzM9uK6q4OMlIfIuuJjyZMJjUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070516; c=relaxed/simple;
	bh=J/Yzk4A0L7REgTNPMuGEIPtJcNrYGya8ppLCZ4QsVxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qeAw4hnl3nGTeb9p4vriPheOWLZ9PDhFeUAhbhSGDAaW5XDuC78+/FYsDr8l0mrVDcMw08+A9xF66DmYujUst/zBYb5p3384Vo5fFVnNtaiAuM3Q1auP15dtiq0qdGusQgZK3raEU9hE9NAnb2aLjJq+Wh8HSiRsl4MAhvkS144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EjQ2gqNN; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HESKvwU4woK5zrACqo9MmetAJNqyrF5d2pUurtkl6os=;
	b=EjQ2gqNN0+NOOheZBaocJKqDVYPXXlw/TlGjX6zyzgUgdJA3fbu+kx9w9GInawI9ghk03T4N1
	rqLFmStJpOqpv1A+wUsZjCoK2mBZF63PHypYu83frUkNcz4uCHGD4QmXiWWxKgXLRKpauk+4dtR
	E+MVD9FrS5sNM1374O1og/Q=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dxYy81w8hz12LDK;
	Thu, 22 Jan 2026 16:24:32 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AB214056A;
	Thu, 22 Jan 2026 16:28:30 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 16:28:28 +0800
Message-ID: <04a81749-54b9-485b-84a2-4b9805f194a9@huawei.com>
Date: Thu, 22 Jan 2026 16:28:28 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] ACPI: CPPC: Clean up cppc_perf_caps and
 cppc_perf_ctrls structs
To: Sumit Gupta <sumitg@nvidia.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-3-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260120145623.2959636-3-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20504-lists,linux-acpi=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,nvidia.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: BDFB7632A1
X-Rspamd-Action: no action

On 2026/1/20 22:56, Sumit Gupta wrote:
> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>   the same is available in 'struct cppc_perf_ctrls' which is used.
> - Move the 'auto_sel' field from 'struct cppc_perf_caps' to
>   'struct cppc_perf_ctrls' as it represents a control register.
> 
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  include/acpi/cppc_acpi.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 4bcdcaf8bf2c..6573a759eb8d 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -119,8 +119,6 @@ struct cppc_perf_caps {
>  	u32 lowest_nonlinear_perf;
>  	u32 lowest_freq;
>  	u32 nominal_freq;
> -	u32 energy_perf;
> -	bool auto_sel;
>  };
>  
>  struct cppc_perf_ctrls {
> @@ -128,6 +126,7 @@ struct cppc_perf_ctrls {
>  	u32 min_perf;
>  	u32 desired_perf;
>  	u32 energy_perf;
> +	bool auto_sel;
>  };
>  
>  struct cppc_perf_fb_ctrs {

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>


