Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFA13078EB
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jan 2021 16:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhA1O7n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jan 2021 09:59:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:62215 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232192AbhA1O6z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Jan 2021 09:58:55 -0500
IronPort-SDR: pGJEmnsf9FJgT6Ho2gdKWgYjYGzoul/O5PvSHD+KxKS92zo6q+aGB5DnoG6TPLkEQZWeBX+5uR
 RhYRYD/CWkeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="180388448"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="180388448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:57:27 -0800
IronPort-SDR: qH82HAqKQwaR86kayRDB2iNbmYBa1ThXbpNluaYRhKh3flnSZ9lG4BC436KprlaeKaLnLbiAo8
 vFE3EgG9KydA==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="369879800"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:57:24 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l58jZ-0004aQ-Rd; Thu, 28 Jan 2021 16:57:21 +0200
Date:   Thu, 28 Jan 2021 16:57:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
Message-ID: <YBLQ0TjbrV8/Thfb@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

