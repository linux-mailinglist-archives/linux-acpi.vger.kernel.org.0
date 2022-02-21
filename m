Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74AC4BDE6C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355094AbiBUKhQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 05:37:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355073AbiBUKhB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 05:37:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B80A922BC9
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 01:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645437553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hYpLDEDmzY94nyryC694ggAPaCfSED0v0r+A/ovP+4=;
        b=fWAQaFLytGOI78LKNxhTb8ndHicbrN3IpouQtcZyInvOcgmJvfkwnBhSALTNFE8ZH35vo9
        JnTPeC+lKJ7Sbozfe0Ec/D9lVO/1v+TiNCvconqp8H0C4cfYHg1utMn6OhL85Yd5Y4bveM
        Tr9slUmprXaDxZoQxAgi5CE9Vw4QFlA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-0XmqaGvmOOu4xKGD9iOatQ-1; Mon, 21 Feb 2022 04:59:12 -0500
X-MC-Unique: 0XmqaGvmOOu4xKGD9iOatQ-1
Received: by mail-ej1-f70.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so4441424ejk.16
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 01:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/hYpLDEDmzY94nyryC694ggAPaCfSED0v0r+A/ovP+4=;
        b=d405wUjzsZDg5dzJT5czLcVWL7rJS3dSl3/+Oo0yCOC3T3CE7p4KXlG+gbTSrFQST4
         eRhsaBVHk7U9O4uxMEbfpZE95AClpFCCgqz0i34TtQd0tEC7k189vbltgb5GG5pUSTKP
         uRqYOdR1Hqj5aNXmGfoQLXYGXF2EmDpJCnRYYemQt9qqPxUVrV9pw5zjESWnCk2SdbRq
         Rv2K/GbLhPb/QZC81z0c3MWB3efHFiAsYuC6/5F0L5v/R6MNcFSw9bEVWm+vzanDTVAw
         B/dNrsHvY7nyPTLMLrd9uKSh51Yne0AD/wTkgRmHdibVUJja3jwr08uD60H3K1BrM/zi
         fCkw==
X-Gm-Message-State: AOAM530V33WOqMx7keonyiwWxpGLurbziidpH69+FuH8uj3ZOiDmg+Of
        LMTij8NywZ1rYOrXjOxPtAMKhzephROYQx8cgbIynd6/BRRTOOS1SspBg7CtAv4iw/flAWkVKQJ
        QM5UFWiwP7EWS99nvkv6xRg==
X-Received: by 2002:a05:6402:1e8c:b0:411:7180:7dfc with SMTP id f12-20020a0564021e8c00b0041171807dfcmr20678749edf.74.1645437551228;
        Mon, 21 Feb 2022 01:59:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXCgjwJruMzMPmsDnimR/8OECtj6YaQy4WLvWE/e1wsXHbGK7ufQirtUop/bB5YG4otwqRAA==
X-Received: by 2002:a05:6402:1e8c:b0:411:7180:7dfc with SMTP id f12-20020a0564021e8c00b0041171807dfcmr20678737edf.74.1645437551057;
        Mon, 21 Feb 2022 01:59:11 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id hs25sm4998969ejc.172.2022.02.21.01.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:59:10 -0800 (PST)
Message-ID: <c7d1539f-01a2-299d-ca4f-8e60cfe71775@redhat.com>
Date:   Mon, 21 Feb 2022 10:59:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/6] platform/x86: int3472: Support multiple clock
 consumers
Content-Language: en-US
To:     Daniel Scally <djrscally@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     rafael@kernel.org, lenb@kernel.org, sboyd@kernel.org,
        markgross@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220216225304.53911-1-djrscally@gmail.com>
 <20220216225304.53911-4-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220216225304.53911-4-djrscally@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/16/22 23:53, Daniel Scally wrote:
> At present, the int3472-tps68470 only supports a single clock consumer when
> passing platform data to the clock driver. In some devices multiple
> sensors depend on the clock provided by a single TPS68470 and so all
> need to be able to acquire the clock. Support passing multiple
> consumers as platform data.
> 
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Michael, I plan to merge this entire series through the platform-drivers-x86 git
tree, may I have your ack for merging the clk bits from this ?

Regards,

Hans



> ---
>  drivers/clk/clk-tps68470.c                    | 13 ++--
>  drivers/platform/x86/intel/int3472/tps68470.c | 59 ++++++++++++++++---
>  include/linux/platform_data/tps68470.h        |  7 ++-
>  3 files changed, 67 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/clk-tps68470.c b/drivers/clk/clk-tps68470.c
> index e5fbefd6ac2d..38f44b5b9b1b 100644
> --- a/drivers/clk/clk-tps68470.c
> +++ b/drivers/clk/clk-tps68470.c
> @@ -200,7 +200,9 @@ static int tps68470_clk_probe(struct platform_device *pdev)
>  		.flags = CLK_SET_RATE_GATE,
>  	};
>  	struct tps68470_clkdata *tps68470_clkdata;
> +	struct tps68470_clk_consumer *consumer;
>  	int ret;
> +	int i;
>  
>  	tps68470_clkdata = devm_kzalloc(&pdev->dev, sizeof(*tps68470_clkdata),
>  					GFP_KERNEL);
> @@ -223,10 +225,13 @@ static int tps68470_clk_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	if (pdata) {
> -		ret = devm_clk_hw_register_clkdev(&pdev->dev,
> -						  &tps68470_clkdata->clkout_hw,
> -						  pdata->consumer_con_id,
> -						  pdata->consumer_dev_name);
> +		for (i = 0; i < pdata->n_consumers; i++) {
> +			consumer = &pdata->consumers[i];
> +			ret = devm_clk_hw_register_clkdev(&pdev->dev,
> +							  &tps68470_clkdata->clkout_hw,
> +							  consumer->consumer_con_id,
> +							  consumer->consumer_dev_name);
> +		}
>  	}
>  
>  	return ret;
> diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
> index 22f61b47f9e5..b535564712bb 100644
> --- a/drivers/platform/x86/intel/int3472/tps68470.c
> +++ b/drivers/platform/x86/intel/int3472/tps68470.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Author: Dan Scally <djrscally@gmail.com> */
>  
> +#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/core.h>
> @@ -95,20 +96,64 @@ static int skl_int3472_tps68470_calc_type(struct acpi_device *adev)
>  	return DESIGNED_FOR_WINDOWS;
>  }
>  
> +/*
> + * Return the size of the flexible array member, because we'll need that later
> + * on to pass .pdata_size to cells.
> + */
> +static int
> +skl_int3472_fill_clk_pdata(struct device *dev, struct tps68470_clk_platform_data **clk_pdata)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	struct acpi_device *consumer;
> +	unsigned int n_consumers = 0;
> +	const char *sensor_name;
> +	unsigned int i = 0;
> +
> +	for_each_acpi_consumer_dev(adev, consumer)
> +		n_consumers++;
> +
> +	if (!n_consumers) {
> +		dev_err(dev, "INT3472 seems to have no dependents\n");
> +		return -ENODEV;
> +	}
> +
> +	*clk_pdata = devm_kzalloc(dev, struct_size(*clk_pdata, consumers, n_consumers),
> +				  GFP_KERNEL);
> +	if (!*clk_pdata)
> +		return -ENOMEM;
> +
> +	(*clk_pdata)->n_consumers = n_consumers;
> +	i = 0;
> +
> +	for_each_acpi_consumer_dev(adev, consumer) {
> +		sensor_name = devm_kasprintf(dev, GFP_KERNEL, I2C_DEV_NAME_FORMAT,
> +					     acpi_dev_name(consumer));
> +		if (!sensor_name)
> +			return -ENOMEM;
> +
> +		(*clk_pdata)->consumers[i].consumer_dev_name = sensor_name;
> +		i++;
> +	}
> +
> +	acpi_dev_put(consumer);
> +
> +	return n_consumers;
> +}
> +
>  static int skl_int3472_tps68470_probe(struct i2c_client *client)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>  	const struct int3472_tps68470_board_data *board_data;
> -	struct tps68470_clk_platform_data clk_pdata = {};
> +	struct tps68470_clk_platform_data *clk_pdata;
> +	unsigned int n_consumers;
>  	struct mfd_cell *cells;
>  	struct regmap *regmap;
>  	int device_type;
>  	int ret;
>  
> -	ret = skl_int3472_get_sensor_adev_and_name(&client->dev, NULL,
> -						   &clk_pdata.consumer_dev_name);
> -	if (ret)
> -		return ret;
> +	n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
> +	if (n_consumers < 0)
> +		return n_consumers;
>  
>  	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
>  	if (IS_ERR(regmap)) {
> @@ -142,8 +187,8 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
>  		 * the clk + regulators must be ready when this happens.
>  		 */
>  		cells[0].name = "tps68470-clk";
> -		cells[0].platform_data = &clk_pdata;
> -		cells[0].pdata_size = sizeof(clk_pdata);
> +		cells[0].platform_data = clk_pdata;
> +		cells[0].pdata_size = struct_size(clk_pdata, consumers, n_consumers);
>  		cells[1].name = "tps68470-regulator";
>  		cells[1].platform_data = (void *)board_data->tps68470_regulator_pdata;
>  		cells[1].pdata_size = sizeof(struct tps68470_regulator_platform_data);
> diff --git a/include/linux/platform_data/tps68470.h b/include/linux/platform_data/tps68470.h
> index 126d082c3f2e..e605a2cab07f 100644
> --- a/include/linux/platform_data/tps68470.h
> +++ b/include/linux/platform_data/tps68470.h
> @@ -27,9 +27,14 @@ struct tps68470_regulator_platform_data {
>  	const struct regulator_init_data *reg_init_data[TPS68470_NUM_REGULATORS];
>  };
>  
> -struct tps68470_clk_platform_data {
> +struct tps68470_clk_consumer {
>  	const char *consumer_dev_name;
>  	const char *consumer_con_id;
>  };
>  
> +struct tps68470_clk_platform_data {
> +	unsigned int n_consumers;
> +	struct tps68470_clk_consumer consumers[];
> +};
> +
>  #endif

