Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541A345AB88
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbhKWSw0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:52:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:10812 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239912AbhKWSw0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 13:52:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="235337859"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="235337859"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:48:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="674591930"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:48:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpaqb-009s3E-9P;
        Tue, 23 Nov 2021 20:48:53 +0200
Date:   Tue, 23 Nov 2021 20:48:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: Replace kernel.h with the necessary
 inclusions
Message-ID: <YZ03lD2nlLwJ2KLL@smile.fi.intel.com>
References: <20211110111640.62807-1-andriy.shevchenko@linux.intel.com>
 <YZ0XXoH05cUQ+UMj@smile.fi.intel.com>
 <CAJZ5v0iz-rRV8dktYCe5L-u_zG3vp5S2ZuF=gjrsfgLgcQSnow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iz-rRV8dktYCe5L-u_zG3vp5S2ZuF=gjrsfgLgcQSnow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 23, 2021 at 07:03:21PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 23, 2021 at 5:31 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Nov 10, 2021 at 01:16:40PM +0200, Andy Shevchenko wrote:
> > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > especially when there are circular dependencies are involved.
> > >
> > > Replace kernel.h inclusion with the list of what is really being used.
> >
> > Anybody any comments on this? I really want to shrink kernel.h usage in
> > headers rather sooner than later...
> 
> Patch applied as 5.17 material, thanks!

Thank you for the prompt acceptance!

-- 
With Best Regards,
Andy Shevchenko


