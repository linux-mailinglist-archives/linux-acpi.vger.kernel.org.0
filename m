Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2D3CB742
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhGPMU0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 08:20:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:36606 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbhGPMU0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Jul 2021 08:20:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="190401757"
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="190401757"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 05:17:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="431192521"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 05:17:29 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m4MmQ-00EDjF-Lx; Fri, 16 Jul 2021 15:17:22 +0300
Date:   Fri, 16 Jul 2021 15:17:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     laurentiu.tudor@nxp.com
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jon@solid-run.com
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
Message-ID: <YPF40t5bhgTFM2wK@smile.fi.intel.com>
References: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
> software nodes, thus leading to underflow errors. Balance the refcount by
> bumping it in the device_create_managed_software_node() function.
> 
> The error [1] was encountered after adding a .shutdown() op to our
> fsl-mc-bus driver.

Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
later on), I can tell that probably something is wrong in the ->shutdown()
method itself.

-- 
With Best Regards,
Andy Shevchenko


