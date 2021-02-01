Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7641630AFB4
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 19:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhBASpQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 13:45:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:24072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhBASpK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Feb 2021 13:45:10 -0500
IronPort-SDR: vSIJQNRp1JEvOzMxRayKrkA+Spvw2xBeqTj6lKRNJ7fy9xcaCAYvelTSZf6A+Ru/sYnXDVcHav
 H0XGTG5X87Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180810324"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="180810324"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:43:10 -0800
IronPort-SDR: fXVApzUD+SS2KQ4MwTnMPLroI1Gw5OZ8k5DiAKNxJflikACXO0KOAWAK38eXNEmv/V/HbCvMSQ
 pZH/dx9SHGtw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="371652732"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:43:07 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6eAC-001Cl9-MC; Mon, 01 Feb 2021 20:43:04 +0200
Date:   Mon, 1 Feb 2021 20:43:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
Message-ID: <YBhLuNZ7xmHdhurU@smile.fi.intel.com>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
 <20210126082101.GD4903@dell>
 <YA/xfxcwCabETug6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YA/xfxcwCabETug6@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 12:39:59PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 26, 2021 at 08:21:01AM +0000, Lee Jones wrote:
> > On Mon, 25 Jan 2021, Andy Shevchenko wrote:
> > 
> > > This is a second part of the Intel MID outdated platforms removal.
> > > First part is available as immutable branch [1]. The series has functional
> > > and build dependencies, so the mentioned branch should be used as a base
> > > for these changes.
> > > 
> > > Note, that some of the drivers, that arch/x86 covers, seems never appeared
> > > in the upstream (like msic_ocd).
> > 
> > What platforms stop working after this removal?
> 
> Intel Moorstown, Medfield, Clovertrail.
> 
> > Are you sure no-one is using them?
> 
> Definitely.
> 
> > I wouldn't be keen on breaking Janet's PC that she's been using daily
> > and keeping up-to-date since the 90's.
> 
> They never were in PCs.
> 
> All of them were supported by Android and Janet won't update her phone or even
> Android tablet for sure they never ever run any kind of Linux than Android.

So, I hope you are satisfied and we may proceed with removal.

-- 
With Best Regards,
Andy Shevchenko


