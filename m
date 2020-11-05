Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AEE2A8207
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 16:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKEPUZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Nov 2020 10:20:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:22139 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgKEPUZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Nov 2020 10:20:25 -0500
IronPort-SDR: 6SAGrPHB0Kml9DIuVCkpOPnXnyAkJdi8TStYnMmTTx3B8yrTWwnAU/j97GY2915rFMit4eOgyZ
 /lC9dWgjSuXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="149250212"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="149250212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 07:20:25 -0800
IronPort-SDR: 0rz5ZUCIQ1jp11+v6O+AfFOfYrlOa+zY3uVyMUIyah6nxyknT8kyI+G+wheDbjn4diXcUfVgrY
 2jgxlKWnRknw==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="539441765"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 07:20:22 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 05 Nov 2020 17:20:20 +0200
Date:   Thu, 5 Nov 2020 17:20:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: How to add the "gpio-line-names" property in a PCI gpio expander
Message-ID: <20201105152020.GO2495@lahna.fi.intel.com>
References: <98acf6339a1b43d6a38f867069088530@asem.it>
 <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
 <20201105115941.GK2495@lahna.fi.intel.com>
 <574b86929d1247caae717ab1a2f31194@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <574b86929d1247caae717ab1a2f31194@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 05, 2020 at 02:01:24PM +0000, Flavio Suligoi wrote:
> Hi Mika,
> 
> > > > In one of our boards we have an add-on PCI board, with a PCI serial
> > device
> > > > Exar XR17V352. This device also contains 16 gpios.
> > > > The exar device drivers work good, both the "8250_exar" and the
> > "gpio_exar", and
> > > > I can manage the exar's gpios correctly.
> > > > The problem is how to assign the gpio-line-names property to a PCI
> > gpio
> > > > expanders like this.
> > > >
> > > > I tried adding a new device in my ACPI configuration, as:
> > > >
> > > > Device (EXAR)
> > > > {
> > > >     Name (_HID, "13A80352")
> > 
> > If this is PCI device then you need to have _ADR here instead of _HID.
> 
> the problem is that the parent bus of this device is not declared in any ACPI table.
> The exar chip is on the bus 7 :
> 
> 07:00.0 Serial controller: Exar Corp. XR17V3521 Dual PCIe UART (rev 03)
> 
> and in the _ADR object you can specify device and function only. 
> How can I specify the parent bus? It is not simple …
> The lspci output is the following:

The parent is the root port the device is connected to and I'm pretty
sure it exists in the namespace as this seems to be Intel hardware. If
you run 'lspci -t' it shows you the root port.

The _ADR should be 0 for this one.
