Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12045534261
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbiEYRrV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 13:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245758AbiEYRrT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 13:47:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC412018E
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653500839; x=1685036839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cy/ZY9c51u1GO5cX9KHF384E8b0FjTATLJGVU/vYlwc=;
  b=FU/gATtdXShFHZ897wMtvRtMSHNQBgHJF28tjobn3LXAobq/OFh851mF
   k9q33yhG7UEopUJo1J3zeXRlYj8asS2YWdLOqtdl+i+LjGBV8/i6aNtBl
   WvCNI0037/6FiQhBr/9oPazV5N4RF+mum5iJTmkMKWZqjZw0iMVCMbOPX
   boR1vgnC9fSlsPiCQnjqlXaaA91+BT2Wod1C3PzLg1+Lgcl/Hw2k3RxQ+
   Z6MmrEtFIN8oyft+YNH29N3rVw1T3XHsC/ILpdNMW+DYpi1zv/DoLyPVF
   hl0PwZYS82gOMkqmmMDbu0ReDomoCYKBS4Wur9dMqAvE7EW9IE1ZoDQ8Z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="272705138"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="272705138"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:36:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="745849176"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:36:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ntuwI-000L5k-IO;
        Wed, 25 May 2022 20:36:54 +0300
Date:   Wed, 25 May 2022 20:36:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 8/8] ACPI: property: Read buffer properties as integers
Message-ID: <Yo5pNjsb2oNX9Knf@smile.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-9-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525130123.767410-9-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 25, 2022 at 04:01:23PM +0300, Sakari Ailus wrote:
> Instead of adding a new property type, read buffer properties as integers.
> Even though the internal representation in ACPI is different, the data
> type is the same (byte) than on 8-bit integers.

...

> +	switch (proptype) {
> +	case DEV_PROP_STRING:
> +		break;
> +	case DEV_PROP_U8 ... DEV_PROP_U64:
> +		if (obj->type == ACPI_TYPE_BUFFER) {

> +			if (nval <= obj->buffer.length)
> +				break;
> +			return -EOVERFLOW;

Why not traditional pattern and be consistent with default case?

			if (nval > obj->buffer.length)
				return -EOVERFLOW;
			break;

> +		}
> +		fallthrough;
> +	default:
> +		if (nval > obj->package.count)
> +			return -EOVERFLOW;

I would add break statement here.

> +	}
>  	if (nval == 0)
>  		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


