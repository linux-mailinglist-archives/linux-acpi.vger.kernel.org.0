Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE663552E08
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 11:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346820AbiFUJOo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jun 2022 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiFUJOn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 05:14:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028F712624
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 02:14:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a11so5889128ljb.5
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9hW3jjf9bp01ZUcaiVpuKXB3YUlqSGpIT2U7YDux9Rg=;
        b=Gwli9c0qw+zfBDR9Giy7/Y+52KIgrthSDWDZ+6p5zkOfFViD/gVgJOzZ8HVe65ZZZq
         R7OXFD+kR9WkHTz83UOHgSsfDefZA9DrOOiS5rOvFoZpIxJmxbPaIzHr11KPXLfaWEvz
         HMzCV8UJKxcvCWtKrE+Q0ie1PD8inJ71VHKvJTcg+3TxVBag9uCAep+FxnvMpwnvnsFE
         IsUZdlSa2Z6gFvu4kcJy8KaSoEtau1sUsJE/MrIdM159J1mxXO3MkBWehVXeSDBSDeMt
         eaEf+u405Xt7tv1EP0rXAjV74aH8Eyrwu9uNl3793ctMqtNDHqByELGkklpMDYeim9ZN
         XLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9hW3jjf9bp01ZUcaiVpuKXB3YUlqSGpIT2U7YDux9Rg=;
        b=UUobXj2tAg6tfWoK1UA1Pi/1d9hjC1iGctlbDtpP5uF3ZcF6TwjXp4oXVOA9dhBA54
         N3CPUK27VylS5OCxDTchxALLyFpHGFso+xfcVsSWUm0N6yjC7mahNiOfqYcK+CKCEz47
         EitqcOx4xOlNDos6fOYYjIdefOXzgI+gw9IsMDEcFzfMnrUO7hMheStUJQT2RY3RmaUm
         TdH/HI1Ei0RAEiafNruBLoK1UufKuxZLfAhq/fHpa3+PgD/XJgf/UrOU1qo1AmdP83gU
         HX+oyRvuj7aVakzQdSLNUoyiWW8rP91QRdSreZ/7avuyv7YtGJ38GGtQBbfJdjVTY0WG
         v8OQ==
X-Gm-Message-State: AJIora/BMKf12Fn3u3GhhzlI3Rwn6xwQY/jI3zGMysK5YGvGTMAe+MeA
        sz/VDGOe5UL5CLqFy2cxGHEHdcAFGFgJt09wppV/pw==
X-Google-Smtp-Source: AGRyM1tKvJq8Yv3GhlY6sfPQBp5eChgXt4TwgRHECFq5GkHc3Tha4gNloRxZWtpPHhXNH3BWUnqfTsoUg09Z/UMHmyo=
X-Received: by 2002:a2e:bf05:0:b0:247:b233:cfba with SMTP id
 c5-20020a2ebf05000000b00247b233cfbamr13439703ljr.131.1655802879101; Tue, 21
 Jun 2022 02:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-12-mw@semihalf.com>
 <YrC1ymfSJ3nxWw4B@smile.fi.intel.com>
In-Reply-To: <YrC1ymfSJ3nxWw4B@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 11:14:29 +0200
Message-ID: <CAPv3WKcqpHfN8UnZo19nKPQMbM5hZvptD=mswvuy-8HB6p=BwQ@mail.gmail.com>
Subject: Re: [net-next: PATCH 11/12] net: dsa: mv88e6xxx: switch to
 device_/fwnode_ APIs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pon., 20 cze 2022 o 20:03 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Jun 20, 2022 at 05:02:24PM +0200, Marcin Wojtas wrote:
> > In order to support both ACPI and DT, modify the generic
> > DSA code to use device_/fwnode_ equivalent routines.
> > No functional change is introduced by this patch.
>
> ...
>
> >       int err;
> >
> > -     if (!np && !pdata)
> > +     if (!fwnode && !pdata)
> >               return -EINVAL;
>
> Sounds like redundant check
>
>         if (pdata)
>                 ...
>         else
>                 compat_info =3D ...
>         if (!compat_info)
>                 return -EINVAL
>
> ?
>
> > -     if (np)
> > -             compat_info =3D of_device_get_match_data(dev);
> > +     if (fwnode)
> > +             compat_info =3D device_get_match_data(dev);
> >
> >       if (pdata) {
>
> Missed 'else' even in the original code (see above)?
>

fwnode/np is mutually exclusive with pdata, but imo nothing wrong with
adding 'else' here or update the condition as suggested above.

Thanks,
Marcin


> >               compat_info =3D pdata_device_get_match_data(dev);
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
