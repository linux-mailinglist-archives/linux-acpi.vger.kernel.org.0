Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D08120527
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 13:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLPMNZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 07:13:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:20168 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfLPMNZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 07:13:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 04:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="217147072"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2019 04:13:20 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1igpFY-0006Ou-DM; Mon, 16 Dec 2019 14:13:20 +0200
Date:   Mon, 16 Dec 2019 14:13:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alex.hung@canonical.com, linux-acpi@vger.kernel.org,
        lenb@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        charles.d.prestopine@intel.com, dvhart@infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v2 3/4] platform/x86: intel-hid: Add new Tiger Lake
 hardware ID to support HID driver
Message-ID: <20191216121320.GQ32742@smile.fi.intel.com>
References: <cover.1576260216.git.gayatri.kammela@intel.com>
 <a70a856e9a87c89ba92da514c1dda1f46f10b0de.1576260216.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70a856e9a87c89ba92da514c1dda1f46f10b0de.1576260216.git.gayatri.kammela@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 13, 2019 at 10:14:22AM -0800, Gayatri Kammela wrote:
> Tiger Lake has a new unique hardware ID to support Intel's HID event
> filter driver. Hence, add it.
> 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> ---
>  drivers/platform/x86/intel-hid.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
> index ef6d4bd77b1a..43d590250228 100644
> --- a/drivers/platform/x86/intel-hid.c
> +++ b/drivers/platform/x86/intel-hid.c
> @@ -19,6 +19,7 @@ MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Alex Hung");
>  
>  static const struct acpi_device_id intel_hid_ids[] = {
> +	{"INT1051", 0},
>  	{"INT33D5", 0},
>  	{"", 0},
>  };
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


