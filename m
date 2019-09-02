Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E3A5376
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfIBJzi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 05:55:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:59622 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbfIBJzi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 05:55:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 02:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="206766667"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2019 02:55:35 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4j3e-0008BY-9C; Mon, 02 Sep 2019 12:55:34 +0300
Date:   Mon, 2 Sep 2019 12:55:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Ferry Toth <fntoth@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] ACPI / platform: Unregister stale platform devices
Message-ID: <20190902095534.GV2680@smile.fi.intel.com>
References: <20190830143432.21695-1-andriy.shevchenko@linux.intel.com>
 <201909021519.YR3Jdy5T%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909021519.YR3Jdy5T%lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 03:19:11PM +0800, kbuild test robot wrote:
>    drivers/acpi/acpi_platform.c: In function 'acpi_platform_device_find_by_adev':
> >> drivers/acpi/acpi_platform.c:38:8: error: implicit declaration of function 'bus_find_device_by_acpi_dev'; did you mean 'bus_find_device_by_name'? [-Werror=implicit-function-declaration]

Same false positive.

-- 
With Best Regards,
Andy Shevchenko


