Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1281F10697C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 11:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVKDu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 05:03:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45399 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVKDu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2019 05:03:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id 14so5959846oir.12
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2019 02:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AnVlEDzkgOJLzVJ+WYXXkPdMFl+RgAgRZ0ch/6KQZA0=;
        b=BB0zm0lWltVmcmSlAkxm3jD2qd8nA3/dfm69nmXRrmPlYsFvIsshNvkMLPDfiQdPht
         GCX8fdE+yTIgBoztRzHA7Kw6FG7n7R/N/p6mUKrQfdVJ2aTf2/uNjBEiN6ZJE6pIzvJh
         wsFIE9Ka2kSUMeWiw06bWHUUEtaz+813du8sokXu1Aw2v/SAqM55F6usRpGXaDV/Nd4n
         KWak1eDGgEI8tfj04rfwVyJn8/VG2XUZa2S4w4vvxOmcjz/dWZ3O3dMZs3dIynZ03QB8
         LWUBIkWXW0Sg0bKbC91Kv9F3YMoVNNI+7zc+27OQ4d3tmfOf3PxQOQZKMPV5gkEnYIbK
         vnDw==
X-Gm-Message-State: APjAAAVZZKi/EVbumS5DjFc9dYYSZ5fz21vf9/Dtqo2IBnM6D9gS3KQb
        pojZm4j+t//xSjhnsg0mwN++mr+eqC+pUrS+DRRsMQ==
X-Google-Smtp-Source: APXvYqyfs0uLp0vHOmOdiig0QWIvapJwHnIsx2VaAX4wBcrjQ0tAP68YzBPtaSh+d6F26KvCm2eNlw8HuAUG/zRjwQM=
X-Received: by 2002:aca:c753:: with SMTP id x80mr10989076oif.115.1574417027651;
 Fri, 22 Nov 2019 02:03:47 -0800 (PST)
MIME-Version: 1.0
References: <1574390957-6313-1-git-send-email-chenxiang66@hisilicon.com>
In-Reply-To: <1574390957-6313-1-git-send-email-chenxiang66@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 11:03:36 +0100
Message-ID: <CAJZ5v0ixTZE6sDD4tojNi7=peqCXSrkS3qyHgeo==zKr4AHKTw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: sysfs: Define the variable gpe from u8 to u16 to
 avoid endless loop in function apci_gpe_apply_masked_gpes()
To:     chenxiang <chenxiang66@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 22, 2019 at 3:52 AM chenxiang <chenxiang66@hisilicon.com> wrote:
>
> From: Xiang Chen <chenxiang66@hisilicon.com>
>
> After the patch (eb09878e1301 ("ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100")),
> the macro ACPI_MASKABLE_GPE_MAX is changed from 0xFF to 0x100. So in function
> apci_gpe_apply_masked_gpes(), the variable gpe may reach 0x100 but it is
> defined as u8, so it will be 0 when reaching 0x100. If the bitmap
> acpi_masked_gpes_map are all 0s, it will loop all the times.
>
> To solve endless loop in the function, define the variable gpe from u8 to u16.
>
> Fixes: eb09878e1301 ("ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100")

This commit has been dropped.

I have a new version of it queued up with the u16 change below folded it.

Thanks!

> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>  drivers/acpi/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 0a83ce1..c60d2c6 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -838,7 +838,7 @@ void __init acpi_gpe_apply_masked_gpes(void)
>  {
>         acpi_handle handle;
>         acpi_status status;
> -       u8 gpe;
> +       u16 gpe;
>
>         for_each_set_bit(gpe, acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) {
>                 status = acpi_get_gpe_device(gpe, &handle);
> --
> 2.8.1
>
