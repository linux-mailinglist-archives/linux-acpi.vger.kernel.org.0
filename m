Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E022672CBFD
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jun 2023 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjFLRDt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 12 Jun 2023 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjFLRDq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jun 2023 13:03:46 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F3E0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jun 2023 10:03:45 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-974604c1394so127330166b.0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jun 2023 10:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589424; x=1689181424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KugEFd75p1HZibW0H8djou1t0Nl/aoyoyfY3EmGS3GU=;
        b=BYZZChUlZQ1CLOSV+rQ5lE2uJHRqF1X0tIqqNTEaj+8Jsnt4Zj5vBNpedbVvGa9Koz
         5bFZ3Jon+4fpOTfUGtFY7rSvFCXEyc6FDR4604CBFmgiXLz+WjSywQevwopo1vw7oWrd
         X0oLdoNt0Bw/tBxj6rMslJ/Uxc5c1HjT6da1Gn534zlVZvTu0n8Qt1La+qEX2HgbLfJx
         lw1SMaXVnmFLrSMd58NpRcjl7meT2IwWkacqMRTKJCYiXUjNFDblM1G8Sp93m46582/u
         LK7qFSX59ShYRQmM4lVx2+bSx3w2m1tJrfeeu0TzaYu+1GXW6WL99d069AEG1ESLc3xr
         yHsQ==
X-Gm-Message-State: AC+VfDwKdfx9VvzR2t8x9+t97VtoPyWS/XBTzVSWSt9sScgexoTFL9FE
        CS8OWnNlfQFyXdVEWc5Xx0Mslq0CPMRB+5QMh2I=
X-Google-Smtp-Source: ACHHUZ5CqeOQCoEqktdtHpydPMO87HIdeHogxTCQ5YGaBtzuQTCAw21aMeRJMM3T9AMhTIQBYSzZ5A0I/YpyTDZ/wsI=
X-Received: by 2002:a17:906:5188:b0:977:c446:3a24 with SMTP id
 y8-20020a170906518800b00977c4463a24mr8682828ejk.7.1686589423565; Mon, 12 Jun
 2023 10:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230608091258.7963-1-hdegoede@redhat.com>
In-Reply-To: <20230608091258.7963-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:03:32 +0200
Message-ID: <CAJZ5v0jNSWo041AMP0vRbs-909g9ErWJt261oM+RuKvET2sPKw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Stop trying to use vendor backlight control
 on laptops from after ~2012
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 8, 2023 at 11:13 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> There have been 2 separate reports now about a non working
> "dell_backlight" device getting registered under /sys/class/backlight
> 1 report for a Raptor Lake based Dell and 1 report for a Meteor Lake
> (development) platform.
>
> On hw from the last 10 years dell-laptop will not register "dell_backlight"
> because acpi_video_get_backlight_type() will return acpi_backlight_video
> there if called before the GPU/kms driver loads. So it does not matter if
> the GPU driver's native backlight is registered after dell-laptop loads.
>
> But it seems that on the latest generation laptops the ACPI tables
> no longer contain acpi_video backlight control support which causes
> acpi_video_get_backlight_type() to return acpi_backlight_vendor causing
> "dell_backlight" to get registered if the dell-laptop module is loaded
> before the GPU/kms driver.
>
> Vendor specific backlight control like the "dell_backlight" device is
> only necessary on quite old hw (from before acpi_video backlight control
> was introduced). Work around "dell_backlight" registering on very new
> hw (where acpi_video backlight control seems to be no more) by making
> acpi_video_get_backlight_type() return acpi_backlight_none instead
> of acpi_backlight_vendor as final fallback when the ACPI tables have
> support for Windows 8 or later (laptops from after ~2012).
>
> Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Reported-by: AceLan Kao <acelan.kao@canonical.com>
> Closes: https://lore.kernel.org/platform-driver-x86/20230607034331.576623-1-acelan.kao@canonical.com/
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index b87783c5872d..eb014c0eba42 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -844,6 +844,27 @@ enum acpi_backlight_type __acpi_video_get_backlight_type(bool native, bool *auto
>         if (native_available)
>                 return acpi_backlight_native;
>
> +       /*
> +        * The vendor specific BIOS interfaces are only necessary for
> +        * laptops from before ~2008.
> +        *
> +        * For laptops from ~2008 till ~2023 this point is never reached
> +        * because on those (video_caps & ACPI_VIDEO_BACKLIGHT) above is true.
> +        *
> +        * Laptops from after ~2023 no longer support ACPI_VIDEO_BACKLIGHT,
> +        * if this point is reached on those, this likely means that
> +        * the GPU kms driver which sets native_available has not loaded yet.
> +        *
> +        * Returning acpi_backlight_vendor in this case is known to sometimes
> +        * cause a non working vendor specific /sys/class/backlight device to
> +        * get registered.
> +        *
> +        * Return acpi_backlight_none on laptops with ACPI tables written
> +        * for Windows 8 (laptops from after ~2012) to avoid this problem.
> +        */
> +       if (acpi_osi_is_win8())
> +               return acpi_backlight_none;
> +
>         /* No ACPI video/native (old hw), use vendor specific fw methods. */
>         return acpi_backlight_vendor;
>  }
> --

Applied as 6.5 material, thanks!
