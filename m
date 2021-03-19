Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA0F3422BC
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 18:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCSRBC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 13:01:02 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40923 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhCSRAu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 13:00:50 -0400
Received: by mail-ot1-f53.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so8882859otb.7;
        Fri, 19 Mar 2021 10:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toMjsBgBC6mKkAcy8GNORcob6dqdbXwjj/bvv+hBTSw=;
        b=EHqaEbRaQLtDTpOEzR1NQe9diba7tajtf94DljCYf4KERVAnQQ3Pzn+QrmoZRN3J+D
         dju79/kk4Z7QhakYGRiDLK49jHPzZaN3PkNraNkV7tQySVAAWEZWkQyUjxloktEQT5cs
         GE9qP72XG6MtYRnuhhd2z+m3IOncLdN5q4Ho1UAGDAYszei7ye4loVuurzPLw5VZ1SLF
         LFTFqGmmH6tOHNdosu2IgopAyZgjzXnzTkLCrLixzMsHwc6YL2YgyweYZNQhRkHAnWEV
         IEntWIBR3d13/frEnOTUa3Dx58Ow7frJ3F9hg79P/p1SB5xbv4dAN5JRT4bJ5Uo6Q0qp
         MZgQ==
X-Gm-Message-State: AOAM532b4PKailBUDnlHIbH/qtyrB7awY/gdxpTSSlixERinlDilVw/f
        qljTfBKHrPGGeGPbIUftPIs+syjEyjja8p2paf4=
X-Google-Smtp-Source: ABdhPJzrNvTDr2zfkvGdkcGNl2vqFw1aKmnAnyorwIAx/gNeaNhE6banpIsF8xAupJgiH6+wdbvqx4xfMJ0b6H/CfRU=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr1829532otq.260.1616173249798;
 Fri, 19 Mar 2021 10:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210312160137.19463-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210312160137.19463-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 18:00:38 +0100
Message-ID: <CAJZ5v0jHXQC+P1_FTq6TkMKAb=FsBH=cw3mUkp9rJUC7R1B-5A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: scan: Use unique number for instance_no
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

On Fri, Mar 12, 2021 at 5:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Current mechanism of incrementing and decrementing plain integer
> to get a next free instance_no when creating an ACPI device is fragile.
>
> In case of hot plug event or namespace removal of the device instances
> with the low numbers the plain integer counter can't cover the gaps
> and become desynchronized with real state of affairs. If during next
> hot plug event or namespace injection the new instances of
> the devices need to be instantiated, the counter may mistakenly point
> to the existing instance_no and kernel will complain:
> "sysfs: cannot create duplicate filename '/bus/acpi/devices/XXXX1234:02'"

This is a slightly convoluted way of stating that there is a bug in
acpi_device_del().

Yes, there is one, the instance_no decrementation is clearly incorrect.

> Replace plain integer approach by using IDA framework.

Also the general idea of using IDA for the instance numbering is a good one IMO.

> Fixes: e49bd2dd5a50 ("ACPI: use PNPID:instance_no as bus_id of ACPI device")
> Fixes: ca9dc8d42b30 ("ACPI / scan: Fix acpi_bus_id_list bookkeeping")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/internal.h |  4 ++-
>  drivers/acpi/scan.c     | 55 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 53 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index e6a5d997241c..6fee4f71ba1c 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -9,6 +9,8 @@
>  #ifndef _ACPI_INTERNAL_H_
>  #define _ACPI_INTERNAL_H_
>
> +#include <linux/idr.h>
> +
>  #define PREFIX "ACPI: "
>
>  int early_acpi_osi_init(void);
> @@ -98,7 +100,7 @@ extern struct list_head acpi_bus_id_list;
>
>  struct acpi_device_bus_id {
>         const char *bus_id;
> -       unsigned int instance_no;
> +       struct ida no;

struct ida instance_ida; ?

>         struct list_head node;
>  };
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a184529d8fa4..a118a58f7dad 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -468,9 +468,27 @@ static void acpi_device_release(struct device *dev)
>         kfree(acpi_dev);
>  }
>
> +static int acpi_device_get_instance_no(struct acpi_device *device)
> +{
> +       const char *p;
> +       int result;
> +       int error;
> +
> +       p = strrchr(dev_name(&device->dev), ':');
> +       if (!p)
> +               return -ENODATA;
> +
> +       error = kstrtoint(p + 1, 16, &result);
> +       if (error)
> +               return error;
> +
> +       return result;
> +}

I don't like the above at all.

I would just store the instance number in struct acpi_device_pnp (say).
