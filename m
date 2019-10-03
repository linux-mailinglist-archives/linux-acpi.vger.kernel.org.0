Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391D4C9C00
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2019 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfJCKRz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Oct 2019 06:17:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:39423 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfJCKRz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Oct 2019 06:17:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 03:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="343624430"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2019 03:17:52 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iFyBD-0007PH-2I; Thu, 03 Oct 2019 13:17:51 +0300
Date:   Thu, 3 Oct 2019 13:17:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 0/6] ACPI / utils: add new helper for HID/UID match
Message-ID: <20191003101751.GE32742@smile.fi.intel.com>
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
 <CAPDyKFq_HPDW5i5ND_df4GJsnaOowHWbFTkgCCOP6w9ar2uo6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq_HPDW5i5ND_df4GJsnaOowHWbFTkgCCOP6w9ar2uo6w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 03, 2019 at 12:00:29PM +0200, Ulf Hansson wrote:
> On Tue, 1 Oct 2019 at 16:27, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There are few users outside of ACPI realm that re-introduce a custom
> > solution to match ACPI device against HID/UID. Add a generic helper for
> > them.
> >
> > The series is supposed to go via linux-pm tree.

> I guess Rafael intend to pick this up for v5.5?

Yes, linux-pm tree is maintained by Rafael.

> In any case, for the mmc patch, feel free to add:
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


