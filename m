Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57B667871F
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 21:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjAWUEX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 15:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAWUEW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 15:04:22 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D303644A
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 12:04:03 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id tz11so33650310ejc.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 12:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3fVX9/iO2GxBu3HeDkyOtWJr/a2aLFft23eQ4Bm/IA=;
        b=3GRgdTikGNKHER1BBsWYIJy0JStJAbpR5L7AtG0CvrOWelRGDI1UnOE2nb81UeyoaS
         39mexrrqtXae/SUboQh9EdSzLrXHFv8eQzy4yC6WvLrHHmWum4dgwedHc4vcNlrZefUw
         UX5cO1SEsYOJrtrijzZWoQx/34wuwhxACiSNUKYT5bIyy11SuVF/5lKaayvfz6DugcFu
         KyaE3jjJ8XZon4tp2HkPfd3RrzdaEu4lCSsTPleQqrsfF0BtHvtdffBEVoQlA2i0M1EC
         zKDhnFucSW14ezlboAGoXrm+4AysV4U/xXkXbCsDSgIiCdGEbVjVlw/ymJlf0RUbirrn
         EbcQ==
X-Gm-Message-State: AFqh2krlj4qTzDc6KQMQDvQhMgUQ419zht8IjRxFPDVQSznOrZLq8GpK
        9l0OHeHrJoC+zu/QldOYv/H3FvWocrd7h0S83XM=
X-Google-Smtp-Source: AMrXdXuENRkvRLb6rYTN1lIZOmvWYGb1pdtChgR0SFwD3x+I9wxq0FF7oammztxQkdMfNYMJH+HQ+pmHm6yEdpT0l7g=
X-Received: by 2002:a17:906:92c8:b0:877:8b1c:fd7c with SMTP id
 d8-20020a17090692c800b008778b1cfd7cmr2051945ejx.67.1674504188794; Mon, 23 Jan
 2023 12:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20230119172441.623918-1-hdegoede@redhat.com>
In-Reply-To: <20230119172441.623918-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jan 2023 21:02:57 +0100
Message-ID: <CAJZ5v0geNw_RcQBpnrfA3qpnqDjyoJCACoJG+v9vCEFr6RMgKA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Asus U46E
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

On Thu, Jan 19, 2023 at 6:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Asus U46E backlight tables have a set of interesting problems:
>
> 1. Its ACPI tables do make _OSI ("Windows 2012") checks, so
>    acpi_osi_is_win8() should return true.
>
>    But the tables have 2 sets of _OSI calls, one from the usual global
>    _INI method setting a global OSYS variable and a second set of _OSI
>    calls from a MSOS method and the MSOS method is the only one calling
>    _OSI ("Windows 2012").
>
>    The MSOS method only gets called in the following cases:
>    1. From some Asus specific WMI methods
>    2. From _DOD, which only runs after acpi_video_get_backlight_type()
>       has already been called by the i915 driver
>    3. From other ACPI video bus methods which never run (see below)
>    4. From some EC query callbacks
>
>    So when i915 calls acpi_video_get_backlight_type() MSOS has never run
>    and acpi_osi_is_win8() returns false, so acpi_video_get_backlight_type()
>    returns acpi_video as the desired backlight type, which causes
>    the intel_backlight device to not register.
>
> 2. _DOD effectively does this:
>
>                     Return (Package (0x01)
>                     {
>                         0x0400
>                     })
>
>    causing acpi_video_device_in_dod() to return false, which causes
>    the acpi_video backlight device to not register.
>
> Leaving the user with no backlight device at all. Note that before 6.1.y
> the i915 driver would register the intel_backlight device unconditionally
> and since that then was the only backlight device userspace would use that.
>
> Add a backlight=native DMI quirk for this special laptop to restore
> the old (and working) behavior of the intel_backlight device registering.
>
> Fixes: fb1836c91317 ("ACPI: video: Prefer native over vendor")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index aa6196e5e574..64eab35037c3 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -610,6 +610,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
>                 },
>         },
> +       {
> +        .callback = video_detect_force_native,
> +        /* Asus U46E */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "U46E"),
> +               },
> +       },
>         {
>          .callback = video_detect_force_native,
>          /* Asus UX303UB */
> --

Applied as 6.2-rcf material, thanks!
