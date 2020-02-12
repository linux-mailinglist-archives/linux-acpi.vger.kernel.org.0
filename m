Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA515A6E7
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 11:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgBLKrw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 05:47:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:35545 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgBLKrw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 05:47:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 02:47:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347493361"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2020 02:47:47 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Feb 2020 12:47:47 +0200
Date:   Wed, 12 Feb 2020 12:47:47 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: wdat_wdt: access width inconsistency
Message-ID: <20200212104747.GR2667@lahna.fi.intel.com>
References: <20200210111638.64925c8e@endymion>
 <20200210112326.GP2667@lahna.fi.intel.com>
 <20200212113030.1c5c9524@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212113030.1c5c9524@endymion>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2020 at 11:30:30AM +0100, Jean Delvare wrote:
> Hi again Mika,
> 
> On Mon, 10 Feb 2020 13:23:26 +0200, Mika Westerberg wrote:
> > I think you are right. For the code in acpi_watchdog.c:
> > 
> > 	if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> > 		res.flags = IORESOURCE_MEM;
> > 		res.end = res.start + ALIGN(gas->access_width, 4) - 1;
> > 	} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> > 		res.flags = IORESOURCE_IO;
> > 		res.end = res.start + gas->access_width - 1;
> > 	} else {
> > 		..
> > 
> > I think it does the "correct" thing, although it is bit convoluted. The
> > first one aligns it to 4 and the I/O access is either 8- or 16-bits so
> > it should be fine, unless I'm missing something.
> 
> I'm looking again into this today. What was the rationale for the
> ALIGN() in the first place? The WDAT table is supposed to declare the
> resources with the appropriate width so it should not set access_width
> = 1 or 2 if the register should be accessed with 32-bit memory
> reads/writes, right? Could it be that the ALIGN() was added to solve
> the bug caused by using access_width directly instead of converting it
> to a byte count first?
> 
> Or is the ALIGN() a safety guard against broken WDAT tables? I'm not
> sure what bad would happen from doing memory-mapped reads/writes of
> less than 32 bits, so I'm really wondering why the ALIGN() is there.
> Especially when the code in wdat_wdt itself doesn't align anything, so
> it's only about the resource size really. Requesting a resource larger
> than we need doesn't make a lot of sense to me.
> 
> (The underlying question being: can I get rid of that ALIGN()
> altogether while fixing the gas->access_width misuse bug?)

I think the ALIGN() was there just because I did not realize that
access_width is 3 and not 4 for 32-bit memory. So it is not needed.

I actually have a patch series that should fix this and the other issue
you found (I found a couple of spare cycles in the morning) so if you
don't mind I'll submit them soon.
