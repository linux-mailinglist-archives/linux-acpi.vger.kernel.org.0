Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42634BC79
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Mar 2021 15:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhC1NCa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Mar 2021 09:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhC1NC2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Mar 2021 09:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 446516186A;
        Sun, 28 Mar 2021 13:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616936547;
        bh=5i4jugDvs90F+iFZ+7J6N2DF93Rc5dBsxwcqjs6tLTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nj0R/QZV7zvE4JFVtr4DPDcuRCCM6y2ekZPxJVggQT4BLoGBFR8KJDT2b+lwjLPzU
         azeVVrjV/7xn0I47ttdQdzN7mFNDnxSFalpn25oWVWFRsuClpLuNsi+q/MLEw3/qMe
         rUD8RXvKNTN5+XAgt/+CXWXxuREw/yf4Aou9JxgI=
Date:   Sun, 28 Mar 2021 15:02:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
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
Message-ID: <YGB+YMh1MsQao3zS@kroah.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-3-andriy.shevchenko@linux.intel.com>
 <YGAmB2Nwph6pArXc@kroah.com>
 <CAHp75VfFzqpdR+6p9vQww-ujQcw3L-V_N7ezUTGhcRmvwvqMZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfFzqpdR+6p9vQww-ujQcw3L-V_N7ezUTGhcRmvwvqMZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 28, 2021 at 03:56:26PM +0300, Andy Shevchenko wrote:
> On Sun, Mar 28, 2021 at 9:47 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Mar 28, 2021 at 12:20:07AM +0200, Andy Shevchenko wrote:
> > > It's very convenient to see what properties and their values
> > > are currently being assigned in the registered software nodes.
> > >
> > > Show properties and their values in sysfs.
> 
> ...
> 
> > > +             for (i = 0; i < prop->length / sizeof(u8); i++)
> > > +                     len += sysfs_emit_at(buf, len, "%u,", ((u8 *)pointer)[i]);
> >
> > No, sysfs is "one value per file", and that is not what you are showing
> > here at all :(
> 
> It is following: it's a "one value" for property in question,
> 
> As we may read in [1]: "...so it is socially acceptable to express an
> array of values of the same type."
> 
> And here is exactly the case: *values of the same type*.

So what is it going to look like exactly?  And what tool is going to be
there to parse this mess?  Who is going to to use it?

Arrays of data are not "one value".

thanks,

greg k-h
