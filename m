Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD734484E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhCVO4P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 10:56:15 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42920 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCVOzx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Mar 2021 10:55:53 -0400
Received: by mail-oi1-f169.google.com with SMTP id n140so13327094oig.9;
        Mon, 22 Mar 2021 07:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxhecs8h6ZrGlDWUuj5bDqeQpBWOSi4ONB8w9TpH/nY=;
        b=bTl7KE37QWKnnihc3hv82c58FPyDKb+fDyFe2xRTFS2VbtHN9yBDtGEStYqWQYxvMH
         wtI9mySX0yO1n/v8Km6yrQGIWpe2UjDEZ84LljDw5HAY+c/CEnwHn3VXylKumUGog4LG
         2sjFToHptXzT7A8MWAzrGKWYbKBv9bpHP7G71kwutklcShCfFnCkPpolfp2AotjZLr++
         ONnLdaj3W0pptEAGsZ7O6VN5FL6I+ZatG+NRq5BszxUDGczuOjm38+Tak3aQcrE3C9kz
         G0lD9uqtH59Xq5ZrjClTXI6S08LDtRlfPR6OgqGBpmSJvRK6n/BbnJvrNdu0BeV1ndKD
         GtsA==
X-Gm-Message-State: AOAM532g8Ja0/XlDtJQKNHvUjBSRiNDcT4mQzH4o5dGT2DWYPi8aUIC1
        bB3jha9DJyiOnnEAEIXJJTquI84bSxfqkXletgw=
X-Google-Smtp-Source: ABdhPJw66pk6+5GZDef3lvjkVkTy9aKd9QT2qIUf/6D9x/U9xW7Bye/wZJ/B+qC1gl98yq1sdqo0XWdbe8FLkDEWJr0=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr56488oie.157.1616424952837;
 Mon, 22 Mar 2021 07:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210319192109.40041-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210319192109.40041-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Mar 2021 15:55:37 +0100
Message-ID: <CAJZ5v0gcqKiXKzEj6u7vq_1Y9pYBdSGA6yT3q6JPVgW4djSiaQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ACPI: scan: Use unique number for instance_no
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 19, 2021 at 8:21 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The decrementation of acpi_device_bus_id->instance_no
> in acpi_device_del() is incorrect, because it may cause
> a duplicate instance number to be allocated next time
> a device with the same acpi_device_bus_id is added.
>
> Replace above mentioned approach by using IDA framework.
>
> Fixes: e49bd2dd5a50 ("ACPI: use PNPID:instance_no as bus_id of ACPI device")
> Fixes: ca9dc8d42b30 ("ACPI / scan: Fix acpi_bus_id_list bookkeeping")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: rewrote commit message once again as proposed by Rafael in v1
>  drivers/acpi/internal.h |  4 +++-
>  drivers/acpi/scan.c     | 32 +++++++++++++++++++++++++++-----
>  include/acpi/acpi_bus.h |  1 +
>  3 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index e6a5d997241c..417eb768d710 100644
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
> +       struct ida instance_ida;
>         struct list_head node;
>  };
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a184529d8fa4..4b445b169ad4 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -479,9 +479,8 @@ static void acpi_device_del(struct acpi_device *device)
>         list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
>                 if (!strcmp(acpi_device_bus_id->bus_id,
>                             acpi_device_hid(device))) {
> -                       if (acpi_device_bus_id->instance_no > 0)
> -                               acpi_device_bus_id->instance_no--;
> -                       else {
> +                       ida_simple_remove(&acpi_device_bus_id->instance_ida, device->pnp.instance_no);
> +                       if (ida_is_empty(&acpi_device_bus_id->instance_ida)) {
>                                 list_del(&acpi_device_bus_id->node);
>                                 kfree_const(acpi_device_bus_id->bus_id);
>                                 kfree(acpi_device_bus_id);
> @@ -631,6 +630,20 @@ static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev_id)
>         return NULL;
>  }
>
> +static int acpi_device_set_name(struct acpi_device *device,
> +                               struct acpi_device_bus_id *acpi_device_bus_id)
> +{
> +       int result;
> +
> +       result = ida_simple_get(&acpi_device_bus_id->instance_ida, 0, 255, GFP_KERNEL);

This is ida_alloc_range(ida, start, (end) - 1, gfp), so I think it
should be 256 above, instead of 255.

While at it, though, there can be more than 256 CPU devices easily on
contemporary systems, so I would use a greater number here.  Maybe
4096 and define a symbol for it?
