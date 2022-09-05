Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4A5AD417
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Sep 2022 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiIENiM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 5 Sep 2022 09:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiIENiE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Sep 2022 09:38:04 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E6C4D4CB;
        Mon,  5 Sep 2022 06:37:52 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 130so7248067ybz.9;
        Mon, 05 Sep 2022 06:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/d95nRqkRbEGLw+fX9p+TIH6MACF5W6pHgpWCiqctb8=;
        b=vkOFrih3VCgNHYZsE0/jnyCdXP3ei1AwJI3HJW3G7Fls8tqBaFKkUvNIVQ7T50A2zZ
         Itc0CspNbZkffsgwRuFMF4pQmZEH2RSK5bHz4pX+TyPhm2PNMilV5s7Jvipeb7WlrvyM
         9Ru5/BYBVDCdZWU5pXNYjBAFQ9klm/jFox/ECshHKqSxl+/PTCFsb0lCBGq8lqso/Apx
         BddijtCreu9mCWm8U/nCG9kxT9JKpjPYhU/A1K9mzc1an+KZTv9lmj6Yqumk+WoxDqSh
         d1aXOaIez6EzPC5KNx6oIATHv31lec1wSwyNZMrK+eobponYufevHx4I+WRBadeqhesJ
         H9Fg==
X-Gm-Message-State: ACgBeo0v2R47vj6/HxTbxHp/B2ci4tLxMs52B+KwA6BY5urmzwA2lllX
        3ePwkv70ia/Pd1vmJGFFkxItA+rb+TVBxp1fMb96iysi
X-Google-Smtp-Source: AA6agR5fQubAc6h3HgvkHs9EUOYKFONPZhi3+SzSgV9pT3VhRa5xnmo0Rq9dnXIVMJQMlfZ/FGkZKuuj2kkM1J31brw=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr34809638ybm.137.1662385024861; Mon, 05
 Sep 2022 06:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220905090005.333429-1-hdegoede@redhat.com> <20220905090005.333429-3-hdegoede@redhat.com>
In-Reply-To: <20220905090005.333429-3-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Sep 2022 15:36:53 +0200
Message-ID: <CAJZ5v0hFSTFYCQZpGK+-S15N5tD=uiJUbQKGAxGtFBiCVPDarA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: video: Change disable_backlight_sysfs_if quirks
 to acpi_backlight=native
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Arvid Norlander <lkml@vorpal.se>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
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

On Mon, Sep 5, 2022 at 11:00 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some Toshibas have a broken acpi-video interface for brightness control
> and need a special firmware call on resume to turn the panel back on.
> So far these have been using the disable_backlight_sysfs_if workaround
> to deal with this.
>
> The recent x86/acpi backlight refactoring has broken this workaround:
> 1. This workaround relies on acpi_video_get_backlight_type() returning
>    acpi_video so that the acpi_video code actually runs; and
> 2. this relies on the actual native GPU driver to offer the sysfs
>    backlight interface to userspace.
>
> After the refactor this breaks since the native driver will no
> longer register its backlight-device if acpi_video_get_backlight_type()
> does not return native and making it return native breaks 1.
>
> Keeping the acpi_video backlight handling on resume active, while not
> using it to set the brightness, is necessary because it does a _BCM
> call on resume which is necessary to turn the panel back on on resume.
>
> Looking at the DSDT shows that this _BCM call results in a Toshiba
> HCI_SET HCI_LCD_BRIGHTNESS call, which turns the panel back on.
>
> This kind of special vendor specific handling really belongs in
> the vendor specific acpi driver. An earlier patch in this series
> modifies toshiba_acpi to make the necessary HCI_SET call on resume
> on affected models.
>
> With toshiba_acpi taking care of the HCI_SET call on resume,
> the acpi_video code no longer needs to call _BCM on resume.
>
> So instead of using the (now broken) disable_backlight_sysfs_if
> workaround, simply setting acpi_backlight=native to disable
> the broken apci-video interface is sufficient fix things now.
>
> After this there are no more users of the disable_backlight_sysfs_if
> flag and as discussed above the flag also no longer works as intended,
> so remove the disable_backlight_sysfs_if flag entirely.
>
> Fixes: b1d36e73cc1c ("drm/i915: Don't register backlight when another backlight should be used (v2)")
> Tested-by: Arvid Norlander <lkml@vorpal.se>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_video.c   | 48 -------------------------------------
>  drivers/acpi/video_detect.c | 35 +++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index a7c3d11e0dac..99894fbcf4e3 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -47,9 +47,6 @@ module_param(brightness_switch_enabled, bool, 0644);
>  static bool allow_duplicates;
>  module_param(allow_duplicates, bool, 0644);
>
> -static int disable_backlight_sysfs_if = -1;
> -module_param(disable_backlight_sysfs_if, int, 0444);
> -
>  #define REPORT_OUTPUT_KEY_EVENTS               0x01
>  #define REPORT_BRIGHTNESS_KEY_EVENTS           0x02
>  static int report_key_events = -1;
> @@ -394,14 +391,6 @@ static int video_set_bqc_offset(const struct dmi_system_id *d)
>         return 0;
>  }
>
> -static int video_disable_backlight_sysfs_if(
> -       const struct dmi_system_id *d)
> -{
> -       if (disable_backlight_sysfs_if == -1)
> -               disable_backlight_sysfs_if = 1;
> -       return 0;
> -}
> -
>  static int video_set_device_id_scheme(const struct dmi_system_id *d)
>  {
>         device_id_scheme = true;
> @@ -474,40 +463,6 @@ static const struct dmi_system_id video_dmi_table[] = {
>                 },
>         },
>
> -       /*
> -        * Some machines have a broken acpi-video interface for brightness
> -        * control, but still need an acpi_video_device_lcd_set_level() call
> -        * on resume to turn the backlight power on.  We Enable backlight
> -        * control on these systems, but do not register a backlight sysfs
> -        * as brightness control does not work.
> -        */
> -       {
> -        /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> -        .callback = video_disable_backlight_sysfs_if,
> -        .ident = "Toshiba Portege R700",
> -        .matches = {
> -               DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -               DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
> -               },
> -       },
> -       {
> -        /* https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
> -        .callback = video_disable_backlight_sysfs_if,
> -        .ident = "Toshiba Portege R830",
> -        .matches = {
> -               DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -               DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R830"),
> -               },
> -       },
> -       {
> -        /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> -        .callback = video_disable_backlight_sysfs_if,
> -        .ident = "Toshiba Satellite R830",
> -        .matches = {
> -               DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -               DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE R830"),
> -               },
> -       },
>         /*
>          * Some machine's _DOD IDs don't have bit 31(Device ID Scheme) set
>          * but the IDs actually follow the Device ID Scheme.
> @@ -1770,9 +1725,6 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
>         if (result)
>                 return;
>
> -       if (disable_backlight_sysfs_if > 0)
> -               return;
> -
>         name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
>         if (!name)
>                 return;
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index db2474fe58ac..0d9064a9804c 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -610,6 +610,41 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 },
>         },
>
> +       /*
> +        * These Toshibas have a broken acpi-video interface for brightness
> +        * control. They also have an issue where the panel is off after
> +        * suspend until a special firmware call is made to turn it back
> +        * on. This is handled by the toshiba_acpi kernel module, so that
> +        * module must be enabled for these models to work correctly.
> +        */
> +       {
> +        /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> +        .callback = video_detect_force_native,
> +        /* Toshiba Portégé R700 */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
> +               },
> +       },
> +       {
> +        /* Portégé: https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
> +        /* Satellite: https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> +        .callback = video_detect_force_native,
> +        /* Toshiba Satellite/Portégé R830 */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
> +               },
> +       },
> +       {
> +        .callback = video_detect_force_native,
> +        /* Toshiba Satellite/Portégé Z830 */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
> +               },
> +       },
> +
>         /*
>          * Desktops which falsely report a backlight and which our heuristics
>          * for this do not catch.
> --
> 2.36.1
>
