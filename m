Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218B8AB2BB
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390235AbfIFHAn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 03:00:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:16311 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387820AbfIFHAn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Sep 2019 03:00:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 00:00:42 -0700
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="199460254"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 00:00:38 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 6E2A82051A; Fri,  6 Sep 2019 10:00:36 +0300 (EEST)
Date:   Fri, 6 Sep 2019 10:00:36 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 11/11] lib/test_printf: Add tests for %pfw printk
 modifier
Message-ID: <20190906070036.GI5475@paasikivi.fi.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <20190902135732.23455-12-sakari.ailus@linux.intel.com>
 <20190902161352.GS2680@smile.fi.intel.com>
 <20190904161051.GX5475@paasikivi.fi.intel.com>
 <20190904172222.GV2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904172222.GV2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 04, 2019 at 08:22:22PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 04, 2019 at 07:10:51PM +0300, Sakari Ailus wrote:
> > On Mon, Sep 02, 2019 at 07:13:52PM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 02, 2019 at 04:57:32PM +0300, Sakari Ailus wrote:
> > > > Add a test for the %pfw printk modifier using software nodes.
> > > 
> > > > +static void __init fwnode_pointer(void)
> > > > +{
> > > > +	const struct software_node softnodes[] = {
> > > > +		{ .name = "first", },
> > > > +		{ .name = "second", .parent = &softnodes[0], },
> > > > +		{ .name = "third", .parent = &softnodes[1], },
> > > > +		{ NULL /* Guardian */ },
> > > 
> > > Comma is still here :-)
> > 
> > Oops. I ended up removing the comma in a wrong patch which wasn't submitted
> > to the list. Will fix for v6.
> 
> Also you may remove NULL there since it's default.

Then it'd become GCC specific. Albeit I'm not sure that's any kind of a
problem in practice. I guess Clang must cope with that, too? Still, I
prefer not to use compiler specific syntax if there's no need to.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
