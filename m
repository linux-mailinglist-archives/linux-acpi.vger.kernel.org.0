Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79907671FC3
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jan 2023 15:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjAROh4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Jan 2023 09:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjAROhj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2023 09:37:39 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86959744
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2023 06:26:49 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id j185so4756044vsc.13
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2023 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqqi0GQK72eWatBF5iXQ8orjIM5rhkb0842NAyd7NO4=;
        b=HCBXy9lEZdNqqZezNdXa5R1YwPrZy6tl5PP5t2eD/lvD+coeSVqtK6+ajYbBSS+4Ao
         71bd8ZGQY3psoI7VIVI9KNgBY2BRrVK8LM9JfJTNIG5p3sBU2JkH73GrbepCIyxHzHw2
         QHdHn42XFKBUiRZcwnZZG7IfnMcpduia2QxBo7DU8tKMkzIe7hjJu/oWGeiG5aIizkBq
         r5KPbUse5duP1eD0ewKlV1SkkikWE5NilH4EtI1VTNJn1fMBFEcBT+A7WNt3kh3Qiqin
         xCpBt9jj6naEztaF+kEh8RvBliq3GG/rYrxlNGDqZi/w4NXlbzKvjj5IgqhD3yIvdF4/
         6OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lqqi0GQK72eWatBF5iXQ8orjIM5rhkb0842NAyd7NO4=;
        b=k2o+vMXhptehM67PZYUPeYnmMQNFUw+lA7K0qWepaV9YHtIA2PX7z3j9uanJM62X8d
         3fI8kY/8q/Y80ltVxrrjGFqQlWm2u6PRdj8v5Qzc8dAviJ7M8K+ZNjOJq2PbRoXx+O7O
         AtQAo4seRGtKwhlNJ6dsuHh2hTTgSPnBEhRvX03+sCqwB2iHS6LcJhxwdPzPm2GPLDSf
         vV9yaKlU8wFaFfSZUkbB6q2Sqdt6TcIgLWvVFrCxhgJFNCvQdD0pzg3ydKFHGAWC/ZrE
         gfFzkA8qzcBVMyf7H4MaAAHeDXI8H29QaX5oA1MYDja4rzpaERgAUB4Vmo4taBhMk1SD
         y+9w==
X-Gm-Message-State: AFqh2krPhFKQjzASd+8U07tgI0+4t5Kfl4Djakoe5BpE/LW9ZqtTGyeF
        IR0fBfyb50rKYaIgZ6XfOwkC8oStcfTzO2BYiDzIqw==
X-Google-Smtp-Source: AMrXdXvqsnUIUZ4tgMYk35KxtchmNg5II+5n7fzSAq5kmnbRxWa8736Kzje9pVpcxADmzMR8BCAAR/gytLy14cjL4CU=
X-Received: by 2002:a67:c387:0:b0:3d2:3577:2d05 with SMTP id
 s7-20020a67c387000000b003d235772d05mr892021vsj.9.1674052008373; Wed, 18 Jan
 2023 06:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20230116193702.31356-1-mario.limonciello@amd.com> <20230116193702.31356-3-mario.limonciello@amd.com>
In-Reply-To: <20230116193702.31356-3-mario.limonciello@amd.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 18 Jan 2023 15:26:37 +0100
Message-ID: <CAMRc=MenxV6Nt3cyLPvPJXVDe6T1s2zeQ_ZszW8rrVwJbW0pXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xRU
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        regressions@lists.linux.dev,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 16, 2023 at 8:37 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> changed the policy such that I2C touchpads may be able to wake up the
> system by default if the system is configured as such.
>
> However on Clevo NL5xRU there is a mistake in the ACPI tables that the
> TP_ATTN# signal connected to GPIO 9 is configured as ActiveLow and level
> triggered but connected to a pull up. As soon as the system suspends the
> touchpad loses power and then the system wakes up.
>
> To avoid this problem, introduce a quirk for this model that will prevent
> the wakeup capability for being set for GPIO 9.
>
> Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> Reported-by: Werner Sembach <wse@tuxedocomputers.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 4287555a12408..9ef0f5641b521 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1623,6 +1623,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>                         .ignore_interrupt = "AMDI0030:00@18",
>                 },
>         },
> +       {
> +               /*
> +                * Spurious wakeups from TP_ATTN# pin
> +                * Found in BIOS 1.7.8
> +                * https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
> +                */
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +               },
> +               .driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +                       .ignore_wake = "ELAN0415:00@9",
> +               },
> +       },
>         {} /* Terminating entry */
>  };
>
> --
> 2.34.1
>

Queued for fixes, thanks!

Bart
