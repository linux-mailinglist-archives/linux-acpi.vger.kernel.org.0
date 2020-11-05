Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6896F2A7DAE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 13:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgKEMCP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Nov 2020 07:02:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:55594 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgKEMCO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 5 Nov 2020 07:02:14 -0500
IronPort-SDR: Ox/FGgIK8A+lRv/6ONruegQgzakvKaQquPjgkz2zbAQyELPuhG9vAT5uRys1BvpAbnhcnae3i9
 MhCKHDWIJzCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="168587888"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="168587888"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 04:01:55 -0800
IronPort-SDR: 5MOVFszxjBka2JolT4Ah9ijYX+daFcCisv5YNjrGxpSYH+ljPiInUhYTwqKia1weri5wSUEGap
 r52/eWwKeCmw==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="354256112"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 04:01:53 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 05 Nov 2020 13:59:41 +0200
Date:   Thu, 5 Nov 2020 13:59:41 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Flavio Suligoi <f.suligoi@asem.it>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: How to add the "gpio-line-names" property in a PCI gpio expander
Message-ID: <20201105115941.GK2495@lahna.fi.intel.com>
References: <98acf6339a1b43d6a38f867069088530@asem.it>
 <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Thu, Nov 05, 2020 at 12:51:18PM +0100, Rafael J. Wysocki wrote:
> CC Mika and Andy who should be more familiar with that problem space than I am.
> 
> On Thu, Nov 5, 2020 at 10:46 AM Flavio Suligoi <f.suligoi@asem.it> wrote:
> >
> > Hi all,
> >
> > I'm working to introduce the "gpio-line-names" property in the ACPI
> > configuration of the BIOS of our x86 boards (we can customize the BIOS of our
> > boards).
> >
> > All is ok for the gpiochips related to the Intel chipset and some I2C gpio
> > expanders. I have inserted the _DSD as described in the Linux documentation.
> >
> > In one of our boards we have an add-on PCI board, with a PCI serial device
> > Exar XR17V352. This device also contains 16 gpios.
> > The exar device drivers work good, both the "8250_exar" and the "gpio_exar", and
> > I can manage the exar's gpios correctly.
> > The problem is how to assign the gpio-line-names property to a PCI gpio
> > expanders like this.
> >
> > I tried adding a new device in my ACPI configuration, as:
> >
> > Device (EXAR)
> > {
> >     Name (_HID, "13A80352")

If this is PCI device then you need to have _ADR here instead of _HID.

> >     Name (_STR, Unicode ("STR - Exar GPIOs"))  // _STR: Description String
> >
> >     Name (_DSD, Package () {
> >         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >         Package () {
> >             Package () {
> >                 "gpio-line-names",
> >                     Package () {
> >                         "exar_0",
> >                         "exar_1",
> >                         "exar_2",
> >                         "exar_3",
> >                         ...
> >                     }
> >                 }
> >             }
> >     })
> > }
> >
> > but I have no result.
> > Does anyone have a suggestion?
> >
> > Thanks,
> >
> > Flavio
