Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0245EEDA
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 23:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfGCV50 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 17:57:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41400 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCV5Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 17:57:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so3332846oia.8
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jul 2019 14:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=facAcgFC+XTI+qNs39LIa4BXwWP87/6c178m8FLgQfQ=;
        b=AB32uWCwt4WPQNu5JQek9A76lObdjQKNY7n0ps503qqKQC5PLKGKh/PNekZpL8r48L
         2U6XJbhM5iJiqhNw3i9Ar6EzZbmVnkJDYRTYFFUBMV8oNd3MlbRonYwF9K6HXwUBkNYL
         fr+Aancqdh8A9sozMtImplqOU8v2GgfRsFj2VdGet90BzfSX0rEjOhfMwGu5NlKXQ+A+
         fDy13SqVBfVMvTjJ0vzxJ3VaMj8sk3aULPHGoT9I+Cgs6L/Zhi2z0kZwU78VU2gs5bFO
         slzEUNHXEO0wBIbNsGmcPi5e1p0IojMht9XfyNubeVSEhXAmBiyAYSZqet+EZLtiFJx4
         TCfw==
X-Gm-Message-State: APjAAAWLpCjl5X1nODwZxKR77mgil7NBHfKUhDF0Nl4OPoAuYhg8vF3V
        8Yz0q8TQo2ibGRyW9ibjiVxIycGDxxM5XAsTzjw=
X-Google-Smtp-Source: APXvYqzbb/QOqIuPIhxbKWonTtHMaRerzldSRDFJhW+ynUsKgKiTuWJwzd94OrgPXubso2zMBpaspTzhRLIkfY2kyCo=
X-Received: by 2002:aca:5a41:: with SMTP id o62mr446353oib.110.1562191044904;
 Wed, 03 Jul 2019 14:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190628181457.6609-1-jeremy.linton@arm.com> <20190628181457.6609-2-jeremy.linton@arm.com>
 <CAJZ5v0jh0+WU5fpd9enq0UHrHzh+0Sgv-xoRiJM3jgu9dQFvdw@mail.gmail.com> <1745d9ee-a4e0-9a6f-138c-c0d5b42b5281@arm.com>
In-Reply-To: <1745d9ee-a4e0-9a6f-138c-c0d5b42b5281@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 23:57:12 +0200
Message-ID: <CAJZ5v0jM5VEuYuY7RdeXYs0S04uRYq5_01fKSBKOouS5DgBhww@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 3, 2019 at 5:11 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi,
>
> Thanks for taking a look at this.
>
> On 7/3/19 4:24 AM, Rafael J. Wysocki wrote:
> > On Fri, Jun 28, 2019 at 8:15 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
> >>
> >> ACPI 6.3 adds a flag to the CPU node to indicate whether
> >> the given PE is a thread. Add a function to return that
> >> information for a given linux logical CPU.
> >>
> >> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >> ---
> >>   drivers/acpi/pptt.c  | 62 +++++++++++++++++++++++++++++++++++++++++++-
> >>   include/linux/acpi.h |  5 ++++
> >>   2 files changed, 66 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> >> index b72e6afaa8fb..bb6196422fad 100644
> >> --- a/drivers/acpi/pptt.c
> >> +++ b/drivers/acpi/pptt.c
> >> @@ -517,6 +517,52 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
> >>          return retval;
> >>   }
> >>
> >> +/**
> >> + * check_acpi_cpu_flag() - Determine if CPU node has a flag set
> >> + * @cpu: Kernel logical CPU number
> >> + * @rev: The PPTT revision defining the flag
> >> + * @flag: The flag itself
> >> + *
> >> + * Check the node representing a CPU for a given flag.
> >> + *
> >> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
> >> + *        the table revision isn't new enough.
> >> + *        1, any passed flag set
> >> + *        0, flag unset
> >> + */
> >> +static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
> >
> > Why not bool?
>
> At least for the thread flag we need the three states so that we can
> fall back to the CPU's description of itself on machines without ACPI
> 6.3 tables.
>
> The ThunderX2 is threaded and without a firmware update a change like
> this will break it.

Fair enough.

> >
> >> +{
> >> +       struct acpi_table_header *table;
> >> +       acpi_status status;
> >> +       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> >> +       struct acpi_pptt_processor *cpu_node = NULL;
> >> +       int ret = -ENOENT;
> >> +       static int saved_pptt_rev = -1;
> >> +
> >> +       /* Cache the PPTT revision to avoid repeat table get/put on failure */
> >
> > This is a rather questionable optimization.
> >
> > Does the extra table get/put really matter?
>
> AFAIK, Probably not.

Then why to optimize it?
