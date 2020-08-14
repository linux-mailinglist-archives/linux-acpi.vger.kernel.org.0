Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4E244C43
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHNPmr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 11:42:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:62661 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgHNPmr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Aug 2020 11:42:47 -0400
IronPort-SDR: CkIuaDTc8vCl4p2sAr0kQSpN+7g8v0/UTmCJDJJEqmTY5jzNU6ZYFgByEX+LXOBLb7P1oKPjQ2
 yxEA0Zai6oeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="133952730"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="133952730"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 08:42:46 -0700
IronPort-SDR: VnepUbwuixTAJmfpyXvMo9sFE2tFpZYGXLOcLCGEXAnvE01nBiAwWO3fSt7E03hLtUz6HDr1Lz
 06UePNNwDklQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="325755829"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2020 08:42:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6bmh-008g7c-H2; Fri, 14 Aug 2020 18:38:23 +0300
Date:   Fri, 14 Aug 2020 18:38:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 4/7] resource: Introduce resource_intersection() for
 overlapping resources
Message-ID: <20200814153823.GS1891694@smile.fi.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
 <20200813175729.15088-4-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iw7_APT0LmcBpGj_Yz9g1hCOw9yeaMtvOffE_n2-ApaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iw7_APT0LmcBpGj_Yz9g1hCOw9yeaMtvOffE_n2-ApaA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 14, 2020 at 05:24:36PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There will be at least one user that can utilize new helper.
> > Provide the helper for future user and for wider use.
> >
> > Deliberately avoid min()/max() macro as they are still parts of
> > kernel.h which is quite a burden to be included here in order
> > to avoid circular dependencies.

...

> I have the same comments as for patch [3/7].

Same answers as there :-)

-- 
With Best Regards,
Andy Shevchenko


