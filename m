Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9AA3B6DA9
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 06:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhF2EfQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 00:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhF2EfP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 00:35:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C242C061760
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jun 2021 21:32:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c5so16130550pfv.8
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jun 2021 21:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23i756DizbPe5Tq81adrM3z+cR5El93g/Fx0K2OMmhk=;
        b=PpsGWIXYxBPhgafzsH2eFwhsDg5mCF0t90pleQ1+fS3Ft68xP+diqvfwpObEbh1oO+
         bHhGDsR0mWE06IgwSiNr7YvCs/yxSGCUX3d/Hqck2bsbW4BnbtPhCORWwEqLjlGx2U1A
         O64aJYmbygBYdr8OZQho+wdTO2OYYMJqeVzGX4DvBpEUOd2H+LWBJU6FSWdiTFaxamPQ
         7LVn+JDX2ueCHS4fOhKPxBL6LLJH4Gu8uGgXcio8KSLFpaCPH76fz4H8pNEVphJHgGF9
         cRfeEkbJOBi44fHyi4y/QgB5JoynuYwfx1idGdew3FsvQM/3TWpX91ic8y8mrt7IZ+F/
         oVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23i756DizbPe5Tq81adrM3z+cR5El93g/Fx0K2OMmhk=;
        b=ou3HjXMdSoRYMihpxFQMX+SN4t4vOTUfKvlsVEVk7TOs4XTxs1UIRFaj7S+9OHBf82
         yzYbthLrQTOS+aUghsjeFS3pTiAsiTijvftvPSwxUFag8YhnWjWxTDhoC1A+I1b9chcj
         0SCrQtekW0FdLqHPj0K8hXgG7p5MDgowNHs0If6pMWGGsmjpoNtOOWINdZrtCTfCs1/2
         ZLSgGo83OmchiRd6u5/NIzmDvbJyjC29R4+bLHkvzJMMsfx5Y4kb+g9co37JxixWAfV7
         lMmqJgQlQxjrsOhLAogjIGIgR0F8GKtnQGJ+KOdoPvJJQ3YuFpz1TgYqzOxQPsNkb+Vf
         Ij3w==
X-Gm-Message-State: AOAM531uWKfg2j5q8yJyX1gx9j72IZ5wk6wURDCQydqXPz7tXXQRKxrU
        EIQYGpnIHo5kn/WW7AsZxXK3tw==
X-Google-Smtp-Source: ABdhPJx+RqUF1CEPwZ70q7pS/j3c5Ho9ctCQ3AvxxRU1qLwOgOmnsHD5adjz3TnwqLo+tfXBwmIvGw==
X-Received: by 2002:a05:6a00:1888:b029:303:ec88:66c with SMTP id x8-20020a056a001888b0290303ec88066cmr28398307pfh.7.1624941167473;
        Mon, 28 Jun 2021 21:32:47 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id 195sm16305577pfw.133.2021.06.28.21.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 21:32:46 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:02:44 +0530
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
Message-ID: <20210629043244.xkjat5dqqjaixkii@vireshk-i7>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <f963d09e57115969dae32827ade5558b0467d3a0.1624266901.git.viresh.kumar@linaro.org>
 <20210624094812.GA6095@arm.com>
 <20210624130418.poiy4ph66mbv3y67@vireshk-i7>
 <20210625085454.GA15540@arm.com>
 <20210625165418.shi3gkebumqllxma@vireshk-i7>
 <20210628104929.GA29595@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628104929.GA29595@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 28-06-21, 11:49, Ionela Voinescu wrote:
> To be honest I would like to have more time on this before you merge the
> set, to better understand Qian's results and some observations I have
> for Thunder X2 (I will share in a bit).

Ideally, this code was already merged in 5.13 and would have required
us to fix any problems as we encounter them. I did revert it because
it caused a kernel crash and I wasn't sure if there was a sane/easy
way of fixing that so late in the release cycle. That was the right
thing to do then.

All those issues are gone now, we may have an issue around rounding of
counters or some hardware specific issues, it isn't clear yet.

But the stuff works fine otherwise, doesn't make the kernel crash and
it is controlled with a CONFIG_ option, so those who don't want to use
it can still disable it.

The merge window is here now, if we don't merge it now, it gets
delayed by a full cycle (roughly two months) and if we merge it now
and are able to narrow down the rounding issues, if there are any, we
will have full two months to make a fix for that and still push it in
5.14 itself.

And so I would like to get it merged in this merge window itself, it
also makes sure more people would get to test it, like Qian was able
to figure out a problem here for us.

> For the code, I think it's fine. I have a single observation regarding
> the following code:
> 
> > +static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
> > +{
> > +	struct cppc_freq_invariance *cppc_fi;
> > +	int cpu, ret;
> > +
> > +	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
> > +		return;
> > +
> > +	for_each_cpu(cpu, policy->cpus) {
> > +		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> > +		cppc_fi->cpu = cpu;
> > +		cppc_fi->cpu_data = policy->driver_data;
> > +		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
> > +		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
> > +
> > +		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
> > +		if (ret) {
> > +			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
> > +				__func__, cpu, ret);
> > +			return;
> > +		}
> 
> For this condition above, think about a scenario where reading counters
> for offline CPUs returns an error. I'm not sure if that can happen, to
> be honest. That would mean here that you will never initialise the freq
> source unless all CPUs in the policy are online at policy creation.
> 
> My recommendation is to warn about the failed read of perf counters but
> only return from this function if the target CPU is online as well when
> reading counters fails.
> 
> This is probably a nit, so I'll let you decide if you want to do something
> about this.

That is a very good observation actually. Thanks for that. This is how
I fixed it.

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index d688877e8fbe..f6540068d0fe 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -171,7 +171,13 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
                if (ret) {
                        pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
                                __func__, cpu, ret);
-                       return;
+
+                       /*
+                        * Don't abort if the CPU was offline while the driver
+                        * was getting registered.
+                        */
+                       if (cpu_online(cpu))
+                               return;
                }
        }

-- 
viresh
