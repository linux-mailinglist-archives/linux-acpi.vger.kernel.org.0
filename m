Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C97B5FF
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2019 01:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfG3XC2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jul 2019 19:02:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36635 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfG3XC2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jul 2019 19:02:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so45980735lfc.3
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jul 2019 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T9/kCG+kgWmWyocQ8aukdYNszqXmy4B/FV1srsKD6M4=;
        b=M/KBtxYZd/o/LS6luyddmmyRKh1YviRHkFXBh42UtAD70mFwuVs9cxNvFwMQlv41Nb
         4p3l0XJlEMHCvqPlJkCLQDsNABMaHVe3sB5QYn8iK5QRyPK7OI3wVfnnsWk3GZcKf4Mc
         C4dn4WbtHT2LTe56EX03vkrH6oZ6t3hbPPxoVVNjARNgIDXcgpSEB5Sb5CGhaJN2P39K
         2B1tC9ujDP50NBBbl3vyrodHmjFR5tE+8E/S6tKJbCFzVLy8ce+XVxeYX/ZS2f7rN+na
         /ETirSjISrdNXcGtjeOWBNwrs5D5UVqhJIMJamtGQ/7auBkUnU3MSvS0keMMdbpv5Yfu
         hWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T9/kCG+kgWmWyocQ8aukdYNszqXmy4B/FV1srsKD6M4=;
        b=awmceZCfCs5OZCfKdFh2KpJp6KLyQDm2E/Saj0+4rNkE3rQZv2y03xCmFy8ISVJC/q
         X8gVWslJjAHtima78hknfj3wDPoIw4CnSiXh4CarfqMC9jn9YQPpnF8zZamN7j6tu2mV
         8YxcCWy9z+6JvtIdnjyvymlVfKYZ6/PuV/mptRIPOq/Zqvs4QPms9wvXKNP6SOetLzo5
         1hdP9eaQ7cXuKz6vdHlNvQouO2MG7dpMNWUIBoIT+vnvmAFdz3Gfwfc66lrMP6UQ8FCv
         ls6BLFp6vbf/5EqXQHrRCtk5/XLX3GoA+uKfrTYAgOGnffZuKaHmx8Eu5Egjv4LDMcZN
         uXRg==
X-Gm-Message-State: APjAAAWaR239/xmc3begs5gyJyPg7RCWdpQaCkWbYprZtP098UDJW4XC
        vTOCGRBk55VnCMjkdy6CkhI5DTT566/iNlX5EXpH6g==
X-Google-Smtp-Source: APXvYqyUifC+ugNDNCn76iknQT/jAoMfy5FjFx/PMiUhBnzuvz04jorFGrHiYe2Ue694maiy7sSl8MZcm9C0DMRdmew=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr54299529lfh.92.1564527746494;
 Tue, 30 Jul 2019 16:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190730104337.21235-1-andriy.shevchenko@linux.intel.com> <20190730104337.21235-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190730104337.21235-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Jul 2019 01:02:14 +0200
Message-ID: <CACRpkdZXTRENogogOxrB6F5aXQSd5qehXFP1R3ax0um1XU93Aw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpiolib-acpi: Move acpi_dev_add_driver_gpios() et
 al to consumer.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 30, 2019 at 12:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The API, which belongs to GPIO library, is foreign to ACPI headers. Earli=
er
> we moved out I=C2=B2C out of the latter, and now it's time for
> acpi_dev_add_driver_gpios() et al.
>
> For time being the acpi_gpio_get_irq_resource() and acpi_dev_gpio_irq_get=
()
> are left untouched as they need more thought about.
>
> Note, it requires uninline acpi_dev_remove_driver_gpios() to keep purity =
of
> consumer.h.
>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org (moderated list:INTEL ASoC DRIVERS)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Just a bit worried that this will collide with Masahiro's #ifdef-reduction,
but I wanted to keep your series together.

Yours,
Linus Walleij
