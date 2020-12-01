Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DCD2CAAD1
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgLASeM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 13:34:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:23317 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbgLASeL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Dec 2020 13:34:11 -0500
IronPort-SDR: Q/IEJmzca4U4BG1Rv6VIKr/JnGqXPzSkPuqEYTD58HR4LniIuEo87UN7EcBo1if5Fkzh+qvuxU
 Ml2t/2YW+xjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="237011493"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="237011493"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 10:32:31 -0800
IronPort-SDR: xgXj4cpJdSo4W9Ovflu9Pb3/504DGnz/AlexKg1c3B9uXNptUBbwf1TQuwsRV4ZUOFLJ0uz3SR
 zrRK+oOFZaYQ==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="364878965"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 10:32:28 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kkASv-00BKyP-KY; Tue, 01 Dec 2020 20:33:29 +0200
Date:   Tue, 1 Dec 2020 20:33:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jie Yang <yang.jie@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of
 resource_intersection()
Message-ID: <20201201183329.GI4077@smile.fi.intel.com>
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
 <160683107676.35139.9521964646147921378.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160683107676.35139.9521964646147921378.b4-ty@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 01, 2020 at 01:57:56PM +0000, Mark Brown wrote:
> On Tue, 24 Nov 2020 11:56:28 +0200, Andy Shevchenko wrote:
> > Since we have resource_intersection() helper, let's utilize it here.
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: Intel: catpt: Replace open coded variant of resource_intersection()
>       (no commit info)

As I mentioned in the comment (after --- line) the patch relies on the stuff in
linux-pm tree. Do you have any immutable branch pulled? Otherwise Rafael
already took it where it won't break compilation.

-- 
With Best Regards,
Andy Shevchenko


