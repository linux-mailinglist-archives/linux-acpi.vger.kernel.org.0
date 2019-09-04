Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586B4A8C3A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfIDQK7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 12:10:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:62815 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732057AbfIDQK6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Sep 2019 12:10:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 09:10:56 -0700
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="183951504"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 09:10:54 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 07921204A6; Wed,  4 Sep 2019 19:10:52 +0300 (EEST)
Date:   Wed, 4 Sep 2019 19:10:51 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 11/11] lib/test_printf: Add tests for %pfw printk
 modifier
Message-ID: <20190904161051.GX5475@paasikivi.fi.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <20190902135732.23455-12-sakari.ailus@linux.intel.com>
 <20190902161352.GS2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902161352.GS2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Mon, Sep 02, 2019 at 07:13:52PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 02, 2019 at 04:57:32PM +0300, Sakari Ailus wrote:
> > Add a test for the %pfw printk modifier using software nodes.
> 
> > +static void __init fwnode_pointer(void)
> > +{
> > +	const struct software_node softnodes[] = {
> > +		{ .name = "first", },
> > +		{ .name = "second", .parent = &softnodes[0], },
> > +		{ .name = "third", .parent = &softnodes[1], },
> > +		{ NULL /* Guardian */ },
> 
> Comma is still here :-)

Oops. I ended up removing the comma in a wrong patch which wasn't submitted
to the list. Will fix for v6.

> 
> > +	};
> 
> > +	test(full_name_second, "%pfw",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> > +	test(full_name, "%pfw",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> > +	test(full_name, "%pfwf",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> > +	test(second_name, "%pfwP",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> > +	test(third_name, "%pfwP",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> 
> I have another thought about these. The test cases will fail in either of
> adding, inserting or removing items in softnodes array. So, using the above
> "protective" scheme doesn't bring any value except making readability worse.

Agreed, to be addressed in v6.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
