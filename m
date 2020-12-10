Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86B2D6371
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 18:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391441AbgLJRZN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 12:25:13 -0500
Received: from foss.arm.com ([217.140.110.172]:54690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728969AbgLJRY3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Dec 2020 12:24:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEFC730E;
        Thu, 10 Dec 2020 09:23:41 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F2EB3F66B;
        Thu, 10 Dec 2020 09:23:41 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:23:40 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mian Yousaf Kaukab <ykaukab@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Petr Cervinka <pcervinka@suse.com>
Subject: Re: [PATCH 1/2] acpi: cppc: add cpufreq device
Message-ID: <20201210172339.GA2828@arm.com>
References: <20201210142139.20490-1-yousaf.kaukab@suse.com>
 <CAJZ5v0hWxLrXCS+X15hnLZ2enBsSJ0aEfnxK2kL+n9k4gkg17Q@mail.gmail.com>
 <20201210150417.GA24136@suse.de>
 <1916679.syIRshJoYJ@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1916679.syIRshJoYJ@kreacher>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Thursday 10 Dec 2020 at 17:55:56 (+0100), Rafael J. Wysocki wrote:
> On Thursday, December 10, 2020 4:04:40 PM CET Mian Yousaf Kaukab wrote:
> > On Thu, Dec 10, 2020 at 03:32:09PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Dec 10, 2020 at 3:23 PM Mian Yousaf Kaukab
> > > <yousaf.kaukab@suse.com> wrote:
> > > >
> > > > Convert cppc-cpufreq driver to a platform driver (done in a separate patch)
> > > > and add cppc-cpufreq device when acpi_cppc_processor_probe() succeeds.
> > > 
> > > Honestly, I prefer to drop 28f06f770454 (along with its follower)
> > > instead of making this change.
> > > 
> > Even if we revert 28f06f770454 there is still one more small issue that these
> > patches fix. Currently, ACPI_PROCESSOR_DEVICE_HID is used to load cppc-cpufreq
> > module. In case when CPPC is disabled, some cycles will be wasted in loading
> > cppc-cpufreq module. The module will return error from the init call though
> > so no memory is wasted.
> > 
> > After converting to platform-driver, cppc-cpufreq module will only be loaded
> > when the platform-device is available.
> 
> Even so, that issue is low-impact AFAICS and may be addressed later and I'd
> rather not let known breakage go into the mainline.
> 
> I'm going to do drop the problematic commit now and please work with Ionela
> to produce a clean series of patches in the right order to avoid introducing
> issues between them.
> 

The following commit will be easy to drop:
a37afa60de38  cppc_cpufreq: optimise memory allocation for HW and NONE coordination (2 weeks ago)

28f06f770454  will be more difficult to drop as it's embedded in the
series, and removing that one will produce conflicts in the patches
that follow it:

f9f5baa8b2a8  ACPI: processor: fix NONE coordination for domain mapping failure (3 weeks ago)
cdb4ae5de6f7  cppc_cpufreq: expose information on frequency domains (3 weeks ago)
c783a4d94848  cppc_cpufreq: clarify support for coordination types (3 weeks ago)
3bd412fb2c7f  cppc_cpufreq: use policy->cpu as driver of frequency setting (3 weeks ago)
28f06f770454  cppc_cpufreq: replace per-cpu structures with lists (3 weeks ago)
bb025fb6c276  cppc_cpufreq: simplify use of performance capabilities (3 weeks ago)
48ad8dc94032  cppc_cpufreq: clean up cpu, cpu_num and cpunum variable use (3 weeks ago)
63087265c288  cppc_cpufreq: fix misspelling, code style and readability issues (3 weeks ago)

Let me know how you want to proceed and I can either send a replacement
series or reverts with conflicts fixed.

Also, if you want you can drop all 5 (all before and including 28f06f770454),
and I can add them again in the series that fixes the problem that Yousaf
reported.

Thanks,
Ionela.

> If that is done timely enough, it may still be possible to push those patches
> for 5.11-rc1.
> 
> Thanks!
> 
> 
> 
