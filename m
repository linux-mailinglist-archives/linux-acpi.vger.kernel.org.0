Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81F18926F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Mar 2020 01:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCRAJL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Mar 2020 20:09:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41289 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgCRAJK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2020 20:09:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id s15so23737259otq.8
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2020 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMwlQkIOIiahCzdJMcDAgkZw1PXO1TaHhQC1hHdlF40=;
        b=kGZyZEGu+kcB3XdOaTAZJM+rbcvTBpICmBPRE18yX/9MJPS66Ytxd7Gm3O3/3Lz55Q
         uFACPo9wGPnI6eO+iUQifq8oVaWyWo0VgR6LIsQdBzIMGZ/wsKCnDqZ/x6TolZxAyg1I
         FJt12qoJReN6PNsY1GOL3OhVCI7MHxaHFRL08jfk4efZyQHKo/X/2ZLHpiq65IrXN3gK
         CSV+tleFFwhhErVV3TFP0znqCHU1QEI/RoTHD38gDLk0At7DJutddsiqKB66BpLTriWO
         uPBtm0hIrgWWUQzC0YsHjdwX6Uk4pe8Z4vLovjAgJJKP8+tW3eLI3j7ZR73xujJ0Sx17
         dojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMwlQkIOIiahCzdJMcDAgkZw1PXO1TaHhQC1hHdlF40=;
        b=kphjK6UY0OBxSR1c1loPXlU9IXqL4Rr7dgUqCR089LSupNP3wYViVH0Fc+D1yHLtab
         5qKHnr4hoIG7BCWbrrYhKv0BbMK/FDPmdGn7hwLUhuSmdgWIkULkXVMDT0crX+5NRG/J
         +RGacpQf/wNooAy3aggbcRFIFRl2ZvpdkFpviABHEKwsk8C6h4izDr9wyC7sLdI4AUBz
         lsVIPBKCa+72yCywd9i017hEj5xjqmakHf/lG8CQxILS5Gj5dG5C6cXqMI0G54SHz7+N
         6ignUbJopAM2m/+REGV9HladGYh+kSqWSqS514/7DvT56+xtx75gMrfv8pIj+PsHDAg9
         6TgQ==
X-Gm-Message-State: ANhLgQ0MqzWxdJZO72E2zWYFeKgprqAAxwiKsC0L7v9bbLkqQA67DJSa
        paZsEjLgQx+AYDenCNpiICKS8vBFN2iP2lrvGSsZlBuXhWo=
X-Google-Smtp-Source: ADFU+vvXy+eUUC+1ujXuIzLpqPYdUPYM4SLDYMYNliIhG5QA4cIByJRT9LCJJcYo4J8eRLDL8+WNi4hE85ZKjbdciSI=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr1641568otn.126.1584490149519;
 Tue, 17 Mar 2020 17:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Mar 2020 17:08:58 -0700
Message-ID: <CAPcyv4hjgNruY84Kr9S5HZ6P03fNcPcmL7H2DN19Z+CbPZ7d+Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: NUMA: Add 'nohmat' option
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 2, 2020 at 2:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Disable parsing of the HMAT for debug, to workaround broken platform
> instances, or cases where it is otherwise not wanted.

Rafael, any heartburn with this change to the numa= option?

...as I look at this I realize I failed to also update
Documentation/x86/x86_64/boot-options.rst, will fix.

>
> Cc: x86@kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/numa.c       |    4 ++++
>  drivers/acpi/numa/hmat.c |    3 ++-
>  include/acpi/acpi_numa.h |    1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 59ba008504dc..22de2e2610c1 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -44,6 +44,10 @@ static __init int numa_setup(char *opt)
>  #ifdef CONFIG_ACPI_NUMA
>         if (!strncmp(opt, "noacpi", 6))
>                 acpi_numa = -1;
> +#ifdef CONFIG_ACPI_HMAT
> +       if (!strncmp(opt, "nohmat", 6))
> +               hmat_disable = 1;
> +#endif
>  #endif
>         return 0;
>  }
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c32cfb72370..d3db121e393a 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -26,6 +26,7 @@
>  #include <linux/sysfs.h>
>
>  static u8 hmat_revision;
> +int hmat_disable __initdata;
>
>  static LIST_HEAD(targets);
>  static LIST_HEAD(initiators);
> @@ -814,7 +815,7 @@ static __init int hmat_init(void)
>         enum acpi_hmat_type i;
>         acpi_status status;
>
> -       if (srat_disabled())
> +       if (srat_disabled() || hmat_disable)
>                 return 0;
>
>         status = acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index fdebcfc6c8df..48ca468e9b61 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -18,6 +18,7 @@ extern int node_to_pxm(int);
>  extern int acpi_map_pxm_to_node(int);
>  extern unsigned char acpi_srat_revision;
>  extern int acpi_numa __initdata;
> +extern int hmat_disable __initdata;
>
>  extern void bad_srat(void);
>  extern int srat_disabled(void);
>
