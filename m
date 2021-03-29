Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23934D708
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 20:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhC2S1A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 14:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhC2S0q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 14:26:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CFC161959;
        Mon, 29 Mar 2021 18:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617042406;
        bh=db98Tt9Q7og8u1XozWxEYojUKSryUAeveaVzE9hYq3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhxzPsg/usCdvBj2kE96zbBO9iHqWawdEDVNj6BzQTWXGpD65aI25OMaJPodMUHRD
         eMrWp96oVJwKifAg8Gij7WWLPagMtBFJ19x/AaZBlXW20TZKvL2NpPlWRt3LBhpYMC
         Em/AlsmQucbx9VnZuhYw9xQpYLw9sJcYIolFOGgk=
Date:   Mon, 29 Mar 2021 20:26:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 3/8] software node: Show properties and their values
 in sysfs
Message-ID: <YGIb4z8oHIV7LlWi@kroah.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-3-andriy.shevchenko@linux.intel.com>
 <YGAmB2Nwph6pArXc@kroah.com>
 <CAHp75VfFzqpdR+6p9vQww-ujQcw3L-V_N7ezUTGhcRmvwvqMZg@mail.gmail.com>
 <YGB+YMh1MsQao3zS@kroah.com>
 <YGHPnkoB/wP6u6HC@smile.fi.intel.com>
 <YGHaTf+cpvAZ5geB@kroah.com>
 <CAHp75VfEN4HAX=BUZNp+-kKD1B1WVU2oeG2SXyaw=EWVa-CAhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfEN4HAX=BUZNp+-kKD1B1WVU2oeG2SXyaw=EWVa-CAhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 29, 2021 at 05:51:01PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 29, 2021 at 4:46 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Mar 29, 2021 at 04:01:18PM +0300, Andy Shevchenko wrote:
> > > On Sun, Mar 28, 2021 at 03:02:24PM +0200, Greg Kroah-Hartman wrote:
> > > > On Sun, Mar 28, 2021 at 03:56:26PM +0300, Andy Shevchenko wrote:
> > > > > On Sun, Mar 28, 2021 at 9:47 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > On Sun, Mar 28, 2021 at 12:20:07AM +0200, Andy Shevchenko wrote:
> > > > > > > It's very convenient to see what properties and their values
> > > > > > > are currently being assigned in the registered software nodes.
> 
> ...
> 
> > > > > > > +             for (i = 0; i < prop->length / sizeof(u8); i++)
> > > > > > > +                     len += sysfs_emit_at(buf, len, "%u,", ((u8 *)pointer)[i]);
> > > > > >
> > > > > > No, sysfs is "one value per file", and that is not what you are showing
> > > > > > here at all :(
> > > > >
> > > > > It is following: it's a "one value" for property in question,
> > > > >
> > > > > As we may read in [1]: "...so it is socially acceptable to express an
> > > > > array of values of the same type."
> > > > >
> > > > > And here is exactly the case: *values of the same type*.
> > > >
> > > > So what is it going to look like exactly?
> > >
> > > Basically we have two approaches (already done in the kernel!) use space or
> > > comma for a separator. So:
> > >  - for boolean it will be an empty string (and it's one value always)
> > >  - for integers it will be, for example, '0,1,2' (w/o single quotes)
> > >    for property array with values 0, 1, and 2
> > >  - for plain integers or arrays out of 1 element it will be plain integer
> > >  - for strings it will be, for example, '"str1","str2"' (w/o single quotes)
> > >    for array of string { "str1", "str2" }
> > >  - for single string or array out of 1 element, it will be '"str"' (w/o single
> > >    quotes)
> > >
> > > This should be a part of documentation.
> >
> > And I will complain then too, these "lists of values" are not for sysfs,
> > sorry.
> 
> How can you recommend showing an array(s) of values of the same type?

I do not think that is something that should be shown in sysfs if at all
possible.

> > > > And what tool is going to be
> > > > there to parse this mess?  Who is going to to use it?
> > >
> > > I guess something like hwinfo (needs a patch).
> >
> > If nothing needs this, then why are you adding these?
> 
> OK, I will prepare tools first, but I have no idea for the format. So,
> how can I be sure that tools will accept the patch if there is no
> kernel interface available? Seems like a stale case.

Develop both together.  Do not think that you will get the kernel format
right without actually knowing what userspace needs/wants.  That is
crazy.

thanks,

greg k-h
