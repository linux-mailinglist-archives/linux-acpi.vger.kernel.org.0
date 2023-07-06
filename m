Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B667498FA
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGFKGP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 06:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGFKGO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 06:06:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38CCDD;
        Thu,  6 Jul 2023 03:06:13 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427242249"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="427242249"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 03:06:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="809585957"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="809585957"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2023 03:06:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qHLsG-000UPD-0R;
        Thu, 06 Jul 2023 13:06:08 +0300
Date:   Thu, 6 Jul 2023 13:06:07 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v3 14/18] media: i2c: Add driver for DW9719 VCM
Message-ID: <ZKaSD0CHRBd+zu/T@smile.fi.intel.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-15-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705213010.390849-15-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 05, 2023 at 11:30:06PM +0200, Hans de Goede wrote:
> From: Daniel Scally <djrscally@gmail.com>
> 
> Add a driver for the DW9719 VCM. The driver creates a v4l2 subdevice
> and registers a control to set the desired focus.

...

> +/*
> + * Based on linux/modules/camera/drivers/media/i2c/imx/dw9719.c in this repo:

Sakari, also long line? :-)

> + * https://github.com/ZenfoneArea/android_kernel_asus_zenfone5
> + */

...

> +#include <asm/unaligned.h>

Usually we include headers from generic to particular / private,
hence asm/* usually goes after linux/*.

> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>

...

> +#define DW9719_CTRL_DELAY_US	1000

USEC_PER_MSEC ?

...

> +#define DELAY_MAX_PER_STEP_NS	(1000000 * 1023)

NSEC_PER_MSEC ?

...

> +#define DW9719_DEFAULT_VCM_FREQ		0x60

Any comment what this value means in Hz?

...

> +#define to_dw9719_device(x) container_of(x, struct dw9719_device, sd)

You can make this no-op at compile time by...

...

> +struct dw9719_device {
> +	struct device *dev;
> +	struct i2c_client *client;
> +	struct regulator *regulator;

> +	struct v4l2_subdev sd;

...having this to be the first member in the structure.

However bloat-o-meter can show grow of the code in case the dev is used more
often. The rule of thumb is to combine two aspects:
- frequency of usage (hence pointer arithmetics);
- hot path vs. slow path (hence importance of the lesser code).

> +	u32 sac_mode;
> +	u32 vcm_freq;
> +
> +	struct dw9719_v4l2_ctrls {
> +		struct v4l2_ctrl_handler handler;
> +		struct v4l2_ctrl *focus;
> +	} ctrls;
> +};

...

> +static int dw9719_i2c_rd8(struct i2c_client *client, u8 reg, u8 *val)
> +{
> +	struct i2c_msg msg[2];
> +	u8 buf[2] = { reg };
> +	int ret;
> +
> +	msg[0].addr = client->addr;
> +	msg[0].flags = 0;

> +	msg[0].len = 1;
> +	msg[0].buf = buf;

	sizeof(buf[0])
	&buf[0]

looks more explicit.

> +	msg[1].addr = client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].len = 1;
> +	msg[1].buf = &buf[1];

Ditto.

> +	*val = 0;
> +
> +	ret = i2c_transfer(client->adapter, msg, 2);

ARRAY_SIZE()

> +	if (ret < 0)
> +		return ret;
> +
> +	*val = buf[1];
> +
> +	return 0;
> +}

But as Sakari said this perhaps could go into CCI library.

...

> +	ret = dw9719_i2c_rd8(dw9719->client, DW9719_INFO, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val != DW9719_ID) {
> +		dev_err(dw9719->dev, "Failed to detect correct id\n");
> +		ret = -ENXIO;

		return -ENXIO;

> +	}
> +
> +	return 0;

...

> +	/* Need 100us to transit from SHUTDOWN to STANDBY*/

Missing space.

> +	usleep_range(100, 1000);

Perhaps fsleep() would be better, but I'm fine with either here.

...

> +static int dw9719_t_focus_abs(struct dw9719_device *dw9719, s32 value)
> +{
> +	int ret;

Redundant?

> +	value = clamp(value, 0, DW9719_MAX_FOCUS_POS);

> +	ret = dw9719_i2c_wr16(dw9719->client, DW9719_VCM_CURRENT, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

	return _wr16(...);

or can it return positive values?

> +}

...

> +static int __maybe_unused dw9719_suspend(struct device *dev)

Can we use new PM macros instead of __maybe_unused?

> +{
> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct dw9719_device *dw9719 = to_dw9719_device(sd);
> +	int ret;
> +	int val;
> +
> +	for (val = dw9719->ctrls.focus->val; val >= 0;
> +	     val -= DW9719_CTRL_STEPS) {
> +		ret = dw9719_t_focus_abs(dw9719, val);
> +		if (ret)
> +			return ret;

> +		usleep_range(DW9719_CTRL_DELAY_US, DW9719_CTRL_DELAY_US + 10);

fsleep() ?

> +	}
> +
> +	return dw9719_power_down(dw9719);
> +}

> +static int __maybe_unused dw9719_resume(struct device *dev)
> +{

As per above function.

...

> +err_power_down:

In one functions you use err_ in another fail_, be consistent.

> +	dw9719_power_down(dw9719);
> +	return ret;
> +}

...

> +	dw9719->regulator = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(dw9719->regulator))
> +		return dev_err_probe(&client->dev, PTR_ERR(dw9719->regulator),

With

	struct device *dev = &client->dev;

code may look neater.

> +				     "getting regulator\n");

-- 
With Best Regards,
Andy Shevchenko


