Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AED75BE
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 14:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfJOMDy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 08:03:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:55667 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJOMDy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Oct 2019 08:03:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 05:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,299,1566889200"; 
   d="scan'208";a="207529046"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 15 Oct 2019 05:03:51 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKLYM-0007Sc-BB; Tue, 15 Oct 2019 15:03:50 +0300
Date:   Tue, 15 Oct 2019 15:03:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 04/14] software node: mark internal macros with double
 underscores
Message-ID: <20191015120350.GF32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-5-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011230721.206646-5-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 04:07:11PM -0700, Dmitry Torokhov wrote:
> Let's mark PROPERTY_ENTRY_* macros that are internal with double leading
> underscores so users are not tempted to use them.

We may undef them at the end of file, right?

> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  include/linux/property.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index f89b930ca4b7..2c9d4d209296 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -256,7 +256,7 @@ struct property_entry {
>   * and structs.
>   */
>  
> -#define PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)	\
> +#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)\
>  (struct property_entry) {						\
>  	.name = _name_,							\
>  	.length = (_len_) * sizeof(_type_),				\
> @@ -266,13 +266,13 @@ struct property_entry {
>  }
>  
>  #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
> -	PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
> +	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
>  #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
> -	PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
> +	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
>  #define PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, _len_)		\
> -	PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
> +	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
>  #define PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, _len_)		\
> -	PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
> +	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
>  
>  #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
>  (struct property_entry) {						\
> @@ -294,7 +294,7 @@ struct property_entry {
>  #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
>  	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
>  
> -#define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
> +#define __PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
>  (struct property_entry) {					\
>  	.name = _name_,						\
>  	.length = sizeof(_type_),				\
> @@ -303,13 +303,13 @@ struct property_entry {
>  }
>  
>  #define PROPERTY_ENTRY_U8(_name_, _val_)		\
> -	PROPERTY_ENTRY_INTEGER(_name_, u8, U8, _val_)
> +	__PROPERTY_ENTRY_INTEGER(_name_, u8, U8, _val_)
>  #define PROPERTY_ENTRY_U16(_name_, _val_)		\
> -	PROPERTY_ENTRY_INTEGER(_name_, u16, U16, _val_)
> +	__PROPERTY_ENTRY_INTEGER(_name_, u16, U16, _val_)
>  #define PROPERTY_ENTRY_U32(_name_, _val_)		\
> -	PROPERTY_ENTRY_INTEGER(_name_, u32, U32, _val_)
> +	__PROPERTY_ENTRY_INTEGER(_name_, u32, U32, _val_)
>  #define PROPERTY_ENTRY_U64(_name_, _val_)		\
> -	PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
> +	__PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
>  
>  #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
>  (struct property_entry) {				\
> -- 
> 2.23.0.700.g56cf767bdb-goog
> 

-- 
With Best Regards,
Andy Shevchenko


