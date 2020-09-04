Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D846125E077
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgIDRAm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:00:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:53983 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgIDRAk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 13:00:40 -0400
IronPort-SDR: 0f4189Bqs76H/HtoA8a7SQJYigg/cIqJzGCbf+0qsW4Nd9AphfxEuyVkrJG1du6ICq3dGafsFW
 2CiJinTMFLOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="155190475"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="155190475"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 10:00:40 -0700
IronPort-SDR: rejMaLGQY5hJ5pm1MW8zL5Nf/fl0eduSCfu+YhdKnsYihNxJm05y7VuBf7ivawSv6T+gsfB+ed
 ZN9/yeM38S8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332221735"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 10:00:31 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEF4e-00EKYW-Kj; Fri, 04 Sep 2020 20:00:28 +0300
Date:   Fri, 4 Sep 2020 20:00:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 10/23] gpio: mockup: fix resource leak in error path
Message-ID: <20200904170028.GG1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-11-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:34PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> If the module init function fails after creating the debugs directory,
> it's never removed. Add proper cleanup calls to avoid this resource
> leak.

Does it fix existing bug?

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpio-mockup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 78c97f7b6893..19c092f814fd 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -550,6 +550,7 @@ static int __init gpio_mockup_init(void)
>  	err = platform_driver_register(&gpio_mockup_driver);
>  	if (err) {
>  		pr_err("error registering platform driver\n");
> +		debugfs_remove_recursive(gpio_mockup_dbg_dir);
>  		return err;
>  	}
>  
> @@ -580,6 +581,7 @@ static int __init gpio_mockup_init(void)
>  			pr_err("error registering device");
>  			platform_driver_unregister(&gpio_mockup_driver);
>  			gpio_mockup_unregister_pdevs();
> +			debugfs_remove_recursive(gpio_mockup_dbg_dir);
>  			return PTR_ERR(pdev);
>  		}
>  
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


