Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA1E4573
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408026AbfJYITy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 04:19:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:31158 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405453AbfJYITx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 04:19:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 01:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="400038721"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 Oct 2019 01:19:51 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNup4-000235-FW; Fri, 25 Oct 2019 11:19:50 +0300
Date:   Fri, 25 Oct 2019 11:19:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH 05/12] ACPICA: make acpi_load_table() return table index
Message-ID: <20191025081950.GI32742@smile.fi.intel.com>
References: <20191024185556.4606-1-erik.schmauss@intel.com>
 <20191024185556.4606-6-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024185556.4606-6-erik.schmauss@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2019 at 11:55:49AM -0700, Erik Schmauss wrote:
> From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> 
> ACPICA commit d1716a829d19be23277d9157c575a03b9abb7457
> 
> For unloading an ACPI table, it is necessary to provide the index of
> the table. The method intended for dynamically loading or hotplug
> addition of tables, acpi_load_table(), should provide this information
> via an optional pointer to the loaded table index.
> 
> This patch fixes the table unload function of acpi_configfs.
> 

Thank you!

My comments below.

First of all, can I be Cc'ed to all series to be able to test?

> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: d06c47e3dd07f ("ACPI: configfs: Resolve objects on host-directed
> table loads")

I believe this has to be one line.

> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -53,7 +53,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
>  	if (!table->header)
>  		return -ENOMEM;
>  
> -	ret = acpi_load_table(table->header);
> +	ret = acpi_load_table(table->header, &table->index);
>  	if (ret) {
>  		kfree(table->header);
>  		table->header = NULL;

As far as I understood the release notes of latest ACPICA there is also a
counterpart function being provided. That said, we need to modify ConfigFS
removing path to use the new API.

Am I correct?

-- 
With Best Regards,
Andy Shevchenko


