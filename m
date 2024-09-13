Return-Path: <linux-acpi+bounces-8280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12217977F3A
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 14:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF5A1C21D75
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 12:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99561D86E6;
	Fri, 13 Sep 2024 12:06:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B31BFDF6;
	Fri, 13 Sep 2024 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229183; cv=none; b=CsGVm9KeEjd0U0pIR3+s6f1TcyQ6QU5jeFtjiTUsIpH7x4W3NQ8shg/2FJtXAXeMo3405spCSIzRTWcP8JrxwFbAMPRBdguhXwrwtmjakl51QuDdzI5pUwOeSoX8lfVQ8QmpLhkbzz+j4iZOtni8GnLN1aDzVJ9CYb9up1zUJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229183; c=relaxed/simple;
	bh=87/tGkZmzXEk3vv9YL4PlH6QGuBQUythRPhFtSr41IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N8YCNrJQ09kbvWttkX9eLmAnZV4TvNAWovhd9OrkjIXB1YIXjKCJKMtXiOGO+/hYZD4ODPVjC5CzbG9eWmU8WMIA+6vDmqKwXeq/+ALW38jyOuar/lrfO0jqSon9XP6yjDPJSaqxmqcgPBCYp2xgw19Fgpt2e3aYiGM6a1UFMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X4tKq6LdVz1j6Bx;
	Fri, 13 Sep 2024 20:05:19 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id ACEEC1A0190;
	Fri, 13 Sep 2024 20:05:51 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 20:05:51 +0800
Message-ID: <79353a26-7304-9d6a-9237-cfa8e7794601@hisilicon.com>
Date: Fri, 13 Sep 2024 20:05:50 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/3] cppc_cpufreq: Return desired perf in ->get() if
 feedback counters are 0
To: Ionela Voinescu <ionela.voinescu@arm.com>
CC: <beata.michalska@arm.com>, <wangxiongfeng2@huawei.com>,
	<viresh.kumar@linaro.org>, <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
References: <20240912072231.439332-1-zhanjie9@hisilicon.com>
 <20240912072231.439332-2-zhanjie9@hisilicon.com> <ZuK3sfcKf2gHssKa@arm.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <ZuK3sfcKf2gHssKa@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500019.china.huawei.com (7.185.36.137)


Hi Ionela,

On 12/09/2024 17:43, Ionela Voinescu wrote:

...

> 
> A possible (slimmer) alternative implementation for you to consider
> (this merges patches 1 & 2):
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bafa32dd375d..c16be9651a6f 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
> 
>         perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
>                                      &fb_ctrs);
> +       if (!perf)
> +               perf = cpu_data->perf_ctrls.desired_perf;
> +

I think it's better to just return here.
If feedback counters are successfully read but unchanged, the following
calculation and update in cppc_scale_freq_workfn() is meaningless because it
won't change anything.

>         cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
> 
>         perf <<= SCHED_CAPACITY_SHIFT;
> @@ -726,7 +729,7 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
> 
>         /* Check to avoid divide-by zero and invalid delivered_perf */
>         if (!delta_reference || !delta_delivered)
> -               return cpu_data->perf_ctrls.desired_perf;
> +               return 0;

This makes sense to me.
Here is probably why Patch 2 looks bulky.

> 
>         return (reference_perf * delta_delivered) / delta_reference;
>  }
> @@ -736,7 +739,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>         struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>         struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>         struct cppc_cpudata *cpu_data;
> -       u64 delivered_perf;
> +       u64 delivered_perf = 0;
>         int ret;
> 
>         if (!policy)
> @@ -747,19 +750,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>         cpufreq_cpu_put(policy);
> 
>         ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
> -       if (ret)
> -               return 0;
> -
> -       udelay(2); /* 2usec delay between sampling */
> -
> -       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> -       if (ret)
> -               return 0;
> +       if (!ret) {
> +               udelay(2); /* 2usec delay between sampling */
> +               ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
> +       }
> +       if (!ret)
> +               delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> +                                                      &fb_ctrs_t1);

TBH, 'if (!ret)' style looks very strange to me.
We haven't done so anywhere in cppc_cpufreq, so let's keep consistency and make
it easier for people to read and maintain?

> +       if ((ret == -EFAULT) || !delivered_perf) {
> +               if (cppc_get_desired_perf(cpu, &delivered_perf))
> +                       delivered_perf = cpu_data->perf_ctrls.desired_perf;

will take this.

> +       }
> 
> -       delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
> -                                              &fb_ctrs_t1);
> +       if (delivered_perf)
> +               return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> 
> -       return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> +       return 0;
>  }
> 
> disclaimer: not fully checked so likely not "production ready" code :)
> 
> Hope it helps,
> Ionela.
> 
>>  
>>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>> -- 
>> 2.33.0
>>
> 

How about this? merged patch 1 & 2 as well.

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bafa32dd375d..411303f2e8cb 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)

          perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
                                       &fb_ctrs);
+       if (!perf)
+               return;
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
@@ -748,18 +751,32 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)

          ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
          if (ret)
-               return 0;
+               goto out_err;

          udelay(2); /* 2usec delay between sampling */

          ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
          if (ret)
-               return 0;
+               goto out_err;

          delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
                                                 &fb_ctrs_t1);

          return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
+
+out_err:
+       /*
+        * Feedback counters could be 0 when cores are powered down.
+        * Take desired perf for reflecting frequency in this case.
+        */
+       if (ret == -EFAULT) {
+               if (cppc_get_desired_perf(cpu, &delivered_perf))
+                       delivered_perf = cpu_data->perf_ctrls.desired_perf;
+
+               return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
+       }
+
+       return 0;
   }

   static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
---

Thanks indeed!
Jie

