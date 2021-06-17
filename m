Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB93AB7DA
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhFQPsu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 11:48:50 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39575 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhFQPst (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 11:48:49 -0400
Received: by mail-oi1-f180.google.com with SMTP id m137so6998775oig.6;
        Thu, 17 Jun 2021 08:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbzinZ+NAonC9wqlui+dAHlqYhhpl9kkhTWJ6kv1MZc=;
        b=bq1+gkXgJSMpdRdPHlxymoUlOADVBUVGKoW0K4HLTpuLvyPjpBKGhBll+w4ebldZwX
         FGceYInZ3soz5/fBL2sJ0wvVvqw6+Js85TRQ2RlxgWEwHuYrbGma/vOnOIXUtKl3Br3t
         dzAPNlAE2KQxfEo0tFewEb2xwED9HApVWWNNGf/uvXRZAcPiVU2ttw9jF8Pypj/4dTYR
         GuieRUDdfc3EYum3w7UxXIwDHBMI334gn3i0VDlJV4MYIljAFVDI4D+9meBcPZqLGa/+
         s+5iCEgkFyJYylbIpFB6rXHw87eHr5l2UKQ9ZIbR8ahSfoCHJppHIDufw4Wv+MXNlZtG
         37Kg==
X-Gm-Message-State: AOAM530L42GauWEbtV4OY1pk98KZ/s863hDUovGnV6xJxzdbdS0iErxA
        mzoukIXKXeBwmB62och78kNhFAK1rRK9INRWOvg=
X-Google-Smtp-Source: ABdhPJwBDLTRdL1aYnPUuzsn+yps2CWx0f3u/a7Q4Ot0hnvUcWkMC098VZg9oD8NMt6Ex0TvruW6zrSDdUBIDjVVQQk=
X-Received: by 2002:aca:f0d5:: with SMTP id o204mr2045268oih.71.1623944800016;
 Thu, 17 Jun 2021 08:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 17:46:29 +0200
Message-ID: <CAJZ5v0g1R6Mtr9FECtes6nzXWLVtnRvGTFvi_Q_a8=fcJOhfUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] ACPI: sysfs: Make sparse happy about address space
 in use
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 7:03 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Sparse is not happy about address space in use in acpi_data_show():
>
> drivers/acpi/sysfs.c:428:14: warning: incorrect type in assignment (different address spaces)
> drivers/acpi/sysfs.c:428:14:    expected void [noderef] __iomem *base
> drivers/acpi/sysfs.c:428:14:    got void *
> drivers/acpi/sysfs.c:431:59: warning: incorrect type in argument 4 (different address spaces)
> drivers/acpi/sysfs.c:431:59:    expected void const *from
> drivers/acpi/sysfs.c:431:59:    got void [noderef] __iomem *base
> drivers/acpi/sysfs.c:433:30: warning: incorrect type in argument 1 (different address spaces)
> drivers/acpi/sysfs.c:433:30:    expected void *logical_address
> drivers/acpi/sysfs.c:433:30:    got void [noderef] __iomem *base
>
> Indeed, acpi_os_map_memory() returns a void pointer with dropped specific
> address space. Hence, we don't need to carry out __iomem in acpi_data_show().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 88629d26bd48..767aa65e4bdd 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -419,7 +419,7 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
>                               loff_t offset, size_t count)
>  {
>         struct acpi_data_attr *data_attr;
> -       void __iomem *base;
> +       void *base;
>         ssize_t rc;
>
>         data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
> --

Applied as 5.14 material along with patches [2-4,7/7] from this series.

Patches [5-6/7] did not apply for me on top of my acpi-sysfs branch
(that is included into my linux-next branch), so I have not applied
them.

Thanks!
