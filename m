Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B2BD9712
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406145AbfJPQXL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 12:23:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:52798 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfJPQXL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Oct 2019 12:23:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 09:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="220832260"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2019 09:23:08 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKm4q-0005d4-0w; Wed, 16 Oct 2019 19:23:08 +0300
Date:   Wed, 16 Oct 2019 19:23:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 11/14] software node: move small properties inline
 when copying
Message-ID: <20191016162308.GY32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-12-dmitry.torokhov@gmail.com>
 <20191015122028.GI32742@smile.fi.intel.com>
 <20191015182553.GG105649@dtor-ws>
 <20191016074857.GN32742@smile.fi.intel.com>
 <20191016160126.GB35946@dtor-ws>
 <20191016161845.GX32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016161845.GX32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2019 at 07:18:45PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 16, 2019 at 09:01:26AM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 16, 2019 at 10:48:57AM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 15, 2019 at 11:25:53AM -0700, Dmitry Torokhov wrote:
> 
> > > You store a value as union, but going to read as a member of union?
> > > I'm pretty sure it breaks standard rules.
> > 
> > No, I move the values _in place_ of the union, and the data is always
> > fetched via void pointers. And copying data via char * or memcpy() is
> > allowed even in C99 and C11.
> > 
> > But I am wondering why are we actually worrying about all of this? The
> > kernel is gnu89 and I think is going to stay this way because we use
> > initializers with a cast in a lot of places:
> > 
> > #define __RAW_SPIN_LOCK_UNLOCKED(lockname)      \
> >         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
> > 
> > and C99 and gnu99 do not allow this. See
> > https://lore.kernel.org/lkml/20141019231031.GB9319@node.dhcp.inet.fi/
> 
> This is simple not a cast.

4.62 Compound literals in C99
ISO C99 supports compound literals. A compound literal looks like a cast
followed by an initializer. Its value is an object of the type specified in the
cast, containing the elements specified in the initializer. It is an lvalue.


-- 
With Best Regards,
Andy Shevchenko


