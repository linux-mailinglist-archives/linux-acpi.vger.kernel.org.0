Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E749158F7F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2020 14:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgBKNLv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 08:11:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:35080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgBKNLu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Feb 2020 08:11:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8987BBD7F;
        Tue, 11 Feb 2020 13:11:48 +0000 (UTC)
Date:   Tue, 11 Feb 2020 14:11:47 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: wdat_wdt: access width inconsistency
Message-ID: <20200211141147.20bad275@endymion>
In-Reply-To: <20200210112326.GP2667@lahna.fi.intel.com>
References: <20200210111638.64925c8e@endymion>
        <20200210112326.GP2667@lahna.fi.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mika,

On Mon, 10 Feb 2020 13:23:26 +0200, Mika Westerberg wrote:
> On Mon, Feb 10, 2020 at 11:16:38AM +0100, Jean Delvare wrote:
> > I'm still working on my customer issue where the wdat_wdt driver
> > reboots the server instantly as soon as the watchdog daemon is started.  
> 
> BTW, you can use "wdat_wdt.dyndbg" to debug this. It should log all the
> instructions it runs.

Thanks for the suggestion. That's not going to help much when the
system reboots instantly as soon as the device node is accessed, but
maybe it will bring some light about what happens before that point.

> > I looked at all the upstream fixes and we already have all relevant
> > ones in our kernel so I start suspecting either a driver bug or a BIOS
> > issue.
> > 
> > While reading the driver code I noticed one suspect thing related to
> > the register access width, which I'd like a second opinion on.
> > 
> > Both acpi_watchdog.c and wdat_wdt.c contain code like:
> > 
> > 	res.end = res.start + gas->access_width - 1;
> > 
> > This suggests that gas->access_width is expected to be 4 in case of a
> > 32-bit register. However in wdat_wdt_read/wdat_wdt_write we have:
> > 
> > 	switch (gas->access_width) {
> > 	(...)
> > 	case 3:
> > 		*value = ioread32(instr->reg);
> > 
> > This looks inconsistent to me.  
> 
> I think you are right. For the code in acpi_watchdog.c:
> 
> 	if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> 		res.flags = IORESOURCE_MEM;
> 		res.end = res.start + ALIGN(gas->access_width, 4) - 1;
> 	} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> 		res.flags = IORESOURCE_IO;
> 		res.end = res.start + gas->access_width - 1;
> 	} else {
> 		..
> 
> I think it does the "correct" thing, although it is bit convoluted. The
> first one aligns it to 4 and the I/O access is either 8- or 16-bits so
> it should be fine, unless I'm missing something.
> 
> However, this code in wdat_wdt.c:
> 
>                  r.end = r.start + gas->access_width - 1;
> 
> is not correct. In this case, I don't think it affects anything but
> should still be fixed.

OK, thanks for confirming.

> > My reading of the ACPI specification suggests that 3 is the right value
> > for 32-bit registers. If so, then shouldn't the resource's end be set
> > to:
> > 
> > 	res.end = res.start + (1 << (gas->access_width - 1)) - 1;
> > 
> > ?  
> 
> Yes, I agree. It seems that we also have helper macro for this:
> ACPI_ACCESS_BIT_WIDTH() that can be used as well but the result needs to
> be divided by 8.

I looked for that macro but my grep wouldn't find it because I expected
a value in bytes not bits. Thanks for pointing it out.

Maybe we should introduce ACPI_ACCESS_BYTE_WIDTH() for the purpose?
This would make the code less convoluted than ACPI_ACCESS_BIT_WIDTH() /
8.

> I will make a patch that fixes these later this week (quite busy with
> something else right now), unless you want to do that.

I'll write the patch, no problem.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
