Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF148292
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2019 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfFQMez (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 08:34:55 -0400
Received: from foss.arm.com ([217.140.110.172]:48278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfFQMey (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Jun 2019 08:34:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 048E92B;
        Mon, 17 Jun 2019 05:34:54 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D76BD3F246;
        Mon, 17 Jun 2019 05:34:52 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, lenb@kernel.org
References: <20190614223158.49575-1-jeremy.linton@arm.com>
 <20190614223158.49575-2-jeremy.linton@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <667f95c0-5aa9-f460-a49a-e6dfefc027d8@arm.com>
Date:   Mon, 17 Jun 2019 13:34:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614223158.49575-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jeremy,

Few nits below.

Also, I had a look at the other PPTT processor flags that were introduced
in 6.3, and the only other one being used is ACPI_LEAF_NODE in
acpi_pptt_leaf_node(). However that one already has a handle on the table
header, so the check_acpi_cpu_flag() isn't of much help there.

I don't believe the other existing flags will benefit from the helper since
they are more about describing the PPTT tree, but I think it doesn't hurt
to keep it around for potential future flags.

On 14/06/2019 23:31, Jeremy Linton wrote:
[...]
> @@ -517,6 +517,43 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>  	return retval;
>  }
>  
> +/**
> + * check_acpi_cpu_flag() - Determine if CPU node has a flag set
> + * @cpu: Kernel logical CPU number
> + * @rev: The PPTT revision defining the flag
> + * @flag: The flag itself
> + *
> + * Check the node representing a CPU for a given flag.
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
> + *	   the table revision isn't new enough.
> + * Otherwise returns flag value
> + */

Nit: strictly speaking we're not returning the flag value but its mask
applied to the flags field. I don't think anyone will care about getting
the actual flag value, but it should be made obvious in the doc:

-ENOENT if ...
0 if the flag isn't set
> 0 if it is set.

[...]
> @@ -581,6 +618,21 @@ int cache_setup_acpi(unsigned int cpu)
>  	return status;
>  }
>  
> +/**
> + * acpi_pptt_cpu_is_thread() - Determine if CPU is a thread
> + * @cpu: Kernel logical CPU number
> + *
> + *

Nit: extra newline

> + * Return: 1, a thread
> + *         0, not a thread
> + *         -ENOENT ,if the PPTT doesn't exist, the CPU cannot be found or
> + *         the table revision isn't new enough.
> + */
> +int acpi_pptt_cpu_is_thread(unsigned int cpu)
> +{
> +	return check_acpi_cpu_flag(cpu, 2, ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD);
> +}
> +
>  /**
>   * find_acpi_cpu_topology() - Determine a unique topology value for a given CPU
>   * @cpu: Kernel logical CPU number
> @@ -641,7 +693,6 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
[...]
