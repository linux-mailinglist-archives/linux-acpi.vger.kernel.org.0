Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA98C3078ED
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jan 2021 16:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhA1O7x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jan 2021 09:59:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:44452 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhA1O7m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Jan 2021 09:59:42 -0500
IronPort-SDR: bZ7q9eThSllxpDpZJV2+mNa3N0Hp6WQjI3LYWTN2n5DHASqvCKF5MEg+EG2WaABl5YkHVutdhZ
 sbNsewsm9R+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="179463014"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="179463014"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:59:01 -0800
IronPort-SDR: 9XMvVtX3dXuxB352Ar42LfyVq0+gbxk4Zp10yckmIH2uYWP3NJVsuN3pU2YHad5H88cGhBFDpn
 aPfWAzbthRsQ==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="363783125"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:59:00 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1l58l8-0004bM-D5; Thu, 28 Jan 2021 16:58:58 +0200
Date:   Tue, 26 Jan 2021 12:39:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
Message-ID: <YA/xfxcwCabETug6@smile.fi.intel.com>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
 <20210126082101.GD4903@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126082101.GD4903@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 08:21:01AM +0000, Lee Jones wrote:
> On Mon, 25 Jan 2021, Andy Shevchenko wrote:
> 
> > This is a second part of the Intel MID outdated platforms removal.
> > First part is available as immutable branch [1]. The series has functional
> > and build dependencies, so the mentioned branch should be used as a base
> > for these changes.
> > 
> > Note, that some of the drivers, that arch/x86 covers, seems never appeared
> > in the upstream (like msic_ocd).
> 
> What platforms stop working after this removal?

Intel Moorstown, Medfield, Clovertrail.

> Are you sure no-one is using them?

Definitely.

> I wouldn't be keen on breaking Janet's PC that she's been using daily
> and keeping up-to-date since the 90's.

They never were in PCs.

All of them were supported by Android and Janet won't update her phone or even
Android tablet for sure they never ever run any kind of Linux than Android.

-- 
With Best Regards,
Andy Shevchenko


