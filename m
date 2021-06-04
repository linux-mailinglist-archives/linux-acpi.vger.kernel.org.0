Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77B39BC56
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFDP5t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 11:57:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:57345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhFDP5s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 11:57:48 -0400
IronPort-SDR: ufYYIo7HH2SIFqu49RYvd0lz4SPaAGyaLbm4DhHFOeXEnkZdbfSA7lNi+VJEkceYIWnswIl0rk
 wNdCGGUto1jA==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="289946027"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="289946027"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 08:55:59 -0700
IronPort-SDR: 3e2YRCpx9WpBo+Zqp7DVkWIgK/bE/PrLgMiJll7yPN/Jm1LF2HIefEoN0VC60pXWMKSAvanqbb
 QCrImlvWQTgw==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="417796460"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 08:55:57 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lpCAs-00HGBm-Qb; Fri, 04 Jun 2021 18:55:54 +0300
Date:   Fri, 4 Jun 2021 18:55:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/1] device property: Unify access to of_node
Message-ID: <YLpNCqho0b3vS7K1@smile.fi.intel.com>
References: <20210604131343.62016-1-andriy.shevchenko@linux.intel.com>
 <202106042250.BjbSOQc0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106042250.BjbSOQc0-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 04, 2021 at 10:55:05PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Perhaps something to improve:

Definitely. Thanks for report!

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/base/property.c: In function 'device_dma_supported':
> >> drivers/base/property.c:875:48: warning: passing argument 1 of 'to_acpi_device_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      875 |  return acpi_dma_supported(to_acpi_device_node(fwnode));
>          |                                                ^~~~~~
>    In file included from drivers/base/property.c:10:
>    include/linux/acpi.h:768:77: note: expected 'struct fwnode_handle *' but argument is of type 'const struct fwnode_handle *'
>      768 | static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
>          |                                                       ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
>    drivers/base/property.c: In function 'device_get_dma_attr':
>    drivers/base/property.c:890:48: warning: passing argument 1 of 'to_acpi_device_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      890 |   attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>          |                                                ^~~~~~
>    In file included from drivers/base/property.c:10:
>    include/linux/acpi.h:768:77: note: expected 'struct fwnode_handle *' but argument is of type 'const struct fwnode_handle *'
>      768 | static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
>          |                                                       ~~~~~~~~~~~~~~~~~~~~~~^~~~~~



-- 
With Best Regards,
Andy Shevchenko


