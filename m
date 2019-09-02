Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D00EA4FA6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 09:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfIBHW2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 03:22:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:5185 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbfIBHW1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 03:22:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:22:27 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="184429072"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:22:25 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id CB98C20B09; Mon,  2 Sep 2019 10:22:22 +0300 (EEST)
Date:   Mon, 2 Sep 2019 10:22:22 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 09/10] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190902072222.GG5475@paasikivi.fi.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
 <20190829101043.24963-10-sakari.ailus@linux.intel.com>
 <20190830130349.GJ2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830130349.GJ2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Thanks for the review.

On Fri, Aug 30, 2019 at 04:03:49PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2019 at 01:10:42PM +0300, Sakari Ailus wrote:
> > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > support printing full path of the node, including its name ("f") and only
> > the node's name ("P") in the printk family of functions. The two flags
> > have equivalent functionality to existing %pOF with the same two modifiers
> > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > based systems is added by this patch.
> > 
> > On ACPI based systems the resulting strings look like
> > 
> > 	\_SB.PCI0.CIO2.port@1.endpoint@0
> > 
> > where the nodes are separated by a dot (".") and the first three are
> > ACPI device nodes and the latter two ACPI data nodes.
> 
> Couple of comments below, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> 
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  Documentation/core-api/printk-formats.rst | 24 +++++++++++++++
> >  lib/vsprintf.c                            | 37 +++++++++++++++++++++++
> >  scripts/checkpatch.pl                     |  3 +-
> >  3 files changed, 63 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> > index 922a29eb70e6c..abba210f67567 100644
> > --- a/Documentation/core-api/printk-formats.rst
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -418,6 +418,30 @@ Examples::
> >  
> >  Passed by reference.
> >  
> > +Fwnode handles
> > +--------------
> > +
> > +::
> > +
> > +	%pfw[fP]
> 
> I'm not familiar with all flavours of the OF case, the question is do we use
> same letters for analogues?

Yes. There are some that may be unworkable to be extended, but in general
this helps folks who are familiar with the OF conversion specifiers.

> 
> > +
> > +For printing information on fwnode handles. The default is to print the full
> > +node name, including the path. The modifiers are functionally equivalent to
> > +%pOF above.
> > +
> > +	- f - full name of the node, including the path
> > +	- P - the name of the node including an address (if there is one)
> > +
> > +Examples (ACPI):
> > +
> > +	%pfwf	\_SB.PCI0.CIO2.port@1.endpoint@0	- Full node name
> > +	%pfwP	endpoint@0				- Node name
> > +
> > +Examples (OF):
> > +
> > +	%pfwf	/ocp@68000000/i2c@48072000/camera@10/port/endpoint - Full name
> > +	%pfwP	endpoint				- Node name
> > +
> >  Time and date (struct rtc_time)
> >  -------------------------------
> >  
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 19f9b3f30623e..79dacd0b9e124 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1978,6 +1978,37 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
> >  	return widen_string(buf, buf - buf_start, end, spec);
> >  }
> >  
> > +static noinline_for_stack
> > +char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> > +		    struct printf_spec spec, const char *fmt)
> > +{
> > +	struct printf_spec str_spec = spec;
> > +	char *buf_start = buf;
> > +
> > +	str_spec.field_width = -1;
> > +
> > +	if (*fmt != 'w')
> > +		return error_string(buf, end, "(%pfw?)", spec);
> > +
> > +	if (check_pointer(&buf, end, fwnode, spec))
> > +		return buf;
> > +
> > +	fmt++;
> > +
> > +	switch (*fmt) {
> > +	case 'f':	/* full_name */
> > +	default:
> > +		buf = fwnode_full_name_string(fwnode, buf, end);
> > +		break;
> > +	case 'P':	/* name */
> 
> > +		buf = string(buf, end, fwnode_get_name(fwnode),
> > +			     str_spec);
> 
> Perfectly one line.

Fixed.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
