Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617ED2FA260
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 15:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAROAg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 09:00:36 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:33808 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404720AbhARN7v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2021 08:59:51 -0500
Received: by mail-oo1-f46.google.com with SMTP id x23so4115891oop.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2021 05:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0bTAOQfEQNUgaA8Wuth/48iPFWLJksYYz/1CLDCgHI=;
        b=nv7Up+gOzEpTL4DjVmyjESVkpO1dtUtaWsxuDBIkXWjopg6wMYkv2TQGOIQZJAO2Ag
         mzQTVOevhE7AkQwNSCbiHeC9cmQrUOnbd4h21UjSffrSUMMe/PtK3kAR9iXQSM+D5JWh
         dRjLb2DhYDRr6h3QcF/IvwyT/cXYE4Cd0ZNbGXs0LFx8/TmEGE+sfG6UNxgqa6OI0OBq
         24rggCsAlS3dFKydKeU7WYVQFnG50snnP/A0wFJ1zw9HNkRFCaAqFqN5BURsMOINrboW
         s8PZY7f4JXwyFiplshAPWAAcz1MfDJSm40mnzg8pqEIo4i/HCAHSrxNr1ktD0bg6j/81
         h7Xg==
X-Gm-Message-State: AOAM533fnYDwjtZ/HBklrItIQ7l6KGm9lCex7zKxPQRwfVzs0x3H5ey3
        2Zv+srowTnfff8bS7QU663M+bih+0UELfywG/FU=
X-Google-Smtp-Source: ABdhPJxOBWR6EMPLT8QwNE5tfOL3KF4HMA2ebV6WCeWnIOmotY8KskdiayFEHCABsVNaNlj/NOQcXvI/QXPTIYmsVZM=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr17224307ooi.44.1610978350534;
 Mon, 18 Jan 2021 05:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20210115215752.389656-1-hdegoede@redhat.com>
In-Reply-To: <20210115215752.389656-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Jan 2021 14:58:54 +0100
Message-ID: <CAJZ5v0gk0ninRntm508SAgzSrRe5gjZ+-e5ac1h-Cx2reVOSfg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Make acpi_bus_get_device() clear the adev ptr
 on error
To:     Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 15, 2021 at 10:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Set the acpi_device pointer which acpi_bus_get_device()
> returns-by-reference to NULL on error.
>
> We've recently had 2 cases where callers of acpi_bus_get_device()
> did not properly error check the return value, using the
> returned-by-reference acpi_device pointer blindly, set it to NULL
> so that this will lead to an immediate oops, rather then following
> a pointer to who knows what.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This should fix the crash reported by Pierre-Louis, so let me apply it
instead of the two debug changes posted by me
(https://lore.kernel.org/linux-acpi/98e6ed8e-884e-adb4-a146-a66daefa94a7@redhat.com/T/#md5add2fe554a30e3a929d87a66b435f4cc8bf628).

Pierre-Louis, can you please double check that the issue goes away
with this patch applied?

> ---
>  drivers/acpi/scan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index c575c9b67f76..c53e88deee1d 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -585,6 +585,8 @@ static int acpi_get_device_data(acpi_handle handle, struct acpi_device **device,
>         if (!device)
>                 return -EINVAL;
>
> +       *device = NULL;
> +
>         status = acpi_get_data_full(handle, acpi_scan_drop_device,
>                                     (void **)device, callback);
>         if (ACPI_FAILURE(status) || !*device) {
> --
> 2.28.0
>
