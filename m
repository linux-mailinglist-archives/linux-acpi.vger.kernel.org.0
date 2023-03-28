Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2787F6CCA94
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 21:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjC1T0x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjC1T0u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 15:26:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113FF35B7;
        Tue, 28 Mar 2023 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680031610; x=1711567610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wIr8LxkLZt0vjaMMTHuDCE4qyrKUT2FzVj4TUTIrZ/w=;
  b=f7SWPiqPZeD/tQIku72Iwe7p0DnAamLQThPC6haeAd/J7OSY1ezfMWA7
   i6Ncm/jPhtFBSW09TRfkh8Ai0Tf9acTjdo+en1Bjq+CBqa9khlBs3d+zA
   eiLiXWZHMwLns6Vk0GCJkcGmKStPPvhIMlWYTbzWqcUUtfjVH86a5xOzg
   3qsCrNEmkIbuYuJJqpG6xF3XdCJsd4DBwY9ImN9qGkvC5DlV3ZlcGwHpj
   deIOgglMaDRH5gD0fFB0a7mx+xJokRMZhILDQMmaP0sioLUowxDs3gUm6
   ZIIRNC2aN96w2CZ8DF6y4JCuCNNCnTSjPqU53h9i3izGh8qFaXcWjWyFf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340692682"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="340692682"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 12:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="807936838"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="807936838"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 12:26:46 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 941A911F937;
        Tue, 28 Mar 2023 22:26:42 +0300 (EEST)
Date:   Tue, 28 Mar 2023 22:26:42 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZCM/cgiPq3g9LeQc@kekkonen.localdomain>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-4-sakari.ailus@linux.intel.com>
 <ZCMDyVoFWizx+tOp@smile.fi.intel.com>
 <ZCMHTZgXnLCWjCje@kekkonen.localdomain>
 <ZCMLz4M37vrE5XJZ@smile.fi.intel.com>
 <ZCMMQp9iaB2Q+f26@kekkonen.localdomain>
 <ZCMNa0sGvu1Qmzgw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMNa0sGvu1Qmzgw@smile.fi.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 06:53:15PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 06:48:18PM +0300, Sakari Ailus wrote:
> > On Tue, Mar 28, 2023 at 06:46:23PM +0300, Andy Shevchenko wrote:
> > > On Tue, Mar 28, 2023 at 06:27:09PM +0300, Sakari Ailus wrote:
> > > > On Tue, Mar 28, 2023 at 06:12:09PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Mar 28, 2023 at 01:12:56PM +0300, Sakari Ailus wrote:
> 
> ...
> 
> > > > > > +	struct scan_check_crs_csi2_context inst_context = {
> > > > > > +		.handle = handle,
> > > > > > +		.res_head = LIST_HEAD_INIT(inst_context.res_head),
> > > > > > +	};
> > > > > > +	struct crs_csi2 *csi2;
> > > > > > +
> > > > > > +	acpi_walk_resources(handle, METHOD_NAME__CRS,
> > > > > > +			    scan_check_crs_csi2_instance, &inst_context);
> > > > > > +
> > > > > > +	if (list_empty(&inst_context.res_head))
> > > > > > +		return;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Found entry, so allocate memory for it, fill it and add it to the
> > > > > > +	 * list.
> > > > > > +	 */
> > > > > > +	csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
> > > > > > +	if (!csi2)
> > > > > 
> > > > > Who is going to release resources allocated in the callback above?
> > > > 
> > > > This is done by crs_csi2_release(), called from acpi_bus_scan_crs_csi2().
> > > 
> > > Isn't it a bit counter intuitive?
> > 
> > Are you suggesting changing something?
> > 
> > Basically we're gathering the information during an ACPI namespace walk.
> > Once the information has been processed and used, the memory can be
> > released.
> 
> Release allocated memory in the function which allocates it. Since it's called
> via callback, the closest one is the one that calls acpi_walk_resources().
> 
> Can't we free them here?

Ah, I get your point now.

I'll change this for v8.

-- 
Sakari Ailus
