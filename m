Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A2433562
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Oct 2021 14:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhJSMHm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Oct 2021 08:07:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:56258 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhJSMHm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Oct 2021 08:07:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="228367676"
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="228367676"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 05:05:28 -0700
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="462731000"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 05:05:26 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mcnrf-000TJE-S8;
        Tue, 19 Oct 2021 15:05:07 +0300
Date:   Tue, 19 Oct 2021 15:05:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to
 intel_pmic_bytcrc driver
Message-ID: <YW60cwMHNoTYgQL6@smile.fi.intel.com>
References: <20211017161523.43801-1-kitakar@gmail.com>
 <20211017161523.43801-2-kitakar@gmail.com>
 <3e6428f1-9411-fac6-9172-1dfe6de58c28@redhat.com>
 <23d641620aebd1aa47fd73d040dec4ad8974d03d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d641620aebd1aa47fd73d040dec4ad8974d03d.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 19, 2021 at 08:56:04PM +0900, Tsuchiya Yuto wrote:
> On Mon, 2021-10-18 at 11:16 +0200, Hans de Goede wrote:
> > On 10/17/21 18:15, Tsuchiya Yuto wrote:

...

> > Tsuchiya, can you give the attached patch a try.
> 
> Thanks!
> 
> I tried your attached patch, and I can confirm that it's working as
> expected.
> 
> Now it's using cht one:
> 
>         $ ls /sys/devices/pci0000:00/808622C1:05/i2c-5/i2c-INT33FD:00
>         cht_crystal_cove_pmic  crystal_cove_gpio  crystal_cove_pwm  driver  firmware_node  modalias  name  power  subsystem  uevent
> 
> and the function intel_soc_pmic_exec_mipi_pmic_seq_element() is also
> working with atomisp driver.

To be formal you may give a dedicated tag here, i.e. Tested-by:.
It will be easier for tools, such as `b4`, to catch it up
and not forget.

-- 
With Best Regards,
Andy Shevchenko


