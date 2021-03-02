Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417F332B446
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353105AbhCCE5h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384436AbhCBPFT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 10:05:19 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DF7C061A28
        for <linux-acpi@vger.kernel.org>; Tue,  2 Mar 2021 06:52:49 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u18so10642806ljd.3
        for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2021 06:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/M0iE7LYiQkzv/JWuS/1M9XYKrUbkxRvIVvQyWoD5T4=;
        b=WBmAgrPqcHHbllyM/fX3Mjdcm+kDUPkno+SQSHhL8LJej4Avezled2lFqOOBYyOhSG
         WFgJLJYGk1I77Q5qe5Du4NwWiXU0EpdNPJ6NaE2rr7pQHVvOFIkLIq5NUYi9x0AyE8NF
         AkRDuKjs9KNZmbZcYCO3ZKGV3t6h4HsMy7/VIUGjP0Nm84JSeXCdSn4/VMiOkn/SLzMv
         ikk3TkzMkBFaUh2Hn4foBw+2ToHqJzTGJCWZriWVcz9+E9WtFROQ+J2cv7rNL3kTNhO2
         TYHJ0Ph2MjFE9d1MAFTrEDYJAp4iUmyQdFU3qZfy/ja7BsWd3Rtmp4BhPBNA8fA/wQek
         oAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/M0iE7LYiQkzv/JWuS/1M9XYKrUbkxRvIVvQyWoD5T4=;
        b=Tx4HAVtFDXZgJ643Rw1+2g6qr4dDKUG5oOw/IZZW+OM6t7CqeZZdulg+aCu/OMHcuS
         Md7Q4PC3+r8l84Dv49ww1QgTKq0/QcjIyc85ncBCpa8c6himVIDYmBSgo6cK7dfxiWQ2
         OetBrONAcncYIVdRRF7Nk8OwrRKrCsJceLiJk+DYXa9o2VeuyrdYQ9tLH96z66CVxsUs
         1Lzxi1IXIvSgfeceVz7IdMkPZDRT7WUq5XhqKXJS/mEcmyaaXioRNJSJiOlIQSxZguN1
         zACyQi7KE6f0aqY4x9LSQ9Da4Eghmmwhnfvhogcdy5xw81w4zfSoSXBFx0AUd62/4gx1
         EVPA==
X-Gm-Message-State: AOAM532+6NazHyzNLcyHnv/sqLbhefv+Er4EYf4sgc4KCMdoHVfoDX12
        eiH+t6T/r/aue8M5uXn0ZAgSHkRSC8bdv3qemVf24w==
X-Google-Smtp-Source: ABdhPJyXAjBUUClEYCZHtVdeFxB93e0KU/DaYNCaGJDseQVcIYSVpAd2vUIWhhLrI6o9uN4JZLtR9Hilte1ubUmv+wo=
X-Received: by 2002:a2e:9041:: with SMTP id n1mr12338272ljg.273.1614696768477;
 Tue, 02 Mar 2021 06:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com> <20210225163320.71267-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210225163320.71267-4-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 15:52:37 +0100
Message-ID: <CACRpkdbeYkQiUjb0t2XWik1j1qQTUZZVyjkASMgpE24DWLx0fQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpio: pca953x: Set IRQ type when handle Intel
 Galileo Gen 2
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 25, 2021 at 5:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The commit 0ea683931adb ("gpio: dwapb: Convert driver to using the
> GPIO-lib-based IRQ-chip") indeliberately made a regression on how
> IRQ line from GPIO I=C2=B2C expander is handled. I.e. it reveals that
> the quirk for Intel Galileo Gen 2 misses the part of setting IRQ type
> which previously was predefined by gpio-dwapb driver. Now, we have to
> reorganize the approach to call necessary parts, which can be done via
> ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk.
>
> Without this fix and with above mentioned change the kernel hangs
> on the first IRQ event with:
>
>     gpio gpiochip3: Persistence not supported for GPIO 1
>     irq 32, desc: 62f8fb50, depth: 0, count: 0, unhandled: 0
>     ->handle_irq():  41c7b0ab, handle_bad_irq+0x0/0x40
>     ->irq_data.chip(): e03f1e72, 0xc2539218
>     ->action(): 0ecc7e6f
>     ->action->handler(): 8a3db21e, irq_default_primary_handler+0x0/0x10
>        IRQ_NOPROBE set
>     unexpected IRQ trap at vector 20
>
> Fixes: ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expander=
s on Galileo Gen 2")
> Depends-on: 0ea683931adb ("gpio: dwapb: Convert driver to using the GPIO-=
lib-based IRQ-chip")

I never saw that before, seems useful!

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Not only does it fix the bug, it also looks so much better by
separation of concerns.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
