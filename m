Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBB3A96C9
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 12:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhFPKFE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhFPKE5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 06:04:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D20C0617A8
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 03:02:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v22so3379980lfa.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4RwAjXPtC218FslHiEhUYGCqGEWToA3TK5+6fZBZNA=;
        b=W++LxgSclajmCz1OuVwxJUxeVJT7cnBxMNmegT+m+GtL1a9J+QwnCek7Wrmt9I5xVg
         niE41/CBGR0oZBqLdovyjpzPVSI5b0RVpb2ofDNdHJQZ/r4N7xhPTtI2lhbdbPN1TmyP
         9G8lykpjuFl4zqYrSEwOtuc8L7tLkx4d/YeNTAEXeLi/p2Ldw+jP+KGeZRauthCkV7hq
         L1P4cvdGnrJDcjP4w3Cm+IKV4sDY/QZ44MRhlKIbHDts9bW7TM43Z3qGGT560hDmkmOC
         e8JcLVHzA/ymO30I74Kpns7R20UJOnEeaGWucvQxbQSYqUGEXbbdavchN+Om91HCGjqK
         /Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4RwAjXPtC218FslHiEhUYGCqGEWToA3TK5+6fZBZNA=;
        b=Vacpj2PUx1CnHTzuXJFjaRcSQ1ZpZ43TbsfzLZKgwwy6VfAQADt7Gb61OaMN/jWSkJ
         blkcYuYmgC4bTZk8R/iv8B/YoEiC/137JX90uNq92+W67mhll3voHJNT2ljPXQA68iy6
         PoFqslCq0kjpU6F4UZjL+Kx22mwFXIC1QtTuMKAgv1KOdWThtTkOxSLwml0Z0jkXcEK2
         GwFP8xDGPIaHJ/kYtzE80ZnNYLZnCj5vNhEWrWjQc4ol1YK9c6+/ztxHbKeLaSH/B+u4
         qjKlTq2rIUFvfRu7Qv399zkuwHTd/vdNwRggFpL7gE9GMZGFiPBWO1xB3AxtE9i02unA
         gnAg==
X-Gm-Message-State: AOAM531fvgKoDZ5KTDpieollrUmmWByyiPwPwbKU2/GL6VNJjv9cF94S
        Q2yFU/DxVhXsgPheOHsJSskUX70pKEDOUVvY1XI+SA==
X-Google-Smtp-Source: ABdhPJyCVESb+FOlmMl5dPAf4Gco8QkFh0ii+imiXjgleMjODWaRGNA06Nxj08O7M4Hur+hzj8u2fz+G5MBr5Z14Ri4=
X-Received: by 2002:a19:4810:: with SMTP id v16mr3052847lfa.254.1623837768679;
 Wed, 16 Jun 2021 03:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623825725.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1623825725.git.viresh.kumar@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Jun 2021 12:02:37 +0200
Message-ID: <CAKfTPtCawkocU+ssGi9hz10tMGYib_pfiFGXNMiF1HGYWinMdw@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] cpufreq: cppc: Add support for frequency invariance
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 16 Jun 2021 at 08:48, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hello,
>
> Changes since V1:
>
> - Few of the patches migrating users to ->exit() callback are posted separately.
>
> - The CPPC patch was completely reverted and so the support for FIE is again
>   added here from scratch.
>
> - The start_cpu() and stop_cpu() interface is reworked a little so stop_cpu() is
>   only ever called for a CPU if start_cpu() was called for it earlier.
>
> - A new patch to implement RCU locking in arch_topology core to avoid some
>   races.
>
> - Some cleanup and very clear/separate paths for FIE in cppc driver now.
>
>
> -------------------------8<-------------------------
>
> CPPC cpufreq driver is used for ARM servers and this patch series tries to
> provide counter-based frequency invariance support for them in the absence for
> architecture specific counters (like AMUs).
>
> This was reverted earlier for the 5.13 kernel after Qian Cai reported kernel
> oops during suspend/resume.
>
> This is based of pm/linux-next + a cleanup patchset:
>
> https://lore.kernel.org/linux-pm/cover.1623825358.git.viresh.kumar@linaro.org/
>
> All the patches are pushed here together for people to run.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/cppc
>
> This is tested on my Hikey platform (without the actual read/write to
> performance counters), with this script for over an hour:
>
> while true; do
>     for i in `seq 1 7`;
>     do
>         echo 0 > /sys/devices/system/cpu/cpu$i/online;
>     done;
>
>     for i in `seq 1 7`;
>     do
>         echo 1 > /sys/devices/system/cpu/cpu$i/online;
>     done;
> done
>
>
> Vincent will be giving this patchset a try on ThunderX2.

I tested your branch and got the following while booting:

[   24.454543] zswap: loaded using pool lzo/zbud
[   24.454753] pstore: Using crash dump compression: deflate
[   24.454776] AppArmor: AppArmor sha1 policy hashing enabled
[   24.454784] ima: No TPM chip found, activating TPM-bypass!
[   24.454789] ima: Allocated hash algorithm: sha256
[   24.454801] ima: No architecture policies found
[   24.455750] pcieport 0000:0f:00.0: Adding to iommu group 0
[   24.893888] ------------[ cut here ]------------
[   24.893891] WARNING: CPU: 95 PID: 1442 at
drivers/cpufreq/cppc_cpufreq.c:123 cppc_scale_freq_workfn+0xc8/0xf8
[   24.893901] Modules linked in:
[   24.893906] CPU: 95 PID: 1442 Comm: cppc_fie Not tainted 5.13.0-rc6+ #359
[   24.893910] Hardware name: To be filled by O.E.M. Saber/Saber, BIOS
0ACKL026 03/19/2019
[   24.893912] pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[   24.893915] pc : cppc_scale_freq_workfn+0xc8/0xf8
[   24.893918] lr : cppc_scale_freq_workfn+0x5c/0xf8
[   24.893921] sp : ffff80003727bd90
[   24.893922] x29: ffff80003727bd90 x28: 0000000000000000 x27: ffff800010ec2000
[   24.893928] x26: ffff800010ec2000 x25: ffff8000107c3d90 x24: 0000000000000001
[   24.893932] x23: ffff000816244880 x22: ffff8000113f9000 x21: ffff009f825a0a80
[   24.893935] x20: ffff009efc394220 x19: ffff800011199000 x18: 000000000000001b
[   24.893939] x17: 0000000000000007 x16: 0000000000000001 x15: 00000000000000bf
[   24.893943] x14: 0000000000000016 x13: 000000000000029b x12: 0000000000000016
[   24.893946] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff009efc6958c0
[   24.893950] x8 : ffff009efc394248 x7 : 0000000002bde780 x6 : 00000000ffffffff
[   24.893954] x5 : 00000000916e502a x4 : 00000000d9730e80 x3 : ffffffffffffffff
[   24.893958] x2 : 00000000001e8480 x1 : 00000000002625a0 x0 : 0000000000000401
[   24.893962] Call trace:
[   24.893964]  cppc_scale_freq_workfn+0xc8/0xf8
[   24.893967]  kthread_worker_fn+0x110/0x318
[   24.893971]  kthread+0xf4/0x120
[   24.893973]  ret_from_fork+0x10/0x18
[   24.893977] ---[ end trace ea6dbaf832bce3e4 ]---


>
> Meanwhile it is up for review. Ideally I would like to get this merged for 5.14,
> but lets see how it goes.
>
> Thanks.
>
> --
> Viresh
>
> Viresh Kumar (3):
>   cpufreq: Add start_cpu() and stop_cpu() callbacks
>   arch_topology: Avoid use-after-free for scale_freq_data
>   cpufreq: CPPC: Add support for frequency invariance
>
>  Documentation/cpu-freq/cpu-drivers.rst |   7 +-
>  drivers/base/arch_topology.c           |  27 ++-
>  drivers/cpufreq/Kconfig.arm            |  10 ++
>  drivers/cpufreq/cppc_cpufreq.c         | 232 +++++++++++++++++++++++--
>  drivers/cpufreq/cpufreq.c              |  19 +-
>  include/linux/arch_topology.h          |   1 +
>  include/linux/cpufreq.h                |   5 +-
>  kernel/sched/core.c                    |   1 +
>  8 files changed, 272 insertions(+), 30 deletions(-)
>
> --
> 2.31.1.272.g89b43f80a514
>
