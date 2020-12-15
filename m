Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E562DB3CD
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Dec 2020 19:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgLOSdb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Dec 2020 13:33:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38412 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbgLOSdH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2020 13:33:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so15890947otq.5
        for <linux-acpi@vger.kernel.org>; Tue, 15 Dec 2020 10:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VxWAgTfrtNIlVmlRfd4RtN9sZzUhFIuumVkDYzL7/I=;
        b=GsQZYtCeSmV0Hcf8svL3whfyzJ431oo0L1uXca6QMgsdnaBUB6LT8uda/HaH5yjk9q
         5bodGkxRSXlh/7BYva5XqZstsKSD64xmf+zDLfhEU1wYKJSdx9pJv8Y8ICCcSEvaTN2J
         2pq6wIZ4bnoWjZ4oy/tsZmP31XVLZiS+eex/KOg11iEx1ZvVbFDiGyK7WzMuXMuiqnU2
         SgvXGpez+8PZWwihaHTNnXGxJVKEuj2cP2kf7F7DvGAF44AAYh1P8waSQmmn7I+Ypgo/
         gvtPsXXe0hniPAEyIZAl6v56aAZX1FS/Xneh/jmU27gaZzIapKdH5sBZKSYjsBSsKSyR
         fvHA==
X-Gm-Message-State: AOAM531ztz9+yCoP+69qtSHy61YxPkIvPYcSck2F4c4Aaw7IlEyLvQ9V
        zebbCf2j8BF9X7Xg8tS3UNhYu19w8oVvkbX4oPQ=
X-Google-Smtp-Source: ABdhPJwc70UyZ1TU7iApvbU0W4t3jnDnARE93JvfSLp8c7WE2rXE72Trp7zCW2BBnRXJABVc9xzhjINU8YRf9+Z52+M=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr22218570ota.260.1608057146483;
 Tue, 15 Dec 2020 10:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20201211021814.36193-1-hui.wang@canonical.com>
In-Reply-To: <20201211021814.36193-1-hui.wang@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Dec 2020 19:32:15 +0100
Message-ID: <CAJZ5v0jaL9ZyaDSV-QMaZgM+ppta90O0=MFdevJdhDnJ5yU2eA@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI / PNP: compare the string length in the matching_id
To:     Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 11, 2020 at 3:19 AM Hui Wang <hui.wang@canonical.com> wrote:
>
> Recently we met a touchscreen problem on some Thinkpad machines, the
> touchscreen driver (i2c-hid) is not loaded and the touchscreen can't
> work.
>
> An i2c ACPI device with the name WACF2200 is defined in the BIOS, with
> the current rule in matching_id(), this device will be regarded as
> a PNP device since there is WACFXXX in the acpi_pnp_device_ids[] and
> this PNP device is attached to the acpi device as the 1st
> physical_node, this will make the i2c bus match fail when i2c bus
> calls acpi_companion_match() to match the acpi_id_table in the i2c-hid
> driver.
>
> WACF2200 is an i2c device instead of a PNP device, after adding the
> string length comparing, the matching_id() will return false when
> matching WACF2200 and WACFXXX, and it is reasonable to compare the
> string length when matching two ids.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> Sorry, the v3 patch has mis-spelling word in the commit header, so fix
> it and send the v4 patch.
>
>  drivers/acpi/acpi_pnp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index 4ed755a963aa..8f2dc176bb41 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -319,6 +319,9 @@ static bool matching_id(const char *idstr, const char *list_id)
>  {
>         int i;
>
> +       if (strlen(idstr) != strlen(list_id))
> +               return false;
> +
>         if (memcmp(idstr, list_id, 3))
>                 return false;
>
> --

Applied as 5.11-rc material, thanks!
