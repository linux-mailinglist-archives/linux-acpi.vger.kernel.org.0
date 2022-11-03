Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9566187F6
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Nov 2022 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKCSvM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Nov 2022 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKCSvL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2022 14:51:11 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DAFF7E;
        Thu,  3 Nov 2022 11:51:10 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id j6so1738346qvn.12;
        Thu, 03 Nov 2022 11:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zis0owZsMFVBZPGXe9QCidngIGxG+l6l59XKN5cG8j8=;
        b=csMiiU2AUBdqpr5DTquZRnoIzQ2aNa8Yv9gXLWHEWvhkuMfp7RRLohcxIPGa9uuSHV
         NS6yYVbmSksyAImklNojOxaB/67fQz+O2R7uQo+uOHDqq9ZnyalnooMNQHH5D40GzCKa
         sz70L6p/hseKeO3Zzw7lh1nXA4AVtAVHXlrQcdVxl0+a2+MYlZB9bxkSdF9P+jQWQi2V
         5c4zWFyJfQbCTvke/lyHzu+taxVB15+EmnKkq3LzZIIff/XnG3QHTxZWSiLZp68JsYkQ
         0G+Db9n0e9xkJo85p2Om7S/4zL1GLZjWivhG0/3TgPuQjq8v/XeOiO/Pw8tOOzXsR+s0
         9xHg==
X-Gm-Message-State: ACrzQf1aTe7pYHkBnA6Kz9zWLuE+if43VXHkiR6uPSsFIRnMFnPkEq6p
        tFpdYHcVKuo+2j64ynhINerBBMghdE8sx/p5wBY=
X-Google-Smtp-Source: AMsMyM4L7sSHmachWAk++pMl1KlZa5F7H0zd2YHtl1JVodoSNE1tlCQWGPBsQPRpUHocU+XhNhjWkK28bHbIgVo8qY0=
X-Received: by 2002:a0c:a90d:0:b0:4b3:f322:1280 with SMTP id
 y13-20020a0ca90d000000b004b3f3221280mr28441369qva.83.1667501470073; Thu, 03
 Nov 2022 11:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221031105806.370672-1-hdegoede@redhat.com>
In-Reply-To: <20221031105806.370672-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:50:59 +0100
Message-ID: <CAJZ5v0jQvopYK-N4eXnp_Fif9vQ8Q=sYGiUhoNeY9hDavkOSgw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Improve Chromebook checks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Mr . Chromebox" <mrchromebox@gmail.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
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

On Mon, Oct 31, 2022 at 11:58 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> 2 improvements for the Chromebook handling in
> acpi_video_get_backlight_type():
>
> 1. Also check for the "GOOG000C" ACPI HID used on some models
> 2. Move the Chromebook check to above the ACPI-video check normally
>    Chromebooks don't have ACPI video backlight support, but when
>    flashed with upstream coreboot builds they may have ACPI video
>    backlight support, but native should still be used/preferred then.
>
> Suggested-by: Mr. Chromebox <mrchromebox@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 9cd8797d12bb..841f6213b4de 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -670,7 +670,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>
>  static bool google_cros_ec_present(void)
>  {
> -       return acpi_dev_found("GOOG0004");
> +       return acpi_dev_found("GOOG0004") || acpi_dev_found("GOOG000C");
>  }
>
>  /*
> @@ -718,6 +718,10 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>         if (apple_gmux_present())
>                 return acpi_backlight_apple_gmux;
>
> +       /* Chromebooks should always use native backlight control. */
> +       if (google_cros_ec_present() && native_available)
> +               return acpi_backlight_native;
> +
>         /* On systems with ACPI video use either native or ACPI video. */
>         if (video_caps & ACPI_VIDEO_BACKLIGHT) {
>                 /*
> @@ -735,13 +739,6 @@ static enum acpi_backlight_type __acpi_video_get_backlight_type(bool native)
>                         return acpi_backlight_video;
>         }
>
> -       /*
> -        * Chromebooks that don't have backlight handle in ACPI table
> -        * are supposed to use native backlight if it's available.
> -        */
> -       if (google_cros_ec_present() && native_available)
> -               return acpi_backlight_native;
> -
>         /* No ACPI video (old hw), use vendor specific fw methods. */
>         return acpi_backlight_vendor;
>  }
> --

Applied as 6.2 material, thanks!
