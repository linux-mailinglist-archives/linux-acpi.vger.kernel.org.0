Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6C119FDC
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2019 01:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLKAYV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 19:24:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39963 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfLKAYV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 19:24:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id s22so21929030ljs.7
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2019 16:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzptMs7UZH6tl5XnB4UdAl95BzHbDkNlnuDcD9QRDL8=;
        b=cLhiqiuP6lKc2NY83ihPT47G3f+3QK4gZxKFKmw65nI/bJUTPbL1OjQ3/4EllNePCM
         OBINPY2S7VQ49MkrBdTCMtAjDl6tcNokO7M8rS2kQtWpfU0g+d3zdtKiOMkYGsyKmOr8
         JkZOg0YTxCt4YVjkOhCNImrhQDKtSjw6qYJNLuE8MQtu9GkRGEiq08YmpoX0yD2p5qPQ
         D/sdqJRrkY1E0EaTMYyDhsblV9geNYlSdkpSKp8bRuByL3iYs0NdjZbsWTlKq1WwXOPo
         kiJ8wMZb9xBnMw9ZnPAq1XrFyhqAluKOJjgBE0OSi8dd4m32SO0dsx7U/6aP4NqAZLoN
         MH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzptMs7UZH6tl5XnB4UdAl95BzHbDkNlnuDcD9QRDL8=;
        b=lLJYKYlhT1XE116MElQ6tQiVpHTrMFkhx63Q+aHt5ssVJhYexWHwN0whdQIdppJkpq
         WotmTG/nEKqm8rYcZ79Wn1Msi/V++9eelA1uLTRfikSTlANQPok7FKkftJNm8xea540D
         hg42vmQaLzsT6fehTIijhyLzIjfi3iSdEx0uGVSvheepdhFMFRLbQr39onqbsT7o6YQe
         oCrc1FpLFCJdBdhDBAQ2zKwzaOSZ46NXlzIHTeDrBbWYNPKVw1aMmneU1XsF0CysX4Au
         n0ZHMol800FFxiJoQA8Nh7bfujOz2OB2xHDdjhzWvMg0h83gYfhHHsHa1Ob37LV1kHLZ
         v+3Q==
X-Gm-Message-State: APjAAAUHlkugzmbho1kJUH8SUYaUhKjS03oC7iWv8KvP/GZxhR6UfZ/7
        svL7KJNqvLPZl2T7ujouvypdul6jLfvXsK5nJQvL1g==
X-Google-Smtp-Source: APXvYqxunEspa1cPku2zi+O3v5VP7+hdM/iiNVHSELvrW9FMmlBlF5UcunUZT+DJ74s0UyP/7ItRKxU/YAJNU6q4iw0=
X-Received: by 2002:a2e:9587:: with SMTP id w7mr74491ljh.42.1576023859174;
 Tue, 10 Dec 2019 16:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20191129185836.2789-1-hdegoede@redhat.com> <20191129185836.2789-3-hdegoede@redhat.com>
 <CACRpkdbRb-LF2tNN-ueo=tKuJc+u4B7Y20+BCyqnN7wYbm8y7Q@mail.gmail.com>
 <87wobfj65b.fsf@intel.com> <47c36b75-bc30-502b-7f8d-035cf2348fc4@redhat.com>
In-Reply-To: <47c36b75-bc30-502b-7f8d-035cf2348fc4@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 01:24:07 +0100
Message-ID: <CACRpkdaJGZsJpYu3cgQCeWuJD1y9CQyzuk_VYfGfAT8WC=_1VA@mail.gmail.com>
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

On Mon, Dec 2, 2019 at 4:49 PM Hans de Goede <hdegoede@redhat.com> wrote:

> There is only one problem, currently is is not possible to
> unregister a mapping added with pinctrl_register_mappings
> and the i915 driver is typically a module which can be unloaded
> and I believe actually is unloaded as part of the i915 CI.
>
> pinctrl_register_mappings copies the passed in mapping, but
> it is a shallow copy, so it contains pointers to the modules
> const segment and we do not want to re-add another copy of
> the mapping when the module loads a second time.
>
> Fixing this is easy though, there already is a pinctrl_unregister_map()
> function, we just need to export it so that the i915 driver can
> remove the mapping when it is unbound.
>
> Linus would exporting this function be ok with you?

Yep!

> Linus, question what is the purpose of the "dupping" / shallow
> copying of the argument passed to pinctrl_register_map ?

The initial commit contained this comment later removed:

+       /*
+        * Make a copy of the map array - string pointers will end up in the
+        * kernel const section anyway so these do not need to be deep copied.
+        */

The use was to free up memory for platforms using boardfiles
with a gazillion variants and huge pin control tables, so these
could be marked  __initdata and discarded after boot.
As the strings would anyway stay around we didn't need to
deep copy.

See for example in arch/arm/mach-u300/core.c
static struct pinctrl_map __initdata u300_pinmux_map[]

> Since
> it is shallow the mem for any pointers contained within there need
> to be kept around by the caller, so why not let the caller keep
> the pinctrl_map struct itself around too?

So the strings will be kept around because the kernel can't get
rid of strings. (Yeah it is silly, should haven been fixed ages
ago, but not by me, haha :)

> If we are going to export pinctrl_unregister_map() we need to make it
> do the right thing for dupped maps too, we can just store the dup flag
> in struct pinctrl_maps. So this is easy, but I wonder if we cannot
> get rid of the dupping all together ?

Maybe ... I don't know. What do you think? I suppose you could
make u300 crash if you do that.

Yours,
Linus Walleij
