Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7664C9447
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 20:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiCATbO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiCATbM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 14:31:12 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61F462122;
        Tue,  1 Mar 2022 11:30:30 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2d07c4a0d06so155784347b3.13;
        Tue, 01 Mar 2022 11:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lvj2PhJi5c7Nf3Ys3iFyqco+8F+q/gsCwtOag2POmXU=;
        b=l8Or4a2qbvVq7SUtMXPhtQ81ahIkLYltBw04tu1O+lziCHKpil5hN582174AMclbrj
         1W/TEuXwOYaBw34uXiO71Ua39aMsmVOiVn1k7jR0pkf3pjFlaW5pACbpsTag3f+sJtAk
         iq2Hf3HRsWvBanBkhGYbGV6g+me3fZ9Kp1Eic+QMEzvhtj9WuBrqE4rig+64PTGvjHgP
         GDG0BnQBSkPvabkRv7NypjjC8FvX8ccGRm3D+2+WWHc7rlHNlznbSXcySMT9KQUsdlrh
         rwWdVPUyQ2YB6Gb6OKbortDK1TrxM8laL8dMNl1vt7pezQnEFHW3rq/TzPyJL/xT1XAu
         DlFg==
X-Gm-Message-State: AOAM531iH+bYAWZYOvRV0DjNOgbmmGnR2YKW7j5BQqectqDZBCDatoak
        pR9nkAC3u+JqTCgGjBj7qBPwyY1NrwqjAIT17k4=
X-Google-Smtp-Source: ABdhPJzq819lUwXZkbbB7vT4oQRJXwFkx81tseuxmh6FPuxLMUm0XpEYvA94FP4FDXIu+S27vZNAKYdTwzEg7tD3JGE=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr13897411ywb.326.1646163030231; Tue, 01
 Mar 2022 11:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20220223135032.731247-1-hdegoede@redhat.com>
In-Reply-To: <20220223135032.731247-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 20:30:19 +0100
Message-ID: <CAJZ5v0gLLrRx7yBp7SQ6rxnox1A7C41qSZBz8CQnHVhfe5XbQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / x86: Add skip i2c clients quirk for Nextbook
 Ares 8
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 23, 2022 at 2:50 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Nextbook Ares 8 is a x86 ACPI tablet which ships with Android x86
> as factory OS. Its DSDT contains a bunch of I2C devices which are not
> actually there, causing various resource conflicts (the Android x86
> kernel fork ignores I2C devices described in the DSDT).
>
> Add a ACPI_QUIRK_SKIP_I2C_CLIENTS for the Nextbook Ares 8 to the
> acpi_quirk_skip_dmi_ids table to woraround this.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index ffdeed5334d6..9b991294f1e5 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -284,6 +284,15 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
>                 .driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
>                                         ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
>         },
> +       {
> +               /* Nextbook Ares 8 */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "M890BAP"),
> +               },
> +               .driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
> +       },
>         {
>                 /* Whitelabel (sold as various brands) TM800A550L */
>                 .matches = {
> --

Applied as 5.18 material along with the [2/2], thanks!
