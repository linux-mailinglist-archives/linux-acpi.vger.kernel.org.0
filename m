Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DFC173814
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2020 14:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1NQj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Feb 2020 08:16:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:26320 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgB1NQj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Feb 2020 08:16:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 05:16:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="261854458"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2020 05:16:35 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j7fVN-005Qeh-Q5; Fri, 28 Feb 2020 15:16:37 +0200
Date:   Fri, 28 Feb 2020 15:16:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
Message-ID: <20200228131637.GK1224808@smile.fi.intel.com>
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
 <20200225105437.GG10400@smile.fi.intel.com>
 <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
 <20200225123425.GK10400@smile.fi.intel.com>
 <20200225125700.GL10400@smile.fi.intel.com>
 <44cc5510-571c-21c4-1855-f3141f72eaa3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44cc5510-571c-21c4-1855-f3141f72eaa3@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 28, 2020 at 12:22:45PM +0100, Hans de Goede wrote:
> On 2/25/20 1:57 PM, Andy Shevchenko wrote:
> > On Tue, Feb 25, 2020 at 02:34:25PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 25, 2020 at 12:26:04PM +0100, Hans de Goede wrote:
> > 
> > > Let's do it as a list of pairs, but in slightly different format (I see some
> > > potential to derive a generic parser, based on users described in
> > > Documentation/admin-guide/kernel-parameters.txt), i.e.
> > > 
> > > 	ignore_wake=pin:controller[,pin:controller[,...]]
> > 
> > Another possible format
> > 
> > 	ignore_wake=controller@pin[;controller@pin[;...]]
> 
> I like this one, the other one with the pin first feels wrong, the pin is
> part of the controller, not the other way around.

Yes, I agree.

> I will rework the patch series to use the ignore_wake=controller@pin format.
> 
> > The second one, while having less users, can be extended to have list of pins
> > of the same controller, like
> > 
> > 	ignore_wake=controller@pin[:pin2:pin3][;controller@pin[:...][;...]]
> 
> I don't really see a need for this, the controller name can be repeated
> in the unlikely case where more then one pin needs to be blacklisted
> from wakeup and I would like to keep the parsing as KISS as possible.
> 
> I guess we can always add this later if people feel like adding it.

Right.

-- 
With Best Regards,
Andy Shevchenko


