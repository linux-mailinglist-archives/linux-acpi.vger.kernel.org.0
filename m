Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F334D1A4
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhC2NrJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 09:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhC2Nq5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 09:46:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EA4B61554;
        Mon, 29 Mar 2021 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617025616;
        bh=c/WTy9azX0/08KD45OZAEbmjtj/yV6bJ6UiCDZa0+JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkTTzmLmQjpE9FiGmyxjjcHBGDyt92CxYwGWCVLHLvHcAfwAhDuXCBplbqcqEyTY+
         WaAZQ/t2njGUMczl1F9flOs/0SBZJL6sLcL5sMXTIY8OxQ/gCpxSpND2spBzHvWO1r
         vxk08s8FbL/c7FXwELNwbcC+su0rSvVmGYuGtnII=
Date:   Mon, 29 Mar 2021 15:46:53 +0200
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
Message-ID: <YGHaTf+cpvAZ5geB@kroah.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-3-andriy.shevchenko@linux.intel.com>
 <YGAmB2Nwph6pArXc@kroah.com>
 <CAHp75VfFzqpdR+6p9vQww-ujQcw3L-V_N7ezUTGhcRmvwvqMZg@mail.gmail.com>
 <YGB+YMh1MsQao3zS@kroah.com>
 <YGHPnkoB/wP6u6HC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGHPnkoB/wP6u6HC@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 29, 2021 at 04:01:18PM +0300, Andy Shevchenko wrote:
> On Sun, Mar 28, 2021 at 03:02:24PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Mar 28, 2021 at 03:56:26PM +0300, Andy Shevchenko wrote:
> > > On Sun, Mar 28, 2021 at 9:47 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sun, Mar 28, 2021 at 12:20:07AM +0200, Andy Shevchenko wrote:
> > > > > It's very convenient to see what properties and their values
> > > > > are currently being assigned in the registered software nodes.
> > > > >
> > > > > Show properties and their values in sysfs.
> > > 
> > > ...
> > > 
> > > > > +             for (i = 0; i < prop->length / sizeof(u8); i++)
> > > > > +                     len += sysfs_emit_at(buf, len, "%u,", ((u8 *)pointer)[i]);
> > > >
> > > > No, sysfs is "one value per file", and that is not what you are showing
> > > > here at all :(
> > > 
> > > It is following: it's a "one value" for property in question,
> > > 
> > > As we may read in [1]: "...so it is socially acceptable to express an
> > > array of values of the same type."
> > > 
> > > And here is exactly the case: *values of the same type*.
> > 
> > So what is it going to look like exactly?
> 
> Basically we have two approaches (already done in the kernel!) use space or
> comma for a separator. So:
>  - for boolean it will be an empty string (and it's one value always)
>  - for integers it will be, for example, '0,1,2' (w/o single quotes)
>    for property array with values 0, 1, and 2
>  - for plain integers or arrays out of 1 element it will be plain integer
>  - for strings it will be, for example, '"str1","str2"' (w/o single quotes)
>    for array of string { "str1", "str2" }
>  - for single string or array out of 1 element, it will be '"str"' (w/o single
>    quotes)
> 
> This should be a part of documentation.

And I will complain then too, these "lists of values" are not for sysfs,
sorry.

> > And what tool is going to be
> > there to parse this mess?  Who is going to to use it?
> 
> I guess something like hwinfo (needs a patch).

If nothing needs this, then why are you adding these?

> The idea behind that this is following what ACPI and DT provides to the users
> via /sys/firmware/ (however, in binary format). I can re-do to provide a
> binary, and it will effectively make software nodes in align with the rest.

binary files in sysfs are only to be used as a "pass through" from
hardware to userspace.  That does not seem relevant here.

sorry, please keep this out of sysfs for now.

greg k-h
