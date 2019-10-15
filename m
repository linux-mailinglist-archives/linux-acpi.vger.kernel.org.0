Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C7D75B6
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 14:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfJOMCy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 08:02:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:11401 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJOMCy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Oct 2019 08:02:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 05:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,299,1566889200"; 
   d="scan'208";a="194498686"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 15 Oct 2019 05:02:50 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKLXN-0007RX-LP; Tue, 15 Oct 2019 15:02:49 +0300
Date:   Tue, 15 Oct 2019 15:02:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 02/14] software node: introduce
 PROPERTY_ENTRY_ARRAY_XXX_LEN()
Message-ID: <20191015120249.GE32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011230721.206646-3-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 04:07:09PM -0700, Dmitry Torokhov wrote:
> Sometimes we want to initialize property entry array from a regular
> pointer, when we can't determine length automatically via ARRAY_SIZE.
> Let's introduce PROPERTY_ENTRY_ARRAY_XXX_LEN macros that take explicit
> "len" argument.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  include/linux/property.h | 45 +++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 44c1704f7163..f89b930ca4b7 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -256,33 +256,44 @@ struct property_entry {
>   * and structs.
>   */
>  
> -#define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _Type_, _val_)	\
> +#define PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)	\
>  (struct property_entry) {						\
>  	.name = _name_,							\
> -	.length = ARRAY_SIZE(_val_) * sizeof(_type_),			\
> +	.length = (_len_) * sizeof(_type_),				\
>  	.is_array = true,						\
>  	.type = DEV_PROP_##_Type_,					\
>  	{ .pointer = { ._type_##_data = _val_ } },			\
>  }
>  
> -#define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)			\
> -	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u8, U8, _val_)
> -#define PROPERTY_ENTRY_U16_ARRAY(_name_, _val_)			\
> -	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u16, U16, _val_)
> -#define PROPERTY_ENTRY_U32_ARRAY(_name_, _val_)			\
> -	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u32, U32, _val_)
> -#define PROPERTY_ENTRY_U64_ARRAY(_name_, _val_)			\
> -	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, U64, _val_)
> +#define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
> +	PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
> +#define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
> +	PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
> +#define PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, _len_)		\
> +	PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
> +#define PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, _len_)		\
> +	PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
>  
> -#define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
> -(struct property_entry) {					\
> -	.name = _name_,						\
> -	.length = ARRAY_SIZE(_val_) * sizeof(const char *),	\
> -	.is_array = true,					\
> -	.type = DEV_PROP_STRING,				\
> -	{ .pointer = { .str = _val_ } },			\
> +#define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
> +(struct property_entry) {						\
> +	.name = _name_,							\
> +	.length = (_len_) * sizeof(const char *),			\
> +	.is_array = true,						\
> +	.type = DEV_PROP_STRING,					\
> +	{ .pointer = { .str = _val_ } },				\
>  }
>  
> +#define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
> +	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
> +#define PROPERTY_ENTRY_U16_ARRAY(_name_, _val_)				\
> +	PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
> +#define PROPERTY_ENTRY_U32_ARRAY(_name_, _val_)				\
> +	PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
> +#define PROPERTY_ENTRY_U64_ARRAY(_name_, _val_)				\
> +	PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
> +#define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
> +	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
> +
>  #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
>  (struct property_entry) {					\
>  	.name = _name_,						\
> -- 
> 2.23.0.700.g56cf767bdb-goog
> 

-- 
With Best Regards,
Andy Shevchenko


