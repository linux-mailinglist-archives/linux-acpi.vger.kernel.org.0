Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30F7A4F8E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 09:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfIBHLg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 03:11:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:48282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbfIBHLf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 03:11:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:11:34 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="183240942"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:11:31 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 3C25120B09; Mon,  2 Sep 2019 10:11:30 +0300 (EEST)
Date:   Mon, 2 Sep 2019 10:11:30 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 07/10] lib/vsprintf: Make use of fwnode API to obtain
 node names and separators
Message-ID: <20190902071130.GF5475@paasikivi.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-8-sakari.ailus@linux.intel.com>
 <20190830125314.GG2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830125314.GG2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Fri, Aug 30, 2019 at 03:53:14PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2019 at 01:10:40PM +0300, Sakari Ailus wrote:
> > Instead of implementing our own means of discovering parent nodes, node
> > names or counting how many parents a node has, use the newly added
> > functions in the fwnode API to obtain that information.
> > 
> 
> Some style comments below.
> Nevertheless,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  lib/vsprintf.c | 38 ++++++++++++++++----------------------
> >  1 file changed, 16 insertions(+), 22 deletions(-)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index b00b57f9f911f..a04a2167101ef 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -38,6 +38,7 @@
> >  #include <net/addrconf.h>
> >  #include <linux/siphash.h>
> >  #include <linux/compiler.h>
> > +#include <linux/property.h>
> >  #ifdef CONFIG_BLOCK
> >  #include <linux/blkdev.h>
> >  #endif
> > @@ -1863,32 +1864,24 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
> >  	return format_flags(buf, end, flags, names);
> >  }
> >  
> > -static const char *device_node_name_for_depth(const struct device_node *np, int depth)
> > -{
> > -	for ( ; np && depth; depth--)
> > -		np = np->parent;
> > -
> > -	return kbasename(np->full_name);
> > -}
> > -
> >  static noinline_for_stack
> > -char *device_node_gen_full_name(const struct device_node *np, char *buf, char *end)
> 
> > +char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
> > +			      char *end)
> 
> I would leave it on one line.
> 
> >  {
> >  	int depth;
> > -	const struct device_node *parent = np->parent;
> >  
> > -	/* special case for root node */
> > -	if (!parent)
> > -		return string_nocheck(buf, end, "/", default_str_spec);
> > +	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
> > +		struct fwnode_handle *__fwnode =
> > +			fwnode_get_nth_parent(fwnode, depth);
> 
> Ditto if you name temporary variable like fw / fh / fn / etc.
> 
> >  
> > -	for (depth = 0; parent->parent; depth++)
> > -		parent = parent->parent;
> > -
> > -	for ( ; depth >= 0; depth--) {
> > -		buf = string_nocheck(buf, end, "/", default_str_spec);
> > -		buf = string(buf, end, device_node_name_for_depth(np, depth),
> 
> > +		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
> > +			     default_str_spec);
> > +		buf = string(buf, end, fwnode_get_name(__fwnode),
> >  			     default_str_spec);
> 
> Ditto.
> 
> > +
> > +		fwnode_handle_put(__fwnode);
> >  	}
> > +
> >  	return buf;
> >  }
> >  
> > @@ -1933,10 +1926,11 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
> >  
> >  		switch (*fmt) {
> >  		case 'f':	/* full_name */
> > -			buf = device_node_gen_full_name(dn, buf, end);
> 
> > +			buf = fwnode_full_name_string(of_fwnode_handle(dn), buf,
> > +						      end);
> 
> Ditto, disregard checkpatch.

Why? I see no reason to avoid wrapping here; in fact, if I'd review a patch
that contained such code, I'd ask the submitter to wrap the lines.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
