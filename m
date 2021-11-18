Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0B3455CDD
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 14:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhKRNo5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 08:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhKRNo5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 08:44:57 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A7C061570
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 05:41:56 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 8so6028866qtx.5
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 05:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=359mfBZr0WvYjngBOhyIwB+eFzfhNEEVt5h7GQmKIeo=;
        b=GwyUqFQoIUC/sXfXNb1T8k9DnlsPY816FDxP2e5DTKUVdwmRQeMEWDxUPXznEwEiVR
         OpAxiBzWQmEfJ/8MRUc77tkM99VIJEHpTIyg0QjPS7I72ZQlp220FsD2zDRZEqB0xuWi
         SKmaDGS2sTBD2ARDCWjPcEiuRiWejkBd4LIvPRFJUHnVH37ItTRgY0z6A4fELJ6zUEVk
         YCfxwf0t1HS/62ar2IJ6v1F05sW+I+xEsFb6MIBZsSOW4rUeUwrmX+ZbNQzs2xO4kKik
         WxdZB1aKyEYltRqxs5rJ+Cd1adYZxvhywkDVaL8oMdiVtUfNNbD21r3BBQAxr6m/7shr
         WNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=359mfBZr0WvYjngBOhyIwB+eFzfhNEEVt5h7GQmKIeo=;
        b=zzpm2cwRP8bWUcEFy56EAsYdU4vlJqG7a5p0yAx9do+zAtw1Us+3uOWc7j8wGyPwdf
         LpXKXupfgxyPrf5TqyozvqPnX5gdptaeg74KMB3OLHVVnaBNiGZ+Ypyoz6Ccca9iJixa
         1pVLYj/g7Duv9AozPqmsRp0Q6SsT3t0e8hLjpyHLnI+yTYsiIF74ORLsqgh7/2e7NFen
         dvclpalCWAhnKstwHV0Glp0LYfkbqMKR7TB2/AcKTC8mehiwMvsNufRxmRFGHJc0onTm
         AcvN6zyEO64pWAoPCtLF0t0H/QlTsSng5NymE/hBLzkTSm75hX5VGMjh+7Z8yhW6OjFq
         UFsw==
X-Gm-Message-State: AOAM533isna99uvo+7DIycnRTrhx3slHUeDs5Ye/EgsGEvVYe1BqScYZ
        n1RFjitGwZcP9aiXk1rTlRxxsM4Hqqd/nB8T4k32rrPZmSXx7Q==
X-Google-Smtp-Source: ABdhPJyAJ5/RokTgt44T75vfuGhWgw8eAo9+LKG8DKq9uIOMLxV6JUb3HijezERs7Yf61T8I/H416tgx6m7wipi3R9Q=
X-Received: by 2002:ac8:4117:: with SMTP id q23mr25778665qtl.390.1637242915953;
 Thu, 18 Nov 2021 05:41:55 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
 <CAJZ5v0hCYE7_eHtnfA3Vn1PFS=Dqk5=dwdbaD_k+nusJucFaCQ@mail.gmail.com>
 <CAA85sZuSGh9pQwvHio6NkNoahQjpjCxoPAhp3MOc-aGeWjDHXg@mail.gmail.com>
 <CAJZ5v0gvEbW9aVTp+yL22fbGrhX2h667g1kGE3phxEN03e_JtA@mail.gmail.com> <CAA85sZsFNoQfQo0ZR79Vzw4f-o7WaxgBQ_2RhyCBMxcNkmrCeg@mail.gmail.com>
In-Reply-To: <CAA85sZsFNoQfQo0ZR79Vzw4f-o7WaxgBQ_2RhyCBMxcNkmrCeg@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 18 Nov 2021 14:41:45 +0100
Message-ID: <CAA85sZs-mgx2UqJZ8LHqmwYFr6EoVs=rM-wnStT=T0b+q9pdVQ@mail.gmail.com>
Subject: Re: HP Elitebook 840 G5 - acpi failure
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

So, hard to capture, crashes faster with minimal output:
https://photos.app.goo.gl/9p56395EdhNBuikQA

First time i didn't even see the oops at all...

On Thu, Nov 18, 2021 at 2:33 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Thu, Nov 18, 2021 at 2:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Nov 18, 2021 at 2:17 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > >
> > > On Thu, Nov 18, 2021 at 2:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Thu, Nov 18, 2021 at 1:43 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I started updating kernels to 5.14 a while ago and the laptop kept
> > > > > deadlocking, it's my work laptop so it's quite locked down wrt bios
> > > > > and bios updates....
> > > > >
> > > > > But, i have since tried with 5.15.2 and it still crashes...
> > > > >
> > > > > So the little testing i have is:
> > > > > acpi=off -> works
> > > > > acpi=ht -> *boom*
> > > >
> > > > This need not mean that ACPI is the source of the problem, though.
> > > >
> > > > > 5.13.x did work however and i know there was updates wrt to acpi in 5.14
> > > > >
> > > > > Older kernel oops can be found here:
> > > > > https://photos.app.goo.gl/ZygV5Ja39C7cQCR39
> > > >
> > > > But the Oops is indeed related to ACPI.  It looks like the AML
> > > > interpreter is crashing when trying to execute the _OFF method of a
> > > > power resource.
> > > >
> > > > > I'd basically just want to know what kind of information can I provide
> > > > > to help you to find and fix this issue?
> > > >
> > > > Would you be able to collect a trace with dynamic debug in
> > > > drivers/acpi/power.c enabled, that is, add dyndbg="file power.c p+" to
> > > > the kernel command line before booting and capture an oops then?
> > >
> > > Done, it seems like it's crashing mid screen refresh or so though,
> > > hope it's useful
> > >
> > > https://photos.app.goo.gl/kzgDv8EV75sq6FYf7
> >
> > The string passed in the kernel command line is not exactly the above,
> > so it didn't turn on the dynamic debug (one of the " characters is
> > misplaced).
>
> Ah, feck, sorry, rebooting....
>
> > > I could also dump all the acpi data, if that helps
> >
> > It may help later.
