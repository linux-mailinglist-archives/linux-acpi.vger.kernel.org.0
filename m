Return-Path: <linux-acpi+bounces-7923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3972962463
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 12:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7AC1F24ACD
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0300E168486;
	Wed, 28 Aug 2024 10:12:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B0815852F;
	Wed, 28 Aug 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839939; cv=none; b=PaANi8lKIBgERPeCPuSegem76TvqnopAvachCEOE0Gij1dsdLR+9P0FVDMk9I3tqzrvR1D4FaYUk4d4Tp/t2FiRDNxA/FTMdk6z1nWzckZsk62NFr/yo00Wsp2EhOdR6SSUR9cyrGATkScxpkv0lyipBGA/0m2BDcJM/sWdJT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839939; c=relaxed/simple;
	bh=EExO7MdS4y5FnR306+3a8K3/hrxpqNnVoyEWqBHwFxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyTEH0+PCqNJcTn5Q3HG2gjQ/i/auCcnPOT8N8RUrbZb2qqhN2Yr/Nyde2Ram//Vj8zGXE35R0uAsSg1U6aDvXHPGQfTxU5opfd6Z1phkAXJ7DW7z5EQPoyXnxfo30sU9M55RL/MzwBto1CSY/1b0iVlaRXRE6WPfhUCX4XUIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40843DA7;
	Wed, 28 Aug 2024 03:12:43 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BFD93F73B;
	Wed, 28 Aug 2024 03:12:16 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:12:14 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Beata Michalska <beata.michalska@arm.com>, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, liaochang1@huawei.com, wanghuiqiang@huawei.com,
	prime.zeng@hisilicon.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH] cpufreq: CPPC: Return desired perf in ->get() if
 feedback counters are 0
Message-ID: <Zs73/p8oIPQPp17t@arm.com>
References: <20240819035147.2239767-1-zhanjie9@hisilicon.com>
 <20240828065041.xf4csybut3csl5mn@vireshk-i7>
 <Zs7dHdj6xaR1cpSN@arm.com>
 <a2746b02-f6ad-edd6-09fe-9df0c40a6995@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2746b02-f6ad-edd6-09fe-9df0c40a6995@hisilicon.com>

On Wednesday 28 Aug 2024 at 17:45:09 (+0800), Jie Zhan wrote:
> 
> 
> On 28/08/2024 16:17, Ionela Voinescu wrote:
> > Hi,
> > 
> > On Wednesday 28 Aug 2024 at 12:20:41 (+0530), Viresh Kumar wrote:
> > > Cc'd few developers.
> > > 
> > > On 19-08-24, 11:51, Jie Zhan wrote:
> > > > The CPPC performance feedback counters could return 0 when the target cpu
> > > > is in a deep idle state (e.g. powered off) and those counters are not
> > > > powered.  cppc_cpufreq_get_rate() returns 0 in this case, triggering two
> > > > problems:
> > > > 
> > > > 1. cpufreq_online() gets a false error and doesn't generate a cpufreq
> > > > policy, which happens in cpufreq_add_dev() when a new cpu device is added.
> > > > 2. 'cpuinfo_cur_freq' shows '<unknown>'
> Hi Ionela,
> > I suppose 2. is not necessarily a problem as the current (hardware)
> > frequency is indeed unknown.
> > 
> > But there's not clean way to fix 1. while keeping 2. as is, or at least
> > not one I could identify.
> Yeah. 1 is the main thing to deal with.
> > > > Don't take it as an error and return the frequency corresponding to the
> > > > desired perf when the feedback counters are 0.
> > > > 
> > > > Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
> > > > Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> > > > ---
> > > >   drivers/cpufreq/cppc_cpufreq.c | 11 +++++++++--
> > > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > > > index bafa32dd375d..1c5eb12c1a5a 100644
> > > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > > @@ -748,18 +748,25 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> > > >   	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> > > >   	if (ret)
> > > > -		return 0;
> > > > +		goto out_err;
> > > >   	udelay(2); /* 2usec delay between sampling */
> > > >   	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> > > >   	if (ret)
> > > > -		return 0;
> > > > +		goto out_err;
> > > >   	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> > > >   					       &fb_ctrs_t1);
> > > >   	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> > > > +
> > > > +out_err:
> > > > +	if (ret == -EFAULT)
> > > > +		return cppc_perf_to_khz(&cpu_data->perf_caps,
> > > > +					cpu_data->perf_ctrls.desired_perf);
> > > > +
> > A better way might be to cppc_get_desired_perf(cpu, &desired_perf) first
> > and return the khz equivalent of the result, as currently done in
> > hisi_cppc_cpufreq_get_rate(). Even a merge of the two functions might be
> > suitable, but I'm not familiar with the specifics of the hisilicon platforms
> > involved. This might be better as some platforms can provide performance
> > feedback through the desired performance register so a read of it would
> > be better than using the cached desired_perf value.
> > 
> > Hope it helps,
> > Ionela.
> Sure, understood.
> Getting the latest desired perf would be more compatible across platforms.
> 
> Merging hisi_cppc_cpufreq_get_rate() can be risky but worth a try. The
> workaround also disables the FIE. I'll figure out whether it's feasible to
> do.

Thanks! What I was thinking was that possibly after your changes the
current cppc_cpufreq_get_rate() would be suitable for what is now the
hisilicon workaround, so there wouldn't be a need to overwrite the .get
callback with a custom one. In depends on whether on that particular
platform the unsupported counter registers read as 0 and result in the
same -EFAUT error.

As for disabling FIE, the current cppc_check_hisi_workaround() can be
called from cppc_freq_invariance_init() as an added check to the existing
ones that result in disabling FIE.

Thanks,
Ionela.

> 
> I'll send a V2 if no objection to the error handling.
> 
> Thanks,
> Jie
> > 
> > > > +	return 0;
> > > >   }
> > > >   static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> > > > -- 
> > > > 2.33.0
> > > > 
> > > -- 
> > > viresh
> 

