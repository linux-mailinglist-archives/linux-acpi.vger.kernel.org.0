Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90C679C0
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Jul 2019 12:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfGMKqp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 13 Jul 2019 06:46:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38696 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMKqo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jul 2019 06:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qA92BokuQwIpfUgsOngEYZTp77wWyZRJldi5ki7ucGw=; b=roABZ5It4KusJQ35a/CptUJMq
        J2ybOivTMeJO3f3eHAcguMk4nkFtL4X1EM2LEXev+K9U+wnPf5Kx8/pY7BZWG+ZqllmmJL6jIHJJ+
        QQWGDKGipwLqOktHGfYoga1l5tGTMam7yPN22WZuOTEY3apy8dMV2zw6pu91eeNCdVu5gqI8QyiJL
        qIB+9nCLap8IbQQlzktu4IC9Gxutj5BZfru9tFr88w+qczynnzCx4ncQ58omSyy9y6bdZEjN7E8i4
        txdV62ktTQXFNKomgQ0To/CRQ9fB01Fy1g4Yg3ZXGkg1P2YzyH0lQX9hzDL0wCJ2pOAVwW/gIWPE1
        DSmvkZBow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmFXq-00063x-1v; Sat, 13 Jul 2019 10:46:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5999B20B51DA5; Sat, 13 Jul 2019 12:46:19 +0200 (CEST)
Date:   Sat, 13 Jul 2019 12:46:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: Re: [PATCHv3 0/6] CPPC optional registers AMD support
Message-ID: <20190713104619.GA3496@hirez.programming.kicks-ass.net>
References: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 10, 2019 at 06:37:09PM +0000, Natarajan, Janakarajan wrote:
> CPPC (Collaborative Processor Performance Control) offers optional
> registers which can be used to tune the system based on energy and/or
> performance requirements.
> 
> Newer AMD processors (>= Family 17h) add support for a subset of these
> optional CPPC registers, based on ACPI v6.1.
> 
> The following are the supported CPPC registers for which sysfs entries
> are created:
> * enable                (NEW)
> * max_perf              (NEW)
> * min_perf              (NEW)
> * energy_perf
> * lowest_perf
> * nominal_perf
> * desired_perf          (NEW)
> * feedback_ctrs
> * auto_sel_enable       (NEW)
> * lowest_nonlinear_perf
> 
> First, update cppc_acpi to create sysfs entries only when the optional
> registers are known to be supported.
> 
> Next, a new CPUFreq driver is introduced to enable the OSPM and the userspace
> to access the newly supported registers through sysfs entries found in
> /sys/devices/system/cpu/cpu<num>/amd_cpufreq/.
> 
> This new CPUFreq driver can only be used by providing a module parameter,
> amd_cpufreq.cppc_enable=1.
> 
> The purpose of exposing the registers via the amd-cpufreq sysfs entries is to
> allow the userspace to:
> * Tweak the values to fit its workload.
> * Apply a profile from AMD's optimization guides.

So in general I think it is a huge mistake to expose all that to
userspace. Before you know it, there's tools that actually rely on it,
and then inhibit the kernel from doing anything sane with it.

> Profiles will be documented in the performance/optimization guides.

I don't think userspace can really do anything sane with this; it lacks
much if not all useful information.

> Note:
> * AMD systems will not have a policy applied in the kernel at this time.

And why the heck not? We're trying to move all cpufreq into the
scheduler and have only a single governor, namely schedutil -- yes,
we're still stuck with legacy, and we're still working on performance
parity in some cases, but I really hope to get rid of all other cpufreq
governors eventually.

And if you look at schedutil (schedutil_cpu_util in specific) then
you'll see it is already prepared for CPPC and currently only held back
by the generic cpufreq interface.

It currently only sets desired freq, it has information for
min/guaranteed, and once we get thermal intergrated we might have
sensible data for max freq too.

> TODO:
> * Create a linux userspace tool that will help users generate a CPPC profile
>   for their target workload.

Basically a big fat NAK for this approach to cpufreq.

> * Create a general CPPC policy in the kernel.

We already have that, sorta.
