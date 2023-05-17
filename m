Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47D87070C8
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 20:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjEQSaf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 17 May 2023 14:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEQSae (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 14:30:34 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C86106
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 11:30:33 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so290891a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 11:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348231; x=1686940231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVuUkuNNuJM37/LFA1UHbT8I1xwI509oVTgpVuBMBeE=;
        b=GBYaE3mYfTjkZTO5jMOj5B+m5B1O1fje0j2j43rpN9DyIGZCxbp+DP1HIvioIPdByB
         ZJxYtVkrqI2OfAVoBFC92bFk8bvysyJ9BugPxwWMEYnnFwDYwarMEGmqig3JSIDn1otN
         eFvGImFi3TORK5WSwtXneZPa5UVLpdT0Ajk5YaPav+3QBMw8/DKgc9qrjBvH1F28CfjL
         WkEpRLMXuGVAgOBEMyylgMyGuIiBsvVnPJ7XsGamRWACJkNZAw7sv+gxjUuanxpZZOPi
         zFKuLxvvUk9/fl6kkg6AiptbsLeOvHkNPEjGmVS/zZLy4X1jBLOm+RLaavEqdRLwlAQv
         xlfQ==
X-Gm-Message-State: AC+VfDxWNjSBZiRBN7UqptV0sx0QZDLqvlrM0MmRuVWwlO3wgIxr++Xk
        yAJV+N8eA/av8efYQscWil9XlgOgaMYjEeyVIzc=
X-Google-Smtp-Source: ACHHUZ4AWJbvCXd2yzoMFZtCBv7Q/bcS8c1GdC77TOtncDle2K/IPN8WzgHyZ+xa3A770dvL/shmSm1S3bVGdPrlAG8=
X-Received: by 2002:a05:6402:4406:b0:50d:a9bb:3571 with SMTP id
 y6-20020a056402440600b0050da9bb3571mr4415307eda.2.1684348231509; Wed, 17 May
 2023 11:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230429103841.6988-1-hdegoede@redhat.com>
In-Reply-To: <20230429103841.6988-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 May 2023 20:30:20 +0200
Message-ID: <CAJZ5v0jRy_Ckf5sbw3eZL4SFDj=k93i7Z2nonLhh7RUv2CPPpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / x86: Add skip i2c clients quirk for Nextbook
 Ares 8A
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Apr 29, 2023 at 12:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Nextbook Ares 8A is a x86 ACPI tablet which ships with Android x86
> as factory OS. Its DSDT contains a bunch of I2C devices which are not
> actually there (the Android x86 kernel fork ignores I2C devices described
> in the DSDT).
>
> On this specific model this just not cause resource conflicts, one of
> the probe() calls for the non existing i2c_clients actually ends up
> toggling a GPIO or executing a _PS3 after a failed probe which turns
> the tablet off.
>
> Add a ACPI_QUIRK_SKIP_I2C_CLIENTS for the Nextbook Ares 8 to the
> acpi_quirk_skip_dmi_ids table to avoid the bogus i2c_clients and
> to fix the tablet turning off during boot because of this.
>
> Also add the "10EC5651" HID for the RealTek ALC5651 codec used
> in this tablet to the list of HIDs for which not to skipi2c_client
> instantiation, since the Intel SST sound driver relies on
> the codec being instantiated through ACPI.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 9c2d6f35f88a..4cfee2da0675 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -365,7 +365,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
>                                         ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
>         },
>         {
> -               /* Nextbook Ares 8 */
> +               /* Nextbook Ares 8 (BYT version)*/
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
>                         DMI_MATCH(DMI_PRODUCT_NAME, "M890BAP"),
> @@ -374,6 +374,16 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
>                                         ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
>                                         ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
>         },
> +       {
> +               /* Nextbook Ares 8A (CHT version)*/
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
> +                       DMI_MATCH(DMI_BIOS_VERSION, "M882"),
> +               },
> +               .driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
> +       },
>         {
>                 /* Whitelabel (sold as various brands) TM800A550L */
>                 .matches = {
> @@ -392,6 +402,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
>  #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
>  static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
>         { "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
> +       { "10EC5651", 0 }, /* RealTek ALC5651 audio codec */
>         { "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
>         { "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
>         { "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
> --

Applied as 6.5 material along with the [2/2], thanks!
