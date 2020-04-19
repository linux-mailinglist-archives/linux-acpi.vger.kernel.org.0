Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475E81AF8D2
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Apr 2020 10:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSIvD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 19 Apr 2020 04:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgDSIvC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 19 Apr 2020 04:51:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9E3C061A0C;
        Sun, 19 Apr 2020 01:51:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so2759347plk.10;
        Sun, 19 Apr 2020 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSX4atb1G7v7QvX1S6vwKE3Ct6JtORUQlj+orW3uWPs=;
        b=kv38SpajgjSUEG3RXxlvI4h01z9FLYQDklEBbr7764fo1zBcwhjvxl7TXyZGty8pKm
         avJTsKIv7iHJSoAopAF8DfFvVATqZWGEi89QEt6AiGeRs5Yv2bqQ28tTcSQdXqwJ06Js
         1T6SVkLn7GeW18AUR1+FXRM33uSpjb9K9RrlYQS+NDgHhJkvaPVSXFBW9MP6KpFh3QNM
         2PnNfQYbFRd0JH5OuT9Ve4CmK4KT/p8VpvLHdpiFkUhOqaB5Wnii8jvZD+NdBOiT3jgO
         R3fmOYkpG4fDhO5dX3cdgaU6piKiJJPUdpvY/ERbxYisiRNChzpcOO/6R10l46mp+lXs
         Exug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSX4atb1G7v7QvX1S6vwKE3Ct6JtORUQlj+orW3uWPs=;
        b=KvylcsijMcI7g0qovWi6teUSGCps5ZXJ2+jzG94LQBpudWug60gpoGLtYh20BMDnHl
         im/7704to5vO1PYXmh0OyV6BUVD81+xkANfLGG/L2mUzR7qOCbHCSpIQvTIAqO6gsrvm
         UVQccuyqU1nMJy2bx/Djg2DwVKo6Sd/CFxEoWcfg2R8BiEydGcpw9ygkrH4In/vY1d/5
         /JjDgqLP9l+My8JS5K6gY7DlDJE2VYdCYLBMaNESTDrww+TcSHvQPibNguIwkP2ydC01
         JQ3Zn6Y2VhLF75cTT2cJhb6U4VHr+Q1r0gmvM2ICf7fhn836wVU7xpcosnOperKMv6tn
         iUZw==
X-Gm-Message-State: AGi0Pub/4THUWsfAh764ffFjIOPVX8MRos4t0kAmz7UZ2k3exwYhtOEA
        jHoxJg1oWaVlYrhcrhaJW3hnyZOwP1KB83yuhxI=
X-Google-Smtp-Source: APiQypI7EuM03jEU3Nn+IPvOp5XXJmt5UCbT1rkVoh8qe5oslUbzYORmUJH0gm+oATx53iA69AKBICqpxb6VjF8dUmQ=
X-Received: by 2002:a17:90a:224b:: with SMTP id c69mr14870292pje.8.1587286261844;
 Sun, 19 Apr 2020 01:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0ihzD4knW=pKFmcsW0Q9c5rfyJMFh2ChiePe5SWO6G_TQ@mail.gmail.com>
 <CAHp75Vf6MT1AFacUkRUP3760nv=3V5kzF2AHWJG64tr5yZ2=dg@mail.gmail.com> <1920083.GZryhg05AW@kreacher>
In-Reply-To: <1920083.GZryhg05AW@kreacher>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Apr 2020 11:50:50 +0300
Message-ID: <CAHp75Vey91K6d+5w8Cnni-Fqitb6xGe1CqxeqpSvzyxVXnNvDg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] platform/x86: intel_cht_int33fe: clean up series
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Apr 18, 2020 at 10:43 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, April 16, 2020 5:21:15 PM CEST Andy Shevchenko wrote:
> > On Thu, Apr 16, 2020 at 6:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Thu, Apr 16, 2020 at 4:17 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Apr 08, 2020 at 07:09:00PM +0300, Andy Shevchenko wrote:

...

> > > > Greg, Rafael,
> > > > any suggestion how to proceed with this series?
> > > >
> > > > (It has been reviewed and tested).
> > >
> > > You can merge them through platform/x86 as far as I'm concerned, or
> > > please let me know if you want me to pick them up.
> >
> > Works for me, but I would like to ask for formal Ack tag.
>
> I'm guessing that you talk about the first two patches, right?

Correct!

> Please feel free to add my ACK to both, thanks!

Thanks!

-- 
With Best Regards,
Andy Shevchenko
