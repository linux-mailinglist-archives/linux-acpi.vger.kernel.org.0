Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05CE678301
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 18:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjAWRZb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 12:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjAWRZa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 12:25:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FCFF774;
        Mon, 23 Jan 2023 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674494729; x=1706030729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hWfbO63VhFYhJ2JYnLTBfIfMlTfHKzpjFM/0JDarWeY=;
  b=FYx72d80VJIdF9GZDcwy+hQvBjuz6iXxwz85k44xAJrzCUL6KrIVOtRg
   kulrQhP5VW0d9MsMEJnuue6C9PcWHD52vn9jNyj8JzL/gWwUUsnCNMcUD
   /cFg3ivDMyTX/DgMn2EbyLN8sJkk6NZMAFWvy+b6mSPyYpmzh3t7PZhhS
   LFcDUE0MJP7RpWSxZ5dFCE2ztFoxnHCgcRV5c9hH92z2mi5OXaOeRhnDU
   Vwkc0a30NFl3MWaAVdU3MUziaqLx+vV8qobGpxc/2zSGjLUuy2DgzlVxu
   inpaORn7HaOPayJAsjMhpFYEXGjHQzAbRo3p/MVIY5Lh6r2bFGFv7T80F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="323790870"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="323790870"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655082099"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="655082099"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 09:25:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pK0ZR-00DqlT-2Q;
        Mon, 23 Jan 2023 19:25:25 +0200
Date:   Mon, 23 Jan 2023 19:25:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y87DBSUo1IJZmMDO@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-3-sakari.ailus@linux.intel.com>
 <Y86inXQ+nEoFiosr@smile.fi.intel.com>
 <Y86wzwrlvro3RFto@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86wzwrlvro3RFto@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 06:07:43PM +0200, Sakari Ailus wrote:
> On Mon, Jan 23, 2023 at 05:07:09PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 23, 2023 at 03:46:11PM +0200, Sakari Ailus wrote:

...

> > > +	memcpy(inst->remote_name, csi2->resource_source.string_ptr,
> > > +	       csi2->resource_source.string_length);
> > 
> > Why don't we use strscpy()? Is it really strings? Or is it some abuse of
> > the ACPI object type?
> 
> I didn't find a guarantee it would be nil terminated. Albeit I'm fine
> switching to strscpy() if there's such a guarantee.

Following this logic neither memcpy() (and especially memcpy()!) call
guarantees that. But hold on, have you actually read strscpy() documentation?

...

> > > +	list_replace(&inst_context.res_list, &csi2->buses);
> > > +	list_add(&csi2->list, list);
> > 
> > Hmm... Can list_swap() be used here?
> 
> We're replacing an entry in a list and then adding an entry to another. How
> would you use list_swap() here?

I see, so it is about two different lists.

...

> > > +	/*
> > > +	 * Figure out how much temporary storage we need for counting
> > > +	 * connections in each device.
> > > +	 */
> > > +	list_for_each_entry(csi2, &crs_csi2_handles, list) {
> > > +		struct crs_csi2_instance *inst;
> > > +
> > > +		handle_count++;
> > 
> > > +		list_for_each_entry(inst, &csi2->buses, list)
> > > +			handle_count++;
> > 
> > list_count_nodes()?
> 
> Are you suggesting adding a new list API function or using one that's not
> in the linux-acpi/testing branch yet?

It's in USB tree.
I'm fine if you switch your code later on.

> > > +	}

-- 
With Best Regards,
Andy Shevchenko


