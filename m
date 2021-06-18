Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C83AD044
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhFRQY3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 12:24:29 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34402 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhFRQY2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 12:24:28 -0400
Received: by mail-ot1-f46.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so10246392ott.1;
        Fri, 18 Jun 2021 09:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaIbuawcQNoZOdUyVXbhxRk5DNAjaQvJITAOax4ZCRE=;
        b=U2GImioeh5iQxrBWp5H13azNZfdwfLUmYJHBEhWVVst8AG7X4ofYvxp/GGzQUvPBJ/
         UbltP+ezFiUpS0ak8iQZFrwwEQcSjDP4VVJJK/J1mDgcoXESji49ZVQGRmLL4JHx9/tf
         Cg8jyssIb702sxXwYwRNPzp3tvuoA2jjRVdnzUiCTS3WTOGzyYy6Z/UMgQDiIjfGU5Ex
         g43jd4WSoadz4ur8JI4GTl6aN+PB1EopS5cx0Crb2ZX9S9QvQQXggGsVl1QCd9XacDpY
         fwbF1R1SgGcMbNij0mY/CeDgh8PamE1AQImCa/QzygvEL1JYI+0M8oPs8xv7Z1T1SCyP
         kS/g==
X-Gm-Message-State: AOAM530GDutRgQfaVqfwuhJEQuI8of39EDurHVV69kjKzWH0MsKHuWzw
        odwU81yA8ZEQ8A82hKtlAvRhx0otourI8YCpAU8=
X-Google-Smtp-Source: ABdhPJwsyey8K9+twUCtbb9euj4Ooya1FyQOrnqF7gcq3M81RHRUmk3hLw46mj2yzsPnPO+ANSFOIb3p/TRInjLetuA=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr2480392otm.260.1624033337860;
 Fri, 18 Jun 2021 09:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210618134128.59335-1-andriy.shevchenko@linux.intel.com> <20210618134128.59335-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210618134128.59335-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jun 2021 18:22:06 +0200
Message-ID: <CAJZ5v0ifuSg9cbUdpoMaB5oK43arN5EJL0j8GwQGb89sRMkcsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: sysfs: Remove tailing return statement in
 void function
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 18, 2021 at 3:41 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The tail return statement is redundant in void functions. Remove it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: rebased on top of bleeding-edge (Rafael)
>
>  drivers/acpi/sysfs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 18e93c3c39cf..00c0ebaab29f 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -897,7 +897,6 @@ void acpi_irq_stats_init(void)
>
>  fail:
>         delete_gpe_attr_array();
> -       return;
>  }
>
>  static void __exit interrupt_stats_exit(void)
> --

Applied as 5.14 material along with the [2/2], thanks!
