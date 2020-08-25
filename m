Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FEC251B69
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Aug 2020 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHYOyB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Aug 2020 10:54:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:9716 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbgHYOxc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Aug 2020 10:53:32 -0400
IronPort-SDR: /ZOqXDBxpJwnSy8dGfpUCmE5+yaeX8fzIk+Yf5cunU2Q+eUYuf8UwM3W0Co2GYdix/Tt5+2WaY
 rVlD1R8keqpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136186106"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="136186106"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 07:53:09 -0700
IronPort-SDR: xCZBWAHDQ9DlZgfqRKEq91dH84AR5+7XOPIRJz9/YCnm8w0/mdgG9O4Qcprtk22atB+MCNEpIk
 Gf9IhagL3igA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="328886276"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 07:53:07 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAa7C-00BLT0-Tn; Tue, 25 Aug 2020 17:39:58 +0300
Date:   Tue, 25 Aug 2020 17:39:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/3] PM operations for software nodes
Message-ID: <20200825143958.GM1891694@smile.fi.intel.com>
References: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 25, 2020 at 04:59:48PM +0300, Heikki Krogerus wrote:
> Hi guys,
> 
> Unfortunately the last patch depends on this:
> https://lore.kernel.org/linux-usb/20200821131101.81915-1-heikki.krogerus@linux.intel.com/
> 
> Would it be easiest that Felipe took care of these (assuming they are
> acceptable)?

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> thanks,
> 
> Heikki Krogerus (3):
>   software node: Power management operations for software nodes
>   software node: Introduce device_add_software_node()
>   usb: dwc3: pci: Register a software node for the dwc3 platform device
> 
>  drivers/base/power/common.c |   8 +-
>  drivers/base/swnode.c       | 569 +++++++++++++++++++++++++++++++++++-
>  drivers/usb/dwc3/dwc3-pci.c | 175 ++++++-----
>  include/linux/property.h    |  13 +
>  4 files changed, 666 insertions(+), 99 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko


