Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C4749F1B
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 16:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjGFOf2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjGFOf1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 10:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB21725
        for <linux-acpi@vger.kernel.org>; Thu,  6 Jul 2023 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688654086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EVda/tXLfmhcrz3HtAgYZz5xbkzCQ7oTwFkXSxZ4YEM=;
        b=PcRc6cKLoia6DHiPZ1rW8CxlObeyLViuKlvnMwaI6ipuj9Oc+JwXVydzK8o9cqlUUT0kxX
        FHJfZc4RHOmQUNr0Qk32FAgE/k7tPyihqEH8vgbLBQ8hFS2Mn5qvlIYwaklG9xVlZj+oej
        u+vKbR+TO186OM4JWnyBzyUEzxfdqjU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-3khP94UrMQaUFumGKFTgMA-1; Thu, 06 Jul 2023 10:34:45 -0400
X-MC-Unique: 3khP94UrMQaUFumGKFTgMA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso55408666b.3
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2023 07:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688654083; x=1691246083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVda/tXLfmhcrz3HtAgYZz5xbkzCQ7oTwFkXSxZ4YEM=;
        b=T2awc7B5/8/H4z1c20PQws6+IJOQ2K+xadW4eGYkQ4vGVKUyTAI6fVexuHY2aP0D0F
         ysYXfFTNRlvL0vxMPl8Po8J9R/Xzd/1LNKhD4umHEDTOm52SiRRfhI+TaYwxkyUiHFUn
         FrnS4QWPZVHEvBQ0+zSqChgF3lsPFcbYl9Qb3PvkxLLvO+l4WF1rPryvOHIEWEQfkW+W
         ZwlQR8dsP9f4wrosyyZxfLX35m/kEb179hjic8eYAfJaubfEYq7mCBEMla0ut7IMCHP/
         +r5G5sD1geQu4BawQggyJRhydAnX6RDUWlOEjp5RvrW77B4lFVDMdoBlU5Pjdw3jkJFo
         OUfw==
X-Gm-Message-State: ABy/qLaw7Uj1BEpmYyRLW3HOoZFIZsphLvyyXp5pOrfmvFEXfwufLFbQ
        3NqTzV3MUVoY5CA4wTMTAQEZQvPROx6q/mgRCIoNBHmBgxFanlKKOw54NtaFLUa7q0uabqXoyQ8
        qX2vFZRtRHncEaap/PPJmng==
X-Received: by 2002:a17:907:9548:b0:98e:a54:42e3 with SMTP id ex8-20020a170907954800b0098e0a5442e3mr1427575ejc.54.1688654083495;
        Thu, 06 Jul 2023 07:34:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGUCzdIZUZBDlQ8IPSCE0ZYFajJuaCm7VSPZ9jPvAUxFBXknKqWIKXas/8rA2BLvOWpZuKvRg==
X-Received: by 2002:a17:907:9548:b0:98e:a54:42e3 with SMTP id ex8-20020a170907954800b0098e0a5442e3mr1427565ejc.54.1688654083211;
        Thu, 06 Jul 2023 07:34:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709065f9700b00992d70cc8acsm882555eju.112.2023.07.06.07.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 07:34:42 -0700 (PDT)
Message-ID: <a841fb53-16a2-aad8-1354-a2772a3a1249@redhat.com>
Date:   Thu, 6 Jul 2023 16:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 14/18] media: i2c: Add driver for DW9719 VCM
To:     Andy Shevchenko <andy@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-15-hdegoede@redhat.com>
 <ZKaSD0CHRBd+zu/T@smile.fi.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZKaSD0CHRBd+zu/T@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/6/23 12:06, Andy Shevchenko wrote:
> On Wed, Jul 05, 2023 at 11:30:06PM +0200, Hans de Goede wrote:
>> From: Daniel Scally <djrscally@gmail.com>
>>
>> Add a driver for the DW9719 VCM. The driver creates a v4l2 subdevice
>> and registers a control to set the desired focus.
> 
> ...
> 
>> +/*
>> + * Based on linux/modules/camera/drivers/media/i2c/imx/dw9719.c in this repo:
> 
> Sakari, also long line? :-)

Nope, this is 79 chars.

> 
>> + * https://github.com/ZenfoneArea/android_kernel_asus_zenfone5
>> + */
> 
> ...
> 
>> +#include <asm/unaligned.h>
> 
> Usually we include headers from generic to particular / private,
> hence asm/* usually goes after linux/*.

Ack (gone after switching to CCI helpers in next version).

>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/types.h>
> 
> ...
> 
>> +#define DW9719_CTRL_DELAY_US	1000
> 
> USEC_PER_MSEC ?

I don't see how that helps readability.

> 
> ...
> 
>> +#define DELAY_MAX_PER_STEP_NS	(1000000 * 1023)
> 
> NSEC_PER_MSEC ?

This define is not used so I've dropped it for the next version.

> 
> ...
> 
>> +#define DW9719_DEFAULT_VCM_FREQ		0x60
> 
> Any comment what this value means in Hz?

This comes directly from the Android driver, no idea what this actually means (no datasheet).

> 
> ...
> 
>> +#define to_dw9719_device(x) container_of(x, struct dw9719_device, sd)
> 
> You can make this no-op at compile time by...
> 
> ...
> 
>> +struct dw9719_device {
>> +	struct device *dev;
>> +	struct i2c_client *client;
>> +	struct regulator *regulator;
> 
>> +	struct v4l2_subdev sd;
> 
> ...having this to be the first member in the structure.

Ack.

> However bloat-o-meter can show grow of the code in case the dev is used more
> often. The rule of thumb is to combine two aspects:
> - frequency of usage (hence pointer arithmetics);
> - hot path vs. slow path (hence importance of the lesser code).
> 
>> +	u32 sac_mode;
>> +	u32 vcm_freq;
>> +
>> +	struct dw9719_v4l2_ctrls {
>> +		struct v4l2_ctrl_handler handler;
>> +		struct v4l2_ctrl *focus;
>> +	} ctrls;
>> +};
> 
> ...
> 
>> +static int dw9719_i2c_rd8(struct i2c_client *client, u8 reg, u8 *val)
>> +{
>> +	struct i2c_msg msg[2];
>> +	u8 buf[2] = { reg };
>> +	int ret;
>> +
>> +	msg[0].addr = client->addr;
>> +	msg[0].flags = 0;
> 
>> +	msg[0].len = 1;
>> +	msg[0].buf = buf;
> 
> 	sizeof(buf[0])
> 	&buf[0]
> 
> looks more explicit.
> 
>> +	msg[1].addr = client->addr;
>> +	msg[1].flags = I2C_M_RD;
>> +	msg[1].len = 1;
>> +	msg[1].buf = &buf[1];
> 
> Ditto.
> 
>> +	*val = 0;
>> +
>> +	ret = i2c_transfer(client->adapter, msg, 2);
> 
> ARRAY_SIZE()
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*val = buf[1];
>> +
>> +	return 0;
>> +}
> 
> But as Sakari said this perhaps could go into CCI library.

Right, this is all gone after switching to the new CCI helpers.



> 
> ...
> 
>> +	ret = dw9719_i2c_rd8(dw9719->client, DW9719_INFO, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (val != DW9719_ID) {
>> +		dev_err(dw9719->dev, "Failed to detect correct id\n");
>> +		ret = -ENXIO;
> 
> 		return -ENXIO;
> 
>> +	}
>> +
>> +	return 0;
> 
> ...
> 
>> +	/* Need 100us to transit from SHUTDOWN to STANDBY*/
> 
> Missing space.
> 
>> +	usleep_range(100, 1000);
> 
> Perhaps fsleep() would be better, but I'm fine with either here.

fsleep() indeed is better here.

> 
> ...
> 
>> +static int dw9719_t_focus_abs(struct dw9719_device *dw9719, s32 value)
>> +{
>> +	int ret;
> 
> Redundant?
> 
>> +	value = clamp(value, 0, DW9719_MAX_FOCUS_POS);
> 
>> +	ret = dw9719_i2c_wr16(dw9719->client, DW9719_VCM_CURRENT, value);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
> 
> 	return _wr16(...);
> 
> or can it return positive values?

Ack, fixed.

> 
>> +}
> 
> ...
> 
>> +static int __maybe_unused dw9719_suspend(struct device *dev)
> 
> Can we use new PM macros instead of __maybe_unused?

Ack, fixed.

>> +{
>> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
>> +	struct dw9719_device *dw9719 = to_dw9719_device(sd);
>> +	int ret;
>> +	int val;
>> +
>> +	for (val = dw9719->ctrls.focus->val; val >= 0;
>> +	     val -= DW9719_CTRL_STEPS) {
>> +		ret = dw9719_t_focus_abs(dw9719, val);
>> +		if (ret)
>> +			return ret;
> 
>> +		usleep_range(DW9719_CTRL_DELAY_US, DW9719_CTRL_DELAY_US + 10);
> 
> fsleep() ?

fsleep would expand to:

		usleep_range(DW9719_CTRL_DELAY_US,  2 * DW9719_CTRL_DELAY_US);

making the loop take up to twice as long.


> 
>> +	}
>> +
>> +	return dw9719_power_down(dw9719);
>> +}
> 
>> +static int __maybe_unused dw9719_resume(struct device *dev)
>> +{
> 
> As per above function.
> 
> ...
> 
>> +err_power_down:
> 
> In one functions you use err_ in another fail_, be consistent.

Ack, fixed.

Regards,

Hans

