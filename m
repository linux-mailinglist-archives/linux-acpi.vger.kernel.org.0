Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEE34B4D1A
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Feb 2022 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349867AbiBNLEA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Feb 2022 06:04:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349793AbiBNLDc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Feb 2022 06:03:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599A4B5B;
        Mon, 14 Feb 2022 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644834713; x=1676370713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8uiKQFrnrOzDBOW05m53tk5x/ATHjKo+rtDwLt+0ac4=;
  b=hPRPTY0XLFGxJp0sUrkcvjHXuzky+kcBOgzSMGiwMZGpHvs1AFcPYy1f
   rUbVV4zXeC0tHr6s13cI8Tyam68onTp+hg38/kbagwdBMMZarP3zosRrl
   tQuENX8nuYqvrAUozos6kEyYh3Lpqjoa2ALE53vGBic1PaXnYJ9OovmGw
   dHdzdNEEQJoTU17ELw2YiyPs9ysPOj+vPNjfedLWKd4XKbEmkN37w9q2M
   inPGD5wlHGibXzgif5b4xe5tc4BrPJ8BGLM5lyAMKzABs8eCLlkvc4k5s
   bHtG0ON8fCCujgPtDxOlQsr7w0hfeLRWQz9NO/t7DG7n0O4Dy8csHhpd5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="233609871"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="233609871"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:31:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587144464"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:31:50 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id BCA07202AE;
        Mon, 14 Feb 2022 12:31:47 +0200 (EET)
Date:   Mon, 14 Feb 2022 12:31:47 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 3/4] device property: Add iomap to fwnode operations
Message-ID: <Ygovk0MVcN/i6+wN@paasikivi.fi.intel.com>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
 <20220206091643.276833-4-sakari.ailus@linux.intel.com>
 <YgaH7iJ5CWSJp1PY@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgaH7iJ5CWSJp1PY@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rob,

Thanks for the review.

On Fri, Feb 11, 2022 at 09:59:42AM -0600, Rob Herring wrote:
> On Sun, Feb 06, 2022 at 11:16:42AM +0200, Sakari Ailus wrote:
> > Add iomap() fwnode operation to implement fwnode_iomap() through fwnode
> > operations, moving the code in fwnode_iomap() to OF framework.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/base/property.c | 5 +----
> >  drivers/of/property.c   | 7 +++++++
> >  include/linux/fwnode.h  | 1 +
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 09686e2e903e..83dd22e7cb81 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -887,10 +887,7 @@ EXPORT_SYMBOL_GPL(device_get_phy_mode);
> >   */
> >  void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
> >  {
> > -	if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
> > -		return of_iomap(to_of_node(fwnode), index);
> > -
> > -	return NULL;
> > +	return fwnode_call_ptr_op(fwnode, iomap, index);
> >  }
> >  EXPORT_SYMBOL(fwnode_iomap);
> >  
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 676899566f7c..8beb89709740 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1465,6 +1465,12 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
> >  	return 0;
> >  }
> >  
> > +static void __iomem *of_fwnode_iomap(struct fwnode_handle *fwnode, int index)
> > +{
> > +	return IS_ENABLED(CONFIG_OF_ADDRESS) ?
> 
> I think this shouldn't be needed. !OF_ADDRESS is Sparc which just has 
> its own implementation of of_iomap().

I'll drop it for v2.

-- 
Sakari Ailus
