Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61DA16C0DF
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgBYMe0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 07:34:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:6003 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbgBYMe0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Feb 2020 07:34:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 04:34:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="255937149"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 25 Feb 2020 04:34:23 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j6ZPt-004edw-LQ; Tue, 25 Feb 2020 14:34:25 +0200
Date:   Tue, 25 Feb 2020 14:34:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
Message-ID: <20200225123425.GK10400@smile.fi.intel.com>
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
 <20200225105437.GG10400@smile.fi.intel.com>
 <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 25, 2020 at 12:26:04PM +0100, Hans de Goede wrote:
> On 2/25/20 11:54 AM, Andy Shevchenko wrote:
> > On Tue, Feb 25, 2020 at 11:27:52AM +0100, Hans de Goede wrote:

...

> > In general I'm fine with this, but looking to the history of your changes I'm
> > afraid that in future it will require more than one pin to be listed or
> > something like this.
> 
> The only models which need this so far are the weird HP X2 models which
> use an external embedded controller with the tablet version of BYT / CHT
> which is just al sorts of hacked together. Also see:
> 
> https://lore.kernel.org/stable/20200223153208.312005-1-hdegoede@redhat.com/T/#u
> 
> For other parts of the same device which also rather "hacked together"
> HP made these models really really interesting...
> 
> With that said I cannot guarantee that we won't need something similar
> for some other botched-up device.

...

> > > +static int ignore_wake = IGNORE_WAKE_AUTO;
> > > +module_param(ignore_wake, int, 0444);
> > > +MODULE_PARM_DESC(ignore_wake,
> > > +	"Ignore ACPI wake flag: x=ignore-for-pin-x, -1=auto, -2=all, -3=none");
> > 
> > Perhaps we may take list of pins or a bitmap (see bitmap list parsers API).
> 
> I guess you mean bitmap_parse_user / bitmap_print_to_pagebuf, the problem
> is that for a more generic solution we need a wat to specify the
> GPIO controller + the pin, so we would get a list of <name>,<pin> pairs
> and then need to parse that, e.g. :
> 
> 	gpiolib_acpi.ignore_wake=INT33FC:00,0x1c;INT33FC:01;0x12
> 
> I agree that if we really want to future proof this that then this is
> the way we should go. This does mean adding a bunch of extra code for
> parsing this, but I guess that would be better then my current hack.
> 
> Please let me know if you prefer going this route then I will respin
> the patches to work this way.

Let's do it as a list of pairs, but in slightly different format (I see some
potential to derive a generic parser, based on users described in
Documentation/admin-guide/kernel-parameters.txt), i.e.

	ignore_wake=pin:controller[,pin:controller[,...]]

...

> > > -MODULE_PARM_DESC(honor_wakeup,
> > > -		 "Honor the ACPI wake-capable flag: 0=no, 1=yes, -1=auto");

> > Isn't it now a part of ABI? I don't think we may remove it, though we may ignore it.
> > Or do something else.
> > 
> > (One of the reasons why I hate module parameters)
> 
> I personally do not subscribe to the module parameters are part of the kernel ABI
> crowd. I do not think Linus has ever stated something like that ?  For long existing
> often used module parameters treating them as such makes a ton of sense, but this
> one is quite new and AFAIK almost nobody is using it. So my vote would be to just
> drop it. If we get push back we can easily restore it in some form.

I'm fine with dropping it, perhaps add a phrase to the commit message about
(safe) removal.

-- 
With Best Regards,
Andy Shevchenko


