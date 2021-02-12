Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6531A0A5
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBLOcU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 09:32:20 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:36425 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhBLOcQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 09:32:16 -0500
Received: by mail-oo1-f44.google.com with SMTP id x10so2105191oor.3;
        Fri, 12 Feb 2021 06:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxRNPbFxKlelvDHRdiVRulQ6mXfnpI+cjkddw+lx5XA=;
        b=fB/RBX0PrRc9HIvwXwoKe2IUTT7GRLAj+gcLq3JizJMOofENcU05dzzrOsG4AVbFDE
         hKOKUkuCpjRujbv5Oulm4W456q98w9xkErBVy9rJeQCFy5QEvNDBcNyFHzDFFjyU9cHg
         /pILdFqEak0n9HPehXFEzBki26kJjrOU9Ijwvh9risoumyvRHbNceWg32aCAL+UJClx1
         l7S9Ac9Fk+7EGooee7ntAqtnMVDudYGQcVGWyiYEiFszCRzquUw2HtTpDfowqOi8d3oH
         7rUGV+u78rCZbjmY4cVAjBdW75KFIH7uTA6eD0OV1c8AempS8bXy2UjBt/cRsDOClZib
         qXwg==
X-Gm-Message-State: AOAM532h8ESs5AVRs27gbl2pXXaiZttgnK18zWWT5ExonDdBRAGsLS6k
        RVH2iYD1h65pcAnurQceubcd6xTqK08OGcOuB0czXFoJ
X-Google-Smtp-Source: ABdhPJy1j2t7k6mb1KF1GD37mX1x73j24pmMwznWqZDxQIFHvv+IlLrC6qyvoT3jeVOtONV+jMwEhsn7hJ37LJt0m/0=
X-Received: by 2002:a4a:d50d:: with SMTP id m13mr2053955oos.2.1613140295448;
 Fri, 12 Feb 2021 06:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com> <20210212141121.62115-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210212141121.62115-5-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 15:31:24 +0100
Message-ID: <CAJZ5v0jot6w2AdTCmxn4Hw2zOzJk2JSrTaeH9cQR4or2N9HjCg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ACPI: property: Refactor acpi_data_prop_read_single()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 12, 2021 at 3:14 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
 >
> Refactor acpi_data_prop_read_single() for less LOCs and better maintenance.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/property.c | 80 ++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e312ebaed8db..494cf283a573 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -785,60 +785,48 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
>                                       enum dev_prop_type proptype, void *val)
>  {
>         const union acpi_object *obj;
> -       int ret;
> +       int ret = 0;
>
> -       if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64) {
> +       if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64)
>                 ret = acpi_data_get_property(data, propname, ACPI_TYPE_INTEGER, &obj);
> -               if (ret)
> -                       return ret;
> -
> -               switch (proptype) {
> -               case DEV_PROP_U8:
> -                       if (obj->integer.value > U8_MAX)
> -                               return -EOVERFLOW;
> -
> -                       if (val)
> -                               *(u8 *)val = obj->integer.value;
> -
> -                       break;

The empty lines of code above are intentional, so please retain them.

> -               case DEV_PROP_U16:
> -                       if (obj->integer.value > U16_MAX)
> -                               return -EOVERFLOW;
> -
> -                       if (val)
> -                               *(u16 *)val = obj->integer.value;
> -
> -                       break;
> -               case DEV_PROP_U32:
> -                       if (obj->integer.value > U32_MAX)
> -                               return -EOVERFLOW;
> -
> -                       if (val)
> -                               *(u32 *)val = obj->integer.value;
> -
> -                       break;
> -               default:
> -                       if (val)
> -                               *(u64 *)val = obj->integer.value;
> -
> -                       break;
> -               }
> -
> -               if (!val)
> -                       return 1;
> -       } else if (proptype == DEV_PROP_STRING) {
> +       else if (proptype == DEV_PROP_STRING)
>                 ret = acpi_data_get_property(data, propname, ACPI_TYPE_STRING, &obj);
> -               if (ret)
> -                       return ret;
> +       if (ret)
> +               return ret;

else if (!val)
        ret = 1;

>
> +       switch (proptype) {
> +       case DEV_PROP_U8:
> +               if (obj->integer.value > U8_MAX)
> +                       return -EOVERFLOW;
> +               if (val)
> +                       *(u8 *)val = obj->integer.value;
> +               break;
> +       case DEV_PROP_U16:
> +               if (obj->integer.value > U16_MAX)
> +                       return -EOVERFLOW;
> +               if (val)
> +                       *(u16 *)val = obj->integer.value;
> +               break;
> +       case DEV_PROP_U32:
> +               if (obj->integer.value > U32_MAX)
> +                       return -EOVERFLOW;
> +               if (val)
> +                       *(u32 *)val = obj->integer.value;
> +               break;
> +       case DEV_PROP_U64:
> +               if (val)
> +                       *(u64 *)val = obj->integer.value;
> +               break;
> +       case DEV_PROP_STRING:
>                 if (val)
>                         *(char **)val = obj->string.pointer;
> -
>                 return 1;
> -       } else {
> -               ret = -EINVAL;
> +       default:
> +               return -EINVAL;
>         }
> -       return ret;

Retain this.

> +
> +       /* When no storage provided return number of available values */
> +       return val ? 0 : 1;

And this is just not looking good to me, sorry.

>  }
>
>  static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
> --
