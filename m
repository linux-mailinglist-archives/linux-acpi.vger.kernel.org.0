Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387DE447CAB
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 10:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhKHJXX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 04:23:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:43643 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236719AbhKHJXX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Nov 2021 04:23:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="232038327"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="232038327"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 01:20:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="668941384"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 01:20:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mk0pC-004cO3-S3;
        Mon, 08 Nov 2021 11:20:22 +0200
Date:   Mon, 8 Nov 2021 11:20:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <YYjr1jHnlE7sPb8i@smile.fi.intel.com>
References: <cover.1635953446.git.yu.c.chen@intel.com>
 <01f8f7d23926dcdb054e5ac170ddcbbdb0aed560.1635953446.git.yu.c.chen@intel.com>
 <YYLHmcQMR/XFOuVX@smile.fi.intel.com>
 <20211106151456.GA570347@chenyu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106151456.GA570347@chenyu-desktop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 06, 2021 at 11:14:56PM +0800, Chen Yu wrote:
> On Wed, Nov 03, 2021 at 07:32:09PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 03, 2021 at 11:43:50PM +0800, Chen Yu wrote:

...

> > > +enum cap_index {
> > > +	CAP_STATUS_IDX = 0,
> > > +	CAP_UPDATE_IDX = 1,
> > > +	CAP_CODE_TYPE_IDX = 2,
> > > +	CAP_FW_VER_IDX = 3,
> > > +	CAP_CODE_RT_VER_IDX = 4,
> > > +	CAP_DRV_TYPE_IDX = 5,
> > > +	CAP_DRV_RT_VER_IDX = 6,
> > > +	CAP_DRV_SVN_IDX = 7,
> > > +	CAP_PLAT_ID_IDX = 8,
> > > +	CAP_OEM_ID_IDX = 9,
> > > +	CAP_OEM_INFO_IDX = 10,
> > 
> > > +	CAP_NR_IDX = 11
> > 
> > Assignment here doesn't make any sense (it just adds unneeded churn and
> > burden). Same to the rest of similar cases below.
> >
> Greg mentioned that, we might need to "explicit about the numbers here, because it
> is uncerntain this is guaranteed by all C compilers or not."
> https://lore.kernel.org/lkml/YXj+QaMcCeV71XbI@kroah.com/
> My understanding is that, this applys to both uapi headers and the kernel internal
> headers.

I was talking only about the last item. This is guaranteed to be LAST+1 by the
C standard and any deviation from that is a compiler bug that must be fixed.

The first elements may be explicitly defined so we will be sure they are always
stay. Greg is right about it.

> > > +};

-- 
With Best Regards,
Andy Shevchenko


