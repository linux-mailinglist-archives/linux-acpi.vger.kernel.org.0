Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1181D96E0
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393653AbfJPQSt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 12:18:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:4632 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfJPQSt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Oct 2019 12:18:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 09:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="202114135"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2019 09:18:46 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKm0b-0005Up-Ef; Wed, 16 Oct 2019 19:18:45 +0300
Date:   Wed, 16 Oct 2019 19:18:45 +0300
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
Message-ID: <20191016161845.GX32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-12-dmitry.torokhov@gmail.com>
 <20191015122028.GI32742@smile.fi.intel.com>
 <20191015182553.GG105649@dtor-ws>
 <20191016074857.GN32742@smile.fi.intel.com>
 <20191016160126.GB35946@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016160126.GB35946@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 16, 2019 at 09:01:26AM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 16, 2019 at 10:48:57AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 15, 2019 at 11:25:53AM -0700, Dmitry Torokhov wrote:

> > You store a value as union, but going to read as a member of union?
> > I'm pretty sure it breaks standard rules.
> 
> No, I move the values _in place_ of the union, and the data is always
> fetched via void pointers. And copying data via char * or memcpy() is
> allowed even in C99 and C11.
> 
> But I am wondering why are we actually worrying about all of this? The
> kernel is gnu89 and I think is going to stay this way because we use
> initializers with a cast in a lot of places:
> 
> #define __RAW_SPIN_LOCK_UNLOCKED(lockname)      \
>         (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
> 
> and C99 and gnu99 do not allow this. See
> https://lore.kernel.org/lkml/20141019231031.GB9319@node.dhcp.inet.fi/

This is simple not a cast.

-- 
With Best Regards,
Andy Shevchenko


