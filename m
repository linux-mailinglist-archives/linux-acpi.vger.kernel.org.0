Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F150C640E5F
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Dec 2022 20:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiLBTXe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Dec 2022 14:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiLBTXb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Dec 2022 14:23:31 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8946ABE4C2
        for <linux-acpi@vger.kernel.org>; Fri,  2 Dec 2022 11:23:30 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id x28so5461569qtv.13
        for <linux-acpi@vger.kernel.org>; Fri, 02 Dec 2022 11:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F843w0lzGxDOkXCu8mgxL/mONXX5TqPQXk4O3HTO9hI=;
        b=MKvkZG0UZT/VgwhSdNV6hQCFbJkjQWvUOB1gmFcSMTdhl/jexmDA0tkjMCuUvp2HSK
         zk3rwpbgfJoVfbAEuD9cNTx2qw0Id+h3I89MaBLWKTwdLVb5tUCsiLyfu/mAmKYDzfVX
         f42nm2JhjPEaldgnJtcI6zj1XwSvwab/QEBxXcXH3aPYNAa8ZmSaVNu9jWII4O/dDgEa
         sDkbO//sOqex7c0j+XM9rrTNXJk/wsKprzGF8Jvf0ji4z55n93vUtNiCRaCN1iWzFx32
         Xl/f17+djS89rJ3NG+b1qXcRbCtYiK8ytGlnhobvsaphx/3QDM39yOXMiKLQfqi3sUz6
         sCdw==
X-Gm-Message-State: ANoB5pmxgjBm2fsnnb4cB4apm2ucdnL9XJvsdDN4d0XhbPuIpo1X6UJE
        NLdyldGQXNGZayT8s0G1morHCR73/en3YTcUTNc2Y+M3
X-Google-Smtp-Source: AA0mqf4wgyDQclDKNoU+JxpHxJT6niJE2NK4tKgh16eXipRmBg6SJgBm8ZfNWFIShxfGE93mo9vgMGINuL8tTaXu2nI=
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id
 cc10-20020a05622a410a00b003a5598742c6mr67060629qtb.147.1670009009676; Fri, 02
 Dec 2022 11:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20221127182403.104471-1-hdegoede@redhat.com>
In-Reply-To: <20221127182403.104471-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 20:23:18 +0100
Message-ID: <CAJZ5v0jrgy99e9oVfZqhPuxhPNd3=sm7A665gFrB4f8rR=Ne1g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Add skip i2c clients quirk for Lenovo Yoga Tab
 3 Pro (YT3-X90F)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Nov 27, 2022 at 7:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Lenovo Yoga Tab 3 Pro (YT3-X90F) is a x86 (Cherry Trail) tablet which
> ships with Android x86 as factory OS. The Android x86 kernel fork ignores
> I2C devices described in the DSDT, except for the PMIC and Audio codecs.
>
> As usual the Lenovo Yoga Tab 3 Pro's DSDT contains a bunch of extra I2C
> devices which are not actually there, causing various resource conflicts.
> Add an ACPI_QUIRK_SKIP_I2C_CLIENTS quirk for the Lenovo Yoga Tab 3 Pro to
> the acpi_quirk_skip_dmi_ids table to woraround this.
>
> ACPI_QUIRK_SKIP_I2C_CLIENTS handling uses i2c_acpi_known_good_ids[],
> so that PMICs and Audio codecs will still be enumerated properly.
> The Lenovo Yoga Tab 3 Pro uses a Whiskey Cove PMIC, add the INT34D3 HID
> for this PMIC to the i2c_acpi_known_good_ids[] list.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 05262488fab9..4e816bb402f6 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -308,7 +308,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
>                                         ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
>         },
>         {
> -               /* Lenovo Yoga Tablet 1050F/L */
> +               /* Lenovo Yoga Tablet 2 1050F/L */
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
>                         DMI_MATCH(DMI_PRODUCT_NAME, "VALLEYVIEW C0 PLATFORM"),
> @@ -319,6 +319,16 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
>                 .driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
>                                         ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
>         },
> +       {
> +               /* Lenovo Yoga Tab 3 Pro X90F */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
> +               },
> +               .driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
> +       },
>         {
>                 /* Medion Lifetab S10346 */
>                 .matches = {
> @@ -359,6 +369,7 @@ static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
>         { "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
>         { "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
>         { "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
> +       { "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
>         { "NPCE69A", 0 },  /* Asus Transformer keyboard dock */
>         {}
>  };
> --

Applied as 6.2 material, thanks!
