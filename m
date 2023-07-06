Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3674980F
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGFJOf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGFJOe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 05:14:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA68BAF;
        Thu,  6 Jul 2023 02:14:33 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366126989"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="366126989"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 02:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="843601338"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="843601338"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2023 02:14:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHL4F-000Tjz-2M;
        Thu, 06 Jul 2023 12:14:27 +0300
Date:   Thu, 6 Jul 2023 12:14:27 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v3 14/18] media: i2c: Add driver for DW9719 VCM
Message-ID: <ZKaF8ywQqEH2GK8b@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-15-hdegoede@redhat.com>
 <ZKZxmqINU1wIh6ne@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKZxmqINU1wIh6ne@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 06, 2023 at 07:47:38AM +0000, Sakari Ailus wrote:
> On Wed, Jul 05, 2023 at 11:30:06PM +0200, Hans de Goede wrote:

...

> > +static int dw9719_init_controls(struct dw9719_device *dw9719)
> > +{
> > +	const struct v4l2_ctrl_ops *ops = &dw9719_ctrl_ops;
> > +	int ret;
> > +
> > +	ret = v4l2_ctrl_handler_init(&dw9719->ctrls.handler, 1);
> > +	if (ret)
> > +		return ret;
> 
> This check can be dropped.

The obvious question why that API returns int instead of void?

> > +	dw9719->ctrls.focus = v4l2_ctrl_new_std(&dw9719->ctrls.handler, ops,
> > +						V4L2_CID_FOCUS_ABSOLUTE, 0,
> > +						DW9719_MAX_FOCUS_POS, 1, 0);
> > +
> > +	if (dw9719->ctrls.handler.error) {
> > +		dev_err(dw9719->dev, "Error initialising v4l2 ctrls\n");
> > +		ret = dw9719->ctrls.handler.error;
> > +		goto err_free_handler;
> > +	}
> > +
> > +	dw9719->sd.ctrl_handler = &dw9719->ctrls.handler;

> > +	return ret;

	return 0;

?

> > +err_free_handler:
> > +	v4l2_ctrl_handler_free(&dw9719->ctrls.handler);
> > +	return ret;
> > +}

-- 
With Best Regards,
Andy Shevchenko


