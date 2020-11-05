Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99372A8354
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 17:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgKEQSY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Nov 2020 11:18:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:17435 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbgKEQSY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Nov 2020 11:18:24 -0500
IronPort-SDR: 219vIN46woNyUwSzLMp68DWvTz1YWupvjTWXxFTSXLnngKLjbK+4wMeQTW5UMnyCPGqhFeiEMJ
 eO79GDqwby8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="254116336"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="254116336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 08:18:18 -0800
IronPort-SDR: NIKJvIvnK6Dotp07tdugw6UksUAYPbgWK4jSadwxlBPPEmAXB+3B0xorwgXSCNCae/+iYApzsv
 HneKmtLYU5fg==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="364395488"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 08:18:16 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kahyp-0046N6-7e; Thu, 05 Nov 2020 18:19:19 +0200
Date:   Thu, 5 Nov 2020 18:19:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: How to add the "gpio-line-names" property in a PCI gpio expander
Message-ID: <20201105161919.GX4077@smile.fi.intel.com>
References: <98acf6339a1b43d6a38f867069088530@asem.it>
 <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
 <20201105115941.GK2495@lahna.fi.intel.com>
 <574b86929d1247caae717ab1a2f31194@asem.it>
 <20201105152020.GO2495@lahna.fi.intel.com>
 <5fb64f9c8af64235943c29c9ba50a2df@asem.it>
 <20201105160925.GW4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105160925.GW4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 05, 2020 at 06:09:25PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 05, 2020 at 03:54:32PM +0000, Flavio Suligoi wrote:
> > > > > > > In one of our boards we have an add-on PCI board, with a PCI
> > > serial
> > > > > device
> > > > > > > Exar XR17V352. This device also contains 16 gpios.
> > > > > > > The exar device drivers work good, both the "8250_exar" and the
> > > > > "gpio_exar", and
> > > > > > > I can manage the exar's gpios correctly.
> > > > > > > The problem is how to assign the gpio-line-names property to a PCI
> > > > > gpio
> > > > > > > expanders like this.
> > > > > > >
> > > > > > > I tried adding a new device in my ACPI configuration, as:
> > > > > > >
> > > > > > > Device (EXAR)
> > > > > > > {
> > > > > > >     Name (_HID, "13A80352")
> > > > >
> > > > > If this is PCI device then you need to have _ADR here instead of _HID.
> > > >
> > > > the problem is that the parent bus of this device is not declared in any
> > > ACPI table.
> > > > The exar chip is on the bus 7 :
> > > >
> > > > 07:00.0 Serial controller: Exar Corp. XR17V3521 Dual PCIe UART (rev 03)
> > > >
> > > > and in the _ADR object you can specify device and function only.
> > > > How can I specify the parent bus? It is not simple …
> > > > The lspci output is the following:
> > > 
> > > The parent is the root port the device is connected to and I'm pretty
> > > sure it exists in the namespace as this seems to be Intel hardware. If
> > > you run 'lspci -t' it shows you the root port.
> > > 
> > > The _ADR should be 0 for this one.
> > 
> > Unfortunately there is bridge in the middle:
> > 
> > root@debian:~# lspci -t
> > -[0000:00]-+-00.0
> >            +-02.0
> >            +-0e.0
> >            +-0f.0
> >            +-12.0
> >            +-13.0-[01]----00.0
> >            +-13.1-[02]----00.0
> >            +-13.2-[03]--
> >            +-14.0-[04]----00.0
> >            +-14.1-[05-09]----00.0-[06-09]--+-01.0-[07]----00.0 <-- Exar (bus 7, dev 0, funct 0)
> >            |                               +-02.0-[08]----00.0
> >            |                               \-03.0-[09]--
> >            +-15.0
> >            +-16.0
> >            +-16.1
> >            +-19.0
> >            +-19.1
> >            +-19.2
> >            +-1f.0
> >            \-1f.1
> > root@debian:~#
> > 
> > My changes in the ACPI:
> > 
> > Scope (_SB.PCI0) {
> >     Device (EXAR)
> > 		{
> > 			Name (_ADR, 0x0000)
> 
> _ADR should represent BDF (Bus:Device.Function)
> 
> Something like 0x07000000

Per documentation:
"High word–Device #, Low word–Function #. (for example, device 3, function 2 is
0x00030002). To refer to all the functions on a device #, use a function number of FFFF)."

It seems it doesn't describe where bus is going.

Maybe Mika can help here.

> > ....
> > 
> > but it doesn't work, because of the bridge.

-- 
With Best Regards,
Andy Shevchenko


