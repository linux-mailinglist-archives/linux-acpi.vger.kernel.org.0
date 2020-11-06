Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB02A9A9A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 18:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKFRQ1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 12:16:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:12710 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgKFRQ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Nov 2020 12:16:27 -0500
IronPort-SDR: 764hgrVnXpeIwryWCvBXelDzWFwaYTahMOHu24llVvoGdBD7DYwNOhtGTRPEvNz9vkER+tbXx0
 xKFsXOitxbuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="157353309"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="157353309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 09:16:26 -0800
IronPort-SDR: Y9X1zk4eBu7ESRskCJls8VkKXxcCCKLcMjTKtM86QxR25V77hDj42jfE10h0r6foGfg0rwc6YA
 wyoUV/ED+BGw==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="529869139"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 09:16:24 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kb5Md-004P3w-6c; Fri, 06 Nov 2020 19:17:27 +0200
Date:   Fri, 6 Nov 2020 19:17:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: How to add the "gpio-line-names" property in a PCI gpio expander
Message-ID: <20201106171727.GK4077@smile.fi.intel.com>
References: <98acf6339a1b43d6a38f867069088530@asem.it>
 <CAJZ5v0g7POp1Lp05RcJJ8ZD1ZiaetN0_SfbAjnQg0kCw4aQukQ@mail.gmail.com>
 <20201105115941.GK2495@lahna.fi.intel.com>
 <574b86929d1247caae717ab1a2f31194@asem.it>
 <20201105152020.GO2495@lahna.fi.intel.com>
 <5fb64f9c8af64235943c29c9ba50a2df@asem.it>
 <20201106070432.GQ2495@lahna.fi.intel.com>
 <c20e82318bbf426c9d9000cac7e7734b@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20e82318bbf426c9d9000cac7e7734b@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 06, 2020 at 04:47:35PM +0000, Flavio Suligoi wrote:

> > Or something like that. RPX is the root port 14.1 and if I read the
> > above right both the bridge and the EXAR device have device and function
> > 0.
> 
> All ok now, I've added the bridge (I had to use the BIOS sources) and
> not it works:

I suppose not -> now ;)

Glad to hear this! So, maybe you can add some bits to the documentation [1]
based on your experience?

Note, I have sent a series [2] to amend it a bit, and your input welcome!

[1]: Documentation/firmware-guide/acpi/gpio-properties.rst
[2]: https://lore.kernel.org/linux-acpi/20201029193243.61546-1-andriy.shevchenko@linux.intel.com/T/#u


-- 
With Best Regards,
Andy Shevchenko


