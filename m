Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FCD749978
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGFK2P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 06:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGFK2O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 06:28:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C64B124;
        Thu,  6 Jul 2023 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688639283; x=1720175283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=13iPjKDynG0EXiyC5iMwzDjb6wWTYRNKZHNMCd8B7TE=;
  b=j0UQOVphpz8+7OlBxG9HqBhC7AGmUUQzl5tk6J0cqeZDJBGGsH2dHdyB
   BTb5uB8pNcjcLpFzP4v5yVS468YM6gKzvW8QOpWq/eI9lho30aqHzO+SY
   pJmfMJRz8sn9DZkAnrF94dHvAbN2aiN5eh3ZRuwf0wMkwPwOiETJIrmH2
   GUb6sSnySimgApywt/tHAGXFCoGWKJ5046CzhY81gCi+dHq+cLt0Bp1sM
   2LO2FhYjCqZN2U6+jhtsWnU7IHJAzmIMo5eF2JcXnT3hIvQ8xQf48dv6Z
   pAkGK2DWW8FLTU5muhHoJOD1iagu20Ci8wyEOb1TeQL8FbM9gOKliN5zf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="348355044"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="348355044"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 03:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719541668"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719541668"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 03:27:58 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 4161F11F9ED;
        Thu,  6 Jul 2023 13:27:55 +0300 (EEST)
Date:   Thu, 6 Jul 2023 10:27:55 +0000
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
        Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v3 14/18] media: i2c: Add driver for DW9719 VCM
Message-ID: <ZKaXK3uRQxB7UTo0@kekkonen.localdomain>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-15-hdegoede@redhat.com>
 <ZKaSD0CHRBd+zu/T@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKaSD0CHRBd+zu/T@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Thu, Jul 06, 2023 at 01:06:07PM +0300, Andy Shevchenko wrote:
...
> > +static int dw9719_i2c_rd8(struct i2c_client *client, u8 reg, u8 *val)
> > +{
> > +	struct i2c_msg msg[2];
> > +	u8 buf[2] = { reg };
> > +	int ret;
> > +
> > +	msg[0].addr = client->addr;
> > +	msg[0].flags = 0;
> 
> > +	msg[0].len = 1;
> > +	msg[0].buf = buf;
> 
> 	sizeof(buf[0])
> 	&buf[0]
> 
> looks more explicit.

The original seems fine to me. Note that this code will disappear soon.

Same for the other comments regarding register access functions (apart from
the return one).

> 
> > +	msg[1].addr = client->addr;
> > +	msg[1].flags = I2C_M_RD;
> > +	msg[1].len = 1;
> > +	msg[1].buf = &buf[1];
> 
> Ditto.
> 
> > +	*val = 0;
> > +
> > +	ret = i2c_transfer(client->adapter, msg, 2);
> 
> ARRAY_SIZE()
> 
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = buf[1];
> > +
> > +	return 0;
> > +}
> 
> But as Sakari said this perhaps could go into CCI library.
> 
> ...
> 
> > +	ret = dw9719_i2c_rd8(dw9719->client, DW9719_INFO, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (val != DW9719_ID) {
> > +		dev_err(dw9719->dev, "Failed to detect correct id\n");
> > +		ret = -ENXIO;
> 
> 		return -ENXIO;
> 
> > +	}
> > +
> > +	return 0;
> 
> ...
> 
> > +	/* Need 100us to transit from SHUTDOWN to STANDBY*/
> 
> Missing space.
> 
> > +	usleep_range(100, 1000);
> 
> Perhaps fsleep() would be better, but I'm fine with either here.
> 
> ...
> 
> > +static int dw9719_t_focus_abs(struct dw9719_device *dw9719, s32 value)
> > +{
> > +	int ret;
> 
> Redundant?
> 
> > +	value = clamp(value, 0, DW9719_MAX_FOCUS_POS);

This is redundant, too, btw., the control framework already handles this.

> 
> > +	ret = dw9719_i2c_wr16(dw9719->client, DW9719_VCM_CURRENT, value);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> 
> 	return _wr16(...);
> 
> or can it return positive values?
> 
> > +}
> 
> ...
> 
> > +static int __maybe_unused dw9719_suspend(struct device *dev)
> 
> Can we use new PM macros instead of __maybe_unused?
> 
> > +{
> > +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > +	struct dw9719_device *dw9719 = to_dw9719_device(sd);
> > +	int ret;
> > +	int val;
> > +
> > +	for (val = dw9719->ctrls.focus->val; val >= 0;
> > +	     val -= DW9719_CTRL_STEPS) {
> > +		ret = dw9719_t_focus_abs(dw9719, val);
> > +		if (ret)
> > +			return ret;
> 
> > +		usleep_range(DW9719_CTRL_DELAY_US, DW9719_CTRL_DELAY_US + 10);
> 
> fsleep() ?
> 
> > +	}
> > +
> > +	return dw9719_power_down(dw9719);
> > +}
> 
> > +static int __maybe_unused dw9719_resume(struct device *dev)
> > +{
> 
> As per above function.
> 
> ...
> 
> > +err_power_down:
> 
> In one functions you use err_ in another fail_, be consistent.
> 
> > +	dw9719_power_down(dw9719);
> > +	return ret;
> > +}
> 
> ...
> 
> > +	dw9719->regulator = devm_regulator_get(&client->dev, "vdd");
> > +	if (IS_ERR(dw9719->regulator))
> > +		return dev_err_probe(&client->dev, PTR_ERR(dw9719->regulator),
> 
> With
> 
> 	struct device *dev = &client->dev;
> 
> code may look neater.

I prefer it as-is.

> 
> > +				     "getting regulator\n");
> 

-- 
Kind regards,

Sakari Ailus
