Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9933B15A667
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 11:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgBLKae (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 05:30:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:55396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgBLKae (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 05:30:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E734AD20;
        Wed, 12 Feb 2020 10:30:32 +0000 (UTC)
Date:   Wed, 12 Feb 2020 11:30:30 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: wdat_wdt: access width inconsistency
Message-ID: <20200212113030.1c5c9524@endymion>
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

Hi again Mika,

On Mon, 10 Feb 2020 13:23:26 +0200, Mika Westerberg wrote:
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

I'm looking again into this today. What was the rationale for the
ALIGN() in the first place? The WDAT table is supposed to declare the
resources with the appropriate width so it should not set access_width
= 1 or 2 if the register should be accessed with 32-bit memory
reads/writes, right? Could it be that the ALIGN() was added to solve
the bug caused by using access_width directly instead of converting it
to a byte count first?

Or is the ALIGN() a safety guard against broken WDAT tables? I'm not
sure what bad would happen from doing memory-mapped reads/writes of
less than 32 bits, so I'm really wondering why the ALIGN() is there.
Especially when the code in wdat_wdt itself doesn't align anything, so
it's only about the resource size really. Requesting a resource larger
than we need doesn't make a lot of sense to me.

(The underlying question being: can I get rid of that ALIGN()
altogether while fixing the gas->access_width misuse bug?)

-- 
Jean Delvare
SUSE L3 Support
