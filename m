Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425E152F578
	for <lists+linux-acpi@lfdr.de>; Sat, 21 May 2022 00:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351351AbiETWFD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 18:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbiETWFC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 18:05:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF3F13F90
        for <linux-acpi@vger.kernel.org>; Fri, 20 May 2022 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653084301; x=1684620301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qg6rv3NqLdKHbssH+rD2O8rHxa41EyWJhzCOaVB6KMg=;
  b=RIoDPCS5xpD0kuN9lHRavBxOY8qfho1sk4FnR2uM+SiSfLCg5TWDh1+r
   k6It5Theu1dY9ZPb5J0cIHvih0txJSHA2DTBGa11dodFkSjjnvlcTbdan
   ogsC6nlzsVsT3ZW+VBCG76x+LEndlT4ePjgB0cC8blUXqrkyy+iAj58Qw
   gz1buotgYUKoER0hS90j+oAMUMNO6ZcIUZ6HKqmfFGGgpz0H/FUoFwPBc
   X2Ks+QGuPRKodV2knP+6jmuaF5lZFPc2TtvepbpEIfwAeBTt2EeyH2BlB
   32jlUbKe5lIjmuNotLccd7piXIUL0QF/hfSB5MHMKwPh0ojjH8F8nb7qB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="271574061"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="271574061"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 15:05:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="576396349"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 15:05:00 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 81CF3200C8;
        Sat, 21 May 2022 01:04:58 +0300 (EEST)
Date:   Sat, 21 May 2022 01:04:58 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v2 6/8] ACPI: property: Unify integer value reading
 functions
Message-ID: <YogQijFxDHC8r+Wr@paasikivi.fi.intel.com>
References: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
 <20220520061148.21366-7-sakari.ailus@linux.intel.com>
 <YoekxdtV9IA7OP7h@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoekxdtV9IA7OP7h@smile.fi.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Thanks for the review.

On Fri, May 20, 2022 at 05:25:09PM +0300, Andy Shevchenko wrote:
> On Fri, May 20, 2022 at 09:11:46AM +0300, Sakari Ailus wrote:
> > Unify functions reading ACPI property integer values into a single macro,
> > and call that macro to generate the functions for each bit depth.
> > 
> > Also use size_t for the counter instead of int.
> 
> ...
> 
> > +#define DECLARE_ACPI_PROPERTY_COPY(bits)				\
> > +	static int							\
> > +	acpi_copy_property_array_u##bits(const union acpi_object *items, \
> 
> Personally I find much better if function templates in macros are not indented
> additionally.

I prefer it the way it is in this patch: indenting the macro has grounds as
it is part of the same pre-processor directive even if it's split on
multiple lines.

> 
> > +					 u##bits *val, size_t nval)	\
> > +	{								\
> > +		size_t i;						\
> > +									\
> > +		for (i = 0; i < nval; i++) {				\
> > +			if (items[i].type != ACPI_TYPE_INTEGER)		\
> > +				return -EPROTO;				\
> > +			if (items[i].integer.value > U##bits##_MAX)	\
> > +				return -EOVERFLOW;			\
> > +									\
> > +			val[i] = items[i].integer.value;		\
> > +		}							\
> > +		return 0;						\
> >  	}
> 
> On top of that, we use a minimum compiler that supports _Generic(). Why not to
> use it?

Good idea, I'll look into this. Perhaps we'll even get rid of having to
define multiple functions for this.

-- 
Kind regards,

Sakari Ailus
