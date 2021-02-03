Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930D830D349
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 07:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhBCGE7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 01:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhBCGE6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 01:04:58 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FEFC06174A
        for <linux-acpi@vger.kernel.org>; Tue,  2 Feb 2021 22:04:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u15so13863184plf.1
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 22:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=20vLb8nYoRvjkPixtWI9JyTtznsxFpVmJabeCI3aLrY=;
        b=zGGMz/uCsy0DOqmB03VshMAkT5rniOOZV3bCV0tOGZi/hHQ9cjyCqqwzX9DuRBEf4t
         t8bFIx/1iFpir/3PucbPSQPzBoBje5cXnHmFttoARVScRt6Ifk0qdvFOFirf0DCnyjHT
         3xw2XT7YtZ8kkho+WAk1TDgSY4ugVW5QSMheAiTEZCmi5fnS9EU/DHz5lyv1RpVTS9kO
         RjURqEtHyOvoaAgkcAq1uEhuYUGO99s8tnvqW/7YPYbUXlvVyYBWF7WpLIupc2r8RniM
         DFv8DAK6Una8oUMAIicu+rNxya7V4tz/08nW5tNd0cgE5ndlinOMP/SDh9q1f/i7Z2Tp
         +vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=20vLb8nYoRvjkPixtWI9JyTtznsxFpVmJabeCI3aLrY=;
        b=op5pu3wvW0jMGUF8gP7HRrtrOmSputuOaW6t+uPehEupy5sSj9/xMDoPCOv95yQvpE
         7h5bwTuzkWixQJ0UJcS81BLRWqRSUavHQ2nDohQsZwvOgP7NzjAbu6Y5UEBNYMsNDydR
         hMxuJ+QoV+ktp5vipAJBUbkAZED/6aQxRTG0BtvRhZCktHewk55fXDsPcxVPVOD7KSAF
         sV4TQCl10BtU7+Xf3TaGd0EM5dmb535lUkZIF2Sj39Hbzrgb28mbaiXZCUFx06lp1m+L
         sMA818usenrXIFIUJiW/IUNdj68vMhxGbkEVaSLMqce8M9V7/KBb4dbB0VqfEcYirRhS
         1e/w==
X-Gm-Message-State: AOAM531ZY0MeNkNGwjLR7zZwX2OykZpSrtlM2v3pw+czZJW6dHi3vYQ9
        BMjHwEjAsSYVWTr/ncRoxXzU0w==
X-Google-Smtp-Source: ABdhPJxtrX8twjMyPQUKFe6UCeOxc2rSBdHhhqxdLHRiGlFr4M2VYBRQsjmgmKxijcLOYNEVoka3dw==
X-Received: by 2002:a17:90b:17c7:: with SMTP id me7mr1583302pjb.205.1612332257550;
        Tue, 02 Feb 2021 22:04:17 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id f7sm770871pjh.45.2021.02.02.22.04.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 22:04:16 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:34:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86,sched: On AMD EPYC set freq_max = max_boost
 in schedutil invariant formula
Message-ID: <20210203060414.hexqlimjol3tdtvq@vireshk-i7>
References: <20210122204038.3238-1-ggherdovich@suse.cz>
 <20210122204038.3238-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122204038.3238-2-ggherdovich@suse.cz>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I am sorry but I wasn't able to get the full picture (not your fault,
it is me), but ...

On 22-01-21, 21:40, Giovanni Gherdovich wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d0a3525ce27f..b96677f6b57e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2721,6 +2721,9 @@ int cpufreq_boost_enabled(void)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
>  
> +DEFINE_STATIC_KEY_FALSE(cpufreq_amd_max_boost);
> +EXPORT_SYMBOL_GPL(cpufreq_amd_max_boost);
> +
>  /*********************************************************************
>   *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
>   *********************************************************************/
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9c8b7437b6cd..341cac76d254 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -40,9 +40,14 @@ enum cpufreq_table_sorting {
>  	CPUFREQ_TABLE_SORTED_DESCENDING
>  };
>  
> +DECLARE_STATIC_KEY_FALSE(cpufreq_amd_max_boost);
> +
> +#define cpufreq_driver_has_max_boost() static_branch_unlikely(&cpufreq_amd_max_boost)
> +

I am not happy with AMD specific code/changes in common parts..

>  struct cpufreq_cpuinfo {
>  	unsigned int		max_freq;
>  	unsigned int		min_freq;
> +	unsigned int		max_boost;
>  
>  	/* in 10^(-9) s = nanoseconds */
>  	unsigned int		transition_latency;
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 6931f0cdeb80..541f3db3f576 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -159,8 +159,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  				  unsigned long util, unsigned long max)
>  {
>  	struct cpufreq_policy *policy = sg_policy->policy;
> -	unsigned int freq = arch_scale_freq_invariant() ?
> -				policy->cpuinfo.max_freq : policy->cur;
> +	unsigned int freq, max_freq;
> +
> +	max_freq = cpufreq_driver_has_max_boost() ?
> +			policy->cpuinfo.max_boost : policy->cpuinfo.max_freq;

Also, can't we update max_freq itself from the cpufreq driver? What
troubles will it cost ?

> +
> +	freq = arch_scale_freq_invariant() ? max_freq : policy->cur;
>  
>  	freq = map_util_freq(util, freq, max);
>  
> -- 
> 2.26.2

-- 
viresh
