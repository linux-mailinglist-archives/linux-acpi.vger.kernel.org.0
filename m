Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1FF2D115A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 14:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgLGNGo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 08:06:44 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44437 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLGNGo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 08:06:44 -0500
Received: by mail-oi1-f194.google.com with SMTP id y74so15255012oia.11;
        Mon, 07 Dec 2020 05:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/94ACdseKqSF6CB7Yif+tucy3tYIplFrTaE2W/sI1s=;
        b=WzZya4CnhChUitKDwMfbqiTDgi1O2Yzxk8npPX7CCz/rm6lW0I7+lKtU+Yy/wo9Pya
         Afrwstsu+JmkgRYTT3bB3E+6simDj9jdKZsUqiDgnigMwWcL4xD++CcMI4BGS2cnO6dp
         3m8VIr7fn/dJZPeiGom5IHHruHYZiUaVVyv5Nes5BdliCPu440OFUx+cEXJmrEd4uz1p
         93FgU8wD3tOEJqqZUtXGam1vtDPzY4dJJT0OGjKbz7/CWUgrYRCzGfFgdeWoegygz2Cz
         bq7n+k0z536C90uX6MRR0qW7jMII++1SpyK8RuEETpvmoybmZBsP5yBGy85BF78MC5Dy
         gFww==
X-Gm-Message-State: AOAM531I1gH/yg383dBbnGXaaYD1XXROCPWhyiDG5FBnN3FZYwynThIA
        9JsJBIPBqOgKz/g9QVqxEwXgQeW9dbWaJnO1JQc=
X-Google-Smtp-Source: ABdhPJwLgTxc/iGDrIiGsv0el6r8b5qwdRF4xEXDC7Zk5XGn9SAYBkqk8ANh86PTwngGe/XRKWHEijJFcVdZQJuBwKE=
X-Received: by 2002:aca:cf4a:: with SMTP id f71mr12862889oig.157.1607346362921;
 Mon, 07 Dec 2020 05:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20201202063942.6644-1-chiu@endlessos.org>
In-Reply-To: <20201202063942.6644-1-chiu@endlessos.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Dec 2020 14:05:46 +0100
Message-ID: <CAJZ5v0h4uMh5qfx5mKDq9+bSC9aUu4x8ivJh_0vmtt8A3htgKw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Add DMI quirk for GIGABYTE GB-BXBT-2807
To:     Chris Chiu <chiu@endlessos.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@endlessos.org, "Jasper St. Pierre" <jstpierre@mecheye.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 2, 2020 at 7:41 AM Chris Chiu <chiu@endlessos.org> wrote:
>
> From: "Jasper St. Pierre" <jstpierre@mecheye.net>
>
> The GIGABYTE GB-BXBT-2807 is a mini-PC which uses off the shelf
> components, like an Intel GPU which is meant for mobile systems.
> As such, it, by default, has a backlight controller exposed.
>
> Unfortunately, the backlight controller only confuses userspace, which
> sees the existence of a backlight device node and has the unrealistic
> belief that there is actually a backlight there!
>
> Add a DMI quirk to force the backlight off on this system.
>
> Signed-off-by: Jasper St. Pierre <jstpierre@mecheye.net>
> Reviewed-by: Chris Chiu <chiu@endlessos.org>
> ---
>  drivers/acpi/video_detect.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 2499d7e3c710..ac2e194acdbf 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -143,6 +143,13 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>         .callback = video_detect_force_vendor,
> +       .ident = "GIGABYTE GB-BXBT-2807",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
> +               },
> +       },
> +       {
>         .ident = "Sony VPCEH3U1E",
>         .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> --

Applied as 5.11 material, thanks!
