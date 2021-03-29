Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157334D073
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 14:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhC2MxH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 08:53:07 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:38527 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhC2Mwm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 08:52:42 -0400
Received: by mail-oo1-f49.google.com with SMTP id n12-20020a4ad12c0000b02901b63e7bc1b4so2942633oor.5
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 05:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsrsE/eURCnxPgkg/YtwzB20bEKCqR2x1XqV0x48CtE=;
        b=lkir48qmjyQcAxT21XJLrb0H5khzGUErsmIr4vO7sfGpCd4xGunnmut45UKIGG0xuF
         eQswYW6jsVT8oaY2z5VSrUGWMvkzJJgjbYWxy/ERhOeC5s6iTBXCkPsohcCVV6Cfdvdd
         3pJ7v7CRYvQ4UiiTRdp743fL92m/K90Us8SnuMnXW3OnY+Sx1iB4bekHrdg/KkWlWQh+
         Eu90joO3O5gvGuHBKwbPlZkD5XYBPhl8rzqHWt8IK1MH6xX7OG/4kiLW2vUH43afhNXU
         gwIQg5bwNUkkVPhvuKxca+x0NgUnax6lDmGk6XQ0RfE2Dj7KDr1sEjNCb1fQQWl+Zd2U
         ChdQ==
X-Gm-Message-State: AOAM531wvXOTFa2S0l+locGAFsoYgnQG92dnb7QPJibv0CX9CkADM7uP
        QYDDjjYd/1dX6RXKO08mOGu0DdYW1oTGw0axJACEBdI6
X-Google-Smtp-Source: ABdhPJww5h0n4X6xV2qUiT/OJfAYg/ZxTnITD/k7rOl4mKqkT9k8H2dV0gsJMs/ojbAfcDgVxohD93vaGXP3QgEGlPQ=
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr21193494oos.2.1617022361881;
 Mon, 29 Mar 2021 05:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210328112000.12502-1-hdegoede@redhat.com>
In-Reply-To: <20210328112000.12502-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Mar 2021 14:52:27 +0200
Message-ID: <CAJZ5v0inp8KejTtRnK0oOy2n+Ugsf99A7Ohj915JxhcTCN6vPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Move acpi_scan_dep_init() higher up in scan.c
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 28, 2021 at 1:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Move acpi_scan_dep_init() higher up in scan.c to avoid needing a forward
> declaration in the next patch in this set.
>
> Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")

Well, this doesn't seem applicable here, as the patch shouldn't make a
practical difference.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/scan.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1584c9e463bd..19f8fd6ea17a 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1655,6 +1655,20 @@ void acpi_device_add_finalize(struct acpi_device *device)
>         kobject_uevent(&device->dev.kobj, KOBJ_ADD);
>  }
>
> +static void acpi_scan_dep_init(struct acpi_device *adev)
> +{
> +       struct acpi_dep_data *dep;
> +
> +       mutex_lock(&acpi_dep_list_lock);
> +
> +       list_for_each_entry(dep, &acpi_dep_list, node) {
> +               if (dep->consumer == adev->handle)
> +                       adev->dep_unmet++;
> +       }
> +
> +       mutex_unlock(&acpi_dep_list_lock);
> +}
> +
>  static int acpi_add_single_object(struct acpi_device **child,
>                                   acpi_handle handle, int type,
>                                   unsigned long long sta)
> @@ -1906,20 +1920,6 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
>         return count;
>  }
>
> -static void acpi_scan_dep_init(struct acpi_device *adev)
> -{
> -       struct acpi_dep_data *dep;
> -
> -       mutex_lock(&acpi_dep_list_lock);
> -
> -       list_for_each_entry(dep, &acpi_dep_list, node) {
> -               if (dep->consumer == adev->handle)
> -                       adev->dep_unmet++;
> -       }
> -
> -       mutex_unlock(&acpi_dep_list_lock);
> -}
> -
>  static bool acpi_bus_scan_second_pass;
>
>  static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
> --
> 2.30.2
>
