Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D54635E0F6
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 11:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGCJY1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 05:24:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42319 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGCJY0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 05:24:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so1610936otn.9
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jul 2019 02:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBhmRSqcGt6U+/+6SrB3QnpytzlXPZrpz69HxBg2hsg=;
        b=c6CJ5szOg21DUjQZcaGmEQk1kOlCOJAmBT3uAiy9BqR84m17BnGyDVi/wh57WL49bE
         /to5FyCFGALgZUfn21CYTD28qoUw8Ggysg6C9BdN0TLwOduAb0ToGih4Glr05hej5Z4n
         H9Eakbr8tAKK4piSTkP7EuRAoRchFiZDQcU1R2phkUDi3Bs7Wdri+aIntjtnkaN4iRHs
         ffW+qviH6pzCHtVGnzAngdUVNGzflefyZHnX9JoQX8tG0pdtI3kCvcdjU/25aPnXuW6S
         4R/+OSNwzmJf209uS+Rbm1Uo2ilWERuNvTzVPvkCgUoYK96hbunnZVSFHdoRra9ovYbD
         1Aqg==
X-Gm-Message-State: APjAAAU7xiiOOqy37cAPc90U52nyv/HlRI7xK6r+fDrQn4EscJtKY+Iz
        PZHKi8m0HQAL53sLCgBiCiDM5MNTgnoDCQERHIQ=
X-Google-Smtp-Source: APXvYqwH9zCLqJlnGt5u/c7J6cKx3OsJTsiyJ5TpKXpL84k8XVze9/mDmIxzNPZPqiuF/Z0KXnrEIZ6ZvWcHWgckC5g=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr8259609otp.189.1562145866135;
 Wed, 03 Jul 2019 02:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190628181457.6609-1-jeremy.linton@arm.com> <20190628181457.6609-2-jeremy.linton@arm.com>
In-Reply-To: <20190628181457.6609-2-jeremy.linton@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 11:24:14 +0200
Message-ID: <CAJZ5v0jh0+WU5fpd9enq0UHrHzh+0Sgv-xoRiJM3jgu9dQFvdw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

On Fri, Jun 28, 2019 at 8:15 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> ACPI 6.3 adds a flag to the CPU node to indicate whether
> the given PE is a thread. Add a function to return that
> information for a given linux logical CPU.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c  | 62 +++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/acpi.h |  5 ++++
>  2 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index b72e6afaa8fb..bb6196422fad 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -517,6 +517,52 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>         return retval;
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
> + *        the table revision isn't new enough.
> + *        1, any passed flag set
> + *        0, flag unset
> + */
> +static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)

Why not bool?

> +{
> +       struct acpi_table_header *table;
> +       acpi_status status;
> +       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +       struct acpi_pptt_processor *cpu_node = NULL;
> +       int ret = -ENOENT;
> +       static int saved_pptt_rev = -1;
> +
> +       /* Cache the PPTT revision to avoid repeat table get/put on failure */

This is a rather questionable optimization.

Does the extra table get/put really matter?

> +       if (saved_pptt_rev > -1 && saved_pptt_rev < rev)
> +               return -ENOENT;

It should be fine to return 'false' here, shouldn't it?

> +
> +       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> +       if (ACPI_FAILURE(status)) {
> +               saved_pptt_rev = 0;
> +               acpi_pptt_warn_missing();
> +               return ret;

And here?

> +       }
> +
> +       saved_pptt_rev = table->revision;
> +
> +       if (saved_pptt_rev >= rev)
> +               cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +
> +       if (cpu_node)
> +               ret = (cpu_node->flags & flag) != 0;

And this can be

ret = !!(cpu_node->flags & flag);

> +
> +       acpi_put_table(table);
> +
> +       return ret;
> +}
> +
>  /**
>   * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
>   * @cpu: Kernel logical CPU number
> @@ -581,6 +627,21 @@ int cache_setup_acpi(unsigned int cpu)
>         return status;
>  }
>
> +/**
> + * acpi_pptt_cpu_is_thread() - Determine if CPU is a thread
> + * @cpu: Kernel logical CPU number
> + *
> + *
> + * Return: 1, a thread
> + *         0, not a thread
> + *         -ENOENT ,if the PPTT doesn't exist, the CPU cannot be found or
> + *         the table revision isn't new enough.
> + */
> +int acpi_pptt_cpu_is_thread(unsigned int cpu)
> +{
> +       return check_acpi_cpu_flag(cpu, 2, ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD);
> +}
> +
>  /**
>   * find_acpi_cpu_topology() - Determine a unique topology value for a given CPU
>   * @cpu: Kernel logical CPU number
> @@ -641,7 +702,6 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>         return ret;
>  }
>
> -
>  /**
>   * find_acpi_cpu_topology_package() - Determine a unique CPU package value
>   * @cpu: Kernel logical CPU number
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d315d86844e4..3e339375e213 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1301,10 +1301,15 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  #endif
>
>  #ifdef CONFIG_ACPI_PPTT
> +int acpi_pptt_cpu_is_thread(unsigned int cpu);
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
>  int find_acpi_cpu_topology_package(unsigned int cpu);
>  int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
>  #else
> +static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
> +{
> +       return -EINVAL;
> +}
>  static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
>  {
>         return -EINVAL;
> --
> 2.21.0
>
