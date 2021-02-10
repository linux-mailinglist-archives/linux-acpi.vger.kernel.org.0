Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6203166E6
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 13:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBJMjA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 07:39:00 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:34741 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhBJMgy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 07:36:54 -0500
Received: by mail-oi1-f179.google.com with SMTP id i3so1828282oif.1;
        Wed, 10 Feb 2021 04:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noDcsWaRDbhoMOrwm+bLWYK4ZXNDvbSi80w2AVwrvj8=;
        b=GQinjsUhzoi4vx50jO8K8NhIP79Lkglp+lJoXnVc6K8HfHCoAe4hMr66ZuERXDVUFs
         A+dvYOvppxt3wmXG+wPeUXfkmbKF2vN+tlLcCWSDeL31FmkBRxAT/NJRiU6zFMr8E33G
         TLPg9nWM1ZesbuQY5B/SVHMjH6XdYc/TNFi5VWP/bF2z+XQARkoafVHZlSDMfRx5xneK
         uOdGezXS7uCTj+/UOsu9RGvSR7OO1kHd2bJ62+Qdloe3bhXXD5lIW9Hho7lLafJEANpI
         cOGkWIwDYH+pWQU7eoasBEWt8cRhJaLUKXjJEsfgeftZWEh8+cE9gHm6oWRsXTpIKwJb
         kQvw==
X-Gm-Message-State: AOAM531M4zdsBVXO5EOFJeOTlXu0oURVEYFGurtkbnhGtsRBuMmVE66y
        85f8dTfLR1bLum/k/okI2SzNzvWrBbEU7FIU4KU=
X-Google-Smtp-Source: ABdhPJxv4Dsu9fsGUtF0zrYLWEkB3ohXBG4qosLtvT/oDMJRBs8xkgyHzi9TJxfdmg63Js7mBVyGNK1PpBcSQPGmJiM=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr1966585oia.157.1612960573735;
 Wed, 10 Feb 2021 04:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com> <20210210114320.3478-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210210114320.3478-7-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Feb 2021 13:36:00 +0100
Message-ID: <CAJZ5v0hx78JHnP5-5xFTPr0Rh9FvPCzAzTCyBaT6eLZ3Dd-mFA@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] ACPI: property: Allow counting a single value as
 an array of 1 element
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 12:51 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We allow to read the single value as a first element in the array.
> Unfortunately the counting doesn't work in this case and we can't
> call fwnode_property_count_*() API without getting an error.

It would be good to mention what the symptom of the issue is here.

> Modify acpi_data_prop_read() to always try the single value read
> and thus allow counting the single value as an array of 1 element.
>
> Reported-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is a bug fix, so it should go in before the cleanups in this series IMO.

Also it looks like stable@vger material.

> ---
>  drivers/acpi/property.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 236316ee0e25..d6100585fceb 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -913,12 +913,14 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
>         const union acpi_object *items;
>         int ret;
>
> -       if (val && nval == 1) {
> +       /* Try to read as a single value first */
> +       if (!val || nval == 1) {
>                 ret = acpi_data_prop_read_single(data, propname, proptype, val);

This returns -EINVAL if val is NULL.

>                 if (ret >= 0)
> -                       return ret;
> +                       return val ? ret : 1;

So val cannot be NULL here.

>         }
>
> +       /* It's not the single value, get an array instead */
>         ret = acpi_data_get_property_array(data, propname, ACPI_TYPE_ANY, &obj);
>         if (ret)
>                 return ret;
> --

To me, acpi_fwnode_property_read_string_array() needs to special-case
val == NULL and nval == 0.
