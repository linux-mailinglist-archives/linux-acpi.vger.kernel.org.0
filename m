Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6049F678625
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 20:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjAWTVD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 14:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAWTVC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 14:21:02 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D207A12F04;
        Mon, 23 Jan 2023 11:20:58 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id v6so33279971ejg.6;
        Mon, 23 Jan 2023 11:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyveUL1w6/9AEHHX4H67XuRj9jaB5D6hXjnDA10SVdo=;
        b=pG6LIBc4b1BbajaN3tjo4sqqgTO3jXxf6P4LZzeMA8JZhoR6b8Vm6QKZ+k0NbEUCpw
         l66EMOPF+QDuRH9Dtz6PTNSVsHgpHbINOmOO66VOJWSXHBPxIIOiUZ7Msm/oRBg+AQU3
         NsABWmu1sD5japXUsEY0DMVTtO0fXA2Qst3/N59pKQ39Qr6wVj3P4FZv6hIILYq2/KVM
         FkF9lKnLQYUyOsl6yjuhrqbmcVyNy24MqnipzJHtZk17Bt8KLc/N371eMZbjhiE6MkDc
         jkQ1k0kqicUZYHmcxLe02sQQX1sqgO4ZOuljLmF+C9iLsavhsqkyfJ72ORAUKHT6J99J
         guHw==
X-Gm-Message-State: AFqh2kqsITNS5vdkyLf7RTTaUcQhOtLSGEWRzpjJot5rlbtCItiVy/k/
        k896Bpzd14Fikk3pkxoTlrqGZmasB0d3y/6AtNk=
X-Google-Smtp-Source: AMrXdXv9boDRwSCBDEvZU+bHzhKD6a+TebngTyi0ePL1a+K7sI7Xd1wu3vI6hnLgFoe3BgoZLiF9HcSayGf5ZcQHrRE=
X-Received: by 2002:a17:907:7855:b0:855:63bb:d3cb with SMTP id
 lb21-20020a170907785500b0085563bbd3cbmr2657732ejc.532.1674501657356; Mon, 23
 Jan 2023 11:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20230123113750.462144-1-hdegoede@redhat.com> <20230123113750.462144-4-hdegoede@redhat.com>
In-Reply-To: <20230123113750.462144-4-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jan 2023 20:20:46 +0100
Message-ID: <CAJZ5v0j4AHHMJs79hNT2wkWVgisuZLDj9QJRq-DvEmvFGYJK2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: video: Fix apple gmux detection
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 12:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some apple laptop models have an ACPI device with a HID of APP000B
> and that device has an IO resource (so it does not describe the new
> unsupported MMIO based gmux type), but there actually is no gmux
> in the laptop at all.
>
> The gmux_probe() function of the actual apple-gmux driver has code
> to detect this, this code has been factored out into a new
> apple_gmux_detect() helper in apple-gmux.h.
>
> Use this new function to fix acpi_video_get_backlight_type() wrongly
> returning apple_gmux as type on these new laptops.
>
> Fixes: 21245df307cb ("ACPI: video: Add Apple GMUX brightness control detection")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this one and route it through platform/x86, thanks!

> ---
>  drivers/acpi/video_detect.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 64eab35037c3..a8c02608dde4 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -110,26 +110,6 @@ static bool nvidia_wmi_ec_supported(void)
>  }
>  #endif
>
> -static bool apple_gmux_backlight_present(void)
> -{
> -       struct acpi_device *adev;
> -       struct device *dev;
> -
> -       adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
> -       if (!adev)
> -               return false;
> -
> -       dev = acpi_get_first_physical_node(adev);
> -       if (!dev)
> -               return false;
> -
> -       /*
> -        * drivers/platform/x86/apple-gmux.c only supports old style
> -        * Apple GMUX with an IO-resource.
> -        */
> -       return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
> -}
> -
>  /* Force to use vendor driver when the ACPI device is known to be
>   * buggy */
>  static int video_detect_force_vendor(const struct dmi_system_id *d)
> @@ -791,6 +771,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>  {
>         static DEFINE_MUTEX(init_mutex);
>         static bool nvidia_wmi_ec_present;
> +       static bool apple_gmux_present;
>         static bool native_available;
>         static bool init_done;
>         static long video_caps;
> @@ -804,6 +785,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>                                     ACPI_UINT32_MAX, find_video, NULL,
>                                     &video_caps, NULL);
>                 nvidia_wmi_ec_present = nvidia_wmi_ec_supported();
> +               apple_gmux_present = apple_gmux_detect(NULL, NULL);
>                 init_done = true;
>         }
>         if (native)
> @@ -825,7 +807,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>         if (nvidia_wmi_ec_present)
>                 return acpi_backlight_nvidia_wmi_ec;
>
> -       if (apple_gmux_backlight_present())
> +       if (apple_gmux_present)
>                 return acpi_backlight_apple_gmux;
>
>         /* Use ACPI video if available, except when native should be preferred. */
> --
> 2.39.0
>
