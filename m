Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6223AA98E
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 05:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFQD0a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 23:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFQD00 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 23:26:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D5FC061767
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 20:24:19 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p13so3905446pfw.0
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 20:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vQ1H5KpmR6igc6vGa3WgsWAZHbvCNMb9RNa0+vWcC+c=;
        b=pntVkEhpVrje7UZgQbd5ogPor9DVKmZh+o6VM42V9+9qGmWQTuQzsaHU4FnqosSDmb
         u17goz6U6MbKUWtgPZ2z/kEYiWnj2LdJPSeaTUKddqGqX1hljiGnYSuqgO3xnbuA/rGW
         mowV5PmjPrGCx4rh/iIiUR21ylReC92w4TwqUIOIepfFOgD8YR7MOcBEi5XbrSDbfD5Z
         GtKkRctOBp9uRnUhtDWJFWtFXaCh70/wvTRZoiRC20upA5jumdFMJIXMa7R4WxRwBIbP
         IKFLPW3Bze94fMiXlrw1bSLFK23kQ1KVGMhB7dQQddbF3zIDvW0un1963cTibr45SyPp
         lqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQ1H5KpmR6igc6vGa3WgsWAZHbvCNMb9RNa0+vWcC+c=;
        b=etNggnKWKl4UF8fmw+EGXFwDRciXxWl8Qc5TpI+0PNarbTqgM0IPx3UJ+pvCVfN7VU
         qXcL/6/PGJqZkzF96DwseMqPKnvKQwEQ8bAy1F9Cg/sT1HgneG7F4opXCoBkLQuHq80K
         UO18JclCkK7XX+UtiLmvDIamO1qlCH53t6KRNhmbU6X5fWUiE+X5r8A3zsYjzAcQ8Dq9
         CjoToDgRgfHKNgOqNFvGwY216DGl1nfhsC2jlBdPAKC8/eR+kpFiLqEihM22j3SNYfxB
         /iD6dGnR77BYy6mzU9FIh1BMC1b04fmd5HPaTOcIqew4r06ZFC9QuCyyzb0z4zc8MAXn
         /WdA==
X-Gm-Message-State: AOAM530WvLvsuBgge7nLEHV8dMN9ZeOdklNm7t4+zUfS4xl5VmXS4JFQ
        bXmmIEOKvBskpZQhWSdMQpaw/A==
X-Google-Smtp-Source: ABdhPJx+WjlyD29L4tT+M6GTV9f9nyqfrcFUEahFhzIAo+O28+IHwvB1LDeBisMZcWKceUhx2vCJYw==
X-Received: by 2002:a05:6a00:1794:b029:2ee:c59c:56bf with SMTP id s20-20020a056a001794b02902eec59c56bfmr3071994pfg.2.1623900258819;
        Wed, 16 Jun 2021 20:24:18 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id n14sm3306910pfa.138.2021.06.16.20.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 20:24:18 -0700 (PDT)
Date:   Thu, 17 Jun 2021 08:54:16 +0530
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
Subject: Re: [PATCH V2 3/3] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210617032416.r2gfp25xxvhc5t4x@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
 <20210616124806.GA6495@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616124806.GA6495@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16-06-21, 13:48, Ionela Voinescu wrote:
> I was looking forward to the complete removal of stop_cpu() :).

No one wants to remove more code than I do :)

> I'll only comment on this for now as I should know the rest.
> 
> Let's assume we don't have these, what happens now is the following:
> 
> 1. We hotplug out the last CPU in a policy, we call the
>    .stop_cpu()/exit() function which will free the cppc_cpudata structure.
> 
>    The only vulnerability is if we have a last tick on that last CPU,
>    after the above callback was called.
> 
> 2. When the CPU at 1. gets hotplugged back in, the cppc_fi->cpu_data is
>    stale.
> 
> We do not have a problem when removing the CPPC cpufreq module as we're
> doing cppc_freq_invariance_exit() before unregistering the driver and
> freeing the data.
> 
> Are 1. and 2 the only problems we have, or have I missed any?

There is more to it. For simplicity, lets assume a quad-core setup,
with all 4 CPUs sharing the cpufreq policy. And here is what happens
without the new changes:

- On CPPC cpufreq driver insertion, we start 4 kthreads/irq-works (1
  for each CPU as it fires from tick) from the ->init() callback.

- Now lets say we offline CPU3. The CPPC cpufreq driver isn't notified
  by anyone and it hasn't registered itself to hotplug notifier as
  well. So, the irq-work/kthread isn't stopped. This results in the
  issue reported by Qian earlier.

  The very same thing happens with schedutil governor too, which uses
  very similar mechanisms, and the cpufreq core takes care of it there
  by stopping the governor before removing the CPU from policy->cpus
  and starting it again. So there we stop irq-work/kthread for all 4
  CPUs, then start them only for remaining 3.

  I thought about that approach as well, but it was too heavy to stop
  everyone and start again in this case. And so I invented start_cpu()
  and stop_cpu() callbacks.

- In this case, because the CPU is going away, we need to make sure we
  don't queue any more irq-work or kthread to it and this is one of
  the main reasons for adding synchronization in the topology core,
  because we need a hard guarantee here that irq-work won't fire
  again, as the CPU won't be there or will not be in a sane state.

- The same sequence of events is true for the case where the last CPU
  of a policy goes away (not in this example, but lets say quad-core
  setup with separate policies for each CPU).

- Not just the policy, but the CPU may be going away as well.

I hope I was able to clarify a bit here.

-- 
viresh
