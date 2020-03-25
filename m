Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51C1933DB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 23:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCYWu5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Mar 2020 18:50:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33207 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWu5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2020 18:50:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id f20so4430615ljm.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2020 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvpoEnCZ4C8vKQMoIguE6IEarWu7BrtW6hbppPd41Ms=;
        b=oiS1IbPa6rVlMQpiVeCxe4ZMoRkeE9A7zdm6RICLtCLk03wzQlXT9oAQNEEHqbunKx
         7cYD+MpDnQ8WB5Rf5xDzOi6OguU/qsogEuvLJUUuwTIoudZBsmB37+jRcWkpJbEyI/cC
         RB7bUKT0yh3ORR3ouXLj/jHG09NDIYmqk+1d02lS2+GyYtMAGj3kngCEa5tHViAu0FHX
         7kia7cGC90BRYYoLTXBqEjLtTM344573/8/H/DWy7cw8xgH3Xw9cNnFf+zhxpcQrSLzC
         AEQfz8TBMpIp7O7ezPZJEJtxMWuUQ1J4S8DHEKmts/yy/ka+BRwXO8qkTlMcQCqPdLmy
         rerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvpoEnCZ4C8vKQMoIguE6IEarWu7BrtW6hbppPd41Ms=;
        b=gVqLOJ7BfdHW3Yp+gKlsgMBUOl7BSZvB8TXW5kNVQPu+0WAnXb+c9ykzHD4bnNE9wK
         7TsMnuH78hknldq/84FiX6YSdcu8+Z2kkwawzA3jCKtbeXk77JK/FKxvDxzjZw0nrzft
         LVPukf76rb3jVT6AkBcLjNkSX2klw0awwP/ecjCvVedpqAlPeq+WbcKUnaICHIJXcy59
         Cn1byf1XT7moalzVEDnDx0fJsb0LswmL9oBluZY79s+JcxqARIp2BiCseE7deQjPz0IU
         hMsl3N48oPXkLVA7e9b+XgmfxH8tyh+P9oj8rR1rPFzv54vRml644cNwd884oHqg7m8j
         Q8Ag==
X-Gm-Message-State: ANhLgQ0PWOh/jHa59jGlDQkYBjDiQX8wTcEmmfjI6+DtMMPgBDeMPH44
        o5FY2XHv/HwPWkN4fniPcqwemcVGR9VOwMYFsuG6+Q==
X-Google-Smtp-Source: ADFU+vuOH4Me0XspRjuLjVHoMVTABevC7PhfbHX7+cC03LR6H2O9N4MTjsXAhpRlFIcEFE1sqmjJ5hoUXeN01SCrpwY=
X-Received: by 2002:a05:651c:445:: with SMTP id g5mr3210224ljg.125.1585176654577;
 Wed, 25 Mar 2020 15:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200205194804.1647-1-mst@semihalf.com> <20200206083149.GK2667@lahna.fi.intel.com>
 <CAMiGqYi2rVAc=hepkY-4S1U_3dJdbR4pOoB0f8tbBL4pzWLdxA@mail.gmail.com>
 <20200207075654.GB2667@lahna.fi.intel.com> <CAMiGqYjmd2edUezEXsX4JBSyOozzks1Pu8miPEviGsx=x59nZQ@mail.gmail.com>
 <20200210101414.GN2667@lahna.fi.intel.com> <CAMiGqYiYp=aSgW-4ro5ceUEaB7g0XhepFg+HZgfPvtvQL9Z1jA@mail.gmail.com>
 <20200310144913.GY2540@lahna.fi.intel.com>
In-Reply-To: <20200310144913.GY2540@lahna.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Mar 2020 23:50:43 +0100
Message-ID: <CACRpkdYP9a0oJnxodiSm8_Jst=3s=S4n82twp9V=8h=WCX5Gtw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cherryview: Add quirk with custom translation of
 ACPI GPIO numbers
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Stanek?= <mst@semihalf.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stanekm@google.com, stable <stable@vger.kernel.org>,
        Marcin Wojtas <mw@semihalf.com>, levinale@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 10, 2020 at 3:49 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> > With the newer kernel the gpiochip%d number is different so crossystem
> > ends up reading the wrong pin.
>
> Hmm, so gpiochipX is also not considered a stable number. It is based on
> ARCH_NR_GPIOS which may change. So if the userspace is relaying certain GPIO
> chip is always gpichip200 for example then it is wrong.

Yes it has always been clear that sysfs is what one shall use for establishing
the topology of the hardware, so /sys/bus/gpiochip etc.

For example on my laptop:
$ pwd
/sys/bus/gpio/devices
$ ls -al
total 0
drwxr-xr-x. 2 root root 0 25 mar 23.49 .
drwxr-xr-x. 4 root root 0 25 mar 23.49 ..
lrwxrwxrwx. 1 root root 0 25 mar 23.49 gpiochip0 ->
../../../devices/pci0000:00/INT344B:00/gpiochip0

Here we see that this gpiochip is on this PCI card and so on.

Linus
