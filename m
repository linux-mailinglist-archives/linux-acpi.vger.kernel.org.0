Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E785362F3
	for <lists+linux-acpi@lfdr.de>; Fri, 27 May 2022 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiE0Mpa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 May 2022 08:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352923AbiE0Mon (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2022 08:44:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D117A88
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2022 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653655418; x=1685191418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mgb2inh/KPajRf59aaZDnbQKbztDLPP9kUPYrp4i3ZY=;
  b=BWpIeD8dn1bUfW5Vvt+rPmsuZmtYQGd7GkKA6d7INdGVle2H5xyyot6n
   RG/cw6furHcMZgpvuH4JxvdKcYHzBwTgIlL2HnR0ozn19RKTWTLoeMtY+
   qfld8EdLYonujOXuyvXpJUxRqBqYJ9U5nH1rOOr1bgaHR36gFNSafmjFH
   8Br3hmNZK9ETcQgpIMsPwIreq/GDSzAbRASDs6oKeA79yuo7tPgc+my2O
   fowF8547IUhIoRbm1RA2atukGx/h8Zag/bRt05POMQxZoO9AZNHvh25G9
   nsO1Qu7D/+hbC4F0rh/ckHlCFHdHDHdsJ/pl3QuYcJQYvn5GrNielFIYP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335119316"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="335119316"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 05:43:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="560752155"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 05:43:36 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id E45182057F;
        Fri, 27 May 2022 15:43:33 +0300 (EEST)
Date:   Fri, 27 May 2022 15:43:33 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 7/8] ACPI: property: Add support for parsing buffer
 property UUID
Message-ID: <YpDHdVa574WiyxCD@paasikivi.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-8-sakari.ailus@linux.intel.com>
 <Yo5q6/qVkRyESOa+@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo5q6/qVkRyESOa+@smile.fi.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, May 25, 2022 at 08:44:11PM +0300, Andy Shevchenko wrote:
> On Wed, May 25, 2022 at 04:01:22PM +0300, Sakari Ailus wrote:
> > Add support for newly added buffer property UUID, as defined in the DSD
> > guide.
> 
> ...
> 
> > +	if (check_mul_overflow((size_t)properties->package.count,
> 
> Why do you need casting? Any issues on 32-bit compilation?

I think it can be removed. I'll see.

> 
> Looking at the below code snippets, it seems you also can have a local
> copy with needed type and use it everywhere (as outer_package_count or so).
> But first question first...

u32 should be fine.

> 
> > +			       sizeof(*package) + sizeof(void *),
> > +			       &alloc_size) ||
> > +	    check_add_overflow(sizeof(*props) + sizeof(*package), alloc_size,
> > +			       &alloc_size)) {
> > +		acpi_handle_warn(handle,
> > +				 "can't allocate memory for %u buffer props",
> > +				 properties->package.count);
> > +		return;
> > +	}
> 
> ...
> 
> > +		if (ACPI_FAILURE(status)) {
> > +			acpi_handle_warn(handle,
> > +					 "can't evaluate \"%s\" as buffer\n",
> > +					 obj->string.pointer);
> 
> I'm wondering if better to use %*pE here to show the full data of the buffer.

The string is supposed to be printable. If it's not, something is seriously
wrong. There's no harm though to prepare for this possibility. It'll make
backslashes printing twice but that is hardly an issue in practice.

> 
> > +			continue;
> > +		}
> 

-- 
Sakari Ailus
