Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A43AC193
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 05:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhFRDsB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 23:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhFRDsB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 23:48:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ED2C061760
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 20:45:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q192so86771pfc.7
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 20:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D3gfKDAObxcZS4gWY0UN6lYsR+wBujiRgEXvE08JM/k=;
        b=w6pQpx38ffbNxQxqffZYOJWP8IocJze1Hw2LnlGTADR4yQYBGEzpWlUGLmvUOvD6EP
         0VoWFrZy2++m9UH4rvkPtJpiqjgK7c60fxkUZqV3sqAM7+Zhg+hiHARBg2nKjLpeC0gv
         9eaE3iRMAelIHjBkpit1Alu11R2dFsPm4oo95+IlxlpDVqXQiNIvgCoBNJJItqWwX8FP
         bkanzCt9M6TGtWH3+QyU1iF2zyU5QmhwASREQXXK2NGMmlQw2NBUc3vnp+J2bis7QUJ7
         yPViUaI1Xj+Wdqy/oeVSH4nLrtSA5FlgN6iQq6wRDK0nlh8I14FADTCVUirtdbQx7c5L
         I5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D3gfKDAObxcZS4gWY0UN6lYsR+wBujiRgEXvE08JM/k=;
        b=ZFPWY4kQ5fwSrvuqjrXgI7lBcvY+/nsgG7cGB4Wy13t+SLvr0S597xovGmeNB4hzSd
         VnpUM1gBje61gzwBXucM6LMyjGjHpAs/AIouaIWRVQdtNFBH5Iq3k3Qv0kqqeBKZFoVE
         asW++t4G+jt/hUI2UNfIMxCKRVz4XYuiEyEdgh7715UGjyzDzDoS0Ily4b05rCixl/f2
         nT77sXY9rm/lhsjxuFeQ+QPE7M5qmrhK7EDScnoY9qydc+atZnIIU29G9yhY8l23wD74
         aS1GE4VZfYlhjZI/SiWUhrVUAA4NX2NUPwEjDEk4uWF8wxYMTXd/iMMgia9x52lXL8Bv
         jyBg==
X-Gm-Message-State: AOAM530fBVEXOicT/ZUcbc8vM6qIzNt8aEVShe+v4FCJ1HGtM1ZeZNRU
        669s8XklUm7zPKn578tXEkK8og==
X-Google-Smtp-Source: ABdhPJzRWmiQooLbv5uZ+44+FIxqwu3Clpnkep9PA7KGuWsZ6OfDbHJ1VpuW0h4g20cCCqSwuWuWGA==
X-Received: by 2002:a65:5206:: with SMTP id o6mr8038475pgp.129.1623987951683;
        Thu, 17 Jun 2021 20:45:51 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id u73sm6652292pfc.169.2021.06.17.20.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 20:45:50 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:15:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20210618034549.wfz24gx4zr2jyfec@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
 <20210616124806.GA6495@arm.com>
 <20210617032416.r2gfp25xxvhc5t4x@vireshk-i7>
 <20210617103415.GA29877@arm.com>
 <20210617111936.cfjzoh6g5zvolaf5@vireshk-i7>
 <YMs+hOKafJMu7Sfu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMs+hOKafJMu7Sfu@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 17-06-21, 14:22, Peter Zijlstra wrote:
> On Thu, Jun 17, 2021 at 04:49:36PM +0530, Viresh Kumar wrote:
> > Peter: Can you help here on this ? Lemme try to explain a bit here:
> > 
> > We are starting an irq-work (in cppc cpufreq driver) from
> > scheduler_tick()->arch_scale_freq_tick(). What will happen if the driver doesn't
> > take care of CPU hotplug explicitly and make sure this work isn't queued again
> > from the next tick.
> > 
> > Is it important for user to make sure it gets rid of the irq-work during hotplug
> > here ?
> 
> irq-work is flushed on hotplug, see smpcfd_dying_cpu().

Thanks Peter.

-- 
viresh
