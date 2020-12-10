Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746D82D5EEA
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 16:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbgLJPDa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 10:03:30 -0500
Received: from foss.arm.com ([217.140.110.172]:47064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389430AbgLJPDM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Dec 2020 10:03:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD191FB;
        Thu, 10 Dec 2020 07:02:25 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F4363F68F;
        Thu, 10 Dec 2020 07:02:25 -0800 (PST)
Date:   Thu, 10 Dec 2020 15:02:23 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Petr Cervinka <pcervinka@suse.com>
Subject: Re: [PATCH 1/2] acpi: cppc: add cpufreq device
Message-ID: <20201210150223.GA28824@arm.com>
References: <20201210142139.20490-1-yousaf.kaukab@suse.com>
 <CAJZ5v0hWxLrXCS+X15hnLZ2enBsSJ0aEfnxK2kL+n9k4gkg17Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hWxLrXCS+X15hnLZ2enBsSJ0aEfnxK2kL+n9k4gkg17Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi guys,

On Thursday 10 Dec 2020 at 15:32:09 (+0100), Rafael J. Wysocki wrote:
> On Thu, Dec 10, 2020 at 3:23 PM Mian Yousaf Kaukab
> <yousaf.kaukab@suse.com> wrote:
> >
> > From: Mian Yousaf Kaukab <ykaukab@suse.de>
> >
> > Since commit 28f06f770454 ("cppc_cpufreq: replace per-cpu structures with
> > lists"), cppc-cpufreq driver doesn't check availability of PSD data before
> > registering with cpufreq core. As a result on a ThunderX2 platform when
> > CPPC is disabled from BIOS, kernel log is spammed with following messages:
> >
> > [  180.974166] CPPC Cpufreq: Error in acquiring _CPC/_PSD data for CPUxx
> >
> > acpi_cppc_processor_probe() never succeed in this case because
> > acpi_evaluate_object_typed("_CPC") always returns AE_NOT_FOUND. When
> > cpufreq core calls cppc_cpufreq_cpu_init(), driver fails to obtain PSD data
> > and print error messages.
> >
> > Convert cppc-cpufreq driver to a platform driver (done in a separate patch)
> > and add cppc-cpufreq device when acpi_cppc_processor_probe() succeeds.
> 
> Honestly, I prefer to drop 28f06f770454 (along with its follower)
> instead of making this change.
> 
> > Fixes: 28f06f770454 ("cppc_cpufreq: replace per-cpu structures with lists")
> 

Sorry for introducing this, I though it was enough to bail out of cpu
init if _CPC entries are not present.

I'll defer to Rafael to decide whether to drop the patches or accept
alternative fixes, but I believe the rework of the data structures and
initialisation is useful.

As alternative fix, would it be okay to introduce a check function to
verify for !cpc_ptr, to be called in cppc_cpufreq_init()? In that case
the driver would not be registered if this check fails.

Thanks,
Ionela.

> Thanks!
