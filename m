Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3229EBAC
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 13:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgJ2MRe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 08:17:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:11695 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbgJ2MRb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 08:17:31 -0400
IronPort-SDR: GVQ3tXaGjA+VxqpTuhEOLycl8BKi9M5xf6QyIYvCnD6ub28WyFc4lGsUZa8869W+PY9TFe31G1
 Ifs6/UHb/faQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="147702864"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="147702864"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 05:17:30 -0700
IronPort-SDR: StQNfa+/3huANQDpnLzvsdHElkvpBUjLebSMi51+ZEqG+vFYiyz59WdgJORzWMw5xQbJ76/kGM
 dkCsdeO2/RXg==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="469114948"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 05:17:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kY6sw-001Ebg-Uv; Thu, 29 Oct 2020 14:18:30 +0200
Date:   Thu, 29 Oct 2020 14:18:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCHv2 0/3] PM operations for software nodes
Message-ID: <20201029121830.GL4077@smile.fi.intel.com>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 01:59:38PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> This is the second version of this series. Rafael pointed out in v1
> that I was not handling bus PM ops correctly. He also requested that I
> put a comment to the code explaining things a little.
> 
> The original v1 series:
> https://lore.kernel.org/linux-acpi/20200825135951.53340-1-heikki.krogerus@linux.intel.com/

I have tested this on Intel Edison and found no regressions.
Feel free to add my
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Heikki Krogerus (3):
>   software node: Power management operations for software nodes
>   software node: Introduce device_add_software_node()
>   usb: dwc3: pci: Register a software node for the dwc3 platform device
> 
>  drivers/base/power/common.c |   8 +-
>  drivers/base/swnode.c       | 738 +++++++++++++++++++++++++++++++++++-
>  drivers/usb/dwc3/dwc3-pci.c | 175 +++++----
>  include/linux/property.h    |  13 +
>  4 files changed, 835 insertions(+), 99 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko


