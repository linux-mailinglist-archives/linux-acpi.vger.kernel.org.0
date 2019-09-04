Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2573BA885C
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfIDOEF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 10:04:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:11571 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfIDOEF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Sep 2019 10:04:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 07:04:03 -0700
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="185122449"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 07:03:58 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 61906204A6; Wed,  4 Sep 2019 17:03:45 +0300 (EEST)
Date:   Wed, 4 Sep 2019 17:03:45 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 11/11] lib/test_printf: Add tests for %pfw printk
 modifier
Message-ID: <20190904140345.GT5475@paasikivi.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-12-sakari.ailus@linux.intel.com>
 <20190903133841.dhb6k2lwx2gglyjs@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903133841.dhb6k2lwx2gglyjs@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Petr,

Thanks for the comments.

On Tue, Sep 03, 2019 at 03:38:41PM +0200, Petr Mladek wrote:
> On Mon 2019-09-02 11:32:40, Sakari Ailus wrote:
> > Add a test for the %pfw printk modifier using software nodes.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  lib/test_printf.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/lib/test_printf.c b/lib/test_printf.c
> > index 944eb50f38625..9c6d716979fb1 100644
> > --- a/lib/test_printf.c
> > +++ b/lib/test_printf.c
> > @@ -22,6 +22,8 @@
> >  #include <linux/gfp.h>
> >  #include <linux/mm.h>
> >  
> > +#include <linux/property.h>
> > +
> >  #include "../tools/testing/selftests/kselftest_module.h"
> >  
> >  #define BUF_SIZE 256
> > @@ -588,6 +590,40 @@ flags(void)
> >  	kfree(cmp_buffer);
> >  }
> >  
> > +static void __init fwnode_pointer(void)
> > +{
> > +	const struct software_node softnodes[] = {
> > +		{ .name = "first", },
> > +		{ .name = "second", .parent = &softnodes[0], },
> > +		{ .name = "third", .parent = &softnodes[1], },
> > +		{ NULL /* Guardian */ },
> > +	};
> > +	const char * const full_name = "/second/third";
> > +	const char * const full_name_second = "/second";
> > +	const char * const second_name = "second";
> > +	const char * const third_name = "third";
> > +	int rval;
> > +
> > +	rval = software_node_register_nodes(softnodes);
> > +	if (rval) {
> > +		pr_warn("cannot register softnodes; rval %d\n", rval);
> > +		return;
> > +	}
> > +
> > +	test(full_name_second, "%pfw",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> 
> "ARRAY_SIZE(softnodes) - 3" is quite cryptic.
> Is there any particular reason to use it instead of &softnodes[1] ?

I'm fine using a direct index, rather than refer to entries from the top
downwards.

> 
> And is it expected that it does not print the "/first" parent?

Heikki actually commented on an issue related to the "root" nodes. I'll
reply to his comment, on the 5th patch of the set.

> 
> > +	test(full_name, "%pfw",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> > +	test(full_name, "%pfwf",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> > +	test(second_name, "%pfwP",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> > +	test(third_name, "%pfwP",
> > +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> > +
> > +	software_node_unregister_nodes(softnodes);
> > +}
> 
> Anyway, thanks for the tests.

You're welcome!

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
