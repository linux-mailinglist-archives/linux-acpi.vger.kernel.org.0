Return-Path: <linux-acpi+bounces-8270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C113F9765EC
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 11:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860FD2841F5
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA3195962;
	Thu, 12 Sep 2024 09:43:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442046F2E8;
	Thu, 12 Sep 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134199; cv=none; b=HHJiD54dRClNJJ/6yqpW9M+UhPqh0hNGFnoXjblZyd8tlUw42lo8BpyN7lf+vXF3LJJBEH/gtVxA+BTcySVGP+01HVyyAx+emw5jZQXOSun98wRuBxGi09kJSX1qACdNYzOrA8AV3uVZzJsS99ToxhoPcLm/xI9xt8BOcGllwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134199; c=relaxed/simple;
	bh=CN6+ANp7FakHDwidepeMf+jwl3si4Kg5XCqRjm/HS6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2erqbno7EuSKqfMSLxeNBhXSgaNsJU1L3H5/PA6aaoN+tMl41kc6tPqn4MMwYMEguExoS5loY5hJWOvzNWJmIBj7YKa2z7/LOrrwsY5waftQvNjW91RIpD/uuCK7Id/cEZ9UZDz4/l00Jba/PAHaerz/+EtR0tUQxwkjvFXTc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCA7EDA7;
	Thu, 12 Sep 2024 02:43:44 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25D1B3F64C;
	Thu, 12 Sep 2024 02:43:15 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:43:13 +0100
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
Message-ID: <ZuK3sfcKf2gHssKa@arm.com>
References: <20240912072231.439332-1-zhanjie9@hisilicon.com>
 <20240912072231.439332-2-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912072231.439332-2-zhanjie9@hisilicon.com>

Hi,

On Thursday 12 Sep 2024 at 15:22:29 (+0800), Jie Zhan wrote:
> The CPPC performance feedback counters could return 0 when the target cpu
> is in a deep idle state, e.g. powered off, and those counters are not
> powered.  In this case, cppc_cpufreq_get_rate() returns 0, and hence,
> cpufreq_online() gets a false error and doesn't generate a cpufreq policy,
> which happens in cpufreq_add_dev() when a new cpu device is added.
> 
> Don't take it as an error and return the frequency corresponding to the
> desired perf when the feedback counters are 0.
> 
> Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> Reviewed-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bafa32dd375d..6aa3af56924b 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -748,18 +748,33 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  
>  	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>  	if (ret)
> -		return 0;
> +		goto out_err;
>  
>  	udelay(2); /* 2usec delay between sampling */
>  
>  	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>  	if (ret)
> -		return 0;
> +		goto out_err;
>  
>  	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>  					       &fb_ctrs_t1);
>  
>  	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> +
> +out_err:
> +	/*
> +	 * Feedback counters could be 0 when cores are powered down.
> +	 * Take desired perf for reflecting frequency in this case.
> +	 */
> +	if (ret == -EFAULT) {
> +		ret = cppc_get_desired_perf(cpu, &delivered_perf);
> +		if (ret)
> +			return 0;
> +
> +		return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> +	}
> +
> +	return 0;
>  }

A possible (slimmer) alternative implementation for you to consider
(this merges patches 1 & 2):

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bafa32dd375d..c16be9651a6f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)

        perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
                                     &fb_ctrs);
+       if (!perf)
+               perf = cpu_data->perf_ctrls.desired_perf;
+
        cppc_fi->prev_perf_fb_ctrs = fb_ctrs;

        perf <<= SCHED_CAPACITY_SHIFT;
@@ -726,7 +729,7 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,

        /* Check to avoid divide-by zero and invalid delivered_perf */
        if (!delta_reference || !delta_delivered)
-               return cpu_data->perf_ctrls.desired_perf;
+               return 0;

        return (reference_perf * delta_delivered) / delta_reference;
 }
@@ -736,7 +739,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
        struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
        struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
        struct cppc_cpudata *cpu_data;
-       u64 delivered_perf;
+       u64 delivered_perf = 0;
        int ret;

        if (!policy)
@@ -747,19 +750,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
        cpufreq_cpu_put(policy);

        ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
-       if (ret)
-               return 0;
-
-       udelay(2); /* 2usec delay between sampling */
-
-       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
-       if (ret)
-               return 0;
+       if (!ret) {
+               udelay(2); /* 2usec delay between sampling */
+               ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
+       }
+       if (!ret)
+               delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
+                                                      &fb_ctrs_t1);
+       if ((ret == -EFAULT) || !delivered_perf) {
+               if (cppc_get_desired_perf(cpu, &delivered_perf))
+                       delivered_perf = cpu_data->perf_ctrls.desired_perf;
+       }

-       delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
-                                              &fb_ctrs_t1);
+       if (delivered_perf)
+               return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);

-       return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
+       return 0;
 }

disclaimer: not fully checked so likely not "production ready" code :)

Hope it helps,
Ionela.

>  
>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> -- 
> 2.33.0
> 

