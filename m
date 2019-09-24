Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493ACBC78D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 14:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfIXMHk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 08:07:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:8170 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbfIXMHk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 08:07:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 05:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="272612668"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2019 05:07:36 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iCjbS-0001Uh-SC; Tue, 24 Sep 2019 15:07:34 +0300
Date:   Tue, 24 Sep 2019 15:07:34 +0300
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
Message-ID: <20190924120734.GT2680@smile.fi.intel.com>
References: <6851700.HULMXZj6Ep@kreacher>
 <20190923094701.24950-1-nikolaus.voss@loewensteinmedical.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923094701.24950-1-nikolaus.voss@loewensteinmedical.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 23, 2019 at 11:47:01AM +0200, Nikolaus Voss wrote:
> For unloading an ACPI table, it is necessary to provide the
> index of the table. The method intended for dynamically
> loading or hotplug addition of tables, acpi_load_table(),
> does not provide this information, so a new function
> acpi_load_table_with_index() with the same functionality,
> but an optional pointer to the loaded table index is introduced.
> 
> The new function is used in the acpi_configfs driver to save the
> index of the newly loaded table in order to unload it later.

I'll test it later, though couple of remarks:
- would it make sense to provide a counter part helper for unloading? Now it
  looks a bit inconsistent in configfs when we use acpi_load_*() vs.
  acpi_tb_*() in remove.
- please, include Ferry into Cc (as done in this mail)

-- 
With Best Regards,
Andy Shevchenko


