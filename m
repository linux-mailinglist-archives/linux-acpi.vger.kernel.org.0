Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843A63C8720
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhGNPQC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 11:16:02 -0400
Received: from foss.arm.com ([217.140.110.172]:36036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232445AbhGNPQB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jul 2021 11:16:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D0231B;
        Wed, 14 Jul 2021 08:13:10 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 183423F694;
        Wed, 14 Jul 2021 08:13:08 -0700 (PDT)
Date:   Wed, 14 Jul 2021 16:12:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 02/13] ACPI: CPPC: Fix doxygen comments
Message-ID: <20210714151210.or4kburfmcsjo3u2@bogus>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-3-sudeep.holla@arm.com>
 <CAJZ5v0ibgrdceoTqnbgbqHhCTZR74RuzKTDxVOzU2UR4VWJkGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ibgrdceoTqnbgbqHhCTZR74RuzKTDxVOzU2UR4VWJkGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 14, 2021 at 02:20:05PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 8, 2021 at 8:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Clang complains about doxygen comments too with W=1 in the build.
> >
> >   | drivers/acpi/cppc_acpi.c:560: warning: Function parameter or member
> >   |     'pcc_ss_id' not described in 'pcc_data_alloc'
> >   | drivers/acpi/cppc_acpi.c:1343: warning: Function parameter or member
> >   |     'cpu_num' not described in 'cppc_get_transition_latency'
> >
> > Fix it.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/acpi/cppc_acpi.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index a4d4eebba1da..eb5685167d19 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -562,6 +562,8 @@ bool __weak cpc_ffh_supported(void)
> >  /**
> >   * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
> >   *
>
> I would drop this empty line (and analogously below).
>

Sure

> > + * @pcc_ss_id: PCC Subspace channel identifier
> > + *
> >   * Check and allocate the cppc_pcc_data memory.
> >   * In some processor configurations it is possible that same subspace
> >   * is shared between multiple CPUs. This is seen especially in CPUs
> > @@ -1347,10 +1349,15 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
> >  /**
> >   * cppc_get_transition_latency - returns frequency transition latency in ns
> >   *
> > + * @cpu_num: Logical index of the CPU for which latencty is requested
> > + *
> >   * ACPI CPPC does not explicitly specify how a platform can specify the
> >   * transition latency for performance change requests. The closest we have
> >   * is the timing information from the PCCT tables which provides the info
> >   * on the number and frequency of PCC commands the platform can handle.
> > + *
> > + * Returns: frequency transition latency on success or CPUFREQ_ETERNAL on
> > + * failure
> 
> Is this change needed?  The one-line summary already says this.
>

Right, not required. I must have got confused with other place that expected
return summary.

-- 
Regards,
Sudeep
