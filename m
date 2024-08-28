Return-Path: <linux-acpi+bounces-7918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6145962001
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 08:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0765C1C23620
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AE1158557;
	Wed, 28 Aug 2024 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTE1V5Jq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD922158553
	for <linux-acpi@vger.kernel.org>; Wed, 28 Aug 2024 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827847; cv=none; b=kBwlhk9lcVYkZu+g500pYJ5nC2bg0Iq8zYog0dAIbHyYAyercpfxOaoZvC+MjFv10Uc6AsUY+c2l3DrDHCzkZHCEyqi+FExIsrW6LRTwHhvvt9j2GVq9d2zS8C2fKlKAsb5wVwgXnVQ0MvY85apz7yg7r7lBEMeFS54QI1SiAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827847; c=relaxed/simple;
	bh=VSaozPMjQSh8Z+AMMpHxbFPbADM9T5C78i7brPcAMNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfChvCvQDO/AG4PK4fa0XVCAimQNIqPqeI6Xmx9Z5rJfUZIYrO/E6DA8vFn00ntJtbFuCpDvVWdlYp9TG2nxX+RiKTBE7Jh7A2U7gCRKYJRb1PclRL6/xROOFKlnw/14fb8Jh7le3QG/PvY84uCP3DwUG1CsW2uFaHQ3GJ169ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZTE1V5Jq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202376301e6so49429505ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Aug 2024 23:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724827845; x=1725432645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYQ+ilkeaMwW+FMWFhvIJ0I6JjOEVk4IWvO+V0FIO5w=;
        b=ZTE1V5JqrMmMVz3RtFVQZNPnMrhjdhJJXwAtj5QpfD6tfo0jgV3XbfJxvqXZcMFVqH
         VSgXh69p0PB3fp9huzboXEfsIwHANeIifshomh9H016tYi5UeEZBSIIiCkNHYGewuJyT
         wAnZ4/Lhb61ATSmhc1XCZeZWstP0vprRllhEhn2Ibc/84Um2pRvld6vOD8LEfHjbKH7x
         Yl6n3LrN4gvRtOtA50/Q8fJMN8xXIiDC9ebRHqioPePWZL8kosnIb29slgkYg3+XgR9J
         64GIA8skRAc7K73OncFzWPj1tnrqnL12BPLt/onFxD/XUnmhRiE9mW8OEKQ65fcwmHom
         khBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724827845; x=1725432645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYQ+ilkeaMwW+FMWFhvIJ0I6JjOEVk4IWvO+V0FIO5w=;
        b=EsLN8ImG0JW3lr+m7jk47lWChqfHV2JNd/a97k6qz8N6uu2RSrpct6EgtO52Mt1c8G
         FGuaXeaqXXKSId97PPTAzx5UR0Pq3jfthVnX5350d6Zvr0Lwl6ncvFmQbu8uQCGzgDA2
         lfmaE8Vf0gX+uz64c1DZWxRuiIuWwSqJfd0jugRkcdVOuLUf2JzEDwgf1eF/yXrfJfuG
         U6fv529eXNR3zVnlNeym8NKsdXHy3Nx0Cw/S8JlFJbHZ8CQqn/EzUm9aQNkvXgqIQ4ag
         rkSn/oln+71r1wZjNqQDREccueJVtK61L3sShYRSH46c+5/nefNUufohK6JEK3i7E1aa
         c/IA==
X-Forwarded-Encrypted: i=1; AJvYcCXPoQ9flERO4scJNpHH52pySlT71Q9wHHxS3geMSLF2NdWUAH3KyyZV9FnDiswVmMRZ5Soj13niSOhT@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvMfpts94+xgeOetvq80NcP+MHZxB9Nai3Kxc31NxFccDIx5O
	Mc/11pJvoWkCCtKxwP364Oq9akHYMfhDBX6i5F9uYkBv8paWdf73mRieKnacEKA=
X-Google-Smtp-Source: AGHT+IGt4pGEHijdX0P/ukNUThZCoMBLg7a93UO62jadaOtNfGpmBEw5TDCiC/MbI3bFxmYb43CjTQ==
X-Received: by 2002:a17:902:f710:b0:201:fac8:ff67 with SMTP id d9443c01a7336-2039e47ab66mr206812765ad.17.1724827845037;
        Tue, 27 Aug 2024 23:50:45 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855664b3sm92842375ad.21.2024.08.27.23.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:50:44 -0700 (PDT)
Date: Wed, 28 Aug 2024 12:20:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Zhan <zhanjie9@hisilicon.com>,
	Beata Michalska <beata.michalska@arm.com>, ionela.voinescu@arm.com
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, liaochang1@huawei.com, wanghuiqiang@huawei.com,
	prime.zeng@hisilicon.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH] cpufreq: CPPC: Return desired perf in ->get() if
 feedback counters are 0
Message-ID: <20240828065041.xf4csybut3csl5mn@vireshk-i7>
References: <20240819035147.2239767-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819035147.2239767-1-zhanjie9@hisilicon.com>

Cc'd few developers.

On 19-08-24, 11:51, Jie Zhan wrote:
> The CPPC performance feedback counters could return 0 when the target cpu
> is in a deep idle state (e.g. powered off) and those counters are not
> powered.  cppc_cpufreq_get_rate() returns 0 in this case, triggering two
> problems:
> 
> 1. cpufreq_online() gets a false error and doesn't generate a cpufreq
> policy, which happens in cpufreq_add_dev() when a new cpu device is added.
> 2. 'cpuinfo_cur_freq' shows '<unknown>'
> 
> Don't take it as an error and return the frequency corresponding to the
> desired perf when the feedback counters are 0.
> 
> Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bafa32dd375d..1c5eb12c1a5a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -748,18 +748,25 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
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
> +	if (ret == -EFAULT)
> +		return cppc_perf_to_khz(&cpu_data->perf_caps,
> +					cpu_data->perf_ctrls.desired_perf);
> +
> +	return 0;
>  }
>  
>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> -- 
> 2.33.0
> 

-- 
viresh

