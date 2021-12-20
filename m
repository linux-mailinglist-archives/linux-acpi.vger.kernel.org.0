Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7E47B55E
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Dec 2021 22:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhLTVtc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Dec 2021 16:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhLTVtb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Dec 2021 16:49:31 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6060EC06173E
        for <linux-acpi@vger.kernel.org>; Mon, 20 Dec 2021 13:49:31 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 207so18128667ljf.10
        for <linux-acpi@vger.kernel.org>; Mon, 20 Dec 2021 13:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gfwB1Y7WC9PzSYQgy+aXs+dGdxRfl9cHOHvCWDuJnkU=;
        b=kDYD5ludLUCahkPbmHfYN+HOIKqU686radMmzyGW8pUbmGj5NrZtro7jjcNPRgkIm7
         Yf3HEeLzUG9wx5jj/mh775SCi0vaUmjBjKqI4B5v3Q+0PoiAeyM7ND7UKLaPOCLECo9W
         T6TaMrlpAudBkc6EXUhIKgEZOxxxTUd97O0N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gfwB1Y7WC9PzSYQgy+aXs+dGdxRfl9cHOHvCWDuJnkU=;
        b=ZS+AoVhif/1aADUEZ47HcIs976mVl9O7pqH6kKNi6I/ia0tHZ2WXmMgf3uaBpXA72J
         lSWdlH4yCVD55mLeFow9H74P6z/VfECEOHdZ+S7VbINANtPNhmmwYAmfy6GIRnRKcouc
         ykiXW3HXv/AT11Wj5LJeNeDL822QbMxfwfBhjm28NFIF2MtVj+0rxWn4/5GjwIbDV2qX
         j3T8jGTpZRFUGW1tmrrZCpR0wfw2bPgLkhaFnn6q1hzhTM/6hitqONI9EvQ9Aqte9tCq
         TgtgdJUS6IcLa1xD4NDRxwVLK9kdlovzqyGtx2yLAPIHHexjVww0Cvcx0rqoenup+eS4
         0A1Q==
X-Gm-Message-State: AOAM533sZrcRodm8V/uoCgMGae1zquQDCO6S681zzNbPEf2oQKCMTMGJ
        saVVFruSDWSb+R6pLH38mPk4dSKspgAvVJrL
X-Google-Smtp-Source: ABdhPJwK1c15LDvNfhMe4pRHtx2IJHgbAy4CWdq1mVVXPTXlEX5ET/LFrH6X8Y33m+BOiweaCxBfuw==
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr48206ljp.362.1640036969279;
        Mon, 20 Dec 2021 13:49:29 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id b10sm885125lfb.107.2021.12.20.13.49.26
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 13:49:27 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id k23so18192267lje.1
        for <linux-acpi@vger.kernel.org>; Mon, 20 Dec 2021 13:49:26 -0800 (PST)
X-Received: by 2002:a2e:8848:: with SMTP id z8mr17346ljj.429.1640036966379;
 Mon, 20 Dec 2021 13:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20211220210643.47842-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20211220210643.47842-1-pmenzel@molgen.mpg.de>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Mon, 20 Dec 2021 13:49:10 -0800
X-Gmail-Original-Message-ID: <CAE_wzQ_Lg1ODV5sEqtW=SauhSXxi6+fh3msOuhnJy8-sNtORcg@mail.gmail.com>
Message-ID: <CAE_wzQ_Lg1ODV5sEqtW=SauhSXxi6+fh3msOuhnJy8-sNtORcg@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: i2c: Add device property for probing
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        coreboot@coreboot.org, Matt DeVillier <matt.devillier@gmail.com>,
        Felix Singer <felixsinger@posteo.net>,
        Duncan Laurie <dlaurie@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Paul,

On Mon, Dec 20, 2021 at 1:07 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> From: Furquan Shaikh <furquan@google.com>
>
> Dear Linux folks,
>
>
> Google Chromebooks are often built with devices sourced from different
> vendors. These need to be probed. To deal with this, the firmware =E2=80=
=93 in
> this case coreboot =E2=80=93 tags such optional devices accordingly =E2=
=80=93 I think
> this is commit fbf2c79b (drivers/i2c/generic: Add config for marking
> device as probed) =E2=80=93 and Chromium OS=E2=80=99 Linux kernel has the=
 patch at hand
> applied to act accordingly. Right after the merge, Dmitry created a
> revert, which was actively discussed for two days but wasn=E2=80=99t appl=
ied.
> That means, millions of devices shipped with such a firmware and Linux
> kernel. To support these devices with upstream Linux kernel, is there an
> alternative to applying the patch to the Linux kernel, and to support
> the shipped devices?

*sigh* I should have pushed harder, but I see it managed to
proliferate even into our newer kernels. Not having this patch should
not cause any problems, it can only hurt, because the i2c core has no
idea how to power up and reset the device properly. The only downside
of not having this patch is that we may have devices in sysfs that are
not connected to actual hardware. They do now cause any problems and
is how we have been shipping ARM-based devices where we also dual- and
triple-source components. However if we were to have a device that
switches between several addresses (let's say device in bootloader
mode uses 0x10 address and in normal mode 0x20) this "probing" may
result in device not being detected at all.

If we wanted to do this correctly, coreboot would have to implement
full power and reset control and also add drivers for I2C controllers
to be able to communicate with peripherals, and then adjust _STA
methods to report "not present" when the device is indeed absent. And
note that even in this case we would have issues with "morphing
devices", so coreboot would also need to know how to reset device out
of bootloader mode, and maybe flash firmware so device can work in
normal mode.

However coreboot does (or did?) not want to add code to handle i2c
controllers, and would like to push this knowledge to the kernel. And
the kernel does know how to handle peripherals properly, but that
knowledge lies in individual drivers, not i2c core.

We should remove "linux,probed" from coreboot and not propagate to
newer Chrome OS kernels, and keep it away from upstream.

Thanks,
Dmitry
