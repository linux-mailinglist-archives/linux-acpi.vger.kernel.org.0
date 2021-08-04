Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99DE3E05E6
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Aug 2021 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhHDQ22 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Aug 2021 12:28:28 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44782 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhHDQ22 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2021 12:28:28 -0400
Received: by mail-ot1-f51.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so2132092ota.11;
        Wed, 04 Aug 2021 09:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3kzQ55GGFtb0Mnc40mJ/qjwvjBGrMWl/RUKJOzRSJ4=;
        b=V/uWiOX4GvD84Kx08E41CAuH525XmKyBaEXVGwNFTcMB4zptUeeJLHWaof7DT7YxkM
         eCROhGvYSMpugK/OctniIkKrtYWLvWAdbJnViofJjsQxODwLSTwn7YRIrhwW3CxK6ZbZ
         5a6mE6Bgk4NOc1slWm9wOr4d5lFRIKjRLMmSYoxCxCHV+nvHAs42GVksPDdiB6T6ZTN/
         j1PkuQ9St7nYwni/LY2CuzOmjqZObPIvM9Uytqn4En4H1AN1Y5EovG71DnI9ynwDDp+d
         8gQELrh1AFaeJnKLe1O0tRbFzHhpZ//TVl4Au5Wrxl3HyqUOvAr8NuRUID0ChmCaNTtG
         i5zw==
X-Gm-Message-State: AOAM5301yYliCatiPHX1wVgwUyiW3jSZTav3G09I4n9MXmqe+Y7H7LAN
        67RHwJ3KWFp10EJDo6bMccLrRHfzsdNbkk/OAMo=
X-Google-Smtp-Source: ABdhPJz3wrMIcjsODR4s1X5t9UxcGX3nbsnfrHYhJrS5pP8rhRT2xB1xfqzyfplseVLyyccz/6Wp2X6PeyiM1uJwaTo=
X-Received: by 2002:a9d:5c8b:: with SMTP id a11mr461995oti.206.1628094494364;
 Wed, 04 Aug 2021 09:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210722193450.35321-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0h6OQDB2hijnfinwpwpo_483UkcjGi8jYX4J6VETqLBEA@mail.gmail.com>
 <CAJZ5v0iCmu+P=phePuNeWC4MgMJ08hMtJrKoCUAzjSSnxBzObw@mail.gmail.com> <162809409848.19113.15878488082512415331@swboyd.mtv.corp.google.com>
In-Reply-To: <162809409848.19113.15878488082512415331@swboyd.mtv.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 18:28:03 +0200
Message-ID: <CAJZ5v0iu_6yxh1hgNT+C7efJX774fK0jaYYXkC2eMt24cd+Lhg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] clk: x86: Rename clk-lpt to more specific clk-lpss-atom
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 4, 2021 at 6:21 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Rafael J. Wysocki (2021-08-04 09:03:31)
> > On Fri, Jul 23, 2021 at 3:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Jul 22, 2021 at 9:34 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > The LPT stands for Lynxpoint PCH. However the driver is used on a few
> > > > Intel Atom SoCs. Rename it to reflect this in a way how another clock
> > > > driver, i.e. clk-pmc-atom, is called.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >
> > > > Good to go either via ACPI or CCF tree.
> > >
> > > In case you want the latter:
> > >
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Assuming that this hasn't been picked up, I'm going to apply it as
> > 5.15 material.
> >
>
> I applied it already to clk tree. Maybe I forgot to send the email,
> sorry.

No prob, dropping it now.
