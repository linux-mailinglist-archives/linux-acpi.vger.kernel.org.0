Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11C411E0EF
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 10:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfLMJfZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 04:35:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:10156 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfLMJfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Dec 2019 04:35:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 01:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="208406805"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2019 01:35:20 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ifhM0-00067Z-Bn; Fri, 13 Dec 2019 11:35:20 +0200
Date:   Fri, 13 Dec 2019 11:35:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alex.hung@canonical.com, linux-acpi@vger.kernel.org,
        lenb@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        charles.d.prestopine@intel.com, dvhart@infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v1 3/4] platform/x86: intel-hid: Add new Tiger Lake
 hardware ID to support HID driver
Message-ID: <20191213093520.GQ32742@smile.fi.intel.com>
References: <cover.1576189376.git.gayatri.kammela@intel.com>
 <4354f2f0e3bdf24497c2791ac02dcbc659c4f076.1576189376.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4354f2f0e3bdf24497c2791ac02dcbc659c4f076.1576189376.git.gayatri.kammela@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 12, 2019 at 02:37:19PM -0800, Gayatri Kammela wrote:

>  	{"INT33D5", 0},
> +	{"INT1051", 0},

And here

-- 
With Best Regards,
Andy Shevchenko


