Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66BEE3877A
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2019 11:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfFGJ65 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Jun 2019 05:58:57 -0400
Received: from foss.arm.com ([217.140.110.172]:37002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfFGJ65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Jun 2019 05:58:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84F99337;
        Fri,  7 Jun 2019 02:49:11 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59F643F96A;
        Fri,  7 Jun 2019 02:50:50 -0700 (PDT)
Date:   Fri, 7 Jun 2019 10:49:07 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, john.garry@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 2/5] ACPI/PPTT: Add function to return ACPI 6.3
 Identical tokens
Message-ID: <20190607094907.GB2429@e107155-lin>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <20190503232407.37195-3-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503232407.37195-3-jeremy.linton@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 03, 2019 at 06:24:04PM -0500, Jeremy Linton wrote:
> ACPI 6.3 adds a flag to indicate that child nodes are all
> identical cores. This is useful to authoritatively determine
> if a set of (possibly offline) cores are identical or not.
> 
> Since the flag doesn't give us a unique id we can generate
> one and use it to create bitmaps of sibling nodes, or simply
> in a loop to determine if a subset of cores are identical.
>

If possible reorder this patch with next just to be sure.
I know the user is not introduced until 4/5, but 3/5 kind of fixes
the implementation.


Apart from that, this looks fine to me.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c  | 26 ++++++++++++++++++++++++++
>  include/linux/acpi.h |  5 +++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 83a026765faa..1865515297ca 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -660,3 +660,29 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>  	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>  					  ACPI_PPTT_PHYSICAL_PACKAGE);
>  }
> +
> +/**
> + * find_acpi_cpu_topology_hetero_id() - Get a core architecture tag
> + * @cpu: Kernel logical CPU number
> + *
> + * Determine a unique heterogeneous tag for the given CPU. CPUs with the same
> + * implementation should have matching tags.
> + *
> + * The returned tag can be used to group peers with identical implementation.
> + *
> + * The search terminates when a level is found with the identical implementation
> + * flag set or we reach a root node.
> + *
> + * Due to limitations in the PPTT data structure, there may be rare situations
> + * where two cores in a heterogeneous machine may be identical, but won't have
> + * the same tag.
> + *

Indeed, it's unfortunate. I gave some thoughts if we can find ways to
avoid this. Hope we don't have to see such weird combinations with ACPI
based systems.

--
Regards,
Sudeep
