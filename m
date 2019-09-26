Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCFCBF6CE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2019 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfIZQfe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Sep 2019 12:35:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:37476 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZQfe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Sep 2019 12:35:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 09:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="180221165"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2019 09:35:30 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iDWjo-00015K-EJ; Thu, 26 Sep 2019 19:35:28 +0300
Date:   Thu, 26 Sep 2019 19:35:28 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Moore, Robert" <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nv@vosn.de" <nv@vosn.de>
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
Message-ID: <20190926163528.GH32742@smile.fi.intel.com>
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <CF6A88132359CE47947DB4C6E1709ED53C6481B1@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C6481B1@ORSMSX122.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 26, 2019 at 07:09:05PM +0300, Schmauss, Erik wrote:
> > -----Original Message-----
> > From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > Sent: Thursday, September 12, 2019 1:08 AM
> > To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik
> > <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Moore,
> > Robert <robert.moore@intel.com>
> > Cc: Len Brown <lenb@kernel.org>; Jacek Anaszewski
> > <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
> > <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> > kernel@vger.kernel.org; nv@vosn.de; Nikolaus Voss
> > <nikolaus.voss@loewensteinmedical.de>
> > Subject: [PATCH] ACPICA: make acpi_load_table() return table index
> > 
> Hi Nikolaus,
> 
> > For unloading an ACPI table, it is necessary to provide the index of the table.
> > The method intended for dynamically loading or hotplug addition of tables,
> > acpi_load_table(), should provide this information via an optional pointer to
> > the loaded table index.
> 
> We'll take this patch for ACPICA upstream

Erik,

how about to have also counterpart to acpi_load_table() which will do
what it's done now in acpi_configfs.c via acpi_tb_*() API?

Because it's kinda strange to call acpi_load_table*() and acpi_tb_*()
in the same module.

-- 
With Best Regards,
Andy Shevchenko


