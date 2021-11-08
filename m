Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2212447F4C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 13:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbhKHMLf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 07:11:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:8780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239399AbhKHMLe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Nov 2021 07:11:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="318411634"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="318411634"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 04:08:48 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="502992384"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 04:08:44 -0800
Date:   Mon, 8 Nov 2021 20:08:00 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <20211108120800.GA619906@chenyu-desktop>
References: <cover.1635953446.git.yu.c.chen@intel.com>
 <01f8f7d23926dcdb054e5ac170ddcbbdb0aed560.1635953446.git.yu.c.chen@intel.com>
 <YYLHmcQMR/XFOuVX@smile.fi.intel.com>
 <20211106151456.GA570347@chenyu-desktop>
 <YYjr1jHnlE7sPb8i@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYjr1jHnlE7sPb8i@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 08, 2021 at 11:20:22AM +0200, Andy Shevchenko wrote:
> On Sat, Nov 06, 2021 at 11:14:56PM +0800, Chen Yu wrote:
> > On Wed, Nov 03, 2021 at 07:32:09PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 03, 2021 at 11:43:50PM +0800, Chen Yu wrote:
> 
> ...
> 
> > > > +enum cap_index {
> > > > +	CAP_STATUS_IDX = 0,
> > > > +	CAP_UPDATE_IDX = 1,
> > > > +	CAP_CODE_TYPE_IDX = 2,
> > > > +	CAP_FW_VER_IDX = 3,
> > > > +	CAP_CODE_RT_VER_IDX = 4,
> > > > +	CAP_DRV_TYPE_IDX = 5,
> > > > +	CAP_DRV_RT_VER_IDX = 6,
> > > > +	CAP_DRV_SVN_IDX = 7,
> > > > +	CAP_PLAT_ID_IDX = 8,
> > > > +	CAP_OEM_ID_IDX = 9,
> > > > +	CAP_OEM_INFO_IDX = 10,
> > > 
> > > > +	CAP_NR_IDX = 11
> > > 
> > > Assignment here doesn't make any sense (it just adds unneeded churn and
> > > burden). Same to the rest of similar cases below.
> > >
> > Greg mentioned that, we might need to "explicit about the numbers here, because it
> > is uncerntain this is guaranteed by all C compilers or not."
> > https://lore.kernel.org/lkml/YXj+QaMcCeV71XbI@kroah.com/
> > My understanding is that, this applys to both uapi headers and the kernel internal
> > headers.
> 
> I was talking only about the last item. This is guaranteed to be LAST+1 by the
> C standard and any deviation from that is a compiler bug that must be fixed.
> 
> The first elements may be explicitly defined so we will be sure they are always
> stay. Greg is right about it.
>
Ok, got it. Previously I've sent a v9 patch set that addressed the issues in v8, except
for this enum issue. I'll wait for a day or two, if there is no further comments on
v9, I'll send a refreshed v10 with this enum issue fixed.

thanks,
Chenyu 
