Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EFA25DFF8
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgIDQmn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:42:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:21767 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDQmn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:42:43 -0400
IronPort-SDR: yO6cboLbR+ba8ZUEy4eE/wDs6duDhNEWhqPWvzyHbLv30LjBIlr00XhtP2Q1hhy2tSwFlix2FC
 7wL0kWMKXclw==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="221989943"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="221989943"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:42:42 -0700
IronPort-SDR: uCXtvlm/p5e5Lku6QREweTklcQfrJMMxLewC7ArAfnaS5eP041nF/eUclu/AKD6gir5aGlaRJY
 75L4/wGcIynQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332217238"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:42:39 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEev-00EKI4-Az; Fri, 04 Sep 2020 19:33:53 +0300
Date:   Fri, 4 Sep 2020 19:33:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 02/23] lib: string_helpers: provide kfree_strarray()
Message-ID: <20200904163353.GV1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:26PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There's a common pattern of dynamically allocating an array of char
> pointers and then also dynamically allocating each string in this
> array. Provide a helper for freeing such a string array with one call.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  include/linux/string_helpers.h |  2 ++
>  lib/string_helpers.c           | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index 86f150c2a6b6..55b25120a1c6 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -94,4 +94,6 @@ char *kstrdup_quotable(const char *src, gfp_t gfp);
>  char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
>  char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
>  
> +void kfree_strarray(char **str_array, size_t num_str);
> +
>  #endif
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 963050c0283e..22505efc6aae 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -649,3 +649,25 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
>  	return pathname;
>  }
>  EXPORT_SYMBOL_GPL(kstrdup_quotable_file);
> +
> +/**
> + * kfree_strarray - free a number of dynamically allocated strings contained
> + *                  in an array and the array itself
> + *
> + * @str_array: Dynamically allocated array of strings to free. If NULL - the
> + *             function does nothing.
> + * @num_str: Number of strings (starting from the beginning of the array) to
> + *           free.
> + */
> +void kfree_strarray(char **str_array, size_t num_str)
> +{
> +	unsigned int i;

> +	if (!str_array)
> +		return;

Shouldn't we expect that caller will supply NULL, 0 and above check is not
needed?

> +	for (i = 0; i < num_str; i++)
> +		kfree(str_array[i]);
> +	kfree(str_array);

> +}
> +EXPORT_SYMBOL_GPL(kfree_strarray);
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


