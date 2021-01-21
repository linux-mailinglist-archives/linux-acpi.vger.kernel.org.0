Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A12FDE8A
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 02:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbhAUBLQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 20:11:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:46172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391847AbhAUBJ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Jan 2021 20:09:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04A5EAC95;
        Thu, 21 Jan 2021 01:09:15 +0000 (UTC)
Message-ID: <1611191354.18842.7.camel@suse.cz>
Subject: Re: [PATCH] x86,sched: On AMD EPYC set freq_max = max_boost in
 schedutil invariant formula
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Thu, 21 Jan 2021 02:09:14 +0100
In-Reply-To: <20210121003550.20415-1-ggherdovich@suse.cz>
References: <20210121003550.20415-1-ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2021-01-21 at 01:35 +0100, Giovanni Gherdovich wrote:
> Phoronix.com discovered a severe performance regression on AMD APYC
> introduced on schedutil [see link 1] by the following commits from v5.11-rc1
> 
>     commit 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
>     commit 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC")
> 
> Furthermore commit db865272d9c4 ("cpufreq: Avoid configuring old governors as
> default with intel_pstate") from v5.10 made it extremely easy to default to
> schedutil even if the preferred driver is acpi_cpufreq. Distros are likely to
> build both intel_pstate and acpi_cpufreq on x86, and the presence of the
> former removes ondemand from the defaults. This situation amplifies the
> visibility of the bug we're addressing.
> 
> [link 1] https://www.phoronix.com/scan.php?page=article&item=linux511-amd-schedutil&num=1
> 
> 1. PROBLEM DESCRIPTION   : over-utilization and schedutil
> 2. PROPOSED SOLUTION     : raise freq_max in schedutil formula
> 3. DATA TABLE            : image processing benchmark
> 4. ANALYSIS AND COMMENTS : with over-utilization, freq-invariance is lost

I've sent this patch twice by mistake, sorry about that.

In case it is of interest, I've shared some plots made while studying this
regression in a bugzilla entry:

  https://bugzilla.kernel.org/show_bug.cgi?id=211305


Thanks,
Giovanni
