Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43C575363
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbiGNQub (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 12:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbiGNQuN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 12:50:13 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A013CE3;
        Thu, 14 Jul 2022 09:47:21 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 75so4192093ybf.4;
        Thu, 14 Jul 2022 09:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKkMo+vK7lqJ6rNsvFjcKcJ08hq9L2uCtIalBlioWsM=;
        b=3rEAHCjxPkYxGZvDSjxlzRpRQ4qEyV/3sbab5GBkTBAO4vrrM8yQoUvdO4C6jjBbay
         Rn4CxwnzMV/PyBdV6odw3JbU2EZcPA1TuX6gPr95Ge08VEl6qoyQZo9zTPNyidiL2HMl
         VpNLtu/erVUHYbUAN3w4gDvkNn5V8Lui+gqc81oF9k1uChHYYlEOCBmQply7/bBv7XwA
         SLlly/SDQs+Z4gRsa4kt04cJMwhRg6cz5FMI5hdgy1/Egm8QkibSX6/PuKsSB+V3VJhe
         AXW6yeOKxsG4I5YB61kHzoCl3AQ/n2+fjKWCmy9rA9KPGN0mkTTP8Dg6x53WdYW5jH2L
         XSIg==
X-Gm-Message-State: AJIora/A0b6O2xrPlF8o5LDCktt6GOa/VI1OIYJQmUnRt/I0rOuTq1Po
        eqdN+MPCo1ebhOuDVtNmlbzUzMoIAY/YjgwjY3dsLivp
X-Google-Smtp-Source: AGRyM1vtzdW/okzhD29lioId5DAwBnQkttu10dp0dNEzR7Qr41jZi4wrgQXdYT1WODRaGoFbgqX+WHhey8zVbRHz9ho=
X-Received: by 2002:a25:fb02:0:b0:66e:3db9:5d49 with SMTP id
 j2-20020a25fb02000000b0066e3db95d49mr10051140ybe.137.1657817240235; Thu, 14
 Jul 2022 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220713211101.85547-1-hdegoede@redhat.com> <20220713211101.85547-2-hdegoede@redhat.com>
In-Reply-To: <20220713211101.85547-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jul 2022 18:47:09 +0200
Message-ID: <CAJZ5v0g6Gpdc3zjh-xJWU+217xA+eU53rJxdz=qYEEhPN=pZ9A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Fix acpi_video_handles_brightness_key_presses()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        regressions@lists.linux.dev, Ben Greening <bgreening@gmail.com>
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

On Wed, Jul 13, 2022 at 11:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 3a0cf7ab8df3 ("ACPI: video: Change how we determine if brightness
> key-presses are handled") made acpi_video_handles_brightness_key_presses()
> report false when none of the ACPI Video Devices support backlight control.
>
> But it turns out that at least on a Dell Inspiron N4010 there is no ACPI
> backlight control, yet brightness hotkeys are still reported through
> the ACPI Video Bus; and since acpi_video_handles_brightness_key_presses()
> now returns false, brightness keypresses are now reported twice.
>
> To fix this rename the has_backlight flag to may_report_brightness_keys and
> also set it the first time a brightness key press event is received.
>
> Depending on the delivery of the other ACPI (WMI) event vs the ACPI Video
> Bus event this means that the first brightness key press might still get
> reported twice, but all further keypresses will be filtered as before.
>
> Note that this relies on other drivers reporting brightness key events
> calling acpi_video_handles_brightness_key_presses() when delivering
> the events (rather then once during driver probe). This is already
> required and documented in include/acpi/video.h:
>
> /*
>  * Note: The value returned by acpi_video_handles_brightness_key_presses()
>  * may change over time and should not be cached.
>  */
>
> Fixes: 3a0cf7ab8df3 ("ACPI: video: Change how we determine if brightness key-presses are handled")
> Link: https://lore.kernel.org/regressions/CALF=6jEe5G8+r1Wo0vvz4GjNQQhdkLT5p8uCHn6ZXhg4nsOWow@mail.gmail.com/
> Reported-by: Ben Greening <bgreening@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_video.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 43177c20ce4f..eaea733b368a 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -73,7 +73,7 @@ module_param(device_id_scheme, bool, 0444);
>  static int only_lcd = -1;
>  module_param(only_lcd, int, 0444);
>
> -static bool has_backlight;
> +static bool may_report_brightness_keys;
>  static int register_count;
>  static DEFINE_MUTEX(register_count_mutex);
>  static DEFINE_MUTEX(video_list_lock);
> @@ -1224,7 +1224,7 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
>         acpi_video_device_find_cap(data);
>
>         if (data->cap._BCM && data->cap._BCL)
> -               has_backlight = true;
> +               may_report_brightness_keys = true;
>
>         mutex_lock(&video->device_list_lock);
>         list_add_tail(&data->entry, &video->video_device_list);
> @@ -1693,6 +1693,9 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
>                 break;
>         }
>
> +       if (keycode)
> +               may_report_brightness_keys = true;
> +
>         acpi_notifier_call_chain(device, event, 0);
>
>         if (keycode && (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS)) {
> @@ -2253,7 +2256,7 @@ void acpi_video_unregister(void)
>         if (register_count) {
>                 acpi_bus_unregister_driver(&acpi_video_bus);
>                 register_count = 0;
> -               has_backlight = false;
> +               may_report_brightness_keys = false;
>         }
>         mutex_unlock(&register_count_mutex);
>  }
> @@ -2275,7 +2278,7 @@ void acpi_video_unregister_backlight(void)
>
>  bool acpi_video_handles_brightness_key_presses(void)
>  {
> -       return has_backlight &&
> +       return may_report_brightness_keys &&
>                (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS);
>  }
>  EXPORT_SYMBOL(acpi_video_handles_brightness_key_presses);
> --
> 2.36.0
>
