Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2EBC793
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 14:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfIXMIt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 08:08:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:30847 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbfIXMIt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 08:08:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 05:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="389836309"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2019 05:08:45 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iCjcZ-0001Vm-MF; Tue, 24 Sep 2019 15:08:43 +0300
Date:   Tue, 24 Sep 2019 15:08:43 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Moore, Robert" <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, nv@vosn.de,
        Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH] ACPICA: Introduce acpi_load_table_with_index()
Message-ID: <20190924120843.GU2680@smile.fi.intel.com>
References: <6851700.HULMXZj6Ep@kreacher>
 <20190923094701.24950-1-nikolaus.voss@loewensteinmedical.de>
 <20190924120734.GT2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924120734.GT2680@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 24, 2019 at 03:07:34PM +0300, Shevchenko, Andriy wrote:
> On Mon, Sep 23, 2019 at 11:47:01AM +0200, Nikolaus Voss wrote:
> > For unloading an ACPI table, it is necessary to provide the
> > index of the table. The method intended for dynamically
> > loading or hotplug addition of tables, acpi_load_table(),
> > does not provide this information, so a new function
> > acpi_load_table_with_index() with the same functionality,
> > but an optional pointer to the loaded table index is introduced.
> > 
> > The new function is used in the acpi_configfs driver to save the
> > index of the newly loaded table in order to unload it later.
> 
> I'll test it later, though couple of remarks:
> - would it make sense to provide a counter part helper for unloading? Now it
>   looks a bit inconsistent in configfs when we use acpi_load_*() vs.
>   acpi_tb_*() in remove.

...and I think we may unexport acpi_tb_* in this case as Bob suggested for it
to be internal API.

> - please, include Ferry into Cc (as done in this mail)


-- 
With Best Regards,
Andy Shevchenko


