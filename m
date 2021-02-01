Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E230AE92
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 18:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBAR5P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 12:57:15 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:42091 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhBAR5C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 12:57:02 -0500
Received: by mail-ot1-f46.google.com with SMTP id f6so17138636ots.9
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 09:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+g5dEnLPO6aKU4YjgwHZ+hJehHc3dES5fpNWcimIMLw=;
        b=p3s82hMPgk4MPMiaNzcMXca5dFy6CGk6YXi5YE1OG3+b+Q6fMsq/4GHUhpmut2Gxki
         x1X915Xx/NnSVPy8/1PGSFZcEG3i1Z0nxyI+9a1XHiyYdwpJ/yu7qrG/7+rkW9LUqZZD
         ntmJb5dINTd3MuRaB7XMnDZYA7yG/4NNBjIqGQJzKN8AV1PPPPIrB/m1kkrjH75GxNw4
         BRH+KrK9AIyvkzJWGhRh3ylRSqo3GA1V22HjjsP7cpXrm+g0CBudwiZXxwmHZcX5siVD
         SSpSzvyASSqA/2RlUMARb1e5uQTTDMprh3r+3A9vEH9kGAQjV/LUQqqXpJ1T+JTwhQJy
         HPcQ==
X-Gm-Message-State: AOAM531g/8/X9I1A/QUOnwZ00TmvtycJh6tMtpbsJBH8yWkgkgOgpliR
        /J248G/S0NxERYLe/0K8hJA0scCS8XITtgyvLds=
X-Google-Smtp-Source: ABdhPJzAth9IOOVlQ+swTU/T1nYM5c+lpjzZQmogDGK9FPfAWYnl/ot9T0vC1/ft7qv3cK7LM890bivoiccvLEXCOoc=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr12905768otm.206.1612202181920;
 Mon, 01 Feb 2021 09:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20210201163419.396568-1-hdegoede@redhat.com> <20210201163419.396568-2-hdegoede@redhat.com>
In-Reply-To: <20210201163419.396568-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Feb 2021 18:56:10 +0100
Message-ID: <CAJZ5v0jOhaeXAZjCh4q0Zamv5UmVmuSs9K8WZ+88X_FizJ7pdw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: scan: Fix Battery devices sometimes never binding
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 1, 2021 at 5:35 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> With the new 2 step scanning process, which defers instantiating some
> ACPI-devices based on their _DEP to the second step, the following may
> happen:
>
> 1. During the first acpi_walk_namespace(acpi_bus_check_add) call
>    acpi_scan_check_dep() gets called on the Battery ACPI dev handle and
>    adds one or more deps for this handle to the acpi_dep_list
>
> 2. During the first acpi_bus_attach() call one or more of the suppliers of
>    these deps get their driver attached and
>    acpi_walk_dep_device_list(supplier_handle) gets called.
>
>    At this point acpi_bus_get_device(dep->consumer) get called,
>    but since the battery has DEPs it has not been instantiated during the
>    first acpi_walk_namespace(acpi_bus_check_add), so the
>    acpi_bus_get_device(dep->consumer) call fails.
>
>    Before this commit, acpi_walk_dep_device_list() would now continue
>    *without* removing the acpi_dep_data entry for this supplier,consumer
>    pair from the acpi_dep_list.

Yeah, I've overlooked the fact that the consumer needs to have a
struct acpi_device in order for the entry to be dropped from the list.
Sorry.

> 3. During the second acpi_walk_namespace(acpi_bus_check_add) call
>    an acpi_device gets instantiated for the battery and
>    acpi_scan_dep_init() gets called to initialize its dep_unmet val.
>
>    Before this commit, the dep_unmet count would include DEPs for
>    suppliers for which acpi_walk_dep_device_list(supplier_handle)
>    has already been called, so it will never become 0 and the
>    ACPI battery driver will never get attached / bind.
>
> Fix the ACPI battery driver never binding in this scenario by making
> acpi_walk_dep_device_list() always remove matching acpi_dep_data
> entries independent of the acpi_bus_get_device(dep->consumer) call
> succeeding or not.
>
> Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied and thanks for fixing this!

> ---
>  drivers/acpi/scan.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5d7b2fcecf06..4ce54115e981 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2123,12 +2123,12 @@ void acpi_walk_dep_device_list(acpi_handle handle)
>         list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
>                 if (dep->supplier == handle) {
>                         acpi_bus_get_device(dep->consumer, &adev);
> -                       if (!adev)
> -                               continue;
>
> -                       adev->dep_unmet--;
> -                       if (!adev->dep_unmet)
> -                               acpi_bus_attach(adev, true);
> +                       if (adev) {
> +                               adev->dep_unmet--;
> +                               if (!adev->dep_unmet)
> +                                       acpi_bus_attach(adev, true);
> +                       }
>
>                         list_del(&dep->node);
>                         kfree(dep);
> --
> 2.29.2
>
