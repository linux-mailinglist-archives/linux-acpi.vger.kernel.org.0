Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD81526131C
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Sep 2020 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIHPAi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Sep 2020 11:00:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:54040 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgIHOYv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Sep 2020 10:24:51 -0400
IronPort-SDR: 4m6ZvNCocenMRoQp8WfOK+J3M4llfpkdJcHUXw+YUzwdQasusrZ2QhaaXCXYNVhbPTyphi1E5p
 8cq5DADRY8XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="158154397"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="158154397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 06:49:22 -0700
IronPort-SDR: UVk6x/m63mBVyH71vbfcR5hvGtRm5fgnJc1bMd5sc6UCHlpDtyq2FjtjkWzPPhIvrQE0/YKY7m
 RrfJ1UHBvFgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="333478612"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2020 06:49:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFdxi-00FDZG-RE; Tue, 08 Sep 2020 16:47:06 +0300
Date:   Tue, 8 Sep 2020 16:47:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/3] device: property: add helpers to count items in
 string arrays
Message-ID: <20200908134706.GZ1891694@smile.fi.intel.com>
References: <20200908125813.8809-1-brgl@bgdev.pl>
 <20200908125813.8809-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908125813.8809-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 08, 2020 at 02:58:11PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Instead of doing the following:
> 
>     count = device_property_read_string_array(dev, propname, NULL, 0);
> 
> Let's provide inline helpers with hardcoded arguments for counting
> strings in property arrays.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  include/linux/property.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 9f805c442819..1fa5e250a8ea 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -170,6 +170,12 @@ static inline int device_property_count_u64(struct device *dev, const char *prop
>  	return device_property_read_u64_array(dev, propname, NULL, 0);
>  }
>  
> +static inline int device_property_count_strings(struct device *dev,
> +						const char *propname)
> +{
> +	return device_property_read_string_array(dev, propname, NULL, 0);
> +}
> +
>  static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
>  					     const char *propname)
>  {
> @@ -224,6 +230,13 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
>  	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
>  }
>  
> +static inline int
> +fwnode_property_count_strings(const struct fwnode_handle *fwnode,
> +			      const char *propname)
> +{
> +	return fwnode_property_read_string_array(fwnode, propname, NULL, 0);
> +}
> +
>  struct software_node;
>  
>  /**
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


