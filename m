Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003CA1759B0
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 12:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCBLpO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 2 Mar 2020 06:45:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41910 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgCBLpN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 06:45:13 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so9946699oie.8;
        Mon, 02 Mar 2020 03:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SLNYhHV8VgjuhrZ6PkGrsfgyd81HsPtycIyiuh3CoLI=;
        b=qENEVz8ucXvymnHgkfj+OlQhRD8RsxUadDyJjGTJEth/6yrV8vPp5nFarAG/HC+AAp
         MQn4+BKUrWj/4HurMKjV0l7Gha8LRsWf5rTHn/763dkOR4ZsesPSEIvKZ0iL4OkRklHC
         hDhuxHo9uSjcuNs/aH40v4J22tDbBqB2f22Y/Mg6zUcUCeyOOdoe+ZpPvG9nw19q+4Us
         8D9zCZnysUwtNJIT+GmG11fICAzMl9t8AFEn9OGRnPhDsUV7QLWQ/DwaE0Bcq5RaoaWi
         6TX1s3tMlpUQiZdxg7mRtJ5MV7uAWlw1N0jqc0Q9X0oxixriwXEUNJHBoORTX2JL49KE
         wl8Q==
X-Gm-Message-State: APjAAAWHVrzvly8KAGnhapmyoyevWgIem1sRBTRel9V/XJ6Y1xBHtZoE
        Fbd/bJmCweKkCQe+0KRECJ0yDcmmnmp/NKbHuww=
X-Google-Smtp-Source: APXvYqw52kt1OueUejBSTej59FJzkSRmsyOjRvbmPvah+zgjVX4FkHL5Pr4NN28Le28iXSOTo5WdzOdiIxXYm+925zU=
X-Received: by 2002:aca:ebcf:: with SMTP id j198mr9618581oih.115.1583149512878;
 Mon, 02 Mar 2020 03:45:12 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
 <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com> <CAJZ5v0gB9yuVmPjJ_MvfT8aFpvP-X5JRsNfZn8+Mv5RwTednGg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gB9yuVmPjJ_MvfT8aFpvP-X5JRsNfZn8+Mv5RwTednGg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Mar 2020 12:45:01 +0100
Message-ID: <CAJZ5v0imqwdmXzKayqs1kgHOb-mXrkr61uNxVka8J9bKca989Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 2, 2020 at 11:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Mar 2, 2020 at 6:54 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> >
> > Daniel Drake <drake@endlessm.com> 於 2020年2月28日 週五 下午5:43寫道：
> > >
> > > On Thu, Feb 27, 2020 at 10:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > The purpose of this series of update of the ACPI EC driver is to make its
> > > > initialization more straightforward.
> > > >
> > > > They fix a couple of issues, clean up some things, remove redundant code etc.
> > > >
> > > > Please refer to the changelogs of individual patches for details.
> > > >
> > > > For easier access, the series is available in the git branch at
> > > >
> > > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > >  acpi-ec-work
> > > >
> > > > on top of 5.6-rc3.
> > >
> > > Jian-Hong, can you please test this on Asus UX434DA?
> > > Check if the screen brightness hotkeys are still working after these changes.
> >
> > Hi Rafael,
> >
> > Thanks for your patches, but we found an issue:
> > The laptops like ASUS UX434DA's screen brightness hotkeys work before
> > this patch series.  However, the hotkeys are failed with the patch
> > "ACPI: EC: Unify handling of event handler installation failures".
>
> So I have modified the series to avoid the change that can possibly break this.
>
> Can you please pull the new series from
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-ec-work
>
> (same branch) and retest?

Note that the current top-most commit in that branch is

0957d98f50da ACPI: EC: Consolidate event handler installation code



>
> I'll post the updated patches later this week, but it would be good to
> try them on now if possible.
>
> Thanks!
