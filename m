Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06F334261A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 20:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSTVy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 15:21:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:48791 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230304AbhCSTVo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Mar 2021 15:21:44 -0400
IronPort-SDR: 8siicJTJWmYz0sZc0YoRwrSt1Ves8tcwGQ8eMEt3VBngH1wDSdxG/9EWcRfUDEAzJ9IlfSGVjw
 eOYhyYytO01A==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="275026165"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="275026165"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 12:21:43 -0700
IronPort-SDR: /H4gCoF9g4se1QXJKVk1w3PvsghJ+PAUkfXJrzUCugl6jswHeGnScAecBSiyTxY+rE9UyJUI2/
 97NzvL2o62Iw==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="450977622"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 12:21:41 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lNKgk-00DxCT-Ei; Fri, 19 Mar 2021 21:21:38 +0200
Date:   Fri, 19 Mar 2021 21:21:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: Re: [PATCH v2 1/1] ACPI: scan: Use unique number for instance_no
Message-ID: <YFT5woqIyNtypwXX@smile.fi.intel.com>
References: <20210319183234.23629-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jihmos4gza_+0MzGsUfxJJ-5LGBOURVebdGsE_RuPhFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jihmos4gza_+0MzGsUfxJJ-5LGBOURVebdGsE_RuPhFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 19, 2021 at 07:51:00PM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 19, 2021 at 7:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Current mechanism of incrementing and decrementing plain integer
> > to get a next free instance_no when creating an ACPI device is buggy.
> >
> > The simple integer and operations line increment and decrement
> > on top of it can't cover the possible gaps during run time. The
> > arbitrary instantiation and elimination of the devices is racy
> 
> But it isn't racy AFAICS.  It always happens under acpi_device_lock().

Hmm.. indeed. I sent a v3 with the commit message based on your proposal.


> > and after a couple of iterations with unequal amount of devices
> > being added and removed we may reproduce a bug:

-- 
With Best Regards,
Andy Shevchenko


