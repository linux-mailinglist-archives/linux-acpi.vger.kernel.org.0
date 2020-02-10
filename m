Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6944615735F
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2020 12:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBJLXb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Feb 2020 06:23:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:4232 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgBJLXb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Feb 2020 06:23:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 03:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,424,1574150400"; 
   d="scan'208";a="347029146"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 10 Feb 2020 03:23:27 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 10 Feb 2020 13:23:26 +0200
Date:   Mon, 10 Feb 2020 13:23:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: wdat_wdt: access width inconsistency
Message-ID: <20200210112326.GP2667@lahna.fi.intel.com>
References: <20200210111638.64925c8e@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210111638.64925c8e@endymion>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 10, 2020 at 11:16:38AM +0100, Jean Delvare wrote:
> Hi all,

Hi Jean,

> I'm still working on my customer issue where the wdat_wdt driver
> reboots the server instantly as soon as the watchdog daemon is started.

BTW, you can use "wdat_wdt.dyndbg" to debug this. It should log all the
instructions it runs.

> I looked at all the upstream fixes and we already have all relevant
> ones in our kernel so I start suspecting either a driver bug or a BIOS
> issue.
> 
> While reading the driver code I noticed one suspect thing related to
> the register access width, which I'd like a second opinion on.
> 
> Both acpi_watchdog.c and wdat_wdt.c contain code like:
> 
> 	res.end = res.start + gas->access_width - 1;
> 
> This suggests that gas->access_width is expected to be 4 in case of a
> 32-bit register. However in wdat_wdt_read/wdat_wdt_write we have:
> 
> 	switch (gas->access_width) {
> 	(...)
> 	case 3:
> 		*value = ioread32(instr->reg);
> 
> This looks inconsistent to me.

I think you are right. For the code in acpi_watchdog.c:

	if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
		res.flags = IORESOURCE_MEM;
		res.end = res.start + ALIGN(gas->access_width, 4) - 1;
	} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
		res.flags = IORESOURCE_IO;
		res.end = res.start + gas->access_width - 1;
	} else {
		..

I think it does the "correct" thing, although it is bit convoluted. The
first one aligns it to 4 and the I/O access is either 8- or 16-bits so
it should be fine, unless I'm missing something.

However, this code in wdat_wdt.c:

                 r.end = r.start + gas->access_width - 1;

is not correct. In this case, I don't think it affects anything but
should still be fixed.

> My reading of the ACPI specification suggests that 3 is the right value
> for 32-bit registers. If so, then shouldn't the resource's end be set
> to:
> 
> 	res.end = res.start + (1 << (gas->access_width - 1)) - 1;
> 
> ?

Yes, I agree. It seems that we also have helper macro for this:
ACPI_ACCESS_BIT_WIDTH() that can be used as well but the result needs to
be divided by 8.

I will make a patch that fixes these later this week (quite busy with
something else right now), unless you want to do that.
