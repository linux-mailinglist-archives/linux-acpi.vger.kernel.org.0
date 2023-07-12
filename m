Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C5750CA7
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 17:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGLPgl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGLPgl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 11:36:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEDDC2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689176200; x=1720712200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MKhmtzRJRuSK0bXL+0Vhxg+8EKYxbADEu8Gg0ad5iiw=;
  b=Sbu66RH5Z8O3l+rELl2YlVdtgfsnhxfnTijL0UcsHfqLhw6Ng2r4hn21
   9Mai5Hrqjc4nXGC4N3CXEDtRqEM0SSDBX8/XAJ1yYHZm5vtC1xgHIIgmB
   +R6bZ0uX6KMjNJ3npJD4LQ6NTJGWv4o/VNiS9xBHdI+M9KHIGAFh5eU97
   Vuc+RW9fLfXMw2P4lPZSLO8V9maQVRbYbgWw+cvIww8mfJV+QagYlwm0X
   RhWaq9G+Wnil8I2gO3asvMuP5Y9C+eDWHKQeQj6VSV7WXSQy/WBIwmXYN
   pHcHWNCvZ9xppema/DRaqx7H+N0SKLqhst9N0sAYOEvv6n5g1CtjK7NL0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367542755"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="367542755"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="1052245701"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="1052245701"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2023 08:36:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJbtL-002ANR-1t;
        Wed, 12 Jul 2023 18:36:35 +0300
Date:   Wed, 12 Jul 2023 18:36:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com,
        pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com, lenb@kernel.org
Subject: Re: [PATCH 3/4] ACPI: NHLT: Table manipulation helpers
Message-ID: <ZK7Ig6TPhnnKs3Yi@smile.fi.intel.com>
References: <20230712091048.2545319-1-cezary.rojewski@intel.com>
 <20230712091048.2545319-4-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712091048.2545319-4-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 12, 2023 at 11:10:47AM +0200, Cezary Rojewski wrote:
> The table is composed of a range of endpoints with each describing
> audio formats they support. Thus most of the operations involve
> iterating over elements of the table. Simplify the process by
> implementing range of getters.

A few nit-picks below.
In general, LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(Please, use my @linux.intel.com address for LKML and related)

> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  include/acpi/nhlt.h | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
> index a2b93b08218f..076aac41a74e 100644
> --- a/include/acpi/nhlt.h
> +++ b/include/acpi/nhlt.h
> @@ -81,4 +81,72 @@ static inline void acpi_nhlt_put_gbl_table(void)
>  	__cfg->capabilities_size == struct_size(__cfg, mics, __cfg->num_mics) ?		\
>  		__cfg : NULL; })
>  
> +/**
> + * acpi_nhlt_endpoint_fmtscfg - Get the formats configuration space.
> + * @ep:		the endpoint to retrieve the space for.
> + *
> + * Return: A pointer to the formats configuration space.
> + */
> +static inline struct acpi_nhlt_formats_config *
> +acpi_nhlt_endpoint_fmtscfg(const struct acpi_nhlt_endpoint *ep)
> +{
> +	struct acpi_nhlt_cfg *cfg = __acpi_nhlt_endpoint_cfg(ep);
> +
> +	return (struct acpi_nhlt_formats_config *)((u8 *)(cfg + 1) + cfg->capabilities_size);
> +}
> +
> +#define __acpi_nhlt_first_endpoint(tb) \
> +	((void *)(tb + 1))
> +
> +#define __acpi_nhlt_next_endpoint(ep) \
> +	((void *)((u8 *)(ep) + (ep)->descriptor_length))
> +
> +#define __acpi_nhlt_get_endpoint(tb, ep, i) \
> +	((i) ? __acpi_nhlt_next_endpoint(ep) : __acpi_nhlt_first_endpoint(tb))
> +
> +#define __acpi_nhlt_first_fmtcfg(fmts) \
> +	((void *)(fmts + 1))
> +
> +#define __acpi_nhlt_next_fmtcfg(fmt) \
> +	((void *)((u8 *)((fmt) + 1) + (fmt)->capability_size))
> +
> +#define __acpi_nhlt_get_fmtcfg(fmts, fmt, i) \
> +	((i) ? __acpi_nhlt_next_fmtcfg(fmt) : __acpi_nhlt_first_fmtcfg(fmts))
> +
> +/*
> + * The for_each_nhlt_xxx() macros rely on an iterator to deal with the

I would do s/xxx/*/

> + * variable length of each endpoint structure and the possible presence
> + * of an OED-Config used by Windows only.
> + */
> +
> +/**
> + * for_each_nhlt_endpoint - Iterate over endpoints in a NHLT table.
> + * @tb:		the pointer to a NHLT table.
> + * @ep:		the pointer to endpoint to use as loop cursor.
> + */
> +#define for_each_nhlt_endpoint(tb, ep)					\
> +	for (unsigned int __i = 0;					\
> +	     __i < (tb)->endpoint_count &&				\
> +		((ep) = __acpi_nhlt_get_endpoint(tb, ep, __i));		\

Do you really need ep to be in parentheses?

> +	     __i++)
> +
> +/**
> + * for_each_nhlt_fmtcfg - Iterate over format configurations.
> + * @fmts:	the pointer to formats configuration space.
> + * @fmt:	the pointer to format to use as loop cursor.
> + */
> +#define for_each_nhlt_fmtcfg(fmts, fmt)					\
> +	for (unsigned int __i = 0;					\
> +	     __i < (fmts)->formats_count &&				\
> +		((fmt) = __acpi_nhlt_get_fmtcfg(fmts, fmt, __i));	\

Similar for fmt.

> +	     __i++)
> +
> +/**
> + * for_each_nhlt_endpoint_fmtcfg - Iterate over format configurations in an endpoint.
> + * @ep:		the pointer to an endpoint.
> + * @fmt:	the pointer to format to use as loop cursor.
> + */
> +#define for_each_nhlt_endpoint_fmtcfg(ep, fmt) \
> +	for_each_nhlt_fmtcfg(acpi_nhlt_endpoint_fmtscfg(ep), fmt)
> +
>  #endif /* __ACPI_NHLT_H__ */
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


