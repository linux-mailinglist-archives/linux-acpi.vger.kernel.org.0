Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB974986B
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGFJaS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 05:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjGFJaR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 05:30:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5385B171D;
        Thu,  6 Jul 2023 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688635816; x=1720171816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QJcLfFrm3rg4VRuZ4pPQZlY8ks6MLYozy8i4eHaqdz4=;
  b=b6Ocfi3dzphHyhULSKeKnj5bh10ihLtFMGLNT1nH6u8EI0+8M7PE0AV0
   FSlVzedd2xK2uBNZP7HoYIJYi266CETPD2iQT25r5146vheH22ZHZHNz6
   KZUNI7CkfW/J5MckTqYeswvXYzcdGFxvOjK99sTdLEzTapFLbmNGWlxmo
   QmrYZoiCleD9J4xF+IRXbaFiF8VlSkJqM6qZuKAJNnS+fAy+kFBk6FpmG
   oP6/TmivinWOXeCoxGhSGjxdkOj2iJ6ACqefhTPduY1HOlSNoofqO37D3
   gqKoVpHLigFbye/KWgVcASFTJ+oG1X9cxHPRVjasPpPESMraHj60Ecl3s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366131093"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="366131093"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 02:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="843610144"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="843610144"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 02:30:11 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 5FDE211FBCE;
        Thu,  6 Jul 2023 12:30:09 +0300 (EEST)
Date:   Thu, 6 Jul 2023 09:30:09 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>, hverkuil@xs4all.nl
Subject: Re: [PATCH v3 14/18] media: i2c: Add driver for DW9719 VCM
Message-ID: <ZKaJoerBi4kOTYw3@kekkonen.localdomain>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-15-hdegoede@redhat.com>
 <ZKZxmqINU1wIh6ne@kekkonen.localdomain>
 <ZKaF8ywQqEH2GK8b@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKaF8ywQqEH2GK8b@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Thu, Jul 06, 2023 at 12:14:27PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 06, 2023 at 07:47:38AM +0000, Sakari Ailus wrote:
> > On Wed, Jul 05, 2023 at 11:30:06PM +0200, Hans de Goede wrote:
> 
> ...
> 
> > > +static int dw9719_init_controls(struct dw9719_device *dw9719)
> > > +{
> > > +	const struct v4l2_ctrl_ops *ops = &dw9719_ctrl_ops;
> > > +	int ret;
> > > +
> > > +	ret = v4l2_ctrl_handler_init(&dw9719->ctrls.handler, 1);
> > > +	if (ret)
> > > +		return ret;
> > 
> > This check can be dropped.
> 
> The obvious question why that API returns int instead of void?

I guess it's for historical reasons. The control handler initialisation
functions won't do anything if the handler is in error state. I guess this
could be changed.

Cc Hans.

> 
> > > +	dw9719->ctrls.focus = v4l2_ctrl_new_std(&dw9719->ctrls.handler, ops,
> > > +						V4L2_CID_FOCUS_ABSOLUTE, 0,
> > > +						DW9719_MAX_FOCUS_POS, 1, 0);
> > > +
> > > +	if (dw9719->ctrls.handler.error) {
> > > +		dev_err(dw9719->dev, "Error initialising v4l2 ctrls\n");
> > > +		ret = dw9719->ctrls.handler.error;
> > > +		goto err_free_handler;
> > > +	}
> > > +
> > > +	dw9719->sd.ctrl_handler = &dw9719->ctrls.handler;
> 
> > > +	return ret;
> 
> 	return 0;
> 
> ?

Makes sense.

> 
> > > +err_free_handler:
> > > +	v4l2_ctrl_handler_free(&dw9719->ctrls.handler);
> > > +	return ret;
> > > +}
> 

-- 
Kind regards,

Sakari Ailus
