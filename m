Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E043B8823
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhF3SHc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Jun 2021 14:07:32 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38668 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhF3SHc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jun 2021 14:07:32 -0400
Received: by mail-ot1-f51.google.com with SMTP id x22-20020a9d6d960000b0290474a76f8bd4so2022217otp.5
        for <linux-acpi@vger.kernel.org>; Wed, 30 Jun 2021 11:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQPgCy05iFrZ24k/AhyqYDKgkSkWDvhh1BWqAAEhEMo=;
        b=qSbFlTqcJO3Zf1cdZ4BQYLiq5bxCkN9t3MFJ0MqkJmz9b1R3A/td1HSfgx+jpmnsJS
         pIVE8D3W+AEFicNP8ZA4UBGuIKM+Behk07Fsz2WrYhpQJ4sD4CwdqPESQxgPxbrIw2Wi
         nj/8zsmDk/rLpDY2v31p4iWd3kgE7Qf2u6kVhQ1qrbt+xblRXAMAeA0xWDjPRMTsByWL
         A5YVwFnN0d3K+5wPYHoyJ5613Vy9NAUpc49/i2Q9+5vGle578WVB4EqOnhixe8fBIv3V
         LKkPu8KTJT8CYxBlRUZzrjvQfSmRuljesph5fFXUqIan53wXnrUJyznP0irVNsaNLaMA
         VU+g==
X-Gm-Message-State: AOAM533jivysHdPIbHNzvvHiOxVqw3TIA9h0j0v1P/0o/SYvemX3XRmF
        sFvgLQlFzz5NQP8VIqpdT0R/OGmKxXr/Xjgy3Ak=
X-Google-Smtp-Source: ABdhPJzM2POjqckFDClNnvjmjwj0RzYXaDedTkstvxNCYrdJ67UgfHkTNQ5KwhaSuJmlyVXnPT7efCZo4D+cMhgtV3Q=
X-Received: by 2002:a05:6830:1d8:: with SMTP id r24mr3501064ota.206.1625076302077;
 Wed, 30 Jun 2021 11:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210630152316.24768-1-hdegoede@redhat.com>
In-Reply-To: <20210630152316.24768-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 20:04:51 +0200
Message-ID: <CAJZ5v0hAA27hym3-29gOatJx3gEQ8YD0p19d=XS4xr+UTzog_A@mail.gmail.com>
Subject: Re: [PATCH] ACPI / video: Add quirk for the Dell Vostro 3350
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 30, 2021 at 5:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Dell Vostro 3350 ACPI video-bus device reports spurious
> ACPI_VIDEO_NOTIFY_CYCLE events resulting in spurious KEY_SWITCHVIDEOMODE
> events being reported to userspace (and causing trouble there).
>
> Add a quirk setting the report_key_events mask to
> REPORT_BRIGHTNESS_KEY_EVENTS so that the ACPI_VIDEO_NOTIFY_CYCLE
> events will be ignored, while still reporting brightness up/down
> hotkey-presses to userspace normally.
>
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1911763
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_video.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 0c884020f74b..08a51dd285c4 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -540,6 +540,15 @@ static const struct dmi_system_id video_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V131"),
>                 },
>         },
> +       {
> +        .callback = video_set_report_key_events,
> +        .driver_data = (void *)((uintptr_t)REPORT_BRIGHTNESS_KEY_EVENTS),
> +        .ident = "Dell Vostro 3350",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3350"),
> +               },
> +       },
>         /*
>          * Some machines change the brightness themselves when a brightness
>          * hotkey gets pressed, despite us telling them not to. In this case
> --

Applied as 5.14-rc1 material, thanks!
