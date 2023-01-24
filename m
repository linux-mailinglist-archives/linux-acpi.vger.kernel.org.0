Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C3679DFD
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 16:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjAXPwO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 10:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjAXPwN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 10:52:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB7222789;
        Tue, 24 Jan 2023 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674575533; x=1706111533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IgYeAnqzF1flLFSZckUXZtQPTmJAi6PYPpcfA50lTQc=;
  b=dcpiXDp5LpKnRdGjzjB7c+9mf3ndnJKNpVYmEIayavVManwtF2S4Vqia
   HeDlXS4z8UzGQshpVuMrOi/m/sUQbM3h1LCwXcnGIJ8x02uNyOnDF70hY
   daTe1riLRFQH0g/K+k0zAUmA/F7cakM/ntAHMRNKuOT0EHJ+EuhT02E76
   jfm1aiphh1t25At1hC45H7UER8uL4Rlpqx88EbeCgIXpvp5jVkD6XTKfQ
   zHKhpxGJTSuajYda6Js4sgVNkJ1lPSph6PcHUptHtnm3vybnO0SL5ConS
   +Usk/IbxVvVVkbLBS9qMHOEcVr8FKQaJSf4+wkTgvNOgZRH92IsGg+H5Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306677250"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="306677250"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:52:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="836006897"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="836006897"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:52:11 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 84BD5122501;
        Tue, 24 Jan 2023 17:52:08 +0200 (EET)
Date:   Tue, 24 Jan 2023 17:52:08 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y8/+qHPNKYaQmTCv@kekkonen.localdomain>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-3-sakari.ailus@linux.intel.com>
 <Y86inXQ+nEoFiosr@smile.fi.intel.com>
 <Y86wzwrlvro3RFto@kekkonen.localdomain>
 <Y87DBSUo1IJZmMDO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87DBSUo1IJZmMDO@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Mon, Jan 23, 2023 at 07:25:25PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 23, 2023 at 06:07:43PM +0200, Sakari Ailus wrote:
> > On Mon, Jan 23, 2023 at 05:07:09PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 23, 2023 at 03:46:11PM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > +	memcpy(inst->remote_name, csi2->resource_source.string_ptr,
> > > > +	       csi2->resource_source.string_length);
> > > 
> > > Why don't we use strscpy()? Is it really strings? Or is it some abuse of
> > > the ACPI object type?
> > 
> > I didn't find a guarantee it would be nil terminated. Albeit I'm fine
> > switching to strscpy() if there's such a guarantee.
> 
> Following this logic neither memcpy() (and especially memcpy()!) call
> guarantees that. But hold on, have you actually read strscpy() documentation?

Yes. And there is such a guarantee, too. The string_length contains the
length of the string, including the terminating nil character. I have no
problem with strscpy() but it won't affect the end result in any way. :-)

> 
> ...
> 
> > > > +	list_replace(&inst_context.res_list, &csi2->buses);
> > > > +	list_add(&csi2->list, list);
> > > 
> > > Hmm... Can list_swap() be used here?
> > 
> > We're replacing an entry in a list and then adding an entry to another. How
> > would you use list_swap() here?
> 
> I see, so it is about two different lists.
> 
> ...
> 
> > > > +	/*
> > > > +	 * Figure out how much temporary storage we need for counting
> > > > +	 * connections in each device.
> > > > +	 */
> > > > +	list_for_each_entry(csi2, &crs_csi2_handles, list) {
> > > > +		struct crs_csi2_instance *inst;
> > > > +
> > > > +		handle_count++;
> > > 
> > > > +		list_for_each_entry(inst, &csi2->buses, list)
> > > > +			handle_count++;
> > > 
> > > list_count_nodes()?
> > 
> > Are you suggesting adding a new list API function or using one that's not
> > in the linux-acpi/testing branch yet?
> 
> It's in USB tree.
> I'm fine if you switch your code later on.

Ack, I'll post a patch once this hits the linux-acpi tree.

> 
> > > > +	}
> 

-- 
Kind regards,

Sakari Ailus
