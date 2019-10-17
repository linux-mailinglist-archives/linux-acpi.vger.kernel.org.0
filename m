Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48EFADB907
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 23:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503622AbfJQV3G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 17:29:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44699 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503620AbfJQV3F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2019 17:29:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id q12so3014763lfc.11;
        Thu, 17 Oct 2019 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9WisCaGvIVX1hFD0yfP4aN4Gk25aG7SIYWHJW0guN10=;
        b=Wzp3MqwMGPcebQE4MB7L4YEOWHXfzFEhgEDNAbJVl4LsNPZ9UkYbTbL4yXHO6taXGm
         CqTyRgsepTfbmhfTXBEwhjnXCzxyOZUgV1/I5kBYbs/KXy5zN6JGQwAHaqHXUPt7mBer
         g8PEzoxzzcN3JcUFyQp4fPnB5iv81UUscKrZhex/enPe+JaK/D2rl6MPM960IszXoq2c
         s8CQyEENz0aUg6rbi+IdtcjHRusqpOU+0pkywHi/UIe95utA9q3oyooSmaJ7A2HlSU2x
         78XxVBPt7u8y6dW5qpsmEtxy7E0qzig45YiIFF6xri8k2fCHLXNeoKnGXXPlkGpsoFD0
         1BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9WisCaGvIVX1hFD0yfP4aN4Gk25aG7SIYWHJW0guN10=;
        b=tekPwXrQK13M3JAwBU4Cs+ZdGJJ3+TMKpDamSot7bbiQXubTqpua2fo+QGWaBj7lUu
         Fo5QzZl9ZwCAtyi/YY9FxScbAYC6WlJswHG0BklPoEDFsuPt+lkN60jp/NqQQ6gIzXD5
         HAKSmt/CsqYT51SryQmZYgFbvEj2r0oSfC61im+Ai9asOtyk1mzJb6r9ZhPvt+eWytXW
         QvJnxoX9QN6yOxRDziZVnwuVavJUgScP3AUYCJdSjglUyhx7/ncnQzs4pXTs3OuxFW+G
         J7Ic3mistSTuToNZ+1sQGIVRJjGd6PtQ9Mz2hRihubvag+FKPR+tP01LRLOd0apLBDgL
         ZUTA==
X-Gm-Message-State: APjAAAVsmPZFEA2SSlg1p+vbjWRHGJKBTZFcNPgzKPWQELgFDPjnoxxW
        PNnVlTmVRpAeL7P3NpW7q4rNm34x
X-Google-Smtp-Source: APXvYqxdLHj7PEXoDZrvTj8y7RlvVo+LQjP7EhIWEpeYE/KpuqcP9+Jnbm2at6c5JgPqnGeqJtUsIA==
X-Received: by 2002:a19:ae05:: with SMTP id f5mr3631184lfc.165.1571347743190;
        Thu, 17 Oct 2019 14:29:03 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id t8sm1433774lfc.80.2019.10.17.14.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 14:29:02 -0700 (PDT)
Subject: Re: [RFT][PATCH 2/3] cpufreq: Use per-policy frequency QoS
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <2811202.iOFZ6YHztY@kreacher> <20154332.AJkCBzCetj@kreacher>
 <1707f018-fc6b-0122-17e0-635340daa4ef@gmail.com>
Message-ID: <d88fc9b4-24af-6081-96e4-5a0b93c59d43@gmail.com>
Date:   Fri, 18 Oct 2019 00:29:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1707f018-fc6b-0122-17e0-635340daa4ef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

16.10.2019 21:01, Dmitry Osipenko пишет:
> 16.10.2019 13:47, Rafael J. Wysocki пишет:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Replace the CPU device PM QoS used for the management of min and max
>> frequency constraints in cpufreq (and its users) with per-policy
>> frequency QoS to avoid problems with cpufreq policies covering
>> more then one CPU.
>>
>> Namely, a cpufreq driver is registered with the subsys interface
>> which calls cpufreq_add_dev() for each CPU, starting from CPU0, so
>> currently the PM QoS notifiers are added to the first CPU in the
>> policy (i.e. CPU0 in the majority of cases).
>>
>> In turn, when the cpufreq driver is unregistered, the subsys interface
>> doing that calls cpufreq_remove_dev() for each CPU, starting from CPU0,
>> and the PM QoS notifiers are only removed when cpufreq_remove_dev() is
>> called for the last CPU in the policy, say CPUx, which as a rule is
>> not CPU0 if the policy covers more than one CPU.  Then, the PM QoS
>> notifiers cannot be removed, because CPUx does not have them, and
>> they are still there in the device PM QoS notifiers list of CPU0,
>> which prevents new PM QoS notifiers from being registered for CPU0
>> on the next attempt to register the cpufreq driver.
>>
>> The same issue occurs when the first CPU in the policy goes offline
>> before unregistering the driver.
>>
>> After this change it does not matter which CPU is the policy CPU at
>> the driver registration time and whether or not it is online all the
>> time, because the frequency QoS is per policy and not per CPU.
>>
>> Fixes: 18c49926c4bf ("cpufreq: Add QoS requests for userspace constraints")
>> Reported-by: Dmitry Osipenko <digetx@gmail.com>
>> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
>> Diagnosed-by: Viresh Kumar <viresh.kumar@linaro.org> 
>> Link: https://lore.kernel.org/linux-pm/5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org/T/#md2d89e95906b8c91c15f582146173dce2e86e99f
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> Applies on top of https://patchwork.kernel.org/patch/11191343/
>>
>> ---
>>  drivers/acpi/processor_driver.c            |    9 +---
>>  drivers/acpi/processor_perflib.c           |   18 ++++----
>>  drivers/acpi/processor_thermal.c           |   18 ++++----
>>  drivers/cpufreq/cpufreq.c                  |   59 ++++++++++++-----------------
>>  drivers/cpufreq/intel_pstate.c             |   30 +++++++-------
>>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c      |   15 +++----
>>  drivers/macintosh/windfarm_cpufreq_clamp.c |   38 ++++++++++--------
>>  drivers/thermal/cpu_cooling.c              |   14 +++---
>>  include/acpi/processor.h                   |   20 ++++-----
>>  include/linux/cpufreq.h                    |    7 ++-
>>  10 files changed, 114 insertions(+), 114 deletions(-)
> 
> Thanks, Rafael! The use-after-free bug is fixed for me.
> 
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Viresh, I'm still seeing the warning splat after cpufreq-dt reloading. It looks like there is a
> problem with dev_pm_opp_set_supported_hw() which should be re-applied after
> dev_pm_opp_of_cpumask_remove_table() in order to avoid that warning, but setting supported hardware
> is not a part of the cpufreq-dt driver and thus I think there is a problem here.
> 
> [   43.362906] ------------[ cut here ]------------
> [   43.363403] WARNING: CPU: 2 PID: 224 at lib/refcount.c:156 dev_pm_opp_of_add_table+0x59/0x128
> [   43.364119] refcount_t: increment on 0; use-after-free.
> [   43.364562] Modules linked in: cpufreq_dt(+) tegra30_devfreq [last unloaded: cpufreq_dt]
> [   43.365268] CPU: 2 PID: 224 Comm: modprobe Tainted: G        W
> 5.4.0-rc3-next-20191016-00202-gdc740c468ab7 #2651
> [   43.366167] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [   43.366747] [<c011116d>] (unwind_backtrace) from [<c010bb05>] (show_stack+0x11/0x14)
> [   43.367417] [<c010bb05>] (show_stack) from [<c0d75aad>] (dump_stack+0x89/0x98)
> [   43.368046] [<c0d75aad>] (dump_stack) from [<c0127813>] (__warn+0x10f/0x110)
> [   43.368650] [<c0127813>] (__warn) from [<c0127b09>] (warn_slowpath_fmt+0x61/0x78)
> [   43.369292] [<c0127b09>] (warn_slowpath_fmt) from [<c095b161>] (dev_pm_opp_of_add_table+0x59/0x128)
> [   43.370057] [<c095b161>] (dev_pm_opp_of_add_table) from [<c095b261>]
> (dev_pm_opp_of_cpumask_add_table+0x31/0x88)
> [   43.370946] [<c095b261>] (dev_pm_opp_of_cpumask_add_table) from [<bf80024d>]
> (cpufreq_init+0xd9/0x280 [cpufreq_dt])
> [   43.371853] [<bf80024d>] (cpufreq_init [cpufreq_dt]) from [<c095ec63>] (cpufreq_online+0x3eb/0x890)
> [   43.372638] [<c095ec63>] (cpufreq_online) from [<c095f191>] (cpufreq_add_dev+0x79/0x80)
> [   43.373340] [<c095f191>] (cpufreq_add_dev) from [<c07201db>] (subsys_interface_register+0xc3/0x100)
> [   43.374113] [<c07201db>] (subsys_interface_register) from [<c095d91b>]
> (cpufreq_register_driver+0x13b/0x1f0)
> [   43.374960] [<c095d91b>] (cpufreq_register_driver) from [<bf80047d>] (dt_cpufreq_probe+0x89/0xe0
> [cpufreq_dt])
> [   43.375818] [<bf80047d>] (dt_cpufreq_probe [cpufreq_dt]) from [<c0723df9>]
> (platform_drv_probe+0x49/0x88)
> [   43.376630] [<c0723df9>] (platform_drv_probe) from [<c0721aa1>] (really_probe+0x109/0x378)
> [   43.377330] [<c0721aa1>] (really_probe) from [<c0721e5b>] (driver_probe_device+0x57/0x15c)
> [   43.378030] [<c0721e5b>] (driver_probe_device) from [<c072210d>] (device_driver_attach+0x61/0x64)
> [   43.378776] [<c072210d>] (device_driver_attach) from [<c0722159>] (__driver_attach+0x49/0xa0)
> [   43.379493] [<c0722159>] (__driver_attach) from [<c071fe35>] (bus_for_each_dev+0x69/0x94)
> [   43.380185] [<c071fe35>] (bus_for_each_dev) from [<c0720f39>] (bus_add_driver+0x179/0x1e8)
> [   43.380883] [<c0720f39>] (bus_add_driver) from [<c0722cbf>] (driver_register+0x8f/0x130)
> [   43.381584] [<c0722cbf>] (driver_register) from [<bf80d017>] (dt_cpufreq_platdrv_init+0x17/0x1000
> [cpufreq_dt])
> [   43.382447] [<bf80d017>] (dt_cpufreq_platdrv_init [cpufreq_dt]) from [<d7fca400>] (0xd7fca400)
> [   43.383252] ---[ end trace f68728a0d3053b55 ]---
> 

Viresh, the warning is actually triggered by this line:

https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/opp/of.c#L664

So it looks like the cpufreq-dt driver removal drops
opp_table->list_kref more times than it should be. I may try to take a
closer look at it later on, please let me know if you have any suggestions.
