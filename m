Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA21A10E97C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2019 12:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLBLV1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Dec 2019 06:21:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42889 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfLBLV1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Dec 2019 06:21:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so27618506lfl.9
        for <linux-acpi@vger.kernel.org>; Mon, 02 Dec 2019 03:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzQY8ysi3fT6Co4/MqtHPbj4fPY/+U/ENbweS9dY9nE=;
        b=pQkNeClTp2cf5DYqzAKqS48zGZdNUDqc9VZ7tpoKCvLUMnWKlkari52Nb79LdNPm8E
         WTOtoAFWCysbP4teqhLKD5GSMyi4zP1zomk2lES0NPpsDpSq6qk5X4Y9PA9/7IiCkthS
         EPGhZxblrCf4u9372E1KKSmCVy/x+2XnKll7AfnCQyoPi/xcuM62orWhXrqdwqDxpAIk
         xTahI+RAIZI7t8z889baVqjk6B+tztSHvaTWDDGP9ow8cc3HRHbHdhJkdACksUPCxfc8
         z27dcPZ6YJfUJ20E0eF0C0Z4pYhqRhMAyyn4RnNjSECWwEimYpST9CdhWXEVNjntMyBx
         0egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzQY8ysi3fT6Co4/MqtHPbj4fPY/+U/ENbweS9dY9nE=;
        b=j4R/Mw9uVWN2/TVHD+Rf9lsoQhR4xIinFlcdaToxupZEPRMZZO10vF/a3OYPB3lyHD
         0mQsKK+5yMxUb3mjr9ciRYYKSflcF0qUxOmiTfSte9BMUhAgfmZ2ZzejCro8SrD2GmfM
         E5vfhZTVSZIlUYYHiVYf4saG97dwCEI/bdktaExSBdru1FIQN0vBTdLmNduopjBWkHbO
         H3SBzCDgfPOSEDUVsamAumdqKqIfoYTO6+bZNIz4BxeIl0XnEsxVbEaWTmVDuFMShd6M
         /XuCZb1wrGTKmKBWzcIdAMGXP2IblTsKXqyXiexNL2XGxDuNrBquJ0tqgAMEmmPEIacY
         6jFQ==
X-Gm-Message-State: APjAAAWfMFW/Snk6O+EPa11VKIKp1o95rabmeO8KnSBravx27T3kBpg3
        ys0yaEFUgcn7GMvm+gnp6PwupTtmSBf2eliZWfQdSrJursVWvQ==
X-Google-Smtp-Source: APXvYqxizDsV6syxLFSpMOqZGIeczavEByhmdDXOVDNV4RRu+SUnOftHbEdPa0gGND2j61UuSk/iw7O6dhtfU4+t6Zk=
X-Received: by 2002:a19:f701:: with SMTP id z1mr37022370lfe.133.1575285684598;
 Mon, 02 Dec 2019 03:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20191129185836.2789-1-hdegoede@redhat.com> <20191129185836.2789-3-hdegoede@redhat.com>
In-Reply-To: <20191129185836.2789-3-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Dec 2019 12:21:13 +0100
Message-ID: <CACRpkdbRb-LF2tNN-ueo=tKuJc+u4B7Y20+BCyqnN7wYbm8y7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/i915/vlv_dsi: Control panel and backlight enable
 GPIOs on BYT
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

thank you for your patch!

On Fri, Nov 29, 2019 at 7:58 PM Hans de Goede <hdegoede@redhat.com> wrote:

> -       /* GPIO Desc for CRC based Panel control */
> +       /* GPIO Desc for panel and backlight control */
>         struct gpio_desc *gpio_panel;
> +       struct gpio_desc *gpio_backlight;

I think what happens here is that you reimplement
drivers/video/backlight/gpio_backlight.c

The existing power control GPIO also reimplements
drivers/regulator/fixed.c in a sense but I am under the
impression that x86 in general and ACPI in particular
has a problem with the regulator subsystem so I am
uncertain about that one.

When I look at the code I get more confused because
nominally panels should have their own drivers in
drivers/gpu/drm/panel/* especially DSI panels, and the
panels control their own GPIOs or regulators for power
and backlight.

I was under the impression that Heikki's and Dmitry's
recent additions to software nodes would make it
possible to actually spawn devices like the GPIO backlight
and/or fixed regulator and put references to them so
that the drivers can pick them up from the respective
frameworks and manage them?

Maybe I misunderstood things here though, I am a bit
under the impression that elder DRM drivers are
considered "elder gods" and do not need to use separate
panel drivers, backlight abstraction etc, and in that
case just go ahead, I guess.

But I suspect some separation
would help the day the i915 driver wants to reuse some
really complex DSI panel from drivers/gpu/drm/panel/*
though.

Yours,
Linus Walleij
