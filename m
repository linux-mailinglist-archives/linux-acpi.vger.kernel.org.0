Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC5BDC6B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2019 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390562AbfIYKxr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Sep 2019 06:53:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:32595 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390412AbfIYKxr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Sep 2019 06:53:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 03:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; 
   d="scan'208";a="340374263"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 25 Sep 2019 03:53:43 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iD4vV-00034Z-VE; Wed, 25 Sep 2019 13:53:41 +0300
Date:   Wed, 25 Sep 2019 13:53:41 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        Ferry Toth <fntoth@gmail.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
Message-ID: <20190925105341.GD5933@smile.fi.intel.com>
References: <20190913151228.GT2680@smile.fi.intel.com>
 <7625fe37-1710-056d-fb9e-39c33fd962a1@gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B967AEC9@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909161134070.2910@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B968327D@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909181624550.3925@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9686438@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909231100190.16390@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B968B639@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909251131060.65328@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1909251131060.65328@fox.voss.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 25, 2019 at 12:18:11PM +0200, Nikolaus Voss wrote:
> On Tue, 24 Sep 2019, Moore, Robert wrote:
> > How about this:
> > Go back to using acpi_tb_install_and_load_table(), but then call acpi_ns_initialize_objects afterwards This is what acpi_load_table does.
> > 
> > 
> >    ACPI_INFO (("Host-directed Dynamic ACPI Table Load:"));
> >    Status = AcpiTbInstallAndLoadTable (ACPI_PTR_TO_PHYSADDR (Table),
> >        ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE, &TableIndex);
> >    if (ACPI_SUCCESS (Status))
> >    {
> >        /* Complete the initialization/resolution of new objects */
> > 
> >        AcpiNsInitializeObjects ();
> >    }
> 
> The idea was to have all drivers use the same interface for dynamically
> loading ACPI tables, i.e. efivar_ssdt_load() (which already used
> acpi_load_table()) and the acpi_configfs driver. The efivar driver doesn't
> provide a possibility to unload the table, so acpi_load_table() is okay for
> this purpose. 

> According to Bob, acpi_tb_install_and_load_table() is not part
> of the external ACPICA API declared under include/acpi (though it is
> exported).

You are answering to Bob himself :-)

So, above is another proposal and we can create a common symmetric APIs in ACPI
glue layer for all users even if some of them don't care about unloading.

> The counterpart of acpi_load_table() - inline comment "Note1: Mainly
> intended to support hotplug addition of SSDTs" - seems to be
> acpi_unload_parent_table() - inline comment "Note: Mainly intended to
> support hotplug removal of SSDTs" - but it doesn't expect a table index but
> an acpi_handle as argument, and it is only used within ACPICA, so IMO the
> API can't be properly used in our case and should be improved even though
> unloading tables is deprecated.
> 
> If changing the API is not an option, we can choose between Rafael's way
> (extending the API instead of changing it) or Bob's proposal (doing the same
> thing - hotplug-loading a SSDT - in different ways, in case of acpi_configfs
> using ACPICA internal API). I don't have a clear favorite, but I'm tending
> to Rafael's solution my favorite being the API change.

-- 
With Best Regards,
Andy Shevchenko


