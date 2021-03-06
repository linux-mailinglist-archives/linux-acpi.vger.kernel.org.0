Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C532F9EF
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Mar 2021 12:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhCFLjQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Mar 2021 06:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhCFLip (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Mar 2021 06:38:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD574C061760
        for <linux-acpi@vger.kernel.org>; Sat,  6 Mar 2021 03:38:44 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bd6so6661077edb.10
        for <linux-acpi@vger.kernel.org>; Sat, 06 Mar 2021 03:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XwU3w6HO2szt/GGoO2HOyG4g/UDC1v7UvybLnW6HJ8=;
        b=kYeqOFiNlpOYF35xOZNkwAHE/modME0EVAMevxEkRYP72Z7I0DF4G7TEYRKzDh2t+7
         l5rz+JdgJ+U9r7+jEmF/icQtO/tkPktURrf3FiFUph6q9zBb0zI79+7aOhL9alo3oYY2
         ynHxV5EU5ZSJLLapQIwspC8t4nkN38FVvpONo2dEnEgt1rLz9Tz9vGOCfX9TBrRxGdsn
         L9b8nsUSMOord9ZxaDAbgS6gvv1NlfzunroYZJU/PlUYhrpVuZAtTTbBqDzpZNQ5abx2
         q2h5DN5fc+TG25qNN26ZJWdOZQRutTPWHn23CqyXfEBu2LD8w1B0xz0Me5HlkNwefevi
         OXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XwU3w6HO2szt/GGoO2HOyG4g/UDC1v7UvybLnW6HJ8=;
        b=UcchpkwY7ZQIFhjoUQXy756jmC8+IXzB5Qp29VcFUjiIfXqyZ5wqfBJshrUasoNDAS
         B3rpSL0/dPO2hheYx2n9cTt5pEpn9RxpIhBZnuAYb8N3ncRqMimNYvaNO5n8cyzvzor0
         6oiJ2wrfD/iX6ip8ClyUypsxxxF0bVP2J9waYSGj6moKt3SS1Y6JKDybpsm9F3gy9VVc
         5NB+PrsYn6hDRI1MZdFaEveOOgp9OKe6UPigKRJ/KzNKTwlip0JKVBdpRNAokan87QRh
         pddDS2X16pKRbkXQoibAdyvFhoOyB5LVn4jexv1DucMwJGJqaHiMSLrtLuZl+L85G7Jl
         V2UA==
X-Gm-Message-State: AOAM532Y8pIJ18EdS00Pr9Uf1XxlCBVmVXSwyDx6jEB41s6R1ghENViB
        r0n79AFJroVXN1bMyCJ9bMnvfl/KwXcRQcG5AVKvdg==
X-Google-Smtp-Source: ABdhPJxNbK792BbmIvOaxF/y9BF8ygUvUTwL/T+i8VkFDRvVe75M6t8HwNw9nF5NwCKR2R6drAGb+SbRYuO9IpUcjok=
X-Received: by 2002:a50:ee05:: with SMTP id g5mr13530841eds.164.1615030723553;
 Sat, 06 Mar 2021 03:38:43 -0800 (PST)
MIME-Version: 1.0
References: <YD9K8LzSFpuAhDvW@black.fi.intel.com>
In-Reply-To: <YD9K8LzSFpuAhDvW@black.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 6 Mar 2021 12:38:33 +0100
Message-ID: <CAMRc=Mf1MsRUGJN9Y09yVQ=OO41-kYRo8n3D3tyLpymnJ6_JvQ@mail.gmail.com>
Subject: Re: [GIT PULL] intel-gpio for 5.12-2
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 3, 2021 at 3:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Hi Linux GPIO and ACPI maintainers,
>
> This is material for v5.12-rcX (presumably -rc2). Since it touches ACPI, this
> PR is to both subsystems.
>
> Thanks,
>
> With Best Regards,
> Andy Shevchenko
>
> The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
>
>   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
>
> are available in the Git repository at:
>
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel.git tags/intel-gpio-v5.12-2
>
> for you to fetch changes up to 437b57d2085950a813c028215513fe941ca2e616:
>
>   gpio: pca953x: Set IRQ type when handle Intel Galileo Gen 2 (2021-03-03 09:49:47 +0200)
>
> ----------------------------------------------------------------
> intel-gpio for v5.12-2
>
> * Fix IRQ flags for ACPI event handler
> * Redo Intel Galileo Gen 2 quirk due to revealed regression
>
> The following is an automated git shortlog grouped by driver:
>
> gpiolib:
>  -  acpi: Allow to find GpioInt() resource by name and index
>  -  acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
>  -  acpi: Add missing IRQF_ONESHOT
>
> pca953x:
>  -  Set IRQ type when handle Intel Galileo Gen 2
>
> ----------------------------------------------------------------
> Andy Shevchenko (3):
>       gpiolib: acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
>       gpiolib: acpi: Allow to find GpioInt() resource by name and index
>       gpio: pca953x: Set IRQ type when handle Intel Galileo Gen 2
>
> Yang Li (1):
>       gpiolib: acpi: Add missing IRQF_ONESHOT
>
>  drivers/gpio/gpio-pca953x.c   | 78 +++++++++++++------------------------------
>  drivers/gpio/gpiolib-acpi.c   | 21 ++++++++----
>  include/linux/acpi.h          | 10 ++++--
>  include/linux/gpio/consumer.h |  2 ++
>  4 files changed, 48 insertions(+), 63 deletions(-)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Pulled, thanks!

Bartosz
