Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B2A64A45E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Dec 2022 16:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiLLPpj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Dec 2022 10:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiLLPpi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2022 10:45:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD986320
        for <linux-acpi@vger.kernel.org>; Mon, 12 Dec 2022 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670859937; x=1702395937;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bOXYXg+Psp/Jb274bPqAEZZCJv0Jnxl+EGdKwfx9IQQ=;
  b=k+S0CBnWfdez/vspWP2bWxm2wrrUmIdXBsNuZs419lREkguVFudGDYW9
   LJrxB8IZza3q0mC1sPCVeS9DZ/xkBg1QDVylJxBFL58DfbsJGgtgZJwsG
   /gA04giwAoXCbyjpEKifvW/6Da3BZPpe2FXnxdDfNI3s5UUgz0WHlqLOm
   7guJEAkMbLFIOYLbiJg3VARLzEbvTEP7eLkmztjW+igcQYK64ylOZNDRs
   hY7vGd/DTOhWVnV4tY9GnUCgfBB1F/p7gpWMyvsepXqjsOA0BsTQZN3Qe
   X+E/wSra5kmqGFaAH5Wd7OCUTTZBafPPuF3f+ibY7DUoIFtnI0qLycDKD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="298230955"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="298230955"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 07:45:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="680716827"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="680716827"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2022 07:45:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1p4kzl-008hhF-1Y;
        Mon, 12 Dec 2022 17:45:33 +0200
Date:   Mon, 12 Dec 2022 17:45:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Niyas Sait <niyas.sait@linaro.org>, linus.walleij@linaro.org,
        fugang.duan@linaro.org
Subject: [RFC] ACPI Code First ECR: Pin Number Space vs. GPIO Number Space
Message-ID: <Y5dMndGzaoZpm3w4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URI_TRY_3LD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In the current form of the specification there is a room for misinterpretation
the PinList argument for Pin*() descriptors and Gpio*() descriptors.

When Pin*() descriptors have been introduced the relationship between the GPIO
Number Space and Pin Number Space wasn't clarified, so update the specification
to address this.

# Title: Clarify the Number Space for the Pin*() and Gpio*() descriptors

# Status: Draft

# Document: ACPI Specification 6.5

# License
SPDX-License Identifier: CC-BY-4.0

# Submitter:
* Sponsor: Rafael J. Wysocki, Intel
* Creator/Contributor: Andy Shevchenko, Intel

# Summary of the Change
Clarify the Pin Number Space and GPIO Number Space and their relationship in
the affected sections to reduce a room of possible misinterpretation.

# Benefits of the Change
It will clarify what Pin Number Space and what GPIO Number Space mean.
In particular, when it's appropriate to use one or the other.

# Impact of the Change
Clear understanding by all stakeholders what numbers should be assigned in
the Pin*() and Gpio*() descriptors and how OSPMs will threat them.

# References
Microsoft GPIO Number Space for the Gpio*() descriptors which allows gaps in it.
<https://learn.microsoft.com/en-us/windows-hardware/drivers/gpio/partitioning-a-gpio-controller-into-banks-of-pins>

An example of the DSDT for the Intel Merrifield platform that has separate
GPIO and pin control IP blocks.
<https://github.com/u-boot/u-boot/blob/master/arch/x86/include/asm/arch-tangier/acpi/southcluster.asl>

# Detailed Description of the Change

* Add an additional note at the end of Description in the Sections 19.6.102,
* 19.6.103, and 19.6.104:

> Note: The PinList for the PinConfig/PinFunction/PinGroup descriptors is
> provided in the Pin Number Space. The PinList for the GpioInt/GpioIo
> descriptors is provided in the GPIO Number Space. That is, the certain pins
> may or may not have a GPIO function and the certain GPIOs may or may not be
> connected through a pin multiplexer. In other words the Pin and GPIO number
> spaces are orthogonal to each other. Nevertheless, it's highly recommended
> that the firmware writer will use 1:1 mapping between register index in the
> hardware and the number in the Pin Number Space.

* Add an additional note at the end of Description in the Sections 19.6.56, and
* 19.6.57:

> Note: The PinList for the GpioInt/GpioIo descriptors is provided in the GPIO
> Number Space. The PinList for the PinConfig/PinFunction/PinGroup descriptors
> is provided in the Pin Number Space.

* Replace {2, 3} by {7, 8} in the Pin*() descriptors in the examples in the
* Sections 19.6.102, and 19.6.103.

-- 
With Best Regards,
Andy Shevchenko


