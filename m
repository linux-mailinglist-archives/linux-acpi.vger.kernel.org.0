Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C67458D50
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 12:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhKVL33 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 06:29:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:57356 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhKVL3Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 06:29:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="214796710"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="214796710"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 03:26:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="674032118"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 03:26:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mp7Se-009Poz-Bv;
        Mon, 22 Nov 2021 13:26:12 +0200
Date:   Mon, 22 Nov 2021 13:26:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v11 4/4] tools: Introduce power/acpi/tools/pfru
Message-ID: <YZt+VPI2n/MED9O6@smile.fi.intel.com>
References: <cover.1637505679.git.yu.c.chen@intel.com>
 <a1f688cd4ade1257e96d13c91eba72a1aeef5d59.1637505679.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f688cd4ade1257e96d13c91eba72a1aeef5d59.1637505679.git.yu.c.chen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Nov 21, 2021 at 11:17:29PM +0800, Chen Yu wrote:
> Introduce a user space tool to make use of the interface exposed by
> Platform Firmware Runtime Update and Telemetry drivers. The users
> can use this tool to do firmware code injection, driver update and
> to retrieve the telemetry data.

Have you tried to build tools with `make O=/my/tmp/folder/for/kernel/build ...`
which previously has been used for kernel builds?

-- 
With Best Regards,
Andy Shevchenko


