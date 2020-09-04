Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08BC25E060
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIDQ44 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:56:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:34166 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgIDQ4z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:56:55 -0400
IronPort-SDR: 2AagIkCnSbOK5Tdv3VfXd6Lszu3/vNl79QDIPIiric7y1kxePY9S93IBC7ODFOHGbUG4BcPHvX
 1fJPOzVD+elA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="175837419"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="175837419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:56:55 -0700
IronPort-SDR: wzfTkJJH7WgbznP3nXUT+8ZzS767uuL/6fZ/c/HbOW5vSVI4ua10j2CU72+gUFLfKXDgGLJAlm
 wEIaxM4xeQAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332220931"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:56:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEF17-00EKW1-NW; Fri, 04 Sep 2020 19:56:49 +0300
Date:   Fri, 4 Sep 2020 19:56:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 21/23] gpio: mockup: provide a way to delete dummy chips
Message-ID: <20200904165649.GE1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-22-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-22-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:45PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a new debugfs attribute 'delete_device' to which the chip label can
> be written to dynamically remove the associated dummy device.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpio-mockup.c | 70 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 1353239dc315..9d2de78a45c2 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/string_helpers.h>
>  #include <linux/uaccess.h>
>  
> @@ -668,14 +669,81 @@ static int __init gpio_mockup_register_chips_from_params(void)
>  	return 0;
>  }
>  
> -static int __init gpio_mockup_init(void)
> +static ssize_t gpio_mockup_debugfs_delete_device_write(struct file *file,
> +						const char __user *usr_buf,
> +						size_t size, loff_t *ppos)
>  {
> +	struct gpio_mockup_device *mockup_dev;
> +	char label[GPIO_MOCKUP_LABEL_SIZE];
> +	struct list_head *curr;
> +	struct device *dev;
> +	const char *prop;
>  	int ret;
>  
> +	if (*ppos != 0)
> +		return -EINVAL;
> +
> +	ret = getline_from_user(label, sizeof(label), usr_buf, size);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&gpio_mockup_devices_lock);
> +
> +	list_for_each(curr, &gpio_mockup_devices) {
> +		mockup_dev = list_entry(curr, struct gpio_mockup_device, list);

Why not list_for_each_entry()?

> +		dev = &mockup_dev->pdev->dev;
> +
> +		ret = device_property_read_string(dev, "chip-label", &prop);
> +		if (ret) {
> +			mutex_unlock(&gpio_mockup_devices_lock);
> +			return ret;
> +		}
> +
> +		if (sysfs_streq(label, prop)) {
> +			gpio_mockup_unregister_one_device(mockup_dev);
> +			mutex_unlock(&gpio_mockup_devices_lock);
> +			return size;
> +		}
> +	}
> +
> +	mutex_unlock(&gpio_mockup_devices_lock);
> +	return -ENODEV;
> +}
> +
> +static const struct file_operations gpio_mockup_debugfs_delete_device_ops = {
> +	.owner = THIS_MODULE,
> +	.open = gpio_mockup_debugfs_open,
> +	.write = gpio_mockup_debugfs_delete_device_write,
> +	.llseek = no_llseek,
> +	.release = single_release,
> +};
> +
> +static int __init gpio_mockup_debugfs_init(void)
> +{
> +	struct dentry *entry;
> +
>  	gpio_mockup_dbg_dir = debugfs_create_dir("gpio-mockup", NULL);
>  	if (IS_ERR(gpio_mockup_dbg_dir))
>  		return PTR_ERR(gpio_mockup_dbg_dir);
>  
> +	entry = debugfs_create_file("delete_device", 0200, gpio_mockup_dbg_dir,
> +				NULL, &gpio_mockup_debugfs_delete_device_ops);
> +	if (IS_ERR(entry)) {
> +		debugfs_remove_recursive(gpio_mockup_dbg_dir);
> +		return PTR_ERR(entry);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init gpio_mockup_init(void)
> +{
> +	int ret;
> +
> +	ret = gpio_mockup_debugfs_init();
> +	if (ret)
> +		return ret;
> +
>  	ret = platform_driver_register(&gpio_mockup_driver);
>  	if (ret) {
>  		pr_err("error registering platform driver\n");
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


