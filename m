Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F5F578006
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jul 2022 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiGRKos (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jul 2022 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGRKor (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2022 06:44:47 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55165DEA2
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jul 2022 03:44:46 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31e47ac84daso1887417b3.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jul 2022 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uc6eWbNciWgCyv7c8q11Fg2PzpQWeHdegtWuP/RJosk=;
        b=hunoSOBK5o/MgbRCfnof4p/yAizCb87IErb0T+TMW5bjsqJf8adSLBxOtskb/3SYq3
         v5NHC2GksmyPzVsCugk7JT9c7iWbccDFF8/aL7PWplrqtLLR5NgEh6HvuIszHu2kjnoO
         RhPU/8A8agWydAQkW8ngj01Y54ZbQDa/XBoBfPm8FgWWSKF/JjImLGXqfpzoR/qhK63R
         1PqtpT6VFiVT94nSADhTt6K/8O+9hThPGsWTAsvov3OItqG7tzWDczZbNU811Mem1xGt
         5XvvpKj+PA2h/0wc3vM/rkRmzpm1uIdp7q3vgvXk/LmhF6I167bH8PsJ1cXEpkAT75Jx
         l35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uc6eWbNciWgCyv7c8q11Fg2PzpQWeHdegtWuP/RJosk=;
        b=VKG15wxXP4nkHrQRbegZVv536A6zmlvh2x/4EBy4T3ZiKHtHUhV91b631PClQoan+K
         ikNh+AhoRfc+gEunwRgDnR+sNuH6hONcG8jcapdG4rG/sWWl0LJnzEqsWBH/vQmu0OZz
         SPrWqO883YpltGFaVu4+n2by4CjLX5P/L4QdFFKbnhU6+BumqV0/dIurh4z8v7mfZko8
         G2Y5T1zCRQs6bY2xJEDFngb0wX6QBaE+QoHXg/eodYZaQGbvtoEzq0LIe5ja8wrvVC6+
         m1JTRMgiTEqrnyOC3SBoDsr18txckHUzJ/+e5t5ugB57ClgDbFABDthpo9389bDtCo7K
         m3wg==
X-Gm-Message-State: AJIora9bXxDMAgcjy/zUE85Ldui+AgmW9pNIdXZfXvaQscFKtF1TEmr+
        TPtSrCsmdpyAS/6QjavBQDpk/UV7A1WqTZTFlw9jtg==
X-Google-Smtp-Source: AGRyM1syf04DDcAP3vOqEDAUO6jpt6YyrJga4szmgQ60QMX18LG8E4DK3LxuaI7O0RIvV7k/Ho7WmxevzlUIt1owlhY=
X-Received: by 2002:a81:4809:0:b0:31d:848:4b3b with SMTP id
 v9-20020a814809000000b0031d08484b3bmr29876705ywa.69.1658141085548; Mon, 18
 Jul 2022 03:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220713131421.1527179-1-nuno.sa@analog.com> <20220713131421.1527179-2-nuno.sa@analog.com>
 <Ys8CpqYhWp7zVNC8@smile.fi.intel.com>
In-Reply-To: <Ys8CpqYhWp7zVNC8@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 12:44:33 +0200
Message-ID: <CACRpkdbc=ogONYXTM6dbe7sJp6syG0sDFfBi1ZTc0YJtoxbJjg@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: add support for bias pull disable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 13, 2022 at 7:37 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Jul 13, 2022 at 03:14:18PM +0200, Nuno S=C3=A1 wrote:
> > This change prepares the gpio core to look at firmware flags and set
> > 'FLAG_BIAS_DISABLE' if necessary. It works in similar way to
> > 'GPIO_PULL_DOWN' and 'GPIO_PULL_UP'.
>
> ...
>
> >       GPIO_PULL_UP                    =3D (1 << 4),
> >       GPIO_PULL_DOWN                  =3D (1 << 5),
> > +     GPIO_PULL_DISABLE               =3D (1 << 6),
>
> To me it seems superfluous. You have already two flags:
> PUp
> PDown
> When none is set --> Pdisable

What happens in the pin control case for some drivers at least is that
the machine
comes up with some pull up/downs enabled (by power-on default or from
the boot loader), and some systems need to explicitly disable these
pulls.

In these (device tree) cases they set bias-disable; in the device tree, and
the driver will actively disable any pull up/down.

OK this is maybe not the most elegant system engineering. But some of
those users are hobbyists and cannot affect what the ASIC or firmware
is doing, because vendors are not really listening.

Another semantic reason is that pins can also be set to bias-high-impedance=
;
which is what "some people" would assume is the default if you disable
both pull up and pull down. (Yeah ... semantics...)

Device tree also has bias-pull-pin-default; to make things more complicated=
.
This should *really* leave it at power-on default. Explicitly.

I think for Nuno's usecase (using a random pin from userspace) the state
of biasing cannot be assumed, the driver will not change bias to
disabled just because neither pull up or down is specified, so the driver
needs an explicit kick saying "disable any bias".

Yours,
Linus Walleij
