Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823BC2AB51E
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 11:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgKIKgL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 05:36:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:45141 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgKIKgL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Nov 2020 05:36:11 -0500
IronPort-SDR: 5NSk0vQgm9CL/H01+dr27nfLoSt3JY/MuDfUeep42PoS2fc0YyfhPtGaoq+VtZ+fBdBFGLA4kx
 uIjJ6/OIpCRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="166270326"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="166270326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:36:11 -0800
IronPort-SDR: iFN/CRxkn61IYiSgU2hakmTJHdGaBlcmo4tHV6HEdfy0cwqEqustU4EvnWDFp+TbpvbjHsDv/7
 pT0XN9NO7y1A==
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="530681109"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:36:09 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kc4Xw-0059Qx-13; Mon, 09 Nov 2020 12:37:12 +0200
Date:   Mon, 9 Nov 2020 12:37:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: How to add the "gpio-line-names" property in a PCI gpio expander
Message-ID: <20201109103712.GV4077@smile.fi.intel.com>
References: <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
 <20201105115941.GK2495@lahna.fi.intel.com>
 <574b86929d1247caae717ab1a2f31194@asem.it>
 <20201105152020.GO2495@lahna.fi.intel.com>
 <5fb64f9c8af64235943c29c9ba50a2df@asem.it>
 <20201106070432.GQ2495@lahna.fi.intel.com>
 <c20e82318bbf426c9d9000cac7e7734b@asem.it>
 <20201106171727.GK4077@smile.fi.intel.com>
 <dfeb12b6c53a49a2afc8cf381b066999@asem.it>
 <20201109103432.GU4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109103432.GU4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 09, 2020 at 12:34:32PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 09, 2020 at 09:05:36AM +0000, Flavio Suligoi wrote:
> 
> > > Glad to hear this! So, maybe you can add some bits to the documentation
> > > [1]
> > > based on your experience?
> > 
> > Yes, I can! Thanks you for asking me!
> > 
> > > Note, I have sent a series [2] to amend it a bit, and your input welcome!
> > > 
> > > [1]: Documentation/firmware-guide/acpi/gpio-properties.rst
> > > [2]: https://lore.kernel.org/linux-acpi/20201029193243.61546-1-
> > > andriy.shevchenko@linux.intel.com/T/#u
> > 
> > Ok, I'll see how to integrate my PCI "investigation" about the
> > identification of the correct path from the CPU to the final PCI
> > device, through the various bridges of the board.
> > I think that a general discourse about it can be useful to
> > other people, too.
> 
> I realized that here we have two items to document:
> 1) the gpio-line-names property in [1];

More precise here is to extend the existing documentation with the examples and
explanation how GPIO subsystem in Linux is expecting those names to be (as I
explained in one thread to you that the property covers only line names from
the beginning to the first hole, when no name is provided, i.o.w. holes are not
accepted).

> 2) PCI hierarchy in ACPI tables, which can be added into [3] under
>    the "PCI hierarchy representation" title or so.
> 
> [3]: Documentation/firmware-guide/acpi/enumeration.rst

-- 
With Best Regards,
Andy Shevchenko


