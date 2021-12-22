Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D047CAF5
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Dec 2021 02:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbhLVBwv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Dec 2021 20:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbhLVBwt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Dec 2021 20:52:49 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04077C06173F
        for <linux-acpi@vger.kernel.org>; Tue, 21 Dec 2021 17:52:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bt1so1737829lfb.13
        for <linux-acpi@vger.kernel.org>; Tue, 21 Dec 2021 17:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PvpXSanHxWA1NlFuLepjdH5cmZWOnCjHjBgKWYYS9CA=;
        b=irdgpDSaEGdOT/kET7iJz/biFGlel/L2LGBeBZmFuhPc1QnXUMW5LrVBkg2t8s47SD
         r9YqZXCBpPfNkMrZLuQMR0CH8H3hjyWy0Fa1pF/EZNEVSAz11mT+fFD8vdBVB6aoYh+N
         CDUy9ZO3yvd/66nBubIF/oFxG11HOI5G8hw9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PvpXSanHxWA1NlFuLepjdH5cmZWOnCjHjBgKWYYS9CA=;
        b=rj7Pille5dXiSr9auvrmwJYHMK3CQHwx7fbTVZtBazj1yE22rtrlqxocuJDyk+Kfn0
         cQwQZvr2Bww+/HDnVt5he8ZrmjEySLYqgCEv9hR0QVUI5IiBFMdcAiX9Y0Q9zpA76jaL
         2HbiiV5kQCXQ2YhcQEKGvFbVPf2UtOzYdUtHpwZ+nBTr69g85KIuBf0U7oIQNpZ+YGPQ
         s+qHd3avM6QoUVptYcNStvyenJdzLgqkoobvz+WtoJk1X3BPDa3KZ5eKDyJw8BR2ougb
         rcIX27aVWhyP5JnK5yUeDsiRYV5BrU5vZUP4XQHMamgnDr0SzZV6H4llRbUvjDCwPe/z
         el2g==
X-Gm-Message-State: AOAM530YIjmToLV24N5WjIe2uKw2MTyaENaBQVuR8bKdZSUYyNERiXgE
        SOjHuIAx5XfYh35b3Gkl6t18Ah4HtjNcw7K4ehw=
X-Google-Smtp-Source: ABdhPJxZD3hQKWPdO53aecDO0ERz2OFzGMDilLdiLemvVbIdadoq4qrZc5SdtbT/TcPhFeVAJYm5KA==
X-Received: by 2002:a05:6512:31d5:: with SMTP id j21mr765235lfe.669.1640137966872;
        Tue, 21 Dec 2021 17:52:46 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s29sm59644lfc.227.2021.12.21.17.52.46
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 17:52:46 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id m12so1232797ljj.6
        for <linux-acpi@vger.kernel.org>; Tue, 21 Dec 2021 17:52:46 -0800 (PST)
X-Received: by 2002:ac2:498c:: with SMTP id f12mr776217lfl.250.1640137540653;
 Tue, 21 Dec 2021 17:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20211220210643.47842-1-pmenzel@molgen.mpg.de> <CAE_wzQ_Lg1ODV5sEqtW=SauhSXxi6+fh3msOuhnJy8-sNtORcg@mail.gmail.com>
 <CABXOdTeNy3jQ5aQijw9HTpwcNvkEJmddz9yf0Mk-Z+78bDDN-A@mail.gmail.com> <8a7fad1b-b34d-88db-2f6b-462303fe03d9@molgen.mpg.de>
In-Reply-To: <8a7fad1b-b34d-88db-2f6b-462303fe03d9@molgen.mpg.de>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Tue, 21 Dec 2021 17:45:24 -0800
X-Gmail-Original-Message-ID: <CAE_wzQ9+esd7WX0hFYVwAyWT_WjywRemPFhyWRmKQpx_4BmfcA@mail.gmail.com>
Message-ID: <CAE_wzQ9+esd7WX0hFYVwAyWT_WjywRemPFhyWRmKQpx_4BmfcA@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: i2c: Add device property for probing
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Guenter Roeck <groeck@google.com>, Wolfram Sang <wsa@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        coreboot@coreboot.org, Matt DeVillier <matt.devillier@gmail.com>,
        Felix Singer <felixsinger@posteo.net>,
        Benson Leung <bleung@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Sangwon Jee <jeesw@melfas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 21, 2021 at 11:42 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Guenter, dear Dmitry,
>
>
> Am 21.12.21 um 17:47 schrieb Guenter Roeck:
> > On Mon, Dec 20, 2021 at 1:49 PM Dmitry Torokhov <dtor@chromium.org> wro=
te:
>
> >> On Mon, Dec 20, 2021 at 1:07 PM Paul Menzel <pmenzel@molgen.mpg.de> wr=
ote:
> >>>
> >>> From: Furquan Shaikh <furquan@google.com>
>
> >>> Google Chromebooks are often built with devices sourced from differen=
t
> >>> vendors. These need to be probed. To deal with this, the firmware =E2=
=80=93 in
> >>> this case coreboot =E2=80=93 tags such optional devices accordingly =
=E2=80=93 I think
> >>> this is commit fbf2c79b (drivers/i2c/generic: Add config for marking
> >>> device as probed) =E2=80=93 and Chromium OS=E2=80=99 Linux kernel has=
 the patch at hand
> >>> applied to act accordingly. Right after the merge, Dmitry created a
> >>> revert, which was actively discussed for two days but wasn=E2=80=99t =
applied.
> >>> That means, millions of devices shipped with such a firmware and Linu=
x
> >>> kernel. To support these devices with upstream Linux kernel, is there=
 an
> >>> alternative to applying the patch to the Linux kernel, and to support
> >>> the shipped devices?
> >>
> >> *sigh* I should have pushed harder, but I see it managed to
> >> proliferate even into our newer kernels. Not having this patch should
> >> not cause any problems, it can only hurt, because the i2c core has no
> >> idea how to power up and reset the device properly. The only downside
> >> of not having this patch is that we may have devices in sysfs that are
> >> not connected to actual hardware. They do now cause any problems and
> >> is how we have been shipping ARM-based devices where we also dual- and
> >> triple-source components. However if we were to have a device that
> >> switches between several addresses (let's say device in bootloader
> >> mode uses 0x10 address and in normal mode 0x20) this "probing" may
> >> result in device not being detected at all.
>
> On google/sarien, the (upstream) Linux kernel sometimes detects the
> Melfas touchscreen and sometimes not, but in never works. When it=E2=80=
=99s
> detected, the errors below are still shown.
>
> ```
> $ grep i2c voidlinux-linux-5.13.19-messages.txt
> [    9.392598] i2c i2c-7: 2/2 memory slots populated (from DMI)
> [    9.393108] i2c i2c-7: Successfully instantiated SPD at 0x50
> [    9.622151] input: MELFAS MIP4 Touchscreen as
> /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-8/i2c-MLFS0000:00/i=
nput/input6
> [    9.657964] cr50_i2c i2c-GOOG0005:00: cr50 TPM 2.0 (i2c 0x50 irq 114
> id 0x28)
> [    9.662309] elan_i2c i2c-ELAN0000:00: supply vcc not found, using
> dummy regulator
> [    9.773244] elan_i2c i2c-ELAN0000:00: Elan Touchpad: Module ID:
> 0x00d6, Firmware: 0x0005, Sample: 0x0009, IAP: 0x0001
> [    9.773349] input: Elan Touchpad as
> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-ELAN0000:00/i=
nput/input7
> [   10.820307] i2c_designware i2c_designware.0: controller timed out
> [   10.820359] mip4_ts i2c-MLFS0000:00: mip4_i2c_xfer - i2c_transfer
> failed: -110 (-110)
> [   11.844523] i2c_designware i2c_designware.0: controller timed out
> [   11.844635] mip4_ts i2c-MLFS0000:00: mip4_i2c_xfer - i2c_transfer
> failed: -110 (-110)
> [   12.868376] i2c_designware i2c_designware.0: controller timed out
> [   12.868488] mip4_ts i2c-MLFS0000:00: mip4_i2c_xfer - i2c_transfer
> failed: -110 (-110)
> [   12.868570] mip4_ts i2c-MLFS0000:00: Failed to read packet info: -110
> ```
>
> Is that related to the probing stuff?

So what happens is that there are Melfas and Elan (i2c-hid)
touchscreens described in DSDT, both sharing the same reset line. So
you get Melfas identified, and then i2c-hid comes along, does not find
anything, and powers off/resets Melfas controller. Unfortunately
coreboot does not implement logic for shared power resources here, so
when I2C core thinks that it is powering off Elan it in fact powers
off an unrelated device.

I wonder if we should offer a language to better describe dual-sourced
components/shared power resources so we would not get into this
situation. I am still curious what powers up the devices in case we
use
i2c_new_scanned_device() path. Is it simply a happenstance? I have a
Sarien with Melfas, I guess I can play with it a bit...

OK, I guess we've built more stuff on top of linux,probed and we will
have to have it if we want to support current Google firmware. We need
to have much stronger wording about what linux,probed property really
means (i.e. we expect the device to be powered up by the firmware,
executing proper power up timing sequence, and not being a "morphing"
device) for this to work reliably.

>
> >> If we wanted to do this correctly, coreboot would have to implement
> >> full power and reset control and also add drivers for I2C controllers
> >> to be able to communicate with peripherals, and then adjust _STA
> >> methods to report "not present" when the device is indeed absent. And
> >> note that even in this case we would have issues with "morphing
> >> devices", so coreboot would also need to know how to reset device out
> >> of bootloader mode, and maybe flash firmware so device can work in
> >> normal mode.
>
> What do you mean by =E2=80=9Cbootloader mode=E2=80=9D?

Modern touch controllers and other peripherals are pretty complex.
They typically have R0 firmware (bootloader) and RW main firmware, and
the controller might end up being in "bootloader" mode if RW firmware
gets corrupted or because of power surge, or something else. Some
controllers (for example Atmel) use different addresses on the bus
when in bootloader mode vs normal mode.

> coreboot also cannot flash
> anything. That=E2=80=99s up to the payload, and even there support for fl=
ashing
> is rare.
>
> Duncan wrote something about the ACPI _STA method idea, that ASL(?) and
> I2C do not go well together.

There would need to be arbitration between OS and firmware when
accessing I2C controllers in this case so indeed this would be hard.
Maybe coreboot would have to pre-scan the peripherals before booting
the OS.

>
> >> However coreboot does (or did?) not want to add code to handle i2c
> >> controllers, and would like to push this knowledge to the kernel. And
> >> the kernel does know how to handle peripherals properly, but that
> >> knowledge lies in individual drivers, not i2c core.
>
> Excuse my ignorance, can you give an example driver? Does the Melfas
> touchscreen driver (`drivers/input/touchscreen/melfas_mip4.c`) support it=
?

Melfas has handling for its reset line, as well as Elan touch
controllers (elants_i2c.c), Atmel (atmel_mxt_ts.c), Raydium, etc.

Thanks,
Dmitry
