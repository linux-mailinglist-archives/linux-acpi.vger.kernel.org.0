Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C654BDF1D
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Feb 2022 18:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355135AbiBUKng (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Feb 2022 05:43:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355175AbiBUKnV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2022 05:43:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8BBD51300
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 02:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645437821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4s8BJxEDtsxmBqxIWggsGjTBGC1Oq+r/eNf7z8ANFYk=;
        b=Yfk5odq8FXojsBj30AulYuuj7gyTUz2Qg5EGzVGaZHW8zmnX3owwmfq0CkITQc8diTHTIL
        gkKbcpv6/gU5ZC3AvpXhmqZ9T7z7I5DZKJvV4Nu8GDeb+GQnldrhytiKzcYU8JjJJ7ETDW
        9aEepjCDbsmSBRQ8XmXjaPc30d4Bi88=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-neuJQ3yHMWWOOBBosueWwg-1; Mon, 21 Feb 2022 05:03:37 -0500
X-MC-Unique: neuJQ3yHMWWOOBBosueWwg-1
Received: by mail-ed1-f69.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so9699919edo.22
        for <linux-acpi@vger.kernel.org>; Mon, 21 Feb 2022 02:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4s8BJxEDtsxmBqxIWggsGjTBGC1Oq+r/eNf7z8ANFYk=;
        b=GuahAIV8VjJ4T1Mjc64pLK2YiTVhHWsU6rYX9FiphLZL/rFNmxdBG0WL2YaLogoBnS
         Fk/5eG0dvgv7HpiMkmW89T/n5CYZvmjWxVIun1RL8H/6CEcpAqwrU4pVtted37jQlqoj
         IyRFUluS11+aKg1580HqkPLF4neKsw68YUtXtN3h+UOLKl8wJi7zYQW8xbIvt177F9IE
         /XVp8+9RcjSO4jigTIuwW5jig/Ww3HGBTxj0u8BInAtIcL4weZt89WjoeF0Pl4sQ3ru7
         y/Kdx3DifakUqQqBCvW/bin+XkMTMX6Qu7QxiAwUzRnh3W+ydODwcAyRWe/TyaFUASP7
         yVfQ==
X-Gm-Message-State: AOAM5309wumad2pY6YyUOXiATEEqwyb3WOP6/+Q9HA5we1C1+yRNofjj
        eAcKU5XL6WM49V26HNIocjBWoGzMSxBL2NyJhWFehNUy/Ee+3jkYlMKJiADaMTb2Vs8TIps0bgO
        DGtN7TynplHnueeAMgH4fZg==
X-Received: by 2002:a17:907:9086:b0:6b3:fce8:50ee with SMTP id ge6-20020a170907908600b006b3fce850eemr15067868ejb.390.1645437816128;
        Mon, 21 Feb 2022 02:03:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvv6nlokX9BhhIjU9STNKNuRrTxESvHoQlBYb54BYeI5iJ0tI4/MuKELQ416ug8QhL5lmNhA==
X-Received: by 2002:a17:907:9086:b0:6b3:fce8:50ee with SMTP id ge6-20020a170907908600b006b3fce850eemr15067860ejb.390.1645437815927;
        Mon, 21 Feb 2022 02:03:35 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b7sm5130124ejl.145.2022.02.21.02.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 02:03:35 -0800 (PST)
Message-ID: <922e686e-26df-a07b-1c82-860127e8403b@redhat.com>
Date:   Mon, 21 Feb 2022 11:03:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 5/6] platform/x86: int3472: Support multiple gpio lookups
 in board data
Content-Language: en-US
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, markgross@kernel.org, robert.moore@intel.com
References: <20220216225304.53911-1-djrscally@gmail.com>
 <20220216225304.53911-6-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220216225304.53911-6-djrscally@gmail.com>
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
> Currently, we only support passing a single gpiod_lookup_table as part
> of the board data for the tps68470 driver. This carries the implicit
> assumption that each TPS68470 device will only support a single
> sensor, which does not hold true.
> 
> Extend the code to support the possibility of multiple sensors each
> having a gpiod_lookup_table, and opportunistically add the lookup
> table for the Surface Go line's IR camera.
> 
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
>  drivers/platform/x86/intel/int3472/tps68470.c | 18 ++++++++++-----
>  drivers/platform/x86/intel/int3472/tps68470.h |  3 ++-
>  .../x86/intel/int3472/tps68470_board_data.c   | 22 ++++++++++++++++---
>  3 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
> index b535564712bb..736480961ec3 100644
> --- a/drivers/platform/x86/intel/int3472/tps68470.c
> +++ b/drivers/platform/x86/intel/int3472/tps68470.c
> @@ -150,6 +150,7 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
>  	struct regmap *regmap;
>  	int device_type;
>  	int ret;
> +	int i;
>  
>  	n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
>  	if (n_consumers < 0)
> @@ -194,15 +195,18 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
>  		cells[1].pdata_size = sizeof(struct tps68470_regulator_platform_data);
>  		cells[2].name = "tps68470-gpio";
>  
> -		gpiod_add_lookup_table(board_data->tps68470_gpio_lookup_table);
> +		for (i = 0; i < board_data->n_gpiod_lookups; i++)
> +			gpiod_add_lookup_table(board_data->tps68470_gpio_lookup_tables[i]);
>  
>  		ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
>  					   cells, TPS68470_WIN_MFD_CELL_COUNT,
>  					   NULL, 0, NULL);
>  		kfree(cells);
>  
> -		if (ret)
> -			gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
> +		if (ret) {
> +			for (i = 0; i < board_data->n_gpiod_lookups; i++)
> +				gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_tables[i]);
> +		}
>  
>  		break;
>  	case DESIGNED_FOR_CHROMEOS:
> @@ -226,10 +230,12 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
>  static int skl_int3472_tps68470_remove(struct i2c_client *client)
>  {
>  	const struct int3472_tps68470_board_data *board_data;
> -
> +	int i;

Please keep an empty line between variable declarations and statements
(I believe checkpatch should have warned about this?)

>  	board_data = int3472_tps68470_get_board_data(dev_name(&client->dev));
> -	if (board_data)
> -		gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
> +	if (board_data) {
> +		for (i = 0; i < board_data->n_gpiod_lookups; i++)
> +			gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_tables[i]);
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/platform/x86/intel/int3472/tps68470.h b/drivers/platform/x86/intel/int3472/tps68470.h
> index cfd33eb62740..35915e701593 100644
> --- a/drivers/platform/x86/intel/int3472/tps68470.h
> +++ b/drivers/platform/x86/intel/int3472/tps68470.h
> @@ -16,8 +16,9 @@ struct tps68470_regulator_platform_data;
>  
>  struct int3472_tps68470_board_data {
>  	const char *dev_name;
> -	struct gpiod_lookup_table *tps68470_gpio_lookup_table;
>  	const struct tps68470_regulator_platform_data *tps68470_regulator_pdata;
> +	unsigned int n_gpiod_lookups;
> +	struct gpiod_lookup_table *tps68470_gpio_lookup_tables[];
>  };
>  
>  const struct int3472_tps68470_board_data *int3472_tps68470_get_board_data(const char *dev_name);
> diff --git a/drivers/platform/x86/intel/int3472/tps68470_board_data.c b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
> index 525f09a3b5ff..442a8a2de224 100644
> --- a/drivers/platform/x86/intel/int3472/tps68470_board_data.c
> +++ b/drivers/platform/x86/intel/int3472/tps68470_board_data.c
> @@ -96,7 +96,7 @@ static const struct tps68470_regulator_platform_data surface_go_tps68470_pdata =
>  	},
>  };
>  
> -static struct gpiod_lookup_table surface_go_tps68470_gpios = {
> +static struct gpiod_lookup_table surface_go_int347a_gpios = {
>  	.dev_id = "i2c-INT347A:00",
>  	.table = {
>  		GPIO_LOOKUP("tps68470-gpio", 9, "reset", GPIO_ACTIVE_LOW),
> @@ -105,16 +105,32 @@ static struct gpiod_lookup_table surface_go_tps68470_gpios = {
>  	}
>  };
>  
> +static struct gpiod_lookup_table surface_go_int347e_gpios = {
> +	.dev_id = "i2c-INT347E:00",
> +	.table = {
> +		GPIO_LOOKUP("tps68470-gpio", 5, "enable", GPIO_ACTIVE_HIGH),
> +		{ }
> +	}
> +};
> +
>  static const struct int3472_tps68470_board_data surface_go_tps68470_board_data = {
>  	.dev_name = "i2c-INT3472:05",
> -	.tps68470_gpio_lookup_table = &surface_go_tps68470_gpios,
>  	.tps68470_regulator_pdata = &surface_go_tps68470_pdata,
> +	.n_gpiod_lookups = 2,
> +	.tps68470_gpio_lookup_tables = {
> +		&surface_go_int347a_gpios,
> +		&surface_go_int347e_gpios,
> +	}
>  };
>  
>  static const struct int3472_tps68470_board_data surface_go3_tps68470_board_data = {
>  	.dev_name = "i2c-INT3472:01",
> -	.tps68470_gpio_lookup_table = &surface_go_tps68470_gpios,
>  	.tps68470_regulator_pdata = &surface_go_tps68470_pdata,
> +	.n_gpiod_lookups = 2,
> +	.tps68470_gpio_lookup_tables = {
> +		&surface_go_int347a_gpios,
> +		&surface_go_int347e_gpios,
> +	}
>  };
>  
>  static const struct dmi_system_id int3472_tps68470_board_data_table[] = {

Otherwise this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


