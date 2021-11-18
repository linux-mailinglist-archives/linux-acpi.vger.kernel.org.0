Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521E7455CAD
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 14:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhKRNc0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 08:32:26 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:43609 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKRNcZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 08:32:25 -0500
Received: by mail-oo1-f48.google.com with SMTP id w5-20020a4a2745000000b002c2649b8d5fso1902163oow.10
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 05:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnHInMoSiunrxyI0Y1MB5Dl3v1KUY9gmTC+mu6uHTf4=;
        b=WmOi0DJWz6Rid0cBn25rLuUsRjGr+lL7y8PBgAO+rO4VdOkXGu9HFpl3XGH67teZKo
         U2FbN0Hh3QPVZzbyndkFrHa57FVdzNh7UspUnCgRLrByxL2TjzuiBWEJ3D1PsHW9S7CJ
         nfFjDV3dXWcan0jhpD0FMpTwW2gYQlIr15aOedU0YoHxumLxhbCQ9HNHXhoo930uXSbV
         AknfhBCZTgeIHpR1GH4rVjvH7H4YB3oZmDIU+fAc8Uc0v2Vv7M0BQGZTdTub0wm26z5i
         vGjXhyZNsHpDA2zA6j2/fujSSxt5UnmXqF+BwbIMNpZR8KMHWUd7pb1UdHwRNG7pw7L7
         IRQQ==
X-Gm-Message-State: AOAM533y9W4lVsX5sOYrL2nnoscjoArj1ptHWFJ8X7BRz+3Wj7EKSgqP
        Brsb2CNPp1LJ8HcKc4z1zOCvF2rPhYDRzyp3g5k0pzx4
X-Google-Smtp-Source: ABdhPJzYNMabH8i6lxdvM+24cKEbdd5gHcZRMZouD9wpnItwJRXC8z/w6xSzuATM417tPBONESR+fcQv8daaQsrBO3Q=
X-Received: by 2002:a05:6820:388:: with SMTP id r8mr6433113ooj.0.1637242165116;
 Thu, 18 Nov 2021 05:29:25 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
 <CAJZ5v0hCYE7_eHtnfA3Vn1PFS=Dqk5=dwdbaD_k+nusJucFaCQ@mail.gmail.com> <CAA85sZuSGh9pQwvHio6NkNoahQjpjCxoPAhp3MOc-aGeWjDHXg@mail.gmail.com>
In-Reply-To: <CAA85sZuSGh9pQwvHio6NkNoahQjpjCxoPAhp3MOc-aGeWjDHXg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 14:29:14 +0100
Message-ID: <CAJZ5v0gvEbW9aVTp+yL22fbGrhX2h667g1kGE3phxEN03e_JtA@mail.gmail.com>
Subject: Re: HP Elitebook 840 G5 - acpi failure
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 2:17 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Thu, Nov 18, 2021 at 2:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Nov 18, 2021 at 1:43 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I started updating kernels to 5.14 a while ago and the laptop kept
> > > deadlocking, it's my work laptop so it's quite locked down wrt bios
> > > and bios updates....
> > >
> > > But, i have since tried with 5.15.2 and it still crashes...
> > >
> > > So the little testing i have is:
> > > acpi=off -> works
> > > acpi=ht -> *boom*
> >
> > This need not mean that ACPI is the source of the problem, though.
> >
> > > 5.13.x did work however and i know there was updates wrt to acpi in 5.14
> > >
> > > Older kernel oops can be found here:
> > > https://photos.app.goo.gl/ZygV5Ja39C7cQCR39
> >
> > But the Oops is indeed related to ACPI.  It looks like the AML
> > interpreter is crashing when trying to execute the _OFF method of a
> > power resource.
> >
> > > I'd basically just want to know what kind of information can I provide
> > > to help you to find and fix this issue?
> >
> > Would you be able to collect a trace with dynamic debug in
> > drivers/acpi/power.c enabled, that is, add dyndbg="file power.c p+" to
> > the kernel command line before booting and capture an oops then?
>
> Done, it seems like it's crashing mid screen refresh or so though,
> hope it's useful
>
> https://photos.app.goo.gl/kzgDv8EV75sq6FYf7

The string passed in the kernel command line is not exactly the above,
so it didn't turn on the dynamic debug (one of the " characters is
misplaced).

> I could also dump all the acpi data, if that helps

It may help later.
