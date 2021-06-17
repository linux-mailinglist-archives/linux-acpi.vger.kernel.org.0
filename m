Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6875B3AB25D
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 13:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhFQLVr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhFQLVr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 07:21:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98591C06175F
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 04:19:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k15so4751100pfp.6
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Np/lQVozeidMH5d/F8qOsmZ9gxCf0/IInqaWOQ/30j4=;
        b=L7dHSltwk04Vk547K8izfarGGRCbF4ISWk6Fb0R1ubDfVGBnc2sFCI9UVohrf3z8hM
         bfHXvQH6gcaLZHZArDnbvRp9HvDkJnyrua/eizeIjvKJHpLMJusIHhjNATDE7h6TErC5
         7CZz6Ul0kbXdmlmjXzNHbpmCZxZ/4AiIkQ0CxGMY2QcMDrzN4s/c3O73uMvTPD7Wxb6C
         MwCRLlkrqHRt8Pcv/UF1TmBMAudCnqRwKjwGjUF8EZYf/MOud9ege9kPmavrzYcEkjSx
         Furj36cWPM+oRKegQtePu4ABTLDiHiuTjbnzmNQETeUYIDjPgNzrEffPnFNsGlVDOIUv
         a6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Np/lQVozeidMH5d/F8qOsmZ9gxCf0/IInqaWOQ/30j4=;
        b=udzLfN+FyLGA9lgzBugVyman8I4zBhDtPpvDep+nRRwekXch6uJN3ZfV+psrYslZ+m
         ORLYYNsJpkvQUYNyAZGQqafNOZV2llQRtfQ7dXJ+OIyn8KUWgzAWVPpO6u6nVj/0eVOz
         aAGVAC+6miNGxrIOGditjux94OdcxVTtnayjitgy1lKR5H308s/hylzHj/PyqiVuebsN
         RvNwBSBr9RY2XqFcSbKUNW9Z0MkA5tScC9hBlB5s+J2iSZGe/8IZijyQq3oBL6u6pP9K
         mCXQFBXSYqoXTGeWGerWfU/PgRqoRQd1P4L6trH9Orq16aA1GiYvkJaINbNbtXzi/+ip
         2a1g==
X-Gm-Message-State: AOAM533BKRGer0sBvAG2WsnSTd+/pyRi0eWA54jIp41jh8uVFZQEvMsT
        WmY6FkB5RugWrcW5c89C4x9bgw==
X-Google-Smtp-Source: ABdhPJxBREtkjK9RmmpOaSHHRyEaKsZymNNG87E3Vgz5LObhwmg1rfNrxRVlX8yXxTFnGAN0vI7hpQ==
X-Received: by 2002:aa7:8f28:0:b029:2f4:9245:4ed with SMTP id y8-20020aa78f280000b02902f4924504edmr4735299pfr.24.1623928779088;
        Thu, 17 Jun 2021 04:19:39 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id v15sm4886439pfm.216.2021.06.17.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:19:38 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:49:36 +0530
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
Message-ID: <20210617111936.cfjzoh6g5zvolaf5@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
 <20210616124806.GA6495@arm.com>
 <20210617032416.r2gfp25xxvhc5t4x@vireshk-i7>
 <20210617103415.GA29877@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617103415.GA29877@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 17-06-21, 11:34, Ionela Voinescu wrote:
> I might be missing something, but when you offline a single CPU in a
> policy, the worse that can happen is that a last call to
> cppc_scale_freq_tick() would have sneaked in before irqs and the tick
> are disabled. But even if we have a last call to
> cppc_scale_freq_workfn(), the counter read methods would know how to
> cope with hotplug, and the cppc_cpudata structure would still be
> allocated and have valid desired_perf and highest_perf values.

Okay, I somehow assumed that cppc_scale_freq_workfn() needs to run on the local
CPU, while it can actually land anywhere. My fault.

But the irq-work being queued here is per-cpu and it will get queued on the
local CPU where the tick occurred.

Now I am not sure of what will happen to this irq-work in that case. I tried to
look now and I see that these irq-work items are processed first on tick and
then the tick handler of scheduler is called, so that will again queue the cppc
irq-work.

What happens if this happens along with CPU hotplug ? I am not sure I understand
that. There may or may not be any side effects of this. Lets assume the work
item is left in the queue as is and no tick happens after that as the CPU is
offlined. We are good.

Now if we unload the cpufreq driver at this moment, the driver will call
irq_work_sync(), which may end up in a while loop ? There is no
irq-work-cancel() API.

Peter: Can you help here on this ? Lemme try to explain a bit here:

We are starting an irq-work (in cppc cpufreq driver) from
scheduler_tick()->arch_scale_freq_tick(). What will happen if the driver doesn't
take care of CPU hotplug explicitly and make sure this work isn't queued again
from the next tick.

Is it important for user to make sure it gets rid of the irq-work during hotplug
here ?

> Worse case, the last scale factor set for the CPU will be meaningless,
> but it's already meaningless as the CPU is going down.
> 
> When you are referring to the issue reported by Qian I suppose you are
> referring to this [1]. I think this is the case where you hotplug the
> last CPU in a policy and free cppc_cpudata.
> 
> [1] https://lore.kernel.org/linux-pm/41f5195e-0e5f-fdfe-ba37-34e1fd8e4064@quicinc.com/

Yes, I was talking about this report only, I am not sure now if I understand
what actually happened here :)

Ionela: I have skipped replying to rest of your email, will get back to that
once we have clarification on the above first.

Thanks a lot for your reviews, always on time :)

-- 
viresh
