Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A4455CC8
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 14:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhKRNhL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 08:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhKRNhL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 08:37:11 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58494C061570
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 05:34:11 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a11so6248264qkh.13
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 05:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59aOkwPj/P9I94m70F2b88+Kaz5n35ugX/rohQZqalo=;
        b=gyglPTRMgJET3BZFAsKDObwZSi23uHXAxrEZ7IpP53pe7H91lr/6MQtw6BFIzGHGkd
         22BNkiR7JR1n9pW6oyLWu+NE3Bu1SpTOFC6r2WiG+8qMu+ocyHABUab/dvk6WsvmyZ2m
         Kr/DTsneS7bUyuMkfmBEYvUTs+AGTzre3oRGIHVEP0YNyjiwX6R/LRUX3dIgbSfpzxhf
         rwlI+ma/D6yjVXN6RRr4SnFQXUiI9rvWbykwRFgZxooXz32c9l22DIX3mDIsJyKtXt5/
         OyfE4WMWvGb8JjkZLEtMMZjAXUBOWCs8uz4FDEshcERVz8EqYt9EZh2s1pKpUmA4SOFr
         R2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59aOkwPj/P9I94m70F2b88+Kaz5n35ugX/rohQZqalo=;
        b=ZMdNeX6Ihwo6Ab2ZtugZl4U/58MNCsbAtF1NjRt9Vz5H9/vYhWqPbyAhO6xCOPhavy
         jdKfv/rxgI3vuIfglrMEN20k2cf1lrNZvGQn6nNvvUVWIeWnnOHLiPs1ERO039NwcMJ6
         8LnZYie1iCur8Y1JlHf4dm1aAhIeaZJQN1s+jsvkli8pvTkTlhwQs51vYY6vJj0fHFfn
         2/lTMxj+VyjKW6f9rLSRISBlgqrR7pOxe9PB3dCNLANh+7QKXpM2SEJ6t+gDNjCFlE2J
         rXaB/JB4fWaSUcRJXXEOCUgk6l7LzM9rKfRb25dTglvTsgFew1nKYb7c1SKlUNDt1k/e
         TUDw==
X-Gm-Message-State: AOAM532QYRopg3sI11iVgNRvZoFkYXpFocUhw6QiwXiZ9dgjUUF4C0AB
        MkKw7QZ52jaL/OtV3/SRuFyGJ03dwLXZfTVS7Tg=
X-Google-Smtp-Source: ABdhPJx149HL70VVtBhjrOqm96+Wg8FE+Qs+qoMuYlICKM/hdJBuzsoVf130CLmxtl/cuG7wUjMCsatY2lMcuJR/aPg=
X-Received: by 2002:a05:620a:2148:: with SMTP id m8mr20759213qkm.435.1637242450372;
 Thu, 18 Nov 2021 05:34:10 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
 <CAJZ5v0hCYE7_eHtnfA3Vn1PFS=Dqk5=dwdbaD_k+nusJucFaCQ@mail.gmail.com>
 <CAA85sZuSGh9pQwvHio6NkNoahQjpjCxoPAhp3MOc-aGeWjDHXg@mail.gmail.com> <CAJZ5v0gvEbW9aVTp+yL22fbGrhX2h667g1kGE3phxEN03e_JtA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvEbW9aVTp+yL22fbGrhX2h667g1kGE3phxEN03e_JtA@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 18 Nov 2021 14:33:59 +0100
Message-ID: <CAA85sZsFNoQfQo0ZR79Vzw4f-o7WaxgBQ_2RhyCBMxcNkmrCeg@mail.gmail.com>
Subject: Re: HP Elitebook 840 G5 - acpi failure
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 2:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 18, 2021 at 2:17 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > On Thu, Nov 18, 2021 at 2:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Thu, Nov 18, 2021 at 1:43 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I started updating kernels to 5.14 a while ago and the laptop kept
> > > > deadlocking, it's my work laptop so it's quite locked down wrt bios
> > > > and bios updates....
> > > >
> > > > But, i have since tried with 5.15.2 and it still crashes...
> > > >
> > > > So the little testing i have is:
> > > > acpi=off -> works
> > > > acpi=ht -> *boom*
> > >
> > > This need not mean that ACPI is the source of the problem, though.
> > >
> > > > 5.13.x did work however and i know there was updates wrt to acpi in 5.14
> > > >
> > > > Older kernel oops can be found here:
> > > > https://photos.app.goo.gl/ZygV5Ja39C7cQCR39
> > >
> > > But the Oops is indeed related to ACPI.  It looks like the AML
> > > interpreter is crashing when trying to execute the _OFF method of a
> > > power resource.
> > >
> > > > I'd basically just want to know what kind of information can I provide
> > > > to help you to find and fix this issue?
> > >
> > > Would you be able to collect a trace with dynamic debug in
> > > drivers/acpi/power.c enabled, that is, add dyndbg="file power.c p+" to
> > > the kernel command line before booting and capture an oops then?
> >
> > Done, it seems like it's crashing mid screen refresh or so though,
> > hope it's useful
> >
> > https://photos.app.goo.gl/kzgDv8EV75sq6FYf7
>
> The string passed in the kernel command line is not exactly the above,
> so it didn't turn on the dynamic debug (one of the " characters is
> misplaced).

Ah, feck, sorry, rebooting....

> > I could also dump all the acpi data, if that helps
>
> It may help later.
