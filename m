Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABA2BED0C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2019 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfIZIJn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Sep 2019 04:09:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:17632 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfIZIJm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Sep 2019 04:09:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 01:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,551,1559545200"; 
   d="scan'208";a="273254662"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2019 01:09:38 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iDOqG-0001ou-EI; Thu, 26 Sep 2019 11:09:36 +0300
Date:   Thu, 26 Sep 2019 11:09:36 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ferry Toth <fntoth@gmail.com>, Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nv@vosn.de" <nv@vosn.de>
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
Message-ID: <20190926080936.GB32742@smile.fi.intel.com>
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
 <4929b1d2-c2a7-4efd-89e4-f02205e79c01@telfort.nl>
 <CF6A88132359CE47947DB4C6E1709ED53C646E97@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C646E97@ORSMSX122.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 25, 2019 at 09:13:34PM +0300, Schmauss, Erik wrote:
> > -----Original Message-----
> > From: Ferry Toth <ftoth@telfort.nl>
> > Sent: Thursday, September 12, 2019 12:37 PM
> > To: Moore, Robert <robert.moore@intel.com>; Nikolaus Voss
> > <nikolaus.voss@loewensteinmedical.de>; Shevchenko, Andriy
> > <andriy.shevchenko@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>;
> > Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>; Jacek Anaszewski
> > <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
> > <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> > kernel@vger.kernel.org; nv@vosn.de
> > Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
> > 
> > Op 12-09-19 om 16:19 schreef Moore, Robert:
> > > Nikolaus,
> > > The ability to unload an ACPI table (especially AML tables such as SSDTs) is in
> > the process of being deprecated in ACPICA -- since it is also deprecated in the
> > current ACPI specification. This is being done because of the difficulty of
> > deleting the namespace entries for the table.  FYI, Windows does not properly
> > support this function either.
> > 
> > I really hope this is not the case. On x86 loading/unloading SSDTs has proven to
> > be a powerful way to handle reconfigurable hardware without rebooting and
> > without requiring dedicated platform drivers. Same for user plugable hardware
> > on i2c/spi busses.
> > 
> > This has worked before and will violate the "don't break user space" rule.
> 
> If the table index wasn't being used, how did this work before?
> Which commit broke this?
> 
> Bob and I are trying to understand if this is a regression or a new feature request...

It is a regression as I explained in my bisecting message.

Before it uses acpi_tb_* API directly.
I thought Bob already got the idea.

-- 
With Best Regards,
Andy Shevchenko


