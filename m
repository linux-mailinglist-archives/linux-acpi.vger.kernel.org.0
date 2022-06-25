Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F70855AA9C
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jun 2022 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiFYNoT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 25 Jun 2022 09:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiFYNoD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Jun 2022 09:44:03 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5861C117;
        Sat, 25 Jun 2022 06:43:46 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id i15so9185033ybp.1;
        Sat, 25 Jun 2022 06:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAKAgQ+yky+qtekDhyWd05POB+q8QkxLv66gfq+6TPk=;
        b=6Lv/onNj9yZUjId2h/vsAJEwQCZB8mGMD9pl8pUaVfwHLIaYTDAW75Y7X0W+hvFS+Y
         pKcGw1mv2UPvAzBnEqzZ4F9qNRODO1GlP9VzxC+Xn/Z2dc1paVNFLIhbfy1VSagR6f0d
         K5wUnWXh1t+/AsZkyNrv2NmizHffXtyO94cVk6BTAPJayoe9UX6MgzK0utw4EnD6GJf8
         O8YjZ0UfcsBZ3XdfN0lJFhHSdPBUYlwV1MBWAVSUpMDJzsxlGdZfOTQVM1rPnYBl5GCk
         8b6AIJS0Z/C1+KKxMPhkVt19lS2HtEKYf3moMCf2A5fLo3s/gM35jW0sM0BQAdumqR/w
         eobg==
X-Gm-Message-State: AJIora+dOwgnGJrAawJRUelgEZTzCycznzMRRzXzJCZwHXj/tXYRa26X
        G6yvj9tuai75Le2Nx2jjXwMLu3MHnqsjqwPipDE=
X-Google-Smtp-Source: AGRyM1v5wXOcNu4UWaZx73jz9jkTRv6Ia0s8IquEmqiLD8bsS43vIR5/4h0nTSbbmb2je2bOmzKYnqG/AJDQMgwHgdg=
X-Received: by 2002:a25:9004:0:b0:66c:97a4:3053 with SMTP id
 s4-20020a259004000000b0066c97a43053mr548906ybl.137.1656164625449; Sat, 25 Jun
 2022 06:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220624112340.10130-1-hdegoede@redhat.com> <20220624112340.10130-2-hdegoede@redhat.com>
In-Reply-To: <20220624112340.10130-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 25 Jun 2022 15:43:34 +0200
Message-ID: <CAJZ5v0gYf30tMDTPzB6QMYVp-6zcENhgFQeKSaT4DzLSDi7_zw@mail.gmail.com>
Subject: Re: [PATCH 1/7] ACPI: video: Change how we determine if brightness
 key-presses are handled
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
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

On Fri, Jun 24, 2022 at 1:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some systems have an ACPI video bus but not ACPI video devices with
> backlight capability. On these devices brightness key-presses are
> (logically) not reported through the ACPI video bus.
>
> Change how acpi_video_handles_brightness_key_presses() determines if
> brightness key-presses are handled by the ACPI video driver to avoid
> vendor specific drivers/platform/x86 drivers filtering out their
> brightness key-presses even though they are the only ones reporting
> these presses.
>
> Fixes: ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double trigger bug")
> Reported-and-tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
> Reported-and-tested-by: Kenneth Chan <kenneth.t.chan@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming that you'll take this one along with the rest of the series.

> ---
>  drivers/acpi/acpi_video.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index b6ee27cb32f3..dc3c037d6313 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -79,6 +79,7 @@ module_param(device_id_scheme, bool, 0444);
>  static int only_lcd = -1;
>  module_param(only_lcd, int, 0444);
>
> +static bool has_backlight;
>  static int register_count;
>  static DEFINE_MUTEX(register_count_mutex);
>  static DEFINE_MUTEX(video_list_lock);
> @@ -1230,6 +1231,9 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
>         acpi_video_device_bind(video, data);
>         acpi_video_device_find_cap(data);
>
> +       if (data->cap._BCM && data->cap._BCL)
> +               has_backlight = true;
> +
>         mutex_lock(&video->device_list_lock);
>         list_add_tail(&data->entry, &video->video_device_list);
>         mutex_unlock(&video->device_list_lock);
> @@ -2276,6 +2280,7 @@ void acpi_video_unregister(void)
>                 cancel_delayed_work_sync(&video_bus_register_backlight_work);
>                 acpi_bus_unregister_driver(&acpi_video_bus);
>                 register_count = 0;
> +               has_backlight = false;
>         }
>         mutex_unlock(&register_count_mutex);
>  }
> @@ -2294,13 +2299,7 @@ EXPORT_SYMBOL(acpi_video_register_backlight);
>
>  bool acpi_video_handles_brightness_key_presses(void)
>  {
> -       bool have_video_busses;
> -
> -       mutex_lock(&video_list_lock);
> -       have_video_busses = !list_empty(&video_bus_head);
> -       mutex_unlock(&video_list_lock);
> -
> -       return have_video_busses &&
> +       return has_backlight &&
>                (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS);
>  }
>  EXPORT_SYMBOL(acpi_video_handles_brightness_key_presses);
> --
> 2.36.0
>
