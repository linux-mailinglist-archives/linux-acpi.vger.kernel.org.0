Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B9C3521
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2019 15:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbfJANEt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Oct 2019 09:04:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:53174 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732272AbfJANEt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Oct 2019 09:04:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="203225613"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 01 Oct 2019 06:04:44 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iFHpb-0000ZP-1D; Tue, 01 Oct 2019 16:04:43 +0300
Date:   Tue, 1 Oct 2019 16:04:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mmc: sdhci-acpi: Switch to use
 acpi_dev_hid_uid_match()
Message-ID: <20191001130443.GN32742@smile.fi.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
 <20190924193739.86133-6-andriy.shevchenko@linux.intel.com>
 <77ce4e34-6692-e54e-0f2f-6b8829d1e9f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ce4e34-6692-e54e-0f2f-6b8829d1e9f5@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 01, 2019 at 03:37:08PM +0300, Adrian Hunter wrote:
> On 24/09/19 10:37 PM, Andy Shevchenko wrote:
> > Since we have a generic helper, drop custom implementation in the driver.

> > -	if (strcmp(hid, "QCOM8051"))
> > +	if (acpi_dev_hid_uid_match(adev, "QCOM8051", NULL))
> 
> Logic is inverted

Good catch! I forgot to double check it here while below it's okay...

> > -	if (strcmp(hid, "QCOM8051"))
> > +	if (!acpi_dev_hid_uid_match(adev, "QCOM8051", NULL))

-- 
With Best Regards,
Andy Shevchenko


