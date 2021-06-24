Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC31D3B2FB5
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jun 2021 15:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhFXNGm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Jun 2021 09:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhFXNGl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jun 2021 09:06:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26DC061756
        for <linux-acpi@vger.kernel.org>; Thu, 24 Jun 2021 06:04:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i4so2907514plt.12
        for <linux-acpi@vger.kernel.org>; Thu, 24 Jun 2021 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sFN5Cy+47yYqPOhkIowUt/KKxpMi4IaFOzdHw+hWIB4=;
        b=euHTIFBiUTAQEYlhiVPJ4XThSS9vcimvbD0wrEXm0OBwQ6mdsWKbkXLoaSMh2A+F/Z
         zA7VEK4BdIcfe+EoGiqZN34QYw0rxwMDlkQWslmdHqQn7KhzOQJ5vcPM5DWNFRztyacb
         kS4w6v5rp0lPD+sUu4FvwUnejKWbQHuRRx4nSJju/vqPK/fdTRCokIYBOTgUCvMcMgcR
         uJZvn2pGLYQa99fux/r4SOtZ9GQXC54xhxTZWVU1fk5SRH5h1ff6F182Acn/asQ60xbJ
         DgbucJsvDmdj/ldggbzRJFpfL9+y21DnEuexsxMcTUuROB7oIptFRozDNqUb7TpZgZ6h
         Ja2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFN5Cy+47yYqPOhkIowUt/KKxpMi4IaFOzdHw+hWIB4=;
        b=uba+fhMfcnwcJz4DyEV1qPtvsqKU3GEcgN3TfT303tb/Zom6wb9UXH7SLRmRNNyy2l
         cHKVzmkYEEeDDLjxIzoicMObMH+QvGf7I4MKA8jrJCc/7cD2OeeS4NHUSWv/NWYXRMiO
         6aJz/uSvV85sjRFI8+LCdZWllK9QjxZsf3OmML46PYNimn7Aqv7DVrHP3+nllXFjrml2
         qK6tqp5KUQsF7WWAJDVZbUd5B6QpyC+tHyo/TALIstrUBGX0DCCZgSZDNkVXrZVopGpq
         +pjBOYN69Wj1MD6IxzLnzGJK/tss/pn33KLOSE5UbT6g/L0vWXhWi9IMpLWRGLAlC48W
         W6CA==
X-Gm-Message-State: AOAM5335dAOFvRzGPTvDzFhamhn0aO4hirKtnaUNBWsuzwSsyH/yxoXr
        jXn20jRFCV0X2GRdkg27DSeFjA==
X-Google-Smtp-Source: ABdhPJweRjj1DyWQN243gjZPbzlvBG/0RsodAwHklaoU6e9TQQVR9vl2qjHLWzPgXf7baUP16THj5g==
X-Received: by 2002:a17:90a:73ca:: with SMTP id n10mr15114543pjk.16.1624539861249;
        Thu, 24 Jun 2021 06:04:21 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id b9sm2712841pfm.124.2021.06.24.06.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 06:04:20 -0700 (PDT)
Date:   Thu, 24 Jun 2021 18:34:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/4] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210624130418.poiy4ph66mbv3y67@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <f963d09e57115969dae32827ade5558b0467d3a0.1624266901.git.viresh.kumar@linaro.org>
 <20210624094812.GA6095@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624094812.GA6095@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 24-06-21, 10:48, Ionela Voinescu wrote:
> On Monday 21 Jun 2021 at 14:49:37 (+0530), Viresh Kumar wrote:
> > The Frequency Invariance Engine (FIE) is providing a frequency scaling
> > correction factor that helps achieve more accurate load-tracking.
> [..]
> > +static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
> > +{
> > +	struct cppc_freq_invariance *cppc_fi;
> > +	int cpu;
> > +
> > +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > +		return;
> > +
> > +	/* policy->cpus will be empty here, use related_cpus instead */
> > +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
> > +
> > +	for_each_cpu(cpu, policy->related_cpus) {
> > +		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> 
> Do you think it might be worth having here something like:
> 
> 		if (!cppc_fi->cpu_data)
> 			continue;
> 
> This would be to protect against cases where the platform does not boot
> with all CPUs or the module is loaded after some have already been
> offlined. Unlikely, but..

Even in that case policy->cpus will contain all offline+online CPUs (at ->init()
time), isn't it ?

> > +		irq_work_sync(&cppc_fi->irq_work);
> > +		kthread_cancel_work_sync(&cppc_fi->work);
> > +	}
> > +}
> 
> The rest of the code is almost the same as the original, so that is all
> from me :).
> 
> Thanks,
> Ionela.

-- 
viresh
