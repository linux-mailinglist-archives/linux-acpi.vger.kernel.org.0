Return-Path: <linux-acpi+bounces-7919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF804962221
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 10:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02091C22687
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 08:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216C15AD90;
	Wed, 28 Aug 2024 08:17:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D613E3EF;
	Wed, 28 Aug 2024 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833059; cv=none; b=ODlSanjBpqLezhZEiztJnOpQfyYGhUoskuDOHuBbG+o/MCksKkvceue5jd/P1foaNAkaHrpEHuRtZmSE0LvhNE6YICD/gp2QIYa6ZkOV6HjRXRi8Kcxs/tkxQ/jyG0YIrQYC1OtNUkqRmtQeOAvYBwjxm9mwDL5pFxEk7bcbMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833059; c=relaxed/simple;
	bh=HNHELctd2vbQ0kQ05AfCXpp3fV+xVTiTn6zW+OdRMuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdjCbLxNwbEjWfyNWThtuI6X0DphcS7w7y6474njAaxM59sNibXp5H/7T1q5RRZm57kA27vSzCDOxVhXoh51uckqiXEFafHidNbMQfuLaM0WIt5oyetzycriV7ttW1ecoHR0cDchdJmgEqJdUji824hbhFZEuOzFjZc3Uitzv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F176DA7;
	Wed, 28 Aug 2024 01:18:02 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79C4A3F762;
	Wed, 28 Aug 2024 01:17:35 -0700 (PDT)
Date: Wed, 28 Aug 2024 09:17:33 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Beata Michalska <beata.michalska@arm.com>, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, liaochang1@huawei.com, wanghuiqiang@huawei.com,
	prime.zeng@hisilicon.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH] cpufreq: CPPC: Return desired perf in ->get() if
 feedback counters are 0
Message-ID: <Zs7dHdj6xaR1cpSN@arm.com>
References: <20240819035147.2239767-1-zhanjie9@hisilicon.com>
 <20240828065041.xf4csybut3csl5mn@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828065041.xf4csybut3csl5mn@vireshk-i7>

Hi,

On Wednesday 28 Aug 2024 at 12:20:41 (+0530), Viresh Kumar wrote:
> Cc'd few developers.
> 
> On 19-08-24, 11:51, Jie Zhan wrote:
> > The CPPC performance feedback counters could return 0 when the target cpu
> > is in a deep idle state (e.g. powered off) and those counters are not
> > powered.  cppc_cpufreq_get_rate() returns 0 in this case, triggering two
> > problems:
> > 
> > 1. cpufreq_online() gets a false error and doesn't generate a cpufreq
> > policy, which happens in cpufreq_add_dev() when a new cpu device is added.
> > 2. 'cpuinfo_cur_freq' shows '<unknown>'

I suppose 2. is not necessarily a problem as the current (hardware)
frequency is indeed unknown.

But there's not clean way to fix 1. while keeping 2. as is, or at least
not one I could identify.

> > 
> > Don't take it as an error and return the frequency corresponding to the
> > desired perf when the feedback counters are 0.
> > 
> > Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
> > Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index bafa32dd375d..1c5eb12c1a5a 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -748,18 +748,25 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> >  
> >  	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> >  	if (ret)
> > -		return 0;
> > +		goto out_err;
> >  
> >  	udelay(2); /* 2usec delay between sampling */
> >  
> >  	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> >  	if (ret)
> > -		return 0;
> > +		goto out_err;
> >  
> >  	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> >  					       &fb_ctrs_t1);
> >  
> >  	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> > +
> > +out_err:
> > +	if (ret == -EFAULT)
> > +		return cppc_perf_to_khz(&cpu_data->perf_caps,
> > +					cpu_data->perf_ctrls.desired_perf);
> > +

A better way might be to cppc_get_desired_perf(cpu, &desired_perf) first
and return the khz equivalent of the result, as currently done in
hisi_cppc_cpufreq_get_rate(). Even a merge of the two functions might be
suitable, but I'm not familiar with the specifics of the hisilicon platforms
involved. This might be better as some platforms can provide performance
feedback through the desired performance register so a read of it would
be better than using the cached desired_perf value.

Hope it helps,
Ionela.

> > +	return 0;
> >  }
> >  
> >  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> > -- 
> > 2.33.0
> > 
> 
> -- 
> viresh

