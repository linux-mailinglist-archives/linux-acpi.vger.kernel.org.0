Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671D910ECA1
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2019 16:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfLBPtY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Dec 2019 10:49:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31356 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727509AbfLBPtY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Dec 2019 10:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575301762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BckxIR8B8BRMaMS0XFEan4pdnPP5uhBwBvuJccFnJ8Q=;
        b=A61CqwShmC5423Udy7o9aOqq/6lNsJ2NYVfdPVQfdO2ajWgR5P1gRvWIrAXk1c6Rzt/gcJ
        /zEuETi06nZe/Op5g7nbY6KSGqgmjz9m1bNeAXYu2rqboVX6mMzKHT3r68KrkftXaLQDGm
        NqUQKo2FZ4WbZEPa+6MN2xqvo6R3Auo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-oXMYdmrZOq2GzMzqgqbp9Q-1; Mon, 02 Dec 2019 10:49:22 -0500
Received: by mail-wr1-f69.google.com with SMTP id b13so114946wrx.22
        for <linux-acpi@vger.kernel.org>; Mon, 02 Dec 2019 07:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BckxIR8B8BRMaMS0XFEan4pdnPP5uhBwBvuJccFnJ8Q=;
        b=gEH/7IZdrulefWtgXQzUBlY5ubh+aWcb1lkUdH9yNBG/Kr3Yey0hwdDpRvj9ISFSYQ
         Ws3F/U/uU13cwEX98Ph6BeAGr5wposxU+fEkxqL23pr2CyPel7lNoiWbV0alBr44rrn/
         JNRhm3eJKS9h/wex/MJFwOM57NSvC9Id+xZwXYtYxJ2F+PULqJQ4RZXKHjFpgy7QhtIV
         fcjVxGzG0yHNqOyRqxW+YuSYPEIngUAJ2Aqy6r4Xskp7MCBBJEbCCEoyn+POSB2hj4Ri
         RTytHRlr5MYBzWPIqclq8fFh/K4cK2R9agVz3cgugn636h2rtu5hkO30GQwZLG0ACTlJ
         5D9w==
X-Gm-Message-State: APjAAAUkr6NnI0jXFPXZvVrOtSG/7XHr5HXydJFbvBmHLyoJGxI/c/vv
        RBO0rDMf61QnW5fKKyfkjk/tYR/flAdrhNKknFjTKKGnAKX8cmZXTosMgmUSgo61AKlDAeX6aNp
        IHz+A2rq4PU4LP24zfTTAaQ==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr6456718wru.382.1575301760249;
        Mon, 02 Dec 2019 07:49:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbHZlEWNG5Tykxe0xX+zM5Eoc9OUvf0CW0XqAwtTuft7mCuNUQ/uAHoVleCkgr1rQJLPOzqw==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr6456671wru.382.1575301759962;
        Mon, 02 Dec 2019 07:49:19 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h97sm43564707wrh.56.2019.12.02.07.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 07:49:19 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/i915/vlv_dsi: Control panel and backlight enable
 GPIOs on BYT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20191129185836.2789-1-hdegoede@redhat.com>
 <20191129185836.2789-3-hdegoede@redhat.com>
 <CACRpkdbRb-LF2tNN-ueo=tKuJc+u4B7Y20+BCyqnN7wYbm8y7Q@mail.gmail.com>
 <87wobfj65b.fsf@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <47c36b75-bc30-502b-7f8d-035cf2348fc4@redhat.com>
Date:   Mon, 2 Dec 2019 16:49:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87wobfj65b.fsf@intel.com>
Content-Language: en-US
X-MC-Unique: oXMYdmrZOq2GzMzqgqbp9Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

HI,

On 02-12-2019 12:53, Jani Nikula wrote:
> On Mon, 02 Dec 2019, Linus Walleij <linus.walleij@linaro.org> wrote:
>> Hi Hans,
>>
>> thank you for your patch!
>>
>> On Fri, Nov 29, 2019 at 7:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>>> -       /* GPIO Desc for CRC based Panel control */
>>> +       /* GPIO Desc for panel and backlight control */
>>>          struct gpio_desc *gpio_panel;
>>> +       struct gpio_desc *gpio_backlight;
>>
>> I think what happens here is that you reimplement
>> drivers/video/backlight/gpio_backlight.c
>>
>> The existing power control GPIO also reimplements
>> drivers/regulator/fixed.c in a sense but I am under the
>> impression that x86 in general and ACPI in particular
>> has a problem with the regulator subsystem so I am
>> uncertain about that one.
>>
>> When I look at the code I get more confused because
>> nominally panels should have their own drivers in
>> drivers/gpu/drm/panel/* especially DSI panels, and the
>> panels control their own GPIOs or regulators for power
>> and backlight.
>>
>> I was under the impression that Heikki's and Dmitry's
>> recent additions to software nodes would make it
>> possible to actually spawn devices like the GPIO backlight
>> and/or fixed regulator and put references to them so
>> that the drivers can pick them up from the respective
>> frameworks and manage them?
>>
>> Maybe I misunderstood things here though, I am a bit
>> under the impression that elder DRM drivers are
>> considered "elder gods" and do not need to use separate
>> panel drivers, backlight abstraction etc, and in that
>> case just go ahead, I guess.
>>
>> But I suspect some separation
>> would help the day the i915 driver wants to reuse some
>> really complex DSI panel from drivers/gpu/drm/panel/*
>> though.
> 
> Sadly I don't think that's going to happen, though.
> 
> For i915 the panels are described by VBT, or Video BIOS Tables. We don't
> really know the make or model of the panels, we just get the timings and
> sequences etc. from there. There's no info to probe a separate panel
> driver. So we just have a "generic" DSI driver that's part of i915 which
> uses the data from the VBT to drive all the possible panels.
> 
> We do use some of the drm DSI framework as a library to abstract things
> a bit better, but that's about it.
> 
> The sequences should include details about GPIOs to toggle as well, so
> in that sense I feel like the gpio calls should be bolted there.

Hmm, yes that makes sense, the problem really is that the VBT sequences
for DSI panels on BYT are incomplete (*) and the MIPI_SEQ_POWER_ON / _OFF
and MIPI_SEQ_BACKLIGHT_ON / _OFF sequences do not containt the
"instructions" to toggle the panel-enable, resp. backlight enable
GPIOs as they do on CHT and newer devices.

So if we see all this of a shortcoming of the VBT tables, then it makes
sense to move all special handling for this to intel_dsi_vbt.c, so we
put the adding of the lookup table, the getting of the pins and the
controlling of the pins all in there.

Jani, is that what you have in mind ?

This would also solve the problem of Linus and Andy not liking the
polution of the pinctrl driver with the adding of the platform
specific lookups; and then we could only add the lookups when the
VBT says the SoC is used for backlight control, leaving things
as is (not even adding the lookups) when the PMIC is used for
backlight control.

There is only one problem, currently is is not possible to
unregister a mapping added with pinctrl_register_mappings
and the i915 driver is typically a module which can be unloaded
and I believe actually is unloaded as part of the i915 CI.

pinctrl_register_mappings copies the passed in mapping, but
it is a shallow copy, so it contains pointers to the modules
const segment and we do not want to re-add another copy of
the mapping when the module loads a second time.

Fixing this is easy though, there already is a pinctrl_unregister_map()
function, we just need to export it so that the i915 driver can
remove the mapping when it is unbound.

Linus would exporting this function be ok with you?

Linus, question what is the purpose of the "dupping" / shallow
copying of the argument passed to pinctrl_register_map ? Since
it is shallow the mem for any pointers contained within there need
to be kept around by the caller, so why not let the caller keep
the pinctrl_map struct itself around too?

If we are going to export pinctrl_unregister_map() we need to make it
do the right thing for dupped maps too, we can just store the dup flag
in struct pinctrl_maps. So this is easy, but I wonder if we cannot
get rid of the dupping all together ?

Regards,

Hans




*) I suspect these are all version 2 VBT sequences (I guess I should check
this) and according to the comment in vlv_dsi.c which documents the sequences,
for v2 these sequences are not used, e.g. instead of executing the
MIPIPanelPowerOn sequence the "panel-on" step is described simply as "power on".
and the MIPIBacklightOn/Off sequences are described as being VBT v3+ only

