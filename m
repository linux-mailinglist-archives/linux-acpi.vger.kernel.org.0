Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD8A5B36
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfIBQN4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 12:13:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:30419 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfIBQN4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 12:13:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 09:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="198604174"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2019 09:13:53 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4oxk-0004ew-S2; Mon, 02 Sep 2019 19:13:52 +0300
Date:   Mon, 2 Sep 2019 19:13:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 11/11] lib/test_printf: Add tests for %pfw printk
 modifier
Message-ID: <20190902161352.GS2680@smile.fi.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
 <20190902135732.23455-12-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902135732.23455-12-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 04:57:32PM +0300, Sakari Ailus wrote:
> Add a test for the %pfw printk modifier using software nodes.

> +static void __init fwnode_pointer(void)
> +{
> +	const struct software_node softnodes[] = {
> +		{ .name = "first", },
> +		{ .name = "second", .parent = &softnodes[0], },
> +		{ .name = "third", .parent = &softnodes[1], },
> +		{ NULL /* Guardian */ },

Comma is still here :-)

> +	};

> +	test(full_name_second, "%pfw",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> +	test(full_name, "%pfw",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> +	test(full_name, "%pfwf",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
> +	test(second_name, "%pfwP",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
> +	test(third_name, "%pfwP",
> +	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));

I have another thought about these. The test cases will fail in either of
adding, inserting or removing items in softnodes array. So, using the above
"protective" scheme doesn't bring any value except making readability worse.

-- 
With Best Regards,
Andy Shevchenko


