Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7091D654558
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Dec 2022 17:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLVQpH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Dec 2022 11:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiLVQpG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Dec 2022 11:45:06 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B022C3055A;
        Thu, 22 Dec 2022 08:45:05 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id o14so1172842qkk.5;
        Thu, 22 Dec 2022 08:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxL994ZGpsng6z6sP3chA/0SbhbU2L3QAQ9J36E7W9k=;
        b=tc4Fj6I3MDe39GjXQdHAhpi25qj1LhN8MkiL70xR+sRRXx3K/gWK2J1SlUeVteA6wm
         00Lm59MuzKJWfo9nfbl4XIo7frB+qPhxvkuFHsdmxHTUSaaq8QoFk+jdOnVKInX+DwzB
         Yyg2Kh2YN6Jhh0Qffc6XdMKlnOSz8rD8BJSnhjhZaUsrUgatqXvCNKl/lBWbkYMa2hns
         fctahRwC7v6RV3U6jzcDuY3FLm01fB5J0UXcyHhb1hIuddKwqq/6QZm05K71QEFyky1S
         DMYf/sbZvVQ2O+KxdvY2D0UE3rbIu6PJ5mFceqqW/UNCW1qeIqBASwEAySjUzyGPC+YB
         IrsQ==
X-Gm-Message-State: AFqh2koRK02pyYUH+FQD0+K9bzqgDyz1/3Ei/OS/kqu3cYGIUBntVKHW
        AeE+soCsqxg/fxWbS+zXeN3qHLAB2HPBBi/nG8E=
X-Google-Smtp-Source: AMrXdXueOXNoMZJh1ljDOmnc56EBDw2PDckPQRzB2G1sHYIncyhPI/jlLhbzYIsCwjmeYgFc9T8EbNSH6QUGPIrhfAw=
X-Received: by 2002:a05:620a:22b1:b0:702:50ce:e49 with SMTP id
 p17-20020a05620a22b100b0070250ce0e49mr307662qkh.443.1671727504866; Thu, 22
 Dec 2022 08:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20221215094138.7120-1-hdegoede@redhat.com>
In-Reply-To: <20221215094138.7120-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Dec 2022 17:44:53 +0100
Message-ID: <CAJZ5v0gre=j1=AMqREj1ZP-L3omHd6LmC8TxrZixUZfn_1R5KQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Fix Apple GMUX backlight detection
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Aditya Garg <gargaditya08@live.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 15, 2022 at 10:41 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The apple-gmux driver only binds to old GMUX devices which have an
> IORESOURCE_IO resource (using inb()/outb()) rather then memory-mapped
> IO (IORESOURCE_MEM).
>
> T2 MacBooks use the new style GMUX devices (with IORESOURCE_MEM access),
> so these are not supported by the apple-gmux driver. This is not a problem
> since they have working ACPI video backlight support.
>
> But the apple_gmux_present() helper only checks if an ACPI device with
> the "APP000B" HID is present, causing acpi_video_get_backlight_type()
> to return acpi_backlight_apple_gmux disabling the acpi_video backlight
> device.
>
> Add a new apple_gmux_backlight_present() helper which checks that
> the "APP000B" device actually is an old GMUX device with an IORESOURCE_IO
> resource.
>
> This fixes the acpi_video0 backlight no longer registering on T2 MacBooks.
>
> Note people are working to add support for the new style GMUX to Linux:
> https://github.com/kekrby/linux-t2/commits/wip/hybrid-graphics
>
> Once this lands this patch should be reverted so that
> acpi_video_get_backlight_type() also prefers the gmux on new style GMUX
> MacBooks, but for now this is necessary to avoid regressing backlight
> control on T2 Macs.
>
> Fixes: 21245df307cb ("ACPI: video: Add Apple GMUX brightness control detection")
> Reported-and-tested-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index a934bbc9dd37..1b78c7434492 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -34,6 +34,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_data/x86/nvidia-wmi-ec-backlight.h>
> +#include <linux/pnp.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  #include <acpi/video.h>
> @@ -105,6 +106,26 @@ static bool nvidia_wmi_ec_supported(void)
>  }
>  #endif
>
> +static bool apple_gmux_backlight_present(void)
> +{
> +       struct acpi_device *adev;
> +       struct device *dev;
> +
> +       adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
> +       if (!adev)
> +               return false;
> +
> +       dev = acpi_get_first_physical_node(adev);
> +       if (!dev)
> +               return false;
> +
> +       /*
> +        * drivers/platform/x86/apple-gmux.c only supports old style
> +        * Apple GMUX with an IO-resource.
> +        */
> +       return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
> +}
> +
>  /* Force to use vendor driver when the ACPI device is known to be
>   * buggy */
>  static int video_detect_force_vendor(const struct dmi_system_id *d)
> @@ -767,7 +788,7 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>         if (nvidia_wmi_ec_present)
>                 return acpi_backlight_nvidia_wmi_ec;
>
> -       if (apple_gmux_present())
> +       if (apple_gmux_backlight_present())
>                 return acpi_backlight_apple_gmux;
>
>         /* Use ACPI video if available, except when native should be preferred. */
> --

Applied as 6.2-rc material, thanks!
