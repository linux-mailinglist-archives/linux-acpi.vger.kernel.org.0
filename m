Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D67DFB1
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2019 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfHAQDO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Aug 2019 12:03:14 -0400
Received: from foss.arm.com ([217.140.110.172]:38454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731613AbfHAQDN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Aug 2019 12:03:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E59A337;
        Thu,  1 Aug 2019 08:57:40 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D96B73F694;
        Thu,  1 Aug 2019 08:57:38 -0700 (PDT)
Date:   Thu, 1 Aug 2019 16:57:36 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        lenb@kernel.org, lorenzo.pieralisi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
Message-ID: <20190801155736.GD23424@e107155-lin>
References: <20190801034634.26913-1-jeremy.linton@arm.com>
 <20190801034634.26913-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801034634.26913-2-jeremy.linton@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi Jeremy,

On Wed, Jul 31, 2019 at 10:46:33PM -0500, Jeremy Linton wrote:
> ACPI 6.3 adds a flag to the CPU node to indicate whether
> the given PE is a thread. Add a function to return that
> information for a given linux logical CPU.
>

Apart from few minor nits,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c  | 54 +++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/acpi.h |  5 ++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 1e7ac0bd0d3a..84718f6cb741 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -540,6 +540,44 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>  	return retval;
>  }
>
> +/**
> + * check_acpi_cpu_flag() - Determine if CPU node has a flag set
> + * @cpu: Kernel logical CPU number
> + * @rev: The PPTT revision defining the flag

[nit] I would rather put it as minimum PPTT revision that supports the
flag. It aligns with the code too as we are not looking for exact match.

> + * @flag: The flag itself
> + *
> + * Check the node representing a CPU for a given flag.
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
> + *	   the table revision isn't new enough.
> + *	   1, any passed flag set
> + *	   0, flag unset
> + */
> +static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
> +{
> +	struct acpi_table_header *table;
> +	acpi_status status;
> +	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +	struct acpi_pptt_processor *cpu_node = NULL;
> +	int ret = -ENOENT;
> +
> +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_pptt_warn_missing();
> +		return ret;
> +	}
> +
> +	if (table->revision >= rev)
> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +
> +	if (cpu_node)
> +		ret = (cpu_node->flags & flag) != 0;
> +
> +	acpi_put_table(table);
> +
> +	return ret;
> +}
> +
>  /**
>   * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
>   * @cpu: Kernel logical CPU number
> @@ -604,6 +642,21 @@ int cache_setup_acpi(unsigned int cpu)
>  	return status;
>  }
>
> +/**
> + * acpi_pptt_cpu_is_thread() - Determine if CPU is a thread
> + * @cpu: Kernel logical CPU number
> + *

[nit] If you spin the patch again, you can drop extra line space here.

--
Regards,
Sudeep
