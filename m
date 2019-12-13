Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D7A11E0F1
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 10:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfLMJfv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 04:35:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:50934 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfLMJfv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Dec 2019 04:35:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 01:35:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="211396414"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2019 01:35:47 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ifhMR-00068A-F9; Fri, 13 Dec 2019 11:35:47 +0200
Date:   Fri, 13 Dec 2019 11:35:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alex.hung@canonical.com, linux-acpi@vger.kernel.org,
        lenb@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        charles.d.prestopine@intel.com, dvhart@infradead.org,
        Zhang rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v1 4/4] thermal: int340x_thermal: Add new Tiger Lake
 hardware IDs to support thermal driver
Message-ID: <20191213093547.GR32742@smile.fi.intel.com>
References: <cover.1576189376.git.gayatri.kammela@intel.com>
 <38c00cdcff470563b238da953b66532f08b83b25.1576189376.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c00cdcff470563b238da953b66532f08b83b25.1576189376.git.gayatri.kammela@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 12, 2019 at 02:37:20PM -0800, Gayatri Kammela wrote:
> Tiger Lake has a new unique hardware IDs to support thermal driver.
> Hence, add them.

>  	{"INT3400", 0},
> +	{"INT1040", 0},

>  	{"INT3403", 0},
> +	{"INT1043", 0},

And here

-- 
With Best Regards,
Andy Shevchenko


