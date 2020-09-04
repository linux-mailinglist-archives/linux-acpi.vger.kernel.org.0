Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC625DFD9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIDQf1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 12:35:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:22282 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgIDQfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Sep 2020 12:35:25 -0400
IronPort-SDR: N7G1NMA1vwgQZOyxy79IzchW1pPfH7PkEXNqYvcXOf+4iQvVX/gX2IOO38Od/e6Sd2bhLHM/BU
 afh1yvK+7vCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="137300774"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="137300774"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 09:35:22 -0700
IronPort-SDR: /dqQJqsIa/VFbqalbeB6jnnHq/h+KBnDMOXQYnSozk9jvYwAZbYayzsGNojeOYVl2FHGANE9zP
 QJyMI8K2AIJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="332215807"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 09:35:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kEEgH-00EKJ1-4s; Fri, 04 Sep 2020 19:35:17 +0300
Date:   Fri, 4 Sep 2020 19:35:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 03/23] lib: uaccess: provide getline_from_user()
Message-ID: <20200904163517.GW1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904154547.3836-4-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:27PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Provide a uaccess helper that allows callers to copy a single line from
> user memory. This is useful for debugfs write callbacks.

Doesn't mm/util.c provides us something like this?
strndup_user()?

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  include/linux/uaccess.h |  3 +++
>  lib/usercopy.c          | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 94b285411659..5aedd8ac5c31 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -333,6 +333,9 @@ long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
>  		long count);
>  long strnlen_user_nofault(const void __user *unsafe_addr, long count);
>  
> +ssize_t getline_from_user(char *dst, size_t dst_size,
> +			  const char __user *src, size_t src_size);
> +
>  /**
>   * get_kernel_nofault(): safely attempt to read from a location
>   * @val: read into this variable
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index b26509f112f9..55aaaf93d847 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -87,3 +87,40 @@ int check_zeroed_user(const void __user *from, size_t size)
>  	return -EFAULT;
>  }
>  EXPORT_SYMBOL(check_zeroed_user);
> +
> +/**
> + * getline_from_user - Copy a single line from user
> + * @dst: Where to copy the line to
> + * @dst_size: Size of the destination buffer
> + * @src: Where to copy the line from
> + * @src_size: Size of the source user buffer
> + *
> + * Copies a number of characters from given user buffer into the dst buffer.
> + * The number of bytes is limited to the lesser of the sizes of both buffers.
> + * If the copied string contains a newline, its first occurrence is replaced
> + * by a NULL byte in the destination buffer. Otherwise the function ensures
> + * the copied string is NULL-terminated.
> + *
> + * Returns the number of copied bytes or a negative error number on failure.
> + */
> +
> +ssize_t getline_from_user(char *dst, size_t dst_size,
> +			  const char __user *src, size_t src_size)
> +{
> +	size_t size = min_t(size_t, dst_size, src_size);
> +	char *c;
> +	int ret;
> +
> +	ret = copy_from_user(dst, src, size);
> +	if (ret)
> +		return -EFAULT;
> +
> +	dst[size - 1] = '\0';
> +
> +	c = strchrnul(dst, '\n');
> +	if (*c)
> +		*c = '\0';
> +
> +	return c - dst;
> +}
> +EXPORT_SYMBOL(getline_from_user);
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


