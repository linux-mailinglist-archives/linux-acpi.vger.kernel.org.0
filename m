Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89416DE87
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2019 11:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfD2JAF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 05:00:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45542 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfD2JAF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2019 05:00:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id e5so7907536otk.12
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2019 02:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crSkA8XNd3z0SC+KxAVvI8kflKvVvG+Q7xkpAUf78qw=;
        b=LOCLmRNa8DTlmHFbjj9Ozomy2KsqRN+70Avw02v2jA/3P9ORs6cvtYPBPkIYD+TPpD
         63aQ/pJsYW/xuFHpYWw8Ae6KLANlHV+RNr0d6A39lwy2Qamr4T24wqOrwNIRfiDgxbR9
         NEq3kmwN+8U4If0meRQhxZEEn6yWrNRlnsFfbn5b3JwnIh1lGJhiWe6y1YDay2NzbYNS
         kmLW3FeOXM/sh78aWListznhHQpTXY7QezZcij8KBtIJi7uDbARZWBwgKvFKo3gEkCkk
         fA8Nt6DYSMihYl/2d5ny6NdJXbhvBp9FcZzPHkluXndxOBHr9zrxqOZZsquLYFtSYm+z
         ZNIg==
X-Gm-Message-State: APjAAAUavIP8GTUNzYIYHDlSr9u0hblsUFxOa8tXVgtrdQCg6uewRo4T
        Rvi2qBdAq3DjlUAcHo4iVJ3rd9Eni+hsQGYybSw=
X-Google-Smtp-Source: APXvYqzESzMlKhAVGvillydRVRAF1i1rYc4aXzXRSW9mYwgisPfJumgIQTSeuJS5LNJ/d49p/LeMpAsMrcLJyO7nXRw=
X-Received: by 2002:a05:6830:20cd:: with SMTP id z13mr8216752otq.168.1556528404498;
 Mon, 29 Apr 2019 02:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190426220309.55654-1-jeremy.linton@arm.com> <20190426220309.55654-4-jeremy.linton@arm.com>
In-Reply-To: <20190426220309.55654-4-jeremy.linton@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Apr 2019 10:59:53 +0200
Message-ID: <CAJZ5v0huzpGwVTwp7rWU5bo4ziP3oRrjoW2cz+KU+A7XfiDwVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI/PPTT: Modify node flag detection to find last IDENTICAL
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Apr 27, 2019 at 12:03 AM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> The ACPI specification implies that the IDENTICAL flag should be
> set on all non leaf nodes where the children are identical.
> This means that we need to be searching for the last node with
> the identical flag set rather than the first one.
>
> To achieve this with the existing code we need to pass a
> function through the tree traversal logic so we can check
> the next node to assure that IDENTICAL isn't set before returning
> a node with IDENTICAL set.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c | 62 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 48 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 1865515297ca..39f660d8be0a 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -432,17 +432,51 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>         }
>  }
>
> +
> +typedef bool (*node_check)(struct acpi_table_header *table_hdr,
> +                          struct acpi_pptt_processor *cpu);

I would just use a function pointer with the entire arg list in the
function header(s).  Using this just makes things harder to follow
IMO.

> +static bool flag_package(struct acpi_table_header *table_hdr,
> +                        struct acpi_pptt_processor *cpu)
> +{
> +       return cpu->flags & ACPI_PPTT_PHYSICAL_PACKAGE;
> +}
> +
> +static bool flag_identical(struct acpi_table_header *table_hdr,
> +                          struct acpi_pptt_processor *cpu)
> +{
> +       struct acpi_pptt_processor *next;
> +
> +       /* heterogeneous machines must use PPTT revision > 1 */
> +       if (table_hdr->revision < 2)
> +               return false;
> +
> +       /* Locate the last node in the tree with IDENTICAL set */
> +       if (cpu->flags & ACPI_PPTT_ACPI_IDENTICAL) {
> +               next = fetch_pptt_node(table_hdr, cpu->parent);
> +               if (!(next && next->flags & ACPI_PPTT_ACPI_IDENTICAL))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool flag_none(struct acpi_table_header *table_hdr,
> +                     struct acpi_pptt_processor *cpu)
> +{
> +       return false;
> +}
> +
>  /* Passing level values greater than this will result in search termination */
>  #define PPTT_ABORT_PACKAGE 0xFF
>
> -static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_table_header *table_hdr,
> -                                                                 struct acpi_pptt_processor *cpu,
> -                                                                 int level, int flag)
> +static struct acpi_pptt_processor *acpi_find_processor_tag_id(struct acpi_table_header *table_hdr,
> +                                                             struct acpi_pptt_processor *cpu,
> +                                                             int level, node_check chk)
>  {
>         struct acpi_pptt_processor *prev_node;
>
>         while (cpu && level) {
> -               if (cpu->flags & flag)
> +               if (chk(table_hdr, cpu))
>                         break;
>                 pr_debug("level %d\n", level);
>                 prev_node = fetch_pptt_node(table_hdr, cpu->parent);
> @@ -473,15 +507,15 @@ static void acpi_pptt_warn_missing(void)
>   * Return: Unique value, or -ENOENT if unable to locate CPU
>   */
>  static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
> -                                    unsigned int cpu, int level, int flag)
> +                                    unsigned int cpu, int level, node_check chk)
>  {
>         struct acpi_pptt_processor *cpu_node;
>         u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>
>         cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>         if (cpu_node) {
> -               cpu_node = acpi_find_processor_package_id(table, cpu_node,
> -                                                         level, flag);
> +               cpu_node = acpi_find_processor_tag_id(table, cpu_node,
> +                                                         level, chk);
>                 /*
>                  * As per specification if the processor structure represents
>                  * an actual processor, then ACPI processor ID must be valid.
> @@ -498,7 +532,7 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>         return -ENOENT;
>  }
>
> -static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
> +static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, node_check chk)
>  {
>         struct acpi_table_header *table;
>         acpi_status status;
> @@ -509,7 +543,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>                 acpi_pptt_warn_missing();
>                 return -ENOENT;
>         }
> -       retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
> +       retval = topology_get_acpi_cpu_tag(table, cpu, level, chk);
>         pr_debug("Topology Setup ACPI CPU %d, level %d ret = %d\n",
>                  cpu, level, retval);
>         acpi_put_table(table);
> @@ -601,7 +635,7 @@ int cache_setup_acpi(unsigned int cpu)
>   */
>  int find_acpi_cpu_topology(unsigned int cpu, int level)
>  {
> -       return find_acpi_cpu_topology_tag(cpu, level, 0);
> +       return find_acpi_cpu_topology_tag(cpu, level, flag_none);
>  }
>
>  /**
> @@ -658,7 +692,7 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>  int find_acpi_cpu_topology_package(unsigned int cpu)
>  {
>         return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
> -                                         ACPI_PPTT_PHYSICAL_PACKAGE);
> +                                         flag_package);
>  }
>
>  /**
> @@ -670,8 +704,8 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>   *
>   * The returned tag can be used to group peers with identical implementation.
>   *
> - * The search terminates when a level is found with the identical implementation
> - * flag set or we reach a root node.
> + * The search terminates when a level is found without the identical
> + * implementation flag set following a node with it set, or we reach the root.
>   *
>   * Due to limitations in the PPTT data structure, there may be rare situations
>   * where two cores in a heterogeneous machine may be identical, but won't have
> @@ -684,5 +718,5 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>  int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  {
>         return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
> -                                         ACPI_PPTT_ACPI_IDENTICAL);
> +                                         flag_identical);
>  }
> --

I'm not a super big fan of passing function pointers in general.

I kind of see how this works for you, but why exactly the flag
(ACPI_PPTT_ACPI_IDENTICAL in this case) is not sufficient to
distinguish between the cases?
