Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0D55335
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 17:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbfFYPUr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jun 2019 11:20:47 -0400
Received: from foss.arm.com ([217.140.110.172]:44006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbfFYPUr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jun 2019 11:20:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE622B;
        Tue, 25 Jun 2019 08:20:46 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF9493F718;
        Tue, 25 Jun 2019 08:20:44 -0700 (PDT)
Date:   Tue, 25 Jun 2019 16:20:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
Message-ID: <20190625152029.GA2308@e107155-lin>
References: <20190614223158.49575-1-jeremy.linton@arm.com>
 <20190614223158.49575-2-jeremy.linton@arm.com>
 <667f95c0-5aa9-f460-a49a-e6dfefc027d8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <667f95c0-5aa9-f460-a49a-e6dfefc027d8@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 17, 2019 at 01:34:51PM +0100, Valentin Schneider wrote:
> Hi Jeremy,
>
> Few nits below.
>
> Also, I had a look at the other PPTT processor flags that were introduced
> in 6.3, and the only other one being used is ACPI_LEAF_NODE in
> acpi_pptt_leaf_node(). However that one already has a handle on the table
> header, so the check_acpi_cpu_flag() isn't of much help there.
>
> I don't believe the other existing flags will benefit from the helper since
> they are more about describing the PPTT tree, but I think it doesn't hurt
> to keep it around for potential future flags.
>
> On 14/06/2019 23:31, Jeremy Linton wrote:
> [...]
> > @@ -517,6 +517,43 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
> >  	return retval;
> >  }
> >
> > +/**
> > + * check_acpi_cpu_flag() - Determine if CPU node has a flag set
> > + * @cpu: Kernel logical CPU number
> > + * @rev: The PPTT revision defining the flag
> > + * @flag: The flag itself

How about the "the processor structure flag being examined" ?

> > + *
> > + * Check the node representing a CPU for a given flag.
> > + *
> > + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
> > + *	   the table revision isn't new enough.
> > + * Otherwise returns flag value
> > + */
>
> Nit: strictly speaking we're not returning the flag value but its mask
> applied to the flags field. I don't think anyone will care about getting
> the actual flag value, but it should be made obvious in the doc:
>

I agree with that. I am also fine if you want to change the code to
return 0 or 1 based on the flag value. It then aligns well with comment
under acpi_pptt_cpu_is_thread. Either way, we just need consistency.

--
Regards,
Sudeep
