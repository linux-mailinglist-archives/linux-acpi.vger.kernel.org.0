Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B473879E
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2019 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfFGKD5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Jun 2019 06:03:57 -0400
Received: from foss.arm.com ([217.140.110.172]:37072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfFGKD4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Jun 2019 06:03:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0767344;
        Fri,  7 Jun 2019 02:53:56 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 947133F96A;
        Fri,  7 Jun 2019 02:55:35 -0700 (PDT)
Date:   Fri, 7 Jun 2019 10:53:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, john.garry@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 3/5] ACPI/PPTT: Modify node flag detection to find
 last IDENTICAL
Message-ID: <20190607095353.GC2429@e107155-lin>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <20190503232407.37195-4-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503232407.37195-4-jeremy.linton@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 03, 2019 at 06:24:05PM -0500, Jeremy Linton wrote:
> The ACPI specification implies that the IDENTICAL flag should be
> set on all non leaf nodes where the children are identical.
> This means that we need to be searching for the last node with
> the identical flag set rather than the first one.
> 
> Since this flag is also dependent on the table revision, we
> need to add a bit of extra code to verify the table revision,
> and the next node's state in the traversal. Since we want to
> avoid function pointers here, lets just special case
> the IDENTICAL flag.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 1865515297ca..456e1c0a35ae 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -432,17 +432,39 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>  	}
>  }
>  
> +static bool flag_identical(struct acpi_table_header *table_hdr,
> +			  struct acpi_pptt_processor *cpu)

Not sure if it's email client problem, but I see quite a few mis-alignment
with parenthesis like above one.

> +{
> +	struct acpi_pptt_processor *next;
> +
> +	/* heterogeneous machines must use PPTT revision > 1 */
> +	if (table_hdr->revision < 2)
> +		return false;
> +
> +	/* Locate the last node in the tree with IDENTICAL set */
> +	if (cpu->flags & ACPI_PPTT_ACPI_IDENTICAL) {
> +		next = fetch_pptt_node(table_hdr, cpu->parent);
> +		if (!(next && next->flags & ACPI_PPTT_ACPI_IDENTICAL))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* Passing level values greater than this will result in search termination */
>  #define PPTT_ABORT_PACKAGE 0xFF
>  
> -static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_table_header *table_hdr,
> +static struct acpi_pptt_processor *acpi_find_processor_tag_id(struct acpi_table_header *table_hdr,
>  								  struct acpi_pptt_processor *cpu,
>  								  int level, int flag)
>  {
>  	struct acpi_pptt_processor *prev_node;
>  
>  	while (cpu && level) {
> -		if (cpu->flags & flag)
> +		if (flag == ACPI_PPTT_ACPI_IDENTICAL) {

flag_identical anyways check the flag, so I assume you can drop the above
check.

> +			if (flag_identical(table_hdr, cpu))
> +				break;
> +		} else if (cpu->flags & flag)
>  			break;
>  		pr_debug("level %d\n", level);
>  		prev_node = fetch_pptt_node(table_hdr, cpu->parent);
> @@ -480,7 +502,7 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>  
>  	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>  	if (cpu_node) {
> -		cpu_node = acpi_find_processor_package_id(table, cpu_node,
> +		cpu_node = acpi_find_processor_tag_id(table, cpu_node,
>  							  level, flag);


Again misaligned, may be that's because of renaming.

--
Regards,
Sudeep

