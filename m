Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0853FE1F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2019 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfD3Qrs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Apr 2019 12:47:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:51649 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3Qrr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Apr 2019 12:47:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 09:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="342168766"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 30 Apr 2019 09:47:45 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hLVuy-0007xt-7k; Tue, 30 Apr 2019 19:47:44 +0300
Date:   Tue, 30 Apr 2019 19:47:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / property: fix handling of data_nodes in
 acpi_get_next_subnode()
Message-ID: <20190430164744.GO9224@smile.fi.intel.com>
References: <20190430155229.14213-1-pierre-louis.bossart@linux.intel.com>
 <20190430163041.GN9224@smile.fi.intel.com>
 <ba56e822-92ee-7a75-5c62-45f3a572ccde@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba56e822-92ee-7a75-5c62-45f3a572ccde@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 30, 2019 at 11:41:50AM -0500, Pierre-Louis Bossart wrote:
> On 4/30/19 11:30 AM, Andy Shevchenko wrote:
> > On Tue, Apr 30, 2019 at 10:52:29AM -0500, Pierre-Louis Bossart wrote:
> > > When the DSDT tables expose devices with subdevices and a set of
> > > hierarchical _DSD properties, the data returned by
> > > acpi_get_next_subnode() is incorrect, with the results suggesting a bad
> > > pointer assignment. The parser works fine with device_nodes or
> > > data_nodes, but not with a combination of the two.
> > > 
> > > The problem is traced to an invalid pointer used when jumping from
> > > handling device_nodes to data nodes. The existing code looks for data
> > > nodes below the last subdevice found instead of the common root. Fix
> > > by forcing the acpi_device pointer to be derived from the same fwnode
> > > for the two types of subnodes.
> > > 
> > > This same problem of handling device and data nodes was already fixed
> > > in a similar way by 'commit bf4703fdd166 ("ACPI / property: fix data
> > > node parsing in acpi_get_next_subnode()")' but broken later by 'commit
> > > 34055190b19 ("ACPI / property: Add fwnode_get_next_child_node()")', so
> > > this should probably go to linux-stable all the way to 4.12
> > 
> > Period is missed in above sentence.
> > 
> > I think it make sense to add Fixes: tag.
> 
> Thanks Andy for the review. I hesitated to add a fixes tag. The line about
> resetting the adev pointer was indeed removed in the latter commit, but
> there were a slew of other changes done later by Sakari on hierarchical _DSD
> so it's quite complicated to say when this was last fully functional.

I see, btw, you forgot to add Sakari to Cc list, he is doing a lot lately WRT
device properties.

> > Nevertheless,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thank you for fixing this interesting issue!

-- 
With Best Regards,
Andy Shevchenko


