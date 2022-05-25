Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B33534268
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 19:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbiEYRt0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 13:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbiEYRtP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 13:49:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81A0B0A72
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500947; x=1685036947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4qhN3hgQveI5aDBmL09sDEMiFdhFO98DlxSJyb2k2Js=;
  b=ODm5KUQS1OYUsGc+HF97YfApMAMcD1CKs3h1WxZMM870N41OmUSYyg3f
   kyAGhHg6m7kxnWoYxzNYBN+h7bvZCz8fkIV2A0Z9KzTH7w6lJroSjaYPn
   YOX9N124erDy73n//XAucqlmhidMqP4cCaWzAa1adesegE2Nsr1TQ0Rk+
   nZ3qgRB2eCuaIVJZ8E1Ke9FfQF3FMx02hcMHBV/WuMKeuS/SLwasYYAUe
   7myy8J6LPeYSw/pXz5I8cRvEsmUDU/jT6wFF+w4gteSxBb3UChSTBCcrF
   qfIekhQIGDCDpYjGYGKAn5bIYE3MQ/RIKLIDrbNBAbWuuQxMBngtWEc1P
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="273998001"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273998001"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:44:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="602095083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:44:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ntv3L-000L5w-Ub;
        Wed, 25 May 2022 20:44:11 +0300
Date:   Wed, 25 May 2022 20:44:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 7/8] ACPI: property: Add support for parsing buffer
 property UUID
Message-ID: <Yo5q6/qVkRyESOa+@smile.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-8-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525130123.767410-8-sakari.ailus@linux.intel.com>
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

On Wed, May 25, 2022 at 04:01:22PM +0300, Sakari Ailus wrote:
> Add support for newly added buffer property UUID, as defined in the DSD
> guide.

...

> +	if (check_mul_overflow((size_t)properties->package.count,

Why do you need casting? Any issues on 32-bit compilation?

Looking at the below code snippets, it seems you also can have a local
copy with needed type and use it everywhere (as outer_package_count or so).
But first question first...

> +			       sizeof(*package) + sizeof(void *),
> +			       &alloc_size) ||
> +	    check_add_overflow(sizeof(*props) + sizeof(*package), alloc_size,
> +			       &alloc_size)) {
> +		acpi_handle_warn(handle,
> +				 "can't allocate memory for %u buffer props",
> +				 properties->package.count);
> +		return;
> +	}

...

> +		if (ACPI_FAILURE(status)) {
> +			acpi_handle_warn(handle,
> +					 "can't evaluate \"%s\" as buffer\n",
> +					 obj->string.pointer);

I'm wondering if better to use %*pE here to show the full data of the buffer.

> +			continue;
> +		}

-- 
With Best Regards,
Andy Shevchenko


