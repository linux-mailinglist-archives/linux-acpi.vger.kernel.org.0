Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4710E99B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2019 12:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLBLkA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Dec 2019 06:40:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42487 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfLBLkA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Dec 2019 06:40:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so27664132lfl.9
        for <linux-acpi@vger.kernel.org>; Mon, 02 Dec 2019 03:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AXdWyFAclFn13sYq0pMWe+evKU32jvfVEFicCGuVwY=;
        b=X/Fh8vTd858T4fJqkrWSfForEze8ojEa3X1bRGcK0nqZXBG+9kxs9RGPa0AR50CzI7
         4PJkYH4WzO5ravUIXPqtvt+RQjCCNoduD0UVGXrjqrF+U9cXukY8HPMLXRZvBsiU3Juy
         c/HKNvcTVoljWSsN0A6S4Iy0ZTWB0DByymPl5BfRTGEpeR6hNCcTha9QzPKBap6a6Zb2
         jGLaCDwtWadYDtdFh7Sg+iOic31Pu2s5K+fFAu2OjUD1XkpfYHNIJTHcTMZpC7yoKSXN
         KtXkcIT8WeMxT5HtA12ZlWblRCJlJNLyJu4rljttptX+0VRpkNYmU/xb2Tmr6/45JlCs
         KQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AXdWyFAclFn13sYq0pMWe+evKU32jvfVEFicCGuVwY=;
        b=aYpHqV8dCaxxoccqP4FerXRbMywKDRmv73VKt2vOG7QS/D/whjOZXc1NpX3FBOu9PP
         aNdG6b14N4mXcJ+2OEQTszo2rqvEHMLHvu+b3yFI19l4G40FupXi+Z6e86OtPSxZCSPi
         KGE++WeEGBoUrFWBT0Sur2HKpcdKBvDhBVavoAvg2SwCQA5S1vQt7tWq1GaEBkUUuTJ/
         1yXemEAQBWNRoqcJrE3Jw7uWgOlRbOlwsJ0mWaN4ipQJmDh/2T3MMGoB7mMxFiny7+bv
         HeGzJU3+60SEUaadYnIz6SnfdDxN1TMWD9ikRCnyvuT7P110CSk1n3VtEZ/id4u/XIHs
         tMtA==
X-Gm-Message-State: APjAAAVgFZgsXVwYYOhsu+VTjpn4yLqeTsmgOuvqcB1PyKCgk0Tp0Zpw
        ad7opw8YugLa2y35OA6bmmN9aObCOcuAEV3OzxTCXg==
X-Google-Smtp-Source: APXvYqx2Wc0CWurXekKEoRooxu6BjHTqZX5eqMTporx3hixdjbyvTWmDISPC0k/mqp1/gmeglDUYzSFsw3VmDEKZxKU=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr15580087lfi.135.1575286798112;
 Mon, 02 Dec 2019 03:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20191129185836.2789-1-hdegoede@redhat.com> <20191129185836.2789-2-hdegoede@redhat.com>
In-Reply-To: <20191129185836.2789-2-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Dec 2019 12:39:45 +0100
Message-ID: <CACRpkda9jLpGaQTVco4QyXQKPs3ZODbRb58fPfcAodnxR_s4zA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: baytrail: Add GPIO lookup and pinctrl-map
 for i915 DSI panel ctrl
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

Hi Hans!

Thanks for your patch!

On Fri, Nov 29, 2019 at 7:58 PM Hans de Goede <hdegoede@redhat.com> wrote:

> On Bay Trail devices the MIPI power on/off sequences for DSI LCD panels
> do not control the LCD panel and backlight GPIOs. So far we have been
> relying on these GPIOs being configured as output and driven high by
> the Video BIOS (GOP) when it initializes the panel.
>
> This does not work when the device is booted with a HDMI monitor connected
> as then the GOP will initialize the HDMI instead of the panel, leaving the
> panel black, even though the i915 driver tries to output an image to it.
>
> Likewise on some device-models when the GOP does not initialize the DSI
> panel it also leaves the mux of the PWM0 pin in generic GPIO mode instead
> of muxing it to the PWM controller.
>
> This commit adds GPIO lookups and a pinctrl-map which the i915 driver can
> use to get the panel- and backlight-enable GPIOs and to mux the PWM0 pin
> to the PWM controller.
>
> Note it may seem a bit weird to add a pinctrl-map for the i915 driver,
> so that it can set the PWM0 pinmux. Doing this from the LPSS PWM driver
> would be more logical. But the only thing telling us that the pin should
> definitely be muxed to the PWM controller is the VBT to which the PWM
> driver does not have access.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
(...)

The code setting up the pinctrl map and the GPIO machine
descriptor essentially looks good to me.

This looks a bit weird:

+       if (soc_data == &byt_score_soc_data) {

Can you do this with explicit platform ID string
comparison instead?

if (!strcmp(soc_data->uid, BYT_SCORE_ACPI_UID)) { ...

It seems more appropriate to me.

What is puzzling is the placement inside the pinctrl driver:
normally the thing that spawns the devices on the platform
such as the "byt_gpio" should register this table too.

However I see that the device comes from the ACPI match.

Two questions:

- Is this one of those cases where ACPI "should have
  thought of this" (a common phrase) and we have to mop
  up the mess in the kernel because ACPI didn't and now
  we have to quirk around it?

- Can we in that case handle this with a "boardfile" of
  quirks under say drivers/platform where we register
  some extra stuff rather than inside the pinctrl driver?

It sort of connects to the other review comments where
I feel we should be spawning gpio backlight devices from
somewhere.

I understand those things may be a bit big, if the intel
pinctrl maintainers are fine with this solution I am fine
with it too, it's not like it is the biggest deal, I am just worried
that we might be stockpiling these quirks all over the place
while they should perhaps be centralized.

Yours,
Linus Walleij
