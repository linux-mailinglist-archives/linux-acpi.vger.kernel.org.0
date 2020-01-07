Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FDD13252D
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2020 12:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgAGLuu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jan 2020 06:50:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44779 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgAGLuu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jan 2020 06:50:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id u71so54377010lje.11
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jan 2020 03:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFsSM6vxEydUs02gD1XbE7gcNfWrUkov42GXmL/B/g4=;
        b=UgZQmucPLWkmL6jVn+2bdRf8+0/tT1LQC8SCfASVMPN3ceCLoNrSJE96uAaxDXt/Zu
         0Hbo5G+pbUeUM6GbbhF1YlxQarR7l4+JqZEmF5905YYykk8rHxtLD58wHt+ShBjRK912
         LJZivrqsEFdbg4bAnOqjO2Q5Dkrwywm8kzc8yTsjFMVi37R8wmbW/DYGysjNHy4SK2V1
         6E88aVpieRgKBp+RpdgjcTtmatxzcC+kMjHuHNsH36cRdiq/F2czCfYVTCL1xfJ+lsG+
         W0ATtxjMQzJWiHW7Ex0twfEwGwjoh2cACHL5CRlSeBOncj4WUca2GyKrhrx05SE6vl80
         dRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFsSM6vxEydUs02gD1XbE7gcNfWrUkov42GXmL/B/g4=;
        b=QB5U+mWxPiH2jwcelRH9YS6bsJolCIkUdia7NUpiYpOUtrreQwT7bEzq6EeV/S03GD
         KEm8EtcPlezxm2i6xT9nKtQJQZ0bMX54hpKZNbfr+fZ9eLvgMnvEuB/rUe6IMa9W4wpc
         TYOZuSNAXoLUYzP1vzWU7vfuDjvHFVfGKYjAWDrYKcZac/WeImUoUzY/BGA/6JwD7D56
         1SXm9PRQWX3J9iF02kKSPfABEKNd7nGMa7YQ0G0PlodWM/BpzUeQ91Kf3ExyEH3pC+GQ
         1AE8IDb2xUvjij1SVQxXgQKiVCvNssYh2Z8eSuMESjmw2fGZqkDzCYzFdUChBc9fehAj
         DYcw==
X-Gm-Message-State: APjAAAU5yKQNfRCeF7mc5TE8O3hVxSHwp16X6w/ZtxnYuPvXYfT2Ls1P
        yTQb5EaktMaFunnz5/3/84ABew3/vkYucwWgySahatHeC90=
X-Google-Smtp-Source: APXvYqzqbaKvZ9Puh8J+kZVQvq2lpgj8PQt1Pkad+wgIKlI0vpiAAtUqurvSdYL9m9Fvp0HSudCVCKDTbQrmH6PpsH8=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr64319128ljm.218.1578397848306;
 Tue, 07 Jan 2020 03:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20200101145243.15912-1-hdegoede@redhat.com>
In-Reply-To: <20200101145243.15912-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 12:50:36 +0100
Message-ID: <CACRpkdbTunsVtgGw5=ksn=cn+ZwYT_F7OhVqucaQjA1-5D8BfQ@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: baytrail: Replace WARN with dev_info_once
 when setting direct-irq pin to output
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 1, 2020 at 3:52 PM Hans de Goede <hdegoede@redhat.com> wrote:

> Suspending Goodix touchscreens requires changing the interrupt pin to
> output before sending them a power-down command. Followed by wiggling
> the interrupt pin to wake the device up, after which it is put back
> in input mode.
>
> On Cherry Trail device the interrupt pin is listed as a GpioInt ACPI
> resource so we can do this without problems as long as we release the
> irq before changing the pin to output mode.
>
> On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
> in combination with listing the pin as a normal GpioIo resource. This
> works fine, but this triggers the WARN in byt_gpio_set_direction-s output
> path because direct-irq support is enabled on the pin.
>
> This commit replaces the WARN call with a dev_info_once call, fixing a
> bunch of WARN splats in dmesg on each suspend/resume cycle.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Replace WARN with a dev_info_once call, instead of dropping it

Patch applied with Mika's ACK!

Yours,
Linus Walleij
