Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D2A8D9B
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfIDRW0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 13:22:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:38749 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731447AbfIDRW0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Sep 2019 13:22:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="173650270"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 04 Sep 2019 10:22:23 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i5Yz8-0004TZ-Pl; Wed, 04 Sep 2019 20:22:22 +0300
Date:   Wed, 4 Sep 2019 20:22:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 11/11] lib/test_printf: Add tests for %pfw printk
 modifier
Message-ID: <20190904172222.GV2680@smile.fi.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <20190902135732.23455-12-sakari.ailus@linux.intel.com>
 <20190902161352.GS2680@smile.fi.intel.com>
 <20190904161051.GX5475@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904161051.GX5475@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 04, 2019 at 07:10:51PM +0300, Sakari Ailus wrote:
> On Mon, Sep 02, 2019 at 07:13:52PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 02, 2019 at 04:57:32PM +0300, Sakari Ailus wrote:
> > > Add a test for the %pfw printk modifier using software nodes.
> > 
> > > +static void __init fwnode_pointer(void)
> > > +{
> > > +	const struct software_node softnodes[] = {
> > > +		{ .name = "first", },
> > > +		{ .name = "second", .parent = &softnodes[0], },
> > > +		{ .name = "third", .parent = &softnodes[1], },
> > > +		{ NULL /* Guardian */ },
> > 
> > Comma is still here :-)
> 
> Oops. I ended up removing the comma in a wrong patch which wasn't submitted
> to the list. Will fix for v6.

Also you may remove NULL there since it's default.

-- 
With Best Regards,
Andy Shevchenko


