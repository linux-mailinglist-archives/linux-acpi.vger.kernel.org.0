Return-Path: <linux-acpi+bounces-8320-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A571897AEF2
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2024 12:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83A31C237E7
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2024 10:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185F3167D80;
	Tue, 17 Sep 2024 10:36:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117F816130C;
	Tue, 17 Sep 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569402; cv=none; b=gEogT8OEQg7uCmLysOISxAJKV6F+CbL7ja9G7yYcVrGiRfSI0iV9/PDonr+RaNdY5r06mSO37/giZU6GmhgCQeBHUhD0OWCvKoxZHYcqGlPrA5lk8W2n7juillJNfuFTL4bolok8N47ikKOo/dlOvzTcS4igFrYF6Dj+7qMQZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569402; c=relaxed/simple;
	bh=Q9JsLsOTE9HWlKx4NBBWcpXXbT0Y/JlNm+xqL6UVWgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdJj34NukQCt0d/k8Wd6l21epdzzHK1AtKvh3eosZ6GJJEXr/GcEJ4c3xuuDlyZB0FfEe/337jaejPCYEmG3W9PfOP8EMTFsww/KkBnZNsdES28OVFbF+NuTs1W7QAwcXzyaTp65yeavYsHPEP7ru6pya7I2l0mqinnDqpU98Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D82841007;
	Tue, 17 Sep 2024 03:37:08 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A96B3F64C;
	Tue, 17 Sep 2024 03:36:39 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:36:37 +0100
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
Message-ID: <ZulbtT8joKPXlFCL@arm.com>
References: <20240912072231.439332-1-zhanjie9@hisilicon.com>
 <20240912072231.439332-2-zhanjie9@hisilicon.com>
 <ZuK3sfcKf2gHssKa@arm.com>
 <79353a26-7304-9d6a-9237-cfa8e7794601@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79353a26-7304-9d6a-9237-cfa8e7794601@hisilicon.com>

Hi,

On Friday 13 Sep 2024 at 20:05:50 (+0800), Jie Zhan wrote:
> 
> Hi Ionela,
> 
> On 12/09/2024 17:43, Ionela Voinescu wrote:
> 
> ...
> 
> > 
> > A possible (slimmer) alternative implementation for you to consider
> > (this merges patches 1 & 2):
> > 
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index bafa32dd375d..c16be9651a6f 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
> > 
> >         perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
> >                                      &fb_ctrs);
> > +       if (!perf)
> > +               perf = cpu_data->perf_ctrls.desired_perf;
> > +
> 
> I think it's better to just return here.
> If feedback counters are successfully read but unchanged, the following
> calculation and update in cppc_scale_freq_workfn() is meaningless because it
> won't change anything.

Agreed!

> 
> >         cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> > 
> >         perf <<= SCHED_CAPACITY_SHIFT;
> > @@ -726,7 +729,7 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> > 
> >         /* Check to avoid divide-by zero and invalid delivered_perf */
> >         if (!delta_reference || !delta_delivered)
> > -               return cpu_data->perf_ctrls.desired_perf;
> > +               return 0;
> 
> This makes sense to me.
> Here is probably why Patch 2 looks bulky.
> 
> > 
> >         return (reference_perf * delta_delivered) / delta_reference;
> >  }
> > @@ -736,7 +739,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> >         struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> >         struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> >         struct cppc_cpudata *cpu_data;
> > -       u64 delivered_perf;
> > +       u64 delivered_perf = 0;
> >         int ret;
> > 
> >         if (!policy)
> > @@ -747,19 +750,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> >         cpufreq_cpu_put(policy);
> > 
> >         ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> > -       if (ret)
> > -               return 0;
> > -
> > -       udelay(2); /* 2usec delay between sampling */
> > -
> > -       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> > -       if (ret)
> > -               return 0;
> > +       if (!ret) {
> > +               udelay(2); /* 2usec delay between sampling */
> > +               ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> > +       }
> > +       if (!ret)
> > +               delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> > +                                                      &fb_ctrs_t1);
> 
> TBH, 'if (!ret)' style looks very strange to me.
> We haven't done so anywhere in cppc_cpufreq, so let's keep consistency and make
> it easier for people to read and maintain?

I agree it's a bit of a difficult read, that's why I only sent my code
as a suggestion. I did like the benefit of not having to have two
different calls to cppc_perf_to_khz() and making the code below common
for the error and non-error paths. But it's up to you. 
> 
> > +       if ((ret == -EFAULT) || !delivered_perf) {
> > +               if (cppc_get_desired_perf(cpu, &delivered_perf))
> > +                       delivered_perf = cpu_data->perf_ctrls.desired_perf;
> 
> will take this.
> 
> > +       }
> > 
> > -       delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> > -                                              &fb_ctrs_t1);
> > +       if (delivered_perf)
> > +               return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> > 
> > -       return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> > +       return 0;
> >  }
> > 
> > disclaimer: not fully checked so likely not "production ready" code :)
> > 
> > Hope it helps,
> > Ionela.
> > 
> >>  
> >>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> >> -- 
> >> 2.33.0
> >>
> > 
> 
> How about this? merged patch 1 & 2 as well.
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bafa32dd375d..411303f2e8cb 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
> 
>           perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
>                                        &fb_ctrs);
> +       if (!perf)
> +               return;
> +
>           cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> 
>           perf <<= SCHED_CAPACITY_SHIFT;
> @@ -726,7 +729,7 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> 
>           /* Check to avoid divide-by zero and invalid delivered_perf */
>           if (!delta_reference || !delta_delivered)
> -               return cpu_data->perf_ctrls.desired_perf;
> +               return 0;
> 
>           return (reference_perf * delta_delivered) / delta_reference;
>    }
> @@ -748,18 +751,32 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
> 
>           ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>           if (ret)
> -               return 0;
> +               goto out_err;
> 
>           udelay(2); /* 2usec delay between sampling */
> 
>           ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>           if (ret)
> -               return 0;
> +               goto out_err;
> 
>           delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>                                                  &fb_ctrs_t1);

You need a check here for !delivered_perf (when at least one of the
deltas is 0) in which case it would be good to take the same error path
below. Something like:

            if(delivered_perf)
	            return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
	    else
		ret = -EFAULT;

That's why I did the tricky if/else dance above as we need to take the
error path below for multiple cases.

Thanks,
Ionela.

> 
>           return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> +
> +out_err:
> +       /*
> +        * Feedback counters could be 0 when cores are powered down.
> +        * Take desired perf for reflecting frequency in this case.
> +        */
> +       if (ret == -EFAULT) {
> +               if (cppc_get_desired_perf(cpu, &delivered_perf))
> +                       delivered_perf = cpu_data->perf_ctrls.desired_perf;
> +
> +               return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> +       }
> +
> +       return 0;
>    }
> 
>    static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> ---
> 
> Thanks indeed!
> Jie

