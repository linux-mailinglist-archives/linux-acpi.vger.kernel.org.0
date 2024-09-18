Return-Path: <linux-acpi+bounces-8327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97597BAA0
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2024 12:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0791C2248A
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2024 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2817AE0C;
	Wed, 18 Sep 2024 10:15:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C382158203;
	Wed, 18 Sep 2024 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726654556; cv=none; b=Z6+JrMv+kFc7Vau7G15oq/B5F59i0DRsFD4V1Xi8fsPAA+jQGSDzuvePtukQC4lzQb3bk6Stwl9RTD8T/UwkNoEyWXdboTU43o+U5Xu/9Azzu2VILVbNWrZl7XGPUOv0gjbVaKquBAiZy42BSxbGwRXfZXoMP6PoaXDbSPeUWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726654556; c=relaxed/simple;
	bh=AYNy7n0RD0uCOrEtstDLwoW0P8Nl+52lB/6v3tqLJuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwNVbQHajy6Jf/LWYLmOs/txkk8cTxdvi0w/zBeUjPctB4wXt8f+g7uOssRFvFGrdvsVAyNwPino26/K2mM56f/epBYGkLVBXskboUDhut+ulFV+lsvTXGNxe8fdUFX78npx1l4AYYogMivxUXrIN+sp3IxoWhK7u2sYR6vFyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B2AFFEC;
	Wed, 18 Sep 2024 03:16:23 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F7A73F64C;
	Wed, 18 Sep 2024 03:15:53 -0700 (PDT)
Date: Wed, 18 Sep 2024 11:15:51 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: beata.michalska@arm.com, wangxiongfeng2@huawei.com,
	viresh.kumar@linaro.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, wanghuiqiang@huawei.com,
	zhenglifeng1@huawei.com, lihuisong@huawei.com,
	yangyicong@huawei.com, liaochang1@huawei.com, zengheng4@huawei.com
Subject: Re: [PATCH v2 1/3] cppc_cpufreq: Return desired perf in ->get() if
 feedback counters are 0
Message-ID: <ZuqoV/RmVXDkg6uv@arm.com>
References: <20240912072231.439332-1-zhanjie9@hisilicon.com>
 <20240912072231.439332-2-zhanjie9@hisilicon.com>
 <ZuK3sfcKf2gHssKa@arm.com>
 <79353a26-7304-9d6a-9237-cfa8e7794601@hisilicon.com>
 <ZulbtT8joKPXlFCL@arm.com>
 <30147eff-6e2f-1651-3875-52c9401273fb@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30147eff-6e2f-1651-3875-52c9401273fb@hisilicon.com>

Hi,

On Wednesday 18 Sep 2024 at 10:05:13 (+0800), Jie Zhan wrote:
> 
> 
> On 17/09/2024 18:36, Ionela Voinescu wrote:
> 
> ...
> 
> >>> @@ -747,19 +750,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> >>>         cpufreq_cpu_put(policy);
> >>>
> >>>         ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> >>> -       if (ret)
> >>> -               return 0;
> >>> -
> >>> -       udelay(2); /* 2usec delay between sampling */
> >>> -
> >>> -       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> >>> -       if (ret)
> >>> -               return 0;
> >>> +       if (!ret) {
> >>> +               udelay(2); /* 2usec delay between sampling */
> >>> +               ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> >>> +       }
> >>> +       if (!ret)
> >>> +               delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> >>> +                                                      &fb_ctrs_t1);
> >>
> >> TBH, 'if (!ret)' style looks very strange to me.
> >> We haven't done so anywhere in cppc_cpufreq, so let's keep consistency and make
> >> it easier for people to read and maintain?
> > 
> > I agree it's a bit of a difficult read, that's why I only sent my code
> > as a suggestion. I did like the benefit of not having to have two
> > different calls to cppc_perf_to_khz() and making the code below common
> > for the error and non-error paths. But it's up to you. 
> 
> Yeah understood. I did try minimizing duplicate code, but ended up with either
> duplicate 'get desired perf' stuff or duplicate cppc_perf_to_khz().
> 
> ...
> >>
> >>           delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> >>                                                  &fb_ctrs_t1);
> > 
> > You need a check here for !delivered_perf (when at least one of the
> > deltas is 0) in which case it would be good to take the same error path
> > below. Something like:
> > 
> >             if(delivered_perf)
> > 	            return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> > 	    else
> > 		ret = -EFAULT;
> > 
> > That's why I did the tricky if/else dance above as we need to take the
> > error path below for multiple cases.
> > 
> > Thanks,
> > Ionela.
> > 
> 
> Sure, thanks for reminding this.
> 
> ...
> 
> How does this look? I think this should have the least duplicate code except for
> two cppc_perf_to_khz() calls, while keeping the logic easy to follow.
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bafa32dd375d..6070444ed098 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
>  
>         perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
>                                      &fb_ctrs);
> +       if (!perf)
> +               return;
> +
>         cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
>  
>         perf <<= SCHED_CAPACITY_SHIFT;
> @@ -726,11 +729,27 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>  
>         /* Check to avoid divide-by zero and invalid delivered_perf */
>         if (!delta_reference || !delta_delivered)
> -               return cpu_data->perf_ctrls.desired_perf;
> +               return 0;
>  
>         return (reference_perf * delta_delivered) / delta_reference;
>  }
>  
> +static int cppc_get_perf_ctrs_sample(int cpu,
> +                                    struct cppc_perf_fb_ctrs *fb_ctrs_t0,
> +                                    struct cppc_perf_fb_ctrs *fb_ctrs_t1)
> +{
> +       int ret;
> +
> +       ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
> +       if (ret)
> +               return ret;
> +
> +       udelay(2); /* 2usec delay between sampling */
> +
> +       ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t1);

nit: white line before return.

> +       return ret;
> +}
> +
>  static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  {
>         struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> @@ -746,20 +765,30 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  
>         cpufreq_cpu_put(policy);
>  
> -       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> -       if (ret)
> -               return 0;
> -
> -       udelay(2); /* 2usec delay between sampling */
> -
> -       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> -       if (ret)
> -               return 0;
> +       ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
> +       if (ret) {
> +               if (ret == -EFAULT)
> +                       goto out_invalid_counters;
> +               else
> +                       return 0;
> +       }
>  
>         delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>                                                &fb_ctrs_t1);
> +       if (!delivered_perf)
> +               goto out_invalid_counters;
>  
>         return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> +
> +out_invalid_counters:
> +       /*
> +        * Feedback counters could be unchanged or 0 when a cpu enters a
> +        * low-power idle state, e.g. clock-gated or power-gated.
> +        * Get the lastest or cached desired perf for reflecting frequency.
> +        */
> +       if (cppc_get_desired_perf(cpu, &delivered_perf))
> +               delivered_perf = cpu_data->perf_ctrls.desired_perf;

nit: same white line before return here :).

Looks good, thanks for the changes.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Ionela.

> +       return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
>  }
>  
>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> 
> 
> Thanks!
> Jie

