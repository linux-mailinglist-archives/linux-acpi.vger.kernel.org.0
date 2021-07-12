Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB27B3C62B6
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhGLSi6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 14:38:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:65212 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhGLSi5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jul 2021 14:38:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="295681284"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="295681284"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 11:36:07 -0700
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="459281025"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 11:36:05 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m30md-00CKKX-E9; Mon, 12 Jul 2021 21:35:59 +0300
Date:   Mon, 12 Jul 2021 21:35:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 4/6] ACPI: glue: Eliminate acpi_platform_notify()
Message-ID: <YOyLj4/s9Sclo/Wl@smile.fi.intel.com>
References: <2780027.e9J7NaK4W3@kreacher>
 <8790139.CDJkKcVGEf@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8790139.CDJkKcVGEf@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 07:25:55PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Get rid of acpi_platform_notify() which is redundant and
> make device_platform_notify() in the driver core call
> acpi_device_notify() and acpi_device_notify_remove() directly.

> +	if (action == KOBJ_ADD)
> +		acpi_device_notify(dev);
> +	else if (action == KOBJ_REMOVE)
> +		acpi_device_notify_remove(dev);

In most of the cases we are using switch-case approach with
KOBJ_ADD/KOBJ_REMOVE. Would it make sense to keep that pattern?

-- 
With Best Regards,
Andy Shevchenko


