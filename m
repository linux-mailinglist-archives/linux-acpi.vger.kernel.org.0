Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F5536483
	for <lists+linux-acpi@lfdr.de>; Fri, 27 May 2022 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbiE0PNB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 May 2022 11:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiE0PNA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2022 11:13:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874791CFF3
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2022 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653664379; x=1685200379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UuukB5wlrMjE0zWIV9iopXBXsfhnmviPdYOdhDlxcv8=;
  b=d715SgKv5JtwLy0ZTmmS/MNkCBwcujvcb7+nv0QOgaLBuetGMQkMj+df
   B6FgJtlRDk8CswgoSfL/7JOlw1kPnlOSq/a2jh1BLsVYo2y4VwGYfjv1e
   AZq0j5sA9imjNRhRWVeY+OQg5zdwk/3lDSd+WUlnWfQ3fstWvcMCL5WUp
   BXbKgI/CBK5A9P8xw6otWXhM+RVRwtoWVTtywirVKdEeV7TD3DrLmyHkx
   cWe+hnL6dVUO1sLZ5TQOhPDl+zGxJmo37/2f6tw3/wHvg6abFVrguwFNi
   nI50r0XoKDNCb6DiozZ8s2WtzvWYR7Ky5njxdZgU3m00qP2Y0XNs+prWT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="272074272"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="272074272"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 08:12:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="705172309"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 08:12:57 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 913D6201A7;
        Fri, 27 May 2022 18:12:55 +0300 (EEST)
Date:   Fri, 27 May 2022 18:12:55 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 6/8] ACPI: property: Unify integer value reading
 functions
Message-ID: <YpDqdzZEPcOhClFY@paasikivi.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-7-sakari.ailus@linux.intel.com>
 <Yo5j/N+qoSSYexnj@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo5j/N+qoSSYexnj@smile.fi.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, May 25, 2022 at 08:14:36PM +0300, Andy Shevchenko wrote:
> On Wed, May 25, 2022 at 04:01:21PM +0300, Sakari Ailus wrote:
> > Unify functions reading ACPI property integer values into a single macro
> > using C99 _Generic().
> > 
> > Also use size_t for the counter instead of int.
> 
> Thanks for an update!
> 
> ...
> 
> > +#define acpi_copy_property_array_uint(items, val, nval)			\
> > +	({								\
> 
> You can define local copies of (read-only) parameters and avoid adding
> parentheses each time you access them.

Sounds good.

> 
> > +		size_t i;						\
> > +		int ret = 0;						\
> > +									\
> > +		for (i = 0; i < (nval); i++) {				\
> > +			if ((items)[i].type != ACPI_TYPE_INTEGER) {	\
> > +				ret = -EPROTO;				\
> > +				break;					\
> > +			}						\
> > +			if ((items)[i].integer.value > _Generic((val),	\
> > +								u8: U8_MAX, \
> > +								u16: U16_MAX, \
> > +								u32: U32_MAX, \
> > +								u64: U64_MAX, \
> > +								default: 0U)) { \
> 
> I think nobody will die if you add one more TAB to each line and make \ be
> consistent column wise.

I think it's unlikely, too. Still the above is consistent with the rest of
recently merged patches adding similar constructs.

-- 
Kind regards,

Sakari Ailus
