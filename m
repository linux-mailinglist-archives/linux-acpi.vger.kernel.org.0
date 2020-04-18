Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64E91AF45C
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Apr 2020 21:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgDRTng (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Apr 2020 15:43:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41945 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgDRTng (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Apr 2020 15:43:36 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id e337815ac515ad22; Sat, 18 Apr 2020 21:43:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v1 0/6] platform/x86: intel_cht_int33fe: clean up series
Date:   Sat, 18 Apr 2020 21:43:34 +0200
Message-ID: <1920083.GZryhg05AW@kreacher>
In-Reply-To: <CAHp75Vf6MT1AFacUkRUP3760nv=3V5kzF2AHWJG64tr5yZ2=dg@mail.gmail.com>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0ihzD4knW=pKFmcsW0Q9c5rfyJMFh2ChiePe5SWO6G_TQ@mail.gmail.com> <CAHp75Vf6MT1AFacUkRUP3760nv=3V5kzF2AHWJG64tr5yZ2=dg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, April 16, 2020 5:21:15 PM CEST Andy Shevchenko wrote:
> On Thu, Apr 16, 2020 at 6:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Apr 16, 2020 at 4:17 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Wed, Apr 08, 2020 at 07:09:00PM +0300, Andy Shevchenko wrote:
> > > > When I started looking into the intel_cht_int33fe driver for an example of use
> > > > software node API, I have noticed that it's hard to get and code a bit messy.
> > > > Here is a clean up, main part of which is to introduce node groups and API to
> > > > register and unregister them. This and some pre-existing APIs can be used in
> > > > the driver.
> > > >
> > > > So, because of cross-subsystem nature of this series, I may recommend to create
> > > > myself the immutable branch which can be pulled to Rafael's and Greg's trees
> > > > respectively. I'm also open for other proposals how to proceed.
> > >
> > > Greg, Rafael,
> > > any suggestion how to proceed with this series?
> > >
> > > (It has been reviewed and tested).
> >
> > You can merge them through platform/x86 as far as I'm concerned, or
> > please let me know if you want me to pick them up.
> 
> Works for me, but I would like to ask for formal Ack tag.

I'm guessing that you talk about the first two patches, right?

Please feel free to add my ACK to both, thanks!



