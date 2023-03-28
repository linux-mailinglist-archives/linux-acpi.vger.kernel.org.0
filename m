Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91546CC70C
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC1Pso (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjC1Psl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 11:48:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E17CD31E;
        Tue, 28 Mar 2023 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018501; x=1711554501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tFhIcP1XBh3915lX6XJU7UhDf+6ICm+NXpdVqxbwcMQ=;
  b=n20DBWgC3DHV0zpqiGNacBzj68mmMraC/5zBB4Ay9lurj4rYcVWp5rPo
   RJx3SyVTZw2/1pWsieirJGKtbA7ild4P/CZj+NK6gStR/g0E/GhfekopP
   pBYBkp04qMRQ2St84C3fhsdDnV8TEUGyr4lqOCbp3ldk8j/y+5M26ktSq
   346su2//L+RIKZuMgPmG3p9Ps3yGAXZ145LUcmzTJqIM6Ibv+fhfvTFNh
   JNri0qRf1qEdQPTyOARlqcmwXEW6KFdf6oz1vkFfnb6Rp90+lt6yxDoV8
   Qz2KKn+1ywHEtY8hsnYowBUTXS5bx2Zu9ga4NjuNmlkgc35wBuAF80nmd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342195698"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342195698"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683951273"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683951273"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:48:21 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id B798711F937;
        Tue, 28 Mar 2023 18:48:18 +0300 (EEST)
Date:   Tue, 28 Mar 2023 18:48:18 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZCMMQp9iaB2Q+f26@kekkonen.localdomain>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-4-sakari.ailus@linux.intel.com>
 <ZCMDyVoFWizx+tOp@smile.fi.intel.com>
 <ZCMHTZgXnLCWjCje@kekkonen.localdomain>
 <ZCMLz4M37vrE5XJZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMLz4M37vrE5XJZ@smile.fi.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 06:46:23PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 06:27:09PM +0300, Sakari Ailus wrote:
> > On Tue, Mar 28, 2023 at 06:12:09PM +0300, Andy Shevchenko wrote:
> > > On Tue, Mar 28, 2023 at 01:12:56PM +0300, Sakari Ailus wrote:
> 
> ...
> 
> > > > +	struct scan_check_crs_csi2_context inst_context = {
> > > > +		.handle = handle,
> > > > +		.res_head = LIST_HEAD_INIT(inst_context.res_head),
> > > > +	};
> > > > +	struct crs_csi2 *csi2;
> > > > +
> > > > +	acpi_walk_resources(handle, METHOD_NAME__CRS,
> > > > +			    scan_check_crs_csi2_instance, &inst_context);
> > > > +
> > > > +	if (list_empty(&inst_context.res_head))
> > > > +		return;
> > > > +
> > > > +	/*
> > > > +	 * Found entry, so allocate memory for it, fill it and add it to the
> > > > +	 * list.
> > > > +	 */
> > > > +	csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
> > > > +	if (!csi2)
> > > 
> > > Who is going to release resources allocated in the callback above?
> > 
> > This is done by crs_csi2_release(), called from acpi_bus_scan_crs_csi2().
> 
> Isn't it a bit counter intuitive?

Are you suggesting changing something?

Basically we're gathering the information during an ACPI namespace walk.
Once the information has been processed and used, the memory can be
released.

-- 
Sakari Ailus
