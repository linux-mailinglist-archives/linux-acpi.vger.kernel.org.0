Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C639F32B453
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353134AbhCCE6U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379983AbhCBQJb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2021 11:09:31 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1646C0617A9
        for <linux-acpi@vger.kernel.org>; Tue,  2 Mar 2021 08:08:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p8so9923203ejb.10
        for <linux-acpi@vger.kernel.org>; Tue, 02 Mar 2021 08:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySBfAUfKkrTxnqwRAlElNRuJskL0Nij32l2OtUpRMe8=;
        b=O4952JgPIL+2tmFGrwVq0Mz2DWtGeThdchNYHRKuK2HtIW5BWKnfwTpOrMWdNDa1dF
         ROEA/v93M49/StTpJD0e+6vtgCssUvWYdSZ9Wwb5HosRH45KD+tbPETJddRsI8F8CETk
         kkLG30ByW1gZM7oIs3k9ReNaqz7RkHeFmetF4Ul9FtJ/avk8EURsL6GWmxIso3EjfIJP
         wHha7T3dbNiE36mo5ifMA9lolpocPXC61k2dzpCfFYylzveW9Poho944CYdLWRojmgNK
         X9aPyJl1wN/X9goP/29Gbofkq6NrwVHTvLhTPfEiTTx3vzWfHbZfTRmYgvAh7G4gyJsh
         b/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySBfAUfKkrTxnqwRAlElNRuJskL0Nij32l2OtUpRMe8=;
        b=CUas+XkNy+sDWGfrZCIjW+Fkqr4yaxbSnWKyq2Wxaznr4GLUzjo3IdhWRxD0Fiqvhb
         guXnvoOFL50SqMSYuoNRUzPA4ao4bqHxDPfwV6aWKRtcIC/TflpbLatWGRUDI417uvqK
         9WrAXZznt59+6TCuw3ofb0IR7h11uacACrZo97K2B07GTU43iKiCcf4LDyxHd2UwJt/R
         QvChgxqOz8drXpGXmo/UHGy39VI3vt3DKgOOyKlzShp883yM1sE1+4VyfHtZo/jeG6+M
         WiutXDg8krw0+h1HYmYexqle36ZPbcomK7W2v/euRiZ8qxBsi3czwM6prj3Bqr9ktNHR
         iBRw==
X-Gm-Message-State: AOAM532LkdAb0ZTR61wijVcEIoCyPVCaoG98ndTu8Rwlbl4ZdrI5fIFb
        gcw0f020tWVP8j+igRcrD0pHBjNXxLBG10ZjoDObRw==
X-Google-Smtp-Source: ABdhPJyDNlQbitvS0R9F0Y/EyzkBOlI0yLYBJOj4a7MK+Gohur1NOzSn7P7javeAqgETQJbauLEnqE6IGdoj3QI/EuA=
X-Received: by 2002:a17:906:5044:: with SMTP id e4mr21277561ejk.445.1614701286820;
 Tue, 02 Mar 2021 08:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com>
 <20210225163320.71267-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdZj4TqOoJmfDhL1MuZCT9quz+5Gj8C6ckZ1i6cYCq9SOA@mail.gmail.com>
 <YD5VJMDC1TmIN/T8@smile.fi.intel.com> <20210302151430.GY2542@lahna.fi.intel.com>
 <YD5X7XUrx9AQvaXP@smile.fi.intel.com>
In-Reply-To: <YD5X7XUrx9AQvaXP@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 2 Mar 2021 17:07:55 +0100
Message-ID: <CAMpxmJX5sKwuta_Ws-VLuA_95ji6xaSB-0ZoNtQ-dL5mAwQcpg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpiolib: acpi: Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 2, 2021 at 4:21 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Mar 02, 2021 at 05:14:30PM +0200, Mika Westerberg wrote:
> > On Tue, Mar 02, 2021 at 05:09:24PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 02, 2021 at 03:48:43PM +0100, Linus Walleij wrote:
> > > > On Thu, Feb 25, 2021 at 5:33 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > > On some systems the ACPI tables has wrong pin number and instead of
> > > > > having a relative one it provides an absolute one in the global GPIO
> > > > > number space.
> > > > >
> > > > > Add ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk to cope with such cases.
> > > > >
> > > > > Fixes: ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")
> > > > > Depends-on: 0ea683931adb ("gpio: dwapb: Convert driver to using the GPIO-lib-based IRQ-chip")
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > OH THE HORROR!
> > > > However, we discussed it before. It is as it is.
> > >
> > > Unfortunately :-( (And recently it seems MS does something really "creative" on
> > > ARM ACPI platform)
> > >
> > > > It's the right place to fix the problem, so:
> > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > >
> > > I am waiting for Mika, but if he keeps silent let's say to the end of the day,
> > > I will submit it as is to the v5.12-rcX fixes.
> >
> > Sorry for the delay - I somehow missed this. Feel free to add my ACK too.
>
> Thanks, Mika!
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Hi Andy,

Do you want me to take these, or will you include them in your PR?

Bart
