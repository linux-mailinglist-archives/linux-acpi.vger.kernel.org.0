Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7E32D2B6
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 13:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhCDMPp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 07:15:45 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36582 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbhCDMPl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 07:15:41 -0500
Received: by mail-ot1-f44.google.com with SMTP id t16so7474757ott.3;
        Thu, 04 Mar 2021 04:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6C1ZutBSyK6kqUR+ByrPHry2A5Xu5UnDxFmzQsZQ8F0=;
        b=fOQxoDSX9zXVXn9II/yVJnosbPMDAsJ3UA3R6LUE3cFzQGycgM0oaApfTJ9z+U/Nlj
         rRhf50Pn7Mqen2a3QvlQ+ALNi3Uajf29M+V53aXRiwEia50w1kHXfGMJFuHcjYfOdZvX
         9SZSGwt9FZnXMC627jZXl22G91UuJprPO6Gqzz85P06rpKd8XkGN1RL6p60bDUD/1Ypc
         /0gIAPeX5K/22IQNY07cPenZLwGNe9HijlSh+FCUs9khqyyhiLEexfW9t7FQj79mp2qn
         GttpALG/U3fp6porUh6SzW+s/zwbG1ayulVGo4kCqTfy7Jwd2hF/K/k0Ee6I7JOQ1FDC
         Rd6w==
X-Gm-Message-State: AOAM532vtzs9Bpy+IWa/fPlRU/OpOvkPVd0Nf8EoZkptci2Um2fSXawS
        il7jgBtavbiytF8YFY+DFRM0Fv6ItuUlrUf4/dQ=
X-Google-Smtp-Source: ABdhPJy98h8ozgdO0m0No+u1zxOVZo7NAoKFN15Arj0BKyQ2mtdeexjpzGxgb2cv+nG9IityJHPwqzMBgAFeBV/AztY=
X-Received: by 2002:a05:6830:1057:: with SMTP id b23mr3365157otp.206.1614860100740;
 Thu, 04 Mar 2021 04:15:00 -0800 (PST)
MIME-Version: 1.0
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Mar 2021 13:14:49 +0100
Message-ID: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 4, 2021 at 2:22 AM George Kennedy <george.kennedy@oracle.com> wrote:
>
> Since commit 7fef431be9c9 ("mm/page_alloc: place pages to tail
> in __free_pages_core()") the following use after free occurs
> intermittently when acpi tables are accessed.
>
> BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
> Read of size 4 at addr ffff8880be453004 by task swapper/0/1
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-7a7fd0d #1
> Call Trace:
>  dump_stack+0xf6/0x158
>  print_address_description.constprop.9+0x41/0x60
>  kasan_report.cold.14+0x7b/0xd4
>  __asan_report_load_n_noabort+0xf/0x20
>  ibft_init+0x134/0xc49
>  do_one_initcall+0xc4/0x3e0
>  kernel_init_freeable+0x5af/0x66b
>  kernel_init+0x16/0x1d0
>  ret_from_fork+0x22/0x30
>
> ACPI tables mapped via kmap() do not have their mapped pages
> reserved and the pages can be "stolen" by the buddy allocator.

What do you mean by this?

> Use memblock_reserve() to reserve all the ACPI table pages.

How is this going to help?

> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>  arch/x86/kernel/setup.c        | 3 +--
>  drivers/acpi/acpica/tbinstal.c | 4 ++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d883176..97deea3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1046,6 +1046,7 @@ void __init setup_arch(char **cmdline_p)
>         cleanup_highmap();
>
>         memblock_set_current_limit(ISA_END_ADDRESS);
> +       acpi_boot_table_init();

This cannot be moved before the acpi_table_upgrade() invocation AFAICS.

Why exactly do you want to move it?

>         e820__memblock_setup();
>
>         /*
> @@ -1139,8 +1140,6 @@ void __init setup_arch(char **cmdline_p)
>         /*
>          * Parse the ACPI tables for possible boot-time SMP configuration.
>          */
> -       acpi_boot_table_init();
> -
>         early_acpi_boot_init();
>
>         initmem_init();
> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
> index 8d1e5b5..4e32b22 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -8,6 +8,7 @@
>   *****************************************************************************/
>
>  #include <acpi/acpi.h>
> +#include <linux/memblock.h>
>  #include "accommon.h"
>  #include "actables.h"
>
> @@ -58,6 +59,9 @@
>                                       new_table_desc->flags,
>                                       new_table_desc->pointer);
>
> +       memblock_reserve(new_table_desc->address,
> +                        PAGE_ALIGN(new_table_desc->pointer->length));
> +

Why do you want to do this here in the first place?

Things like that cannot be done in the ACPICA code in general.

>         acpi_tb_print_table_header(new_table_desc->address,
>                                    new_table_desc->pointer);
>
> --
