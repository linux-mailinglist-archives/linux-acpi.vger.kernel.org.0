Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30F2C0A40
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 14:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbgKWNR5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 08:17:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38070 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732515AbgKWNRz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 08:17:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id 92so12777821otd.5
        for <linux-acpi@vger.kernel.org>; Mon, 23 Nov 2020 05:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtIg/mr7EYSJUios6yEOFPXRjF+gCFSVTedG6movZ/g=;
        b=gu7wQYy+Cc08qrbmTwLAUp14qlnCmFsRYCC2cuWL+pgg6eG00a2O1W0x3rO7J5QwXc
         4fYnXTYdb20M+7JV4o7l3KVdOr5frKz4OeBI4Aph4rT+AdMocjzQ8iWtMMxbxlipvg7l
         QpP1X1TEi92ZHy7nzzEo50Bb7oLE8CMQxhZoAI1LF9xurm/W/T8Pscpg0Fu+bUEno+FB
         VtY67a7ceYRqGfgQcY0ER06+hRpJcRCacQcZQVeUB3ONbcPcQz4THEFnou+CELciq3PI
         CnWTtr+UfNbNGzRD3eSIyXhwa45OG9YE+58n7FKwQCuCjq0WxAp/wVJhqfdpaTo9z8bv
         uOlw==
X-Gm-Message-State: AOAM533fGL9s7UWvxL671wzIhY5jj7ZYF4+5TdMa+IL5zbhDUoOvIV6c
        wxBP6vdc3W7KqcQEWo7AllHG/M29tRxVGnsRoEE=
X-Google-Smtp-Source: ABdhPJzN4PXtyMuLXi4dc/T3PVhyKhespjqNGW3HTP6StSnJ5v/t/ybJfhpvZDhnx154LPpU8/g6nEO8J4MI8hIOgUE=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr24148744ota.260.1606137474427;
 Mon, 23 Nov 2020 05:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20201121203040.146252-1-hdegoede@redhat.com> <20201121203040.146252-6-hdegoede@redhat.com>
In-Reply-To: <20201121203040.146252-6-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 13:17:37 +0100
Message-ID: <CAJZ5v0i+Oz4meRo+YQw_LRZXReo9APh4kpqAP4Nby8_HExrrJg@mail.gmail.com>
Subject: Re: [PATCH 5/7] ACPI: scan: Add support for deferring adding devices
 to the second scan phase based on the _DEP list
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 21, 2020 at 9:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The current solution, of deferring adding of some devices because they
> need access during the OpRegions of other devices while they are added,
> is not very generic.
>
> And support for making the decision to defer adding a device based on
> its _DEP list, instead of the device's HID being in a fixed list of HIDs
> to defer, which should be a more generic way to deal with this.

Thanks a lot for working on this!

I'll have a more thorough look at the series later this week, stay tuned.

> Since this is likely to cause issues on some hardware, this new method will
> only be used if the new acpi.defer_scan_based_on_dep kernel commandline
> option is set to 1.

However, I already can say that I don't like the new command line option.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/scan.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 407c8536568b..9927036bfe77 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -31,6 +31,11 @@ extern struct acpi_device *acpi_root;
>
>  #define INVALID_ACPI_HANDLE    ((acpi_handle)empty_zero_page)
>
> +static int defer_scan_based_on_dep = -1;
> +module_param(defer_scan_based_on_dep, int, 0444);
> +MODULE_PARM_DESC(defer_scan_based_on_dep,
> +       "Use new scan-scheme deferring addition of devices with non empty _DEP list (-1=auto, 0=no, 1=yes)");
> +
>  static const char *dummy_hid = "device";
>
>  static LIST_HEAD(acpi_dep_list);
> @@ -1657,11 +1662,45 @@ void acpi_device_add_finalize(struct acpi_device *device)
>
>  static bool acpi_should_defer_add(acpi_handle handle, struct acpi_device_info *info)
>  {
> +       struct acpi_handle_list dep_devices;
> +       acpi_status status;
> +       int i;
> +
>         if (!acpi_check_defer_add || !info)
>                 return false;
>
> -       if (acpi_info_matches_hids(info, acpi_defer_add_hids))
> +       if (!defer_scan_based_on_dep)
> +               return acpi_info_matches_hids(info, acpi_defer_add_hids);
> +
> +       /*
> +        * We check for _ADR here to avoid deferring the adding of the following:
> +        * 1. PCI devices
> +        * 2. ACPI nodes describing USB ports
> +        * Note checking for _ADR catches more then just these cases...

s/then/than/

> +        */
> +       if (info->valid & ACPI_VALID_ADR)
> +               return false;
> +
> +       status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
> +       if (ACPI_FAILURE(status))
> +               return false;
> +
> +       for (i = 0; i < dep_devices.count; i++) {
> +               struct acpi_device_info *dep_info;
> +               bool ignore;
> +
> +               status = acpi_get_object_info(dep_devices.handles[i], &dep_info);
> +               if (ACPI_FAILURE(status))
> +                       continue;
> +
> +               ignore = acpi_info_matches_hids(dep_info, acpi_ignore_dep_hids);
> +               kfree(dep_info);
> +
> +               if (ignore)
> +                       continue;
> +
>                 return true;
> +       }
>
>         return false;
>  }
> @@ -2251,6 +2290,10 @@ int __init acpi_scan_init(void)
>         struct acpi_table_stao *stao_ptr;
>         struct acpi_deferred_dev *deferred_dev, *tmp;
>
> +       /* Currently no devices are known which need _dep based scan deferral */
> +       if (defer_scan_based_on_dep == -1)
> +               defer_scan_based_on_dep = 0;
> +
>         acpi_pci_root_init();
>         acpi_pci_link_init();
>         acpi_processor_init();
> --
> 2.28.0
>
