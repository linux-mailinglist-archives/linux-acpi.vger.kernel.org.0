Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7E10E9D0
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2019 12:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLBLxO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Dec 2019 06:53:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:31447 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfLBLxO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Dec 2019 06:53:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 03:53:13 -0800
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="204529220"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 03:53:08 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list\:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list\:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/i915/vlv_dsi: Control panel and backlight enable GPIOs on BYT
In-Reply-To: <CACRpkdbRb-LF2tNN-ueo=tKuJc+u4B7Y20+BCyqnN7wYbm8y7Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191129185836.2789-1-hdegoede@redhat.com> <20191129185836.2789-3-hdegoede@redhat.com> <CACRpkdbRb-LF2tNN-ueo=tKuJc+u4B7Y20+BCyqnN7wYbm8y7Q@mail.gmail.com>
Date:   Mon, 02 Dec 2019 13:53:04 +0200
Message-ID: <87wobfj65b.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 02 Dec 2019, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi Hans,
>
> thank you for your patch!
>
> On Fri, Nov 29, 2019 at 7:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
>> -       /* GPIO Desc for CRC based Panel control */
>> +       /* GPIO Desc for panel and backlight control */
>>         struct gpio_desc *gpio_panel;
>> +       struct gpio_desc *gpio_backlight;
>
> I think what happens here is that you reimplement
> drivers/video/backlight/gpio_backlight.c
>
> The existing power control GPIO also reimplements
> drivers/regulator/fixed.c in a sense but I am under the
> impression that x86 in general and ACPI in particular
> has a problem with the regulator subsystem so I am
> uncertain about that one.
>
> When I look at the code I get more confused because
> nominally panels should have their own drivers in
> drivers/gpu/drm/panel/* especially DSI panels, and the
> panels control their own GPIOs or regulators for power
> and backlight.
>
> I was under the impression that Heikki's and Dmitry's
> recent additions to software nodes would make it
> possible to actually spawn devices like the GPIO backlight
> and/or fixed regulator and put references to them so
> that the drivers can pick them up from the respective
> frameworks and manage them?
>
> Maybe I misunderstood things here though, I am a bit
> under the impression that elder DRM drivers are
> considered "elder gods" and do not need to use separate
> panel drivers, backlight abstraction etc, and in that
> case just go ahead, I guess.
>
> But I suspect some separation
> would help the day the i915 driver wants to reuse some
> really complex DSI panel from drivers/gpu/drm/panel/*
> though.

Sadly I don't think that's going to happen, though.

For i915 the panels are described by VBT, or Video BIOS Tables. We don't
really know the make or model of the panels, we just get the timings and
sequences etc. from there. There's no info to probe a separate panel
driver. So we just have a "generic" DSI driver that's part of i915 which
uses the data from the VBT to drive all the possible panels.

We do use some of the drm DSI framework as a library to abstract things
a bit better, but that's about it.

The sequences should include details about GPIOs to toggle as well, so
in that sense I feel like the gpio calls should be bolted there.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
