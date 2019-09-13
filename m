Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B54B231D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2019 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403816AbfIMPMg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Sep 2019 11:12:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:32854 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389163AbfIMPMf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Sep 2019 11:12:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 08:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197581837"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 13 Sep 2019 08:12:30 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i8nFM-0005c2-Js; Fri, 13 Sep 2019 18:12:28 +0300
Date:   Fri, 13 Sep 2019 18:12:28 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     Nikolaus Voss <nv@vosn.de>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ferry Toth <ftoth@telfort.nl>,
        "nikolaus.voss@loewensteinmedical.de" 
        <nikolaus.voss@loewensteinmedical.de>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
Message-ID: <20190913151228.GT2680@smile.fi.intel.com>
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909130911180.20316@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B967ADF6@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B967ADF6@ORSMSX110.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 13, 2019 at 05:20:21PM +0300, Moore, Robert wrote:
> -----Original Message-----
> From: Nikolaus Voss [mailto:nv@vosn.de] 
> Sent: Friday, September 13, 2019 12:44 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; Ferry Toth <ftoth@telfort.nl>; nikolaus.voss@loewensteinmedical.de
> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table index
> 
> Bob,
> 
> On Thu, 12 Sep 2019, Moore, Robert wrote:
> > The ability to unload an ACPI table (especially AML tables such as
> > SSDTs) is in the process of being deprecated in ACPICA -- since it is 
> > also deprecated in the current ACPI specification. This is being done 
> > because of the difficulty of deleting the namespace entries for the 
> > table.  FYI, Windows does not properly support this function either.
> 
> ok, I see it can be a problem to unload an AML table with all it's consequences e.g. with respect to driver unregistering in setups with complex dependencies. It will only work properly under certain conditions
> - nevertheless acpi_tb_unload_table() is still exported in ACPICA and we should get this working as it worked before.
> 
> AcpiTbUnloadTable is not exported, it is an internal interface only -- as
> recognized by the "AcpiTb".

In Linux it became a part of ABI when the

commit 772bf1e2878ecfca0d1f332071c83e021dd9cf01
Author: Jan Kiszka <jan.kiszka@siemens.com>
Date:   Fri Jun 9 20:36:31 2017 +0200

    ACPI: configfs: Unload SSDT on configfs entry removal

appeared in the kernel.

> I'm not sure that I want to change the interface
> to AcpiLoadTable just for something that is being deprecated. Already, we
> throw an ACPI_EXCEPTION if the Unload operator is encountered in the AML byte
> stream. The same thing with AcpiUnloadParentTable - it is being deprecated.
> 
>     ACPI_EXCEPTION ((AE_INFO, AE_NOT_IMPLEMENTED,
>         "AML Unload operator is not supported"));

-- 
With Best Regards,
Andy Shevchenko


