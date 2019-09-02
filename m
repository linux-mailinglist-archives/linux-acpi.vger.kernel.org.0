Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE819A5368
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 11:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfIBJwx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 05:52:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:30027 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbfIBJwx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 05:52:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 02:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="333520654"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 02 Sep 2019 02:52:50 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4j0z-000890-DK; Mon, 02 Sep 2019 12:52:49 +0300
Date:   Mon, 2 Sep 2019 12:52:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ferry Toth <fntoth@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] ACPI / platform: Unregister stale platform devices
Message-ID: <20190902095249.GU2680@smile.fi.intel.com>
References: <20190830143432.21695-1-andriy.shevchenko@linux.intel.com>
 <201909021425.8xcQQHYK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909021425.8xcQQHYK%lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 02:38:05PM +0800, kbuild test robot wrote:
> Hi Andy,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc6 next-20190830]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/ACPI-platform-Unregister-stale-platform-devices/20190902-001307
> config: x86_64-lkp (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers//acpi/acpi_platform.c: In function 'acpi_platform_device_find_by_adev':
> >> drivers//acpi/acpi_platform.c:38:8: error: implicit declaration of function 'bus_find_device_by_acpi_dev'; did you mean 'bus_find_device_by_name'? [-Werror=implicit-function-declaration]

False positive, it has Depends-on tag for the dependency which is not yet in
upstream.

Btw, have you noticed double slash in the paths in your scripts for LKP?
(Look above)

-- 
With Best Regards,
Andy Shevchenko


