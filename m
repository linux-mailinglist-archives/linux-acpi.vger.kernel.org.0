Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A83B4796
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 18:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYQ4o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 12:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFYQ4n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jun 2021 12:56:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBDC061767
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jun 2021 09:54:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m17so5011087plx.7
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jun 2021 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l7dX5dgpmPFuySJbZwA/qhXdydYfRA2CAHeZv6VJOdk=;
        b=iqLixdZ4UQzIfrMpWEvBZKk5Fvm5nRLt8h9LHj6PsJATVMPi7t0AV1zK5ok8y6mRpP
         +M8ZOCK/fdssvSFI6zERVDwSO0CDJKSow466MIVRQOMvAPt/3YvcZMXzOmooS3BsNUz8
         aZsOdhZi6YjFTNoNOv1FnZgYDkyYti0HOxNk6ztUJX2NweNGCSJ8iJE762SgA7Loi333
         S0LK6OC2LSk9yFqBz/NtkI0obfj2RJSGpHwnYt3uFzpzz5dFzr+CKvb95L5lGFpMROQn
         Nqw/9cNf3YHkpLw0oADqyiPOY42p4HIc0IHJMdkevGMH5NNE0TklGkeGQNzXcUxWFWBy
         5Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7dX5dgpmPFuySJbZwA/qhXdydYfRA2CAHeZv6VJOdk=;
        b=TJzHl3ZAr5WhqIS4jeCyvZujL8JE06PagOayo3+ZGz3wPhbrV7WjtOS+zk2x0nx48I
         hlsJykj66d38hfbTvEtuM8co56/wHXUllKW33al/Tp/meT93qGqb4e6AgOatGi+WN8Rd
         LIVJFoWthIvMWCR2aPNaOxtKbD9ipkyh4VEjHOlat4HDYRZcUo6Fd3tyLfwnqfkFo79b
         zeuofCredunlpsnEdyqW+Lu9DA21/QPctAUSrvsrVfJkdq2VKTVqVuXfFH0HDNauW9BC
         yQpeaqerkakOaT349jjzSJNmKluA3NuxLfhg287UdOE7S9dPIK2I6vM3hhjt3U16daLw
         imOw==
X-Gm-Message-State: AOAM533MZF6/YsLpKF+BLQ6CiXTYZj6WWHjSgWfmCRjH9gGSHUI5/xxI
        zU+uNLAl3IZkrECW8w6YZnMxVg==
X-Google-Smtp-Source: ABdhPJxoBHY6Quyfae50dLrV3dw6N6ydOo0cfw07RcLuzRCsFLfKsBPoKFLzrHhyox7gDhH1l8Cn4w==
X-Received: by 2002:a17:90b:1809:: with SMTP id lw9mr12225978pjb.128.1624640061688;
        Fri, 25 Jun 2021 09:54:21 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id b9sm5826453pfm.124.2021.06.25.09.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:54:21 -0700 (PDT)
Date:   Fri, 25 Jun 2021 22:24:18 +0530
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
Message-ID: <20210625165418.shi3gkebumqllxma@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <f963d09e57115969dae32827ade5558b0467d3a0.1624266901.git.viresh.kumar@linaro.org>
 <20210624094812.GA6095@arm.com>
 <20210624130418.poiy4ph66mbv3y67@vireshk-i7>
 <20210625085454.GA15540@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625085454.GA15540@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25-06-21, 09:54, Ionela Voinescu wrote:
> Hey,
> 
> On Thursday 24 Jun 2021 at 18:34:18 (+0530), Viresh Kumar wrote:
> > On 24-06-21, 10:48, Ionela Voinescu wrote:
> > > On Monday 21 Jun 2021 at 14:49:37 (+0530), Viresh Kumar wrote:
> > > > The Frequency Invariance Engine (FIE) is providing a frequency scaling
> > > > correction factor that helps achieve more accurate load-tracking.
> > > [..]
> > > > +static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
> > > > +{
> > > > +	struct cppc_freq_invariance *cppc_fi;
> > > > +	int cpu;
> > > > +
> > > > +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > > > +		return;
> > > > +
> > > > +	/* policy->cpus will be empty here, use related_cpus instead */
> > > > +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
> > > > +
> > > > +	for_each_cpu(cpu, policy->related_cpus) {
> > > > +		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> > > 
> > > Do you think it might be worth having here something like:
> > > 
> > > 		if (!cppc_fi->cpu_data)
> > > 			continue;
> > > 
> > > This would be to protect against cases where the platform does not boot
> > > with all CPUs or the module is loaded after some have already been
> > > offlined. Unlikely, but..
> > 
> > Even in that case policy->cpus will contain all offline+online CPUs (at ->init()
> > time), isn't it ?
> > 
> 
> Right, my bad. I missed cpumask_and(policy->cpus, policy->cpus,
> cpu_online_mask) being done after init(). It logically seems a bit
> wrong, but drivers are in control of setting policy->cpus and acting on
> it, and in this case the driver does the right thing.

Do you want me to re-add your Reviewed-by here ?

-- 
viresh
