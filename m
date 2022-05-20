Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D752EE13
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 16:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244844AbiETOZP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbiETOZO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 10:25:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221F0169E0B
        for <linux-acpi@vger.kernel.org>; Fri, 20 May 2022 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653056714; x=1684592714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RBLuajRoKS4IdfHNySDykeDo5BeoiSi7Ao6GdtNh9Ng=;
  b=RG416YgGWcpi6hClX9g7NOPPiRp6cnTFqYgZJLEJCYQPX5zzsi5V5HqT
   W+waf/KAD5BR7tQtB75+b9QQBI4ZrO5tEl6Vn1PS2otapPCKhNBMgCOl2
   MLWR5K7mYDuy9Fv+Co57cv8jNMd0dcW4rweKVfKd6dQxd7BBzofBIQ1Ep
   oLhRuTxAAPfDSxad8O5o8XSCV+/dyKaAWbiZ3vSdm8lNdknCLjNk1tixP
   cngxpTmnQkg16YMH2crdGjnaMj7tAebFYvqoVdUP4BJMy12dr7lejByW6
   nz2DqP5JOtdzEcorFjYqA/QD/Gm1NAlP5ETbwm6+T53q4+AtVU/8ETbUu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="297929210"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="297929210"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:25:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="662284143"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:25:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ns3Yz-000Gqf-BW;
        Fri, 20 May 2022 17:25:09 +0300
Date:   Fri, 20 May 2022 17:25:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v2 6/8] ACPI: property: Unify integer value reading
 functions
Message-ID: <YoekxdtV9IA7OP7h@smile.fi.intel.com>
References: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
 <20220520061148.21366-7-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520061148.21366-7-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 20, 2022 at 09:11:46AM +0300, Sakari Ailus wrote:
> Unify functions reading ACPI property integer values into a single macro,
> and call that macro to generate the functions for each bit depth.
> 
> Also use size_t for the counter instead of int.

...

> +#define DECLARE_ACPI_PROPERTY_COPY(bits)				\
> +	static int							\
> +	acpi_copy_property_array_u##bits(const union acpi_object *items, \

Personally I find much better if function templates in macros are not indented
additionally.

> +					 u##bits *val, size_t nval)	\
> +	{								\
> +		size_t i;						\
> +									\
> +		for (i = 0; i < nval; i++) {				\
> +			if (items[i].type != ACPI_TYPE_INTEGER)		\
> +				return -EPROTO;				\
> +			if (items[i].integer.value > U##bits##_MAX)	\
> +				return -EOVERFLOW;			\
> +									\
> +			val[i] = items[i].integer.value;		\
> +		}							\
> +		return 0;						\
>  	}

On top of that, we use a minimum compiler that supports _Generic(). Why not to
use it?

-- 
With Best Regards,
Andy Shevchenko


