Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0223213E12
	for <lists+linux-acpi@lfdr.de>; Sun,  5 May 2019 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEEHKp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 May 2019 03:10:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfEEHKp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 5 May 2019 03:10:45 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0CDC92711EA03533A31B;
        Sun,  5 May 2019 15:10:42 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sun, 5 May 2019
 15:10:33 +0800
Subject: Re: [PATCH v3 2/5] ACPI/PPTT: Add function to return ACPI 6.3
 Identical tokens
To:     Jeremy Linton <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <lorenzo.pieralisi@arm.com>,
        <will.deacon@arm.com>, <sudeep.holla@arm.com>, <rjw@rjwysocki.net>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <catalin.marinas@arm.com>, <lenb@kernel.org>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <20190503232407.37195-3-jeremy.linton@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <b52d15ab-de9c-8aa4-d2a4-dacdcb9d137e@huawei.com>
Date:   Sun, 5 May 2019 15:09:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190503232407.37195-3-jeremy.linton@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2019/5/4 7:24, Jeremy Linton wrote:
> ACPI 6.3 adds a flag to indicate that child nodes are all
> identical cores. This is useful to authoritatively determine
> if a set of (possibly offline) cores are identical or not.
>
> Since the flag doesn't give us a unique id we can generate
> one and use it to create bitmaps of sibling nodes, or simply
> in a loop to determine if a subset of cores are identical.
>
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
> + * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
> + * Otherwise returns a value which represents a group of identical cores
> + * similar to this CPU.
> + */
> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
> +{
> +	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
> +					  ACPI_PPTT_ACPI_IDENTICAL);
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d5dcebd7aad3..1444fb042898 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1309,6 +1309,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  #ifdef CONFIG_ACPI_PPTT
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>  int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
>  #else
>  static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
> @@ -1319,6 +1320,10 @@ static inline int find_acpi_cpu_topology_package(unsigned int cpu)
>  {
>  	return -EINVAL;
>  }
static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
> +static int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
> +{
> +	return -EINVAL;
> +}
>  static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>  {
>  	return -EINVAL;

