Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244F0534250
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiEYRkV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbiEYRkU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 13:40:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C187B0A5B
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500419; x=1685036419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ivHSfv9fm9Pjzy2w2QEDBgU/ysAU36TdG373PzzKDKI=;
  b=Z76ne+7bKA21bTET1CSTdNEi+KppYLOGwBjloM4c1ykcH4P9jyigU8S7
   WVU8Aw0kdG0OOphRZc8hIezi0i1zRmREnkpgCbQUPa6twW10XF2Voc3z5
   nBYvv2a/jflESjipmjDxUnkGdVu99zjwJ/v1tCKOu+i5tbUdmx23aHEtl
   RHRp8Ii0knM8sNMdLuNHDk/K6oVcSvnHNDVjcF4NjQ2iq2fEyUlnugnLY
   EPa1HgGKmPOWbi+BOA6Emx8zb/iHE8hl5pxFimW62khd/0YDGfaBgOkMc
   0aKgxmIGSkGGVKjCcWEZvowV+XJU8TJnllSG3Je7WJVzTRvFCju6KTBBy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="271457204"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="271457204"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:14:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="609289146"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:14:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ntuai-000L4U-KH;
        Wed, 25 May 2022 20:14:36 +0300
Date:   Wed, 25 May 2022 20:14:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 6/8] ACPI: property: Unify integer value reading
 functions
Message-ID: <Yo5j/N+qoSSYexnj@smile.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-7-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525130123.767410-7-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 25, 2022 at 04:01:21PM +0300, Sakari Ailus wrote:
> Unify functions reading ACPI property integer values into a single macro
> using C99 _Generic().
> 
> Also use size_t for the counter instead of int.

Thanks for an update!

...

> +#define acpi_copy_property_array_uint(items, val, nval)			\
> +	({								\

You can define local copies of (read-only) parameters and avoid adding
parentheses each time you access them.

> +		size_t i;						\
> +		int ret = 0;						\
> +									\
> +		for (i = 0; i < (nval); i++) {				\
> +			if ((items)[i].type != ACPI_TYPE_INTEGER) {	\
> +				ret = -EPROTO;				\
> +				break;					\
> +			}						\
> +			if ((items)[i].integer.value > _Generic((val),	\
> +								u8: U8_MAX, \
> +								u16: U16_MAX, \
> +								u32: U32_MAX, \
> +								u64: U64_MAX, \
> +								default: 0U)) { \

I think nobody will die if you add one more TAB to each line and make \ be
consistent column wise.

> +				ret = -EOVERFLOW;			\
> +				break;					\
> +			}						\
> +									\
> +			(val)[i] = (items)[i].integer.value;		\
> +		}							\
> +		ret;							\
> +	})

-- 
With Best Regards,
Andy Shevchenko


