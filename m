Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6036C7DC6
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCXMMv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 24 Mar 2023 08:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCXMMu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 08:12:50 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52A1136CC
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 05:12:48 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id t10so7056891edd.12
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 05:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679659967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUps+/y5UEonFRz2KFiTjlZSvlnjW2w2hp/ch+Fawc8=;
        b=W8RdcfnZqOHqkO9QEwk6c5SurnDBkNZ/hhg9Tq9O/41jl+pzBLOaseCDWi1qL3osWR
         Iup6zZdpoP6mthZWeUSdGKCaFnWezJyjOvb0zpZTzegzREXkrxJTaf0fNXA2ITzktuVE
         8fvjBl1GHscll3+230qb2OENF5X2vnF58WEb6DCJYdCJztI6TspErvxj0QwI53GdMwZW
         4nHq4cgusL3A6WqbdKYOujOOGKDY3sc6TBiXlqR1/Cqg1n2TWXRuFHQWT3SLv/IxY0kF
         vRZCAuQssalk79Ufzyp8ybN8nn2ZNQrSz2DiQRKmkUzzKqy76yvmKSXDELmD1+99YcTT
         Kf/A==
X-Gm-Message-State: AO0yUKXxqCHWy4fJlW17tNgEXp+z1tkNJZLOOydMdbSMJRrZvtTmKjKE
        zSU2veby4PN6/KH/d0xyxayFeGXwrqf5bryavQI=
X-Google-Smtp-Source: AK7set9keoEIn87jlECERLmV78bmDbII3xIsTpBXFUl5oH4fAx+odKnCUfqRiZ1nD9ZiVZyBojTwSOd9MW2KnZBW+y8=
X-Received: by 2002:a17:907:d20e:b0:8d7:edbc:a7b6 with SMTP id
 vd14-20020a170907d20e00b008d7edbca7b6mr1584644ejc.2.1679659966952; Fri, 24
 Mar 2023 05:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
 <20230307093308.m5enhuegm3r4qwvo@pengutronix.de> <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
 <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de> <6d97df76de719871c90fb59726f2d6b0.squirrel@mail.panix.com>
 <20230307200843.yxhvnb23tpecjjng@pengutronix.de> <20230323212212.udho2htrhd2vlzxm@pengutronix.de>
In-Reply-To: <20230323212212.udho2htrhd2vlzxm@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 13:12:35 +0100
Message-ID: <CAJZ5v0haCTNn+MYA2wSNhC_MzWiyH7uBYQ3F__OgL4OuubRRUg@mail.gmail.com>
Subject: Re: [Regression] acpi: laptop panics early in boot
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Pierre Asselin <pa@panix.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 23, 2023 at 10:22 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Pierre,
>
> On Tue, Mar 07, 2023 at 09:08:55PM +0100, Uwe Kleine-König wrote:
> > On Tue, Mar 07, 2023 at 02:31:49PM -0500, Pierre Asselin wrote:
> > > > Maybe the following patch helps (on top of v6.3-rc1):
> > > >
> > > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > > index 9531dd0fef50..a5a8f82981ce 100644
> > > > --- a/drivers/acpi/bus.c
> > > > +++ b/drivers/acpi/bus.c
> > > > @@ -518,7 +518,7 @@ static void acpi_bus_notify(acpi_handle handle, u32
> > > > type, void *data)
> > > >   if (!adev)
> > > >           goto err;
> > > >
> > > > - if (adev->dev.driver) {
> > > > + if (device_is_bound(&adev->dev)) {
> > > >           struct acpi_driver *driver = to_acpi_driver(adev->dev.driver);
> > > >
> > > >           if (driver && driver->ops.notify &&
> > > >
> > >
> > > It does indeed "fix" 6.3-rc1.  Modulo locking issues, which I am
> > > not qualified to evaluate.
> >
> > Thanks for your prompt test feedback.
> >
> > The locked variant could look as follows:
> >
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 9531dd0fef50..fddca263ac40 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -518,13 +518,15 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
> >       if (!adev)
> >               goto err;
> >
> > -     if (adev->dev.driver) {
> > +     device_lock(&adev->dev);
> > +     if (device_is_bound(&adev->dev)) {
> >               struct acpi_driver *driver = to_acpi_driver(adev->dev.driver);
> >
> >               if (driver && driver->ops.notify &&
> >                   (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
> >                       driver->ops.notify(adev, type);
> >       }
> > +     device_unlock(&adev->dev);
> >
> >       if (!hotplug_event) {
> >               acpi_put_acpi_dev(adev);
> >
> > Pierre: If you want to test that, I suggest to also enable
> > PROVE_LOCKING.
> >
> > Rafael: I don't know if this would work and I hope you're able to judge
> > this better than I do. The change without the lock is for sure better
> > than the status quo.
> >
> > I did a similar conversion as the blamed commit for pci that got
> > reverted for similiar reasons. See
> > 68da4e0eaaab421f228eac57cbe7505b136464af. (Added Bjorn and Robert to
> > Cc:) I think the pci code suffers from a similar race even after
> > reverting my change. If someone is able to find the right fix for one of
> > them, that might be transferable to the other?!
>
> This mail didn't make it into the archive on lore.kernel.org. Did
> someone receive it?

I have received it.
