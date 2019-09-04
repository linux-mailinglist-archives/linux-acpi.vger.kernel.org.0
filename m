Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE11A892E
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfIDPEg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 11:04:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:5161 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbfIDPEg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Sep 2019 11:04:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 08:04:19 -0700
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="358127318"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 08:04:16 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id E8AAF204A6; Wed,  4 Sep 2019 18:04:13 +0300 (EEST)
Date:   Wed, 4 Sep 2019 18:04:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 10/11] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190904150413.GU5475@paasikivi.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-11-sakari.ailus@linux.intel.com>
 <20190903130607.cf2qv3s3evobbd5g@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903130607.cf2qv3s3evobbd5g@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Petr,

On Tue, Sep 03, 2019 at 03:06:07PM +0200, Petr Mladek wrote:
> On Mon 2019-09-02 11:32:39, Sakari Ailus wrote:
> > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > support printing full path of the node, including its name ("f") and only
> > the node's name ("P") in the printk family of functions. The two flags
> > have equivalent functionality to existing %pOF with the same two modifiers
> > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > based systems is added by this patch.
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
> > +
> > +For printing information on fwnode handles. The default is to print the full
> > +node name, including the path. The modifiers are functionally equivalent to
> > +%pOF above.
> > +
> > +	- f - full name of the node, including the path
> > +	- P - the name of the node including an address (if there is one)
> > +
> > +Examples (ACPI):
> 
> s/:/::/ for the .rst formar.

Fixed both.

> 
> > +
> > +	%pfwf	\_SB.PCI0.CIO2.port@1.endpoint@0	- Full node name
> > +	%pfwP	endpoint@0				- Node name
> > +
> > +Examples (OF):
> 
> Same here.
> 
> > +
> > +	%pfwf	/ocp@68000000/i2c@48072000/camera@10/port/endpoint - Full name
> > +	%pfwP	endpoint				- Node name
> > +
> >  Time and date (struct rtc_time)
> >  -------------------------------
> >  
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 4ad9332d54ba6..b9b4c835db063 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1981,6 +1981,36 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
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

This should have been:

		return error_string(buf, end, "(%pf?)", spec);

I'll address that for v6.

> 
> This means that only "%pfw" will dereference the pointer by
> fwnode_full_name_string() or fwnode_get_name(). All the other
> eventual misuses of the obsolete %pf format will result in this
> error message.
> 
> OK, it is hard to imagine using "%pf" to get symbol name and always add
> 'w' suffix. Therefore it looks that reusing the obsolete %pf format
> modifier is pretty safe after all.
> 
> 
> > +	if (check_pointer(&buf, end, fwnode, spec))
> > +		return buf;
> > +
> > +	fmt++;
> > +
> > +	switch (*fmt) {
> > +	case 'f':	/* full_name */
> > +	default:
> 
> Using default: in the middle of switch might cause a lot of confusion.
> Please, make it the last label.

Fixed.

> 
> 
> > +		buf = fwnode_full_name_string(fwnode, buf, end);
> > +		break;
> > +	case 'P':	/* name */
> > +		buf = string(buf, end, fwnode_get_name(fwnode), str_spec);
> > +		break;
> > +	}
> > +
> > +	return widen_string(buf, buf - buf_start, end, spec);
> > +}
> > +
> >  /*
> >   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
> >   * by an extra set of alphanumeric characters that are extended format
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index a60c241112cd4..8df50911ff4e9 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -5995,7 +5995,8 @@ sub process {
> >  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> >  					$specifier = $1;
> >  					$extension = $2;
> > -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> > +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
> > +					    $extension =~ /^f[^w]/) {
> 
> This does not work. $extension seems to have only one character.

Good catch. \w indeed matches a single letter; I'll change that to \w+ and
change the other uses accordingly.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
