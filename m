Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEBF2E35B9
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Dec 2020 11:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgL1KPO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 05:15:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:30884 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgL1KPN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Dec 2020 05:15:13 -0500
IronPort-SDR: HBP2g1Q93KKK65JbxiSPMynVPbZOitzEy5YfqrGjZV4VXGO1AhB9SLujPmdc148flvUXdGatzr
 iEUKZxLb/iQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9847"; a="172857407"
X-IronPort-AV: E=Sophos;i="5.78,454,1599548400"; 
   d="scan'208";a="172857407"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 02:14:32 -0800
IronPort-SDR: 2o4QrVc5rt8K5snm4jNOP8DVG+i65S6cUj1QRCuntb4Jlr6nOgSwGZOxSK/8GtFxZXGVM90fgy
 5VWJOoopVeow==
X-IronPort-AV: E=Sophos;i="5.78,454,1599548400"; 
   d="scan'208";a="384530659"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 02:14:25 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1ktpYk-000CE8-13; Mon, 28 Dec 2020 12:15:26 +0200
Date:   Mon, 28 Dec 2020 12:15:26 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Daniel Scally' <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        "niklas.soderlund+renesas@ragnatech.se" 
        <niklas.soderlund+renesas@ragnatech.se>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 05/14] software_node: unregister software_nodes in
 reverse order
Message-ID: <20201228101526.GV4077@smile.fi.intel.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-6-djrscally@gmail.com>
 <CAHp75VdF5NdjrSxcOafh7KNNDteYEUDk9otA0HKX-iks7G0D4g@mail.gmail.com>
 <de478ef0-0b4d-df1d-2651-9cc35bf2f45b@gmail.com>
 <CAHp75VdWuowLenNPQRNc+QXeyuvwKqh_bjw=1WvmFrzoygXFRw@mail.gmail.com>
 <2b415312-fe30-c73b-0077-4ec2a07116df@gmail.com>
 <fcb07dea193b4b99b11f2a8e684d8acf@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb07dea193b4b99b11f2a8e684d8acf@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 24, 2020 at 06:36:10PM +0000, David Laight wrote:
> From: Daniel Scally 
> > Sent: 24 December 2020 14:14
> ...
> > >> The array will be unwound in reverse order (i.e. last entry first). If
> > >> any member of the array is a child of another member then the child must
> > > children ?
> > 
> > Yes, you are right of course.
> 
> The second 'child' is a back-reference to 'any member' so is singular
> so 'child' is correct.
> 'the child' could be replaced by 'it'
> 
> You could have:
>    If any members of the array are children of another member then the
>    children must appear later in the list.

Works for me!
Dan, can you consider David's proposal?

-- 
With Best Regards,
Andy Shevchenko


