Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7ADA5E7
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 09:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407861AbfJQHC5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 03:02:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:31079 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390955AbfJQHC5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Oct 2019 03:02:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 00:02:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,306,1566889200"; 
   d="scan'208";a="279779997"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2019 00:02:48 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKzo7-0008AI-Np; Thu, 17 Oct 2019 10:02:47 +0300
Date:   Thu, 17 Oct 2019 10:02:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 05/14] software node: clean up
 property_copy_string_array()
Message-ID: <20191017070247.GA32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-6-dmitry.torokhov@gmail.com>
 <20191015120726.GG32742@smile.fi.intel.com>
 <20191015181211.GD105649@dtor-ws>
 <20191016075300.GO32742@smile.fi.intel.com>
 <20191016170059.GE35946@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016170059.GE35946@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2019 at 10:00:59AM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 16, 2019 at 10:53:00AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 15, 2019 at 11:12:11AM -0700, Dmitry Torokhov wrote:
> > > On Tue, Oct 15, 2019 at 03:07:26PM +0300, Andy Shevchenko wrote:

> > Yes, since property_set_pointer is called independently
> > on the type of the value.
> 
> We still call property_set_pointer() independently of the type of the
> value even with this patch. The point is that we do not set the pointer
> in property_copy_string_array(), so we only set the pointer once.
> 
> We used to have essentially for string arrays:
> 
> 	copy data
> 	set pointer in dst
> 	get pointer from dst
> 	set pointer in dst
> 
> With this patch we have:
> 
> 	copy data
> 	set pointer in dst

> > > This is confising and awkward and I believe it
> > > is cleaner for property_copy_string_array() to give a pointer to a copy
> > > of a string array, and then property_entry_copy_data() use it when
> > > handling the destination structure.
> > 
> > We probably need a 3rd opinion here.
> 
> I think I can still convince you ;)

Probably this is fine.

-- 
With Best Regards,
Andy Shevchenko


