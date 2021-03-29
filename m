Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D696734D0D5
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhC2NBo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 09:01:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:38158 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhC2NB2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 09:01:28 -0400
IronPort-SDR: IZ4WvCnN/rFWLCZ0t0+yM4JxD1/NxasVKi+gGIt1PZUnpLUmsYZ2Qw7THHjt/dMBuW9D74aErp
 Zh39Sg16Y6sQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="188275054"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="188275054"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 06:01:26 -0700
IronPort-SDR: r29PVR40HJDKTPxnh2BdepZ2i6qkER5CYOGByOT3/Lm06gJBDSe6vdRkyLv4TeOa0FYGKNR1VK
 Nq8h5aza3AAQ==
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="376417615"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 06:01:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lQrWA-00H1cf-Md; Mon, 29 Mar 2021 16:01:18 +0300
Date:   Mon, 29 Mar 2021 16:01:18 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <YGHPnkoB/wP6u6HC@smile.fi.intel.com>
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-3-andriy.shevchenko@linux.intel.com>
 <YGAmB2Nwph6pArXc@kroah.com>
 <CAHp75VfFzqpdR+6p9vQww-ujQcw3L-V_N7ezUTGhcRmvwvqMZg@mail.gmail.com>
 <YGB+YMh1MsQao3zS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGB+YMh1MsQao3zS@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 28, 2021 at 03:02:24PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Mar 28, 2021 at 03:56:26PM +0300, Andy Shevchenko wrote:
> > On Sun, Mar 28, 2021 at 9:47 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Mar 28, 2021 at 12:20:07AM +0200, Andy Shevchenko wrote:
> > > > It's very convenient to see what properties and their values
> > > > are currently being assigned in the registered software nodes.
> > > >
> > > > Show properties and their values in sysfs.
> > 
> > ...
> > 
> > > > +             for (i = 0; i < prop->length / sizeof(u8); i++)
> > > > +                     len += sysfs_emit_at(buf, len, "%u,", ((u8 *)pointer)[i]);
> > >
> > > No, sysfs is "one value per file", and that is not what you are showing
> > > here at all :(
> > 
> > It is following: it's a "one value" for property in question,
> > 
> > As we may read in [1]: "...so it is socially acceptable to express an
> > array of values of the same type."
> > 
> > And here is exactly the case: *values of the same type*.
> 
> So what is it going to look like exactly?

Basically we have two approaches (already done in the kernel!) use space or
comma for a separator. So:
 - for boolean it will be an empty string (and it's one value always)
 - for integers it will be, for example, '0,1,2' (w/o single quotes)
   for property array with values 0, 1, and 2
 - for plain integers or arrays out of 1 element it will be plain integer
 - for strings it will be, for example, '"str1","str2"' (w/o single quotes)
   for array of string { "str1", "str2" }
 - for single string or array out of 1 element, it will be '"str"' (w/o single
   quotes)

This should be a part of documentation.

> And what tool is going to be
> there to parse this mess?  Who is going to to use it?

I guess something like hwinfo (needs a patch).

The idea behind that this is following what ACPI and DT provides to the users
via /sys/firmware/ (however, in binary format). I can re-do to provide a
binary, and it will effectively make software nodes in align with the rest.

-- 
With Best Regards,
Andy Shevchenko


