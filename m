Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F72C5E5DEA
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 10:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIVItZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Sep 2022 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIVItY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2022 04:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B46AE82
        for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2022 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPdA7w9nalhVXxot1oY+v+I3XEFa4g11czVtLBfespg=;
        b=cemK65raOSCLWG5hqnZ+QmcNiRa/iwxURVvMKTVQuOzag/33SYiZIv+OW9H/WSjKItk9gf
        zvOc+Q3pbPg1iPVPi/LtGNTc9m12uNnGeToLE1dQV0ab1ZIzvos8nx663hVmd3xSQU1o/C
        zTFQKM4ZqedevP+Pg43BNJnMyP6KsVs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-ZFHCYp9KM-ugFb_qNZWF1A-1; Thu, 22 Sep 2022 04:49:17 -0400
X-MC-Unique: ZFHCYp9KM-ugFb_qNZWF1A-1
Received: by mail-ej1-f69.google.com with SMTP id nb35-20020a1709071ca300b007805be52049so4174085ejc.17
        for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2022 01:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RPdA7w9nalhVXxot1oY+v+I3XEFa4g11czVtLBfespg=;
        b=LNat55s2zbILLMgP6Afy2p2hF+R/RskLdR4Na6yYmfPaqn70ts8vht9un8LxIM6Vy1
         B1PwM6kdZe/nQyi/4BQCCe2JQrdz58FAFmvhPGpQuvBHB5quI8NMTrvkEE9wEHeiIJF9
         zlfTCDDyns7ZOUB20HEmJy0wsovXXXsPzSeq5ZqaNUZHdBfkYlUzGkfFXjSh+g7Gfr3S
         En7K4ruXoZfQR094Al5Ok9ijki01Nk3cteLIPXpROJVaFWtwAHxq3ZfBGffaGXU1MWMW
         rZH0z6bJkQUavPQ10k3nMAydVis78fhKb6XL0I869f1bZUMNsW4xoM27PthbWxhIhhnq
         WVtA==
X-Gm-Message-State: ACrzQf0fbWlMYDNA9FflmSKftkdXf4hkKCrXyPDPXABI1z8884xea9yL
        6LzOqnigr7bJeU4trjWVCpDG55kY7r+NdmsociVetz6mFcF5fHT/TWSwbsHgWOlo7zGrGR2Gqfz
        zzSVWjVf+Z6+Qwpt9XJE/cA==
X-Received: by 2002:a17:906:9b89:b0:780:62a5:462c with SMTP id dd9-20020a1709069b8900b0078062a5462cmr1854884ejc.119.1663836556721;
        Thu, 22 Sep 2022 01:49:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ZILcK7tzV0QZQ0C0dHQCZ3h9+66RMaTT4SI0bpAwupZb5fJ1j7htX6OBeC6hMuTylF6oHzA==
X-Received: by 2002:a17:906:9b89:b0:780:62a5:462c with SMTP id dd9-20020a1709069b8900b0078062a5462cmr1854869ejc.119.1663836556515;
        Thu, 22 Sep 2022 01:49:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u17-20020a50c2d1000000b0044e8d0682b2sm3360949edf.71.2022.09.22.01.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 01:49:16 -0700 (PDT)
Message-ID: <47119a2a-323c-89ca-21c8-5bfcbb796bf5@redhat.com>
Date:   Thu, 22 Sep 2022 10:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 3/5] platform/x86: int3472: Support multiple clock
 consumers
Content-Language: en-US
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220921230439.768185-1-djrscally@gmail.com>
 <20220921230439.768185-4-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220921230439.768185-4-djrscally@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/22/22 01:04, Daniel Scally wrote:
> At present, the tps68470.c only supports a single clock consumer when
> passing platform data to the clock driver. In some devices multiple
> sensors depend on the clock provided by a single TPS68470 and so all
> need to be able to acquire the clock. Support passing multiple
> consumers as platform data.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Note this one already has a review + ack from Stephen Boyd for
merging this through the pdx86 tree (from v1 of the series):

https://lore.kernel.org/platform-driver-x86/20220225004943.AA8EDC340EF@smtp.kernel.org/


Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>


Regards,

Hans





> ---
> Changes since v2:
> 
> 	- None
> 
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
> index 22f61b47f9e5..8a684030933d 100644
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
>  	struct mfd_cell *cells;
>  	struct regmap *regmap;
> +	int n_consumers;
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

