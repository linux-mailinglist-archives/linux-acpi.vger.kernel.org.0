Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7218B5813C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 13:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfF0LPi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 07:15:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41927 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0LPh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2019 07:15:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id g7so1266619oia.8;
        Thu, 27 Jun 2019 04:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCoUAfvQtoOdUQRzJp3YAxMM5z56DlV6XuvnfrWIxh8=;
        b=i5tUm84hpzVj5tc/Ydd9YeNUaRZa9BalURw2NMRQ1seeLibJOEwurOSqbUTIPEep3T
         6/JEsutFoKBGAZ+p+yv+5XD1EN/uUGpD8enKPhNOuhXf2pDKxvycIrIlBIs5cqZ1NBcU
         XZQQSi/COP5JB8Jot71NT+JwGTEmt3+Qzgt+UE6KUROZ+yIIga9tmr3WKIcGh0UjJx4n
         Q5joDs6hGmSapPaM6euqT0jZii//IVMrWnZvvdDY9CuRr3IVArtY52yqWkvACYAjjZ4F
         F2bTrPYBwaGb60ONJUrIR6rO2crjN7w37pphjfR6N/RdHNH8oxGUFfdFru8r7+lTAegq
         rLLw==
X-Gm-Message-State: APjAAAUw5736VsyLZ/rrE+oe/orsDdvjLGlqBdGuWnjPcHNuMDOBoEKm
        dqgIK+Ky2tfSo+SNKHKrhxRPGWtrJm1GZXOMs9yFd+4w
X-Google-Smtp-Source: APXvYqwAWX+rdfzN6BS5NnzFFSQ0MP8VbFK4AUz0L4L0N3ZMcq/c/6idSpee191DuJWvyvA6pYrbJ3AK3fDg2yVWEnQ=
X-Received: by 2002:aca:d907:: with SMTP id q7mr1855837oig.68.1561634136962;
 Thu, 27 Jun 2019 04:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190626213718.39423-1-jeremy.linton@arm.com> <20190626213718.39423-3-jeremy.linton@arm.com>
In-Reply-To: <20190626213718.39423-3-jeremy.linton@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jun 2019 13:15:26 +0200
Message-ID: <CAJZ5v0hfHJ-L_ZqkvvVnj0TZqv0MEzMvcFiUetBeiKdjAfLVwg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] ACPI/PPTT: Add function to return ACPI 6.3
 Identical tokens
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Gou <gouhanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 26, 2019 at 11:37 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> ACPI 6.3 adds a flag to indicate that child nodes are all
> identical cores. This is useful to authoritatively determine
> if a set of (possibly offline) cores are identical or not.
>
> Since the flag doesn't give us a unique id we can generate
> one and use it to create bitmaps of sibling nodes, or simply
> in a loop to determine if a subset of cores are identical.
>
> Tested-by: Hanjun Gou <gouhanjun@huawei.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Assuming that the Tested-by tag will be fixed:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/pptt.c  | 26 ++++++++++++++++++++++++++
>  include/linux/acpi.h |  5 +++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 05344413f199..1e7ac0bd0d3a 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -683,3 +683,29 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>         return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>                                           ACPI_PPTT_PHYSICAL_PACKAGE);
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
> +       return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
> +                                         ACPI_PPTT_ACPI_IDENTICAL);
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d315d86844e4..5bcd23e5ccd6 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1303,6 +1303,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  #ifdef CONFIG_ACPI_PPTT
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>  int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
>  #else
>  static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
> @@ -1313,6 +1314,10 @@ static inline int find_acpi_cpu_topology_package(unsigned int cpu)
>  {
>         return -EINVAL;
>  }
> +static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
> +{
> +       return -EINVAL;
> +}
>  static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>  {
>         return -EINVAL;
> --
> 2.21.0
>
