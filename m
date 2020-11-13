Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0E2B1CEC
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 15:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKMOKh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 09:10:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:10875 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMOKh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Nov 2020 09:10:37 -0500
IronPort-SDR: FOU0VfpkOoG885ABBCVCRqJrr+fqZDj/GHRQk1o3wN5rShsAOrBdPUpW11pEIfvQBdSPgHsvWM
 qLokGGdp7sjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="149744757"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="149744757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 06:10:37 -0800
IronPort-SDR: 4UJhCmPrxvYp9nMv9XR0Vicnv7PKmSfXgX2gyxuUDqOdPjwfcurt4zTGbCnupiS/JhZc926P1/
 Nmpxy5a3yelQ==
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="474672813"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 06:10:35 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kdZnd-006SvZ-95; Fri, 13 Nov 2020 16:11:37 +0200
Date:   Fri, 13 Nov 2020 16:11:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] rtc: ds1307: Remove non-valid ACPI IDs
Message-ID: <20201113141137.GO4077@smile.fi.intel.com>
References: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hNBguxETML2rjweXEp6=iyxRyMNBcTYaLpwjO+ZposRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hNBguxETML2rjweXEp6=iyxRyMNBcTYaLpwjO+ZposRw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 08:01:37PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 12, 2020 at 4:58 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The commit 9c19b8930d2c ("rtc: ds1307: Add ACPI support") added non-valid
> 
> s/non-valid/invalid/ ?
> 
> > ACPI IDs (all of them abusing ACPI specification). Moreover there is
> > no even a single evidence that vendor registered any of such device.
> 
> "not even" and "devices".
> 
> > Remove broken ACPI IDs from the driver. For prototyping one may use PRP0001
> > with device tree defined bindings.
> 
> "with device properties adhering to a DT binding". ?
> 
> > The following patches will add support of that to the driver.

Rafael, thanks for review, I will address them all in v2.

-- 
With Best Regards,
Andy Shevchenko


