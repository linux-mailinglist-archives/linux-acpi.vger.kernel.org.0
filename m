Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF635BE32
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2019 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfGAOZ5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jul 2019 10:25:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52532 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbfGAOZ4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2019 10:25:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x61EP5sx120080;
        Mon, 1 Jul 2019 09:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561991105;
        bh=suqhGlKu09i4bHSG5nwK6itb8XxQsF0NeEzzxpNaGkA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eVpIGSj98fC4TDHIu49z+fkYkfsd0RcXPbecRkhAswRSnDlkkfUwkaaQ4MjMqF5zw
         1OFfE3FtS16XYpv2/bXmnlqACRozPWWLsVxIPjyjv/cakmsIyLnXa2OU29iYrRR7x8
         KQvFkOBKtEDRC2HsU4rmoqJ8youpxAE3OUtqVcqs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x61EP53W046247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jul 2019 09:25:05 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Jul
 2019 09:25:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Jul 2019 09:25:05 -0500
Received: from [10.250.68.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x61EP4Qh124077;
        Mon, 1 Jul 2019 09:25:04 -0500
Subject: Re: [PATCH v2 1/2] ASoC: tas5720.c: cleanup variant management
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <nv@vosn.de>
References: <20190628143037.GH5379@sirena.org.uk>
 <cover.1561988282.git.nikolaus.voss@loewensteinmedical.de>
 <c79df50175d59265a37c5e7c8a0cfbf8119bcf78.1561988282.git.nikolaus.voss@loewensteinmedical.de>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <80af3fca-f71b-c118-e5d8-fde8b7d21705@ti.com>
Date:   Mon, 1 Jul 2019 10:25:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <c79df50175d59265a37c5e7c8a0cfbf8119bcf78.1561988282.git.nikolaus.voss@loewensteinmedical.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/1/19 9:42 AM, Nikolaus Voss wrote:
> Replace enum tas572x_type with struct tas5720_variant which aggregates
> variant specific stuff and can be directly referenced from an id table.
> 
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>  sound/soc/codecs/tas5720.c | 98 +++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 65 deletions(-)
> 
> diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
> index 37fab8f22800..b2e897f094b4 100644
> --- a/sound/soc/codecs/tas5720.c
> +++ b/sound/soc/codecs/tas5720.c
> @@ -28,9 +28,10 @@
>  /* Define how often to check (and clear) the fault status register (in ms) */
>  #define TAS5720_FAULT_CHECK_INTERVAL		200
>  
> -enum tas572x_type {
> -	TAS5720,
> -	TAS5722,
> +struct tas5720_variant {
> +	const int device_id;
> +	const struct regmap_config *reg_config;
> +	const struct snd_soc_component_driver *comp_drv;
>  };
>  
>  static const char * const tas5720_supply_names[] = {
> @@ -44,7 +45,7 @@ struct tas5720_data {
>  	struct snd_soc_component *component;
>  	struct regmap *regmap;
>  	struct i2c_client *tas5720_client;
> -	enum tas572x_type devtype;
> +	const struct tas5720_variant *variant;

Why add a new struct? Actually I don't see the need for this patch at
all, the commit message only explains the 'what' not the 'why'. We can
and do already build this info from the tas572x_type.

Also below are several functional changes, the cover letter says this is
not a functional change, yet the driver behaves differently now.

Andrew

>  	struct regulator_bulk_data supplies[TAS5720_NUM_SUPPLIES];
>  	struct delayed_work fault_check_work;
>  	unsigned int last_fault;
> @@ -179,17 +180,13 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
>  		goto error_snd_soc_component_update_bits;
>  
>  	/* Configure TDM slot width. This is only applicable to TAS5722. */
> -	switch (tas5720->devtype) {
> -	case TAS5722:
> +	if (tas5720->variant->device_id == TAS5722_DEVICE_ID) {
>  		ret = snd_soc_component_update_bits(component, TAS5722_DIGITAL_CTRL2_REG,
>  						    TAS5722_TDM_SLOT_16B,
>  						    slot_width == 16 ?
>  						    TAS5722_TDM_SLOT_16B : 0);
>  		if (ret < 0)
>  			goto error_snd_soc_component_update_bits;
> -		break;
> -	default:
> -		break;
>  	}
>  
>  	return 0;
> @@ -277,7 +274,7 @@ static void tas5720_fault_check_work(struct work_struct *work)
>  static int tas5720_codec_probe(struct snd_soc_component *component)
>  {
>  	struct tas5720_data *tas5720 = snd_soc_component_get_drvdata(component);
> -	unsigned int device_id, expected_device_id;
> +	unsigned int device_id;
>  	int ret;
>  
>  	tas5720->component = component;
> @@ -301,21 +298,9 @@ static int tas5720_codec_probe(struct snd_soc_component *component)
>  		goto probe_fail;
>  	}
>  
> -	switch (tas5720->devtype) {
> -	case TAS5720:
> -		expected_device_id = TAS5720_DEVICE_ID;
> -		break;
> -	case TAS5722:
> -		expected_device_id = TAS5722_DEVICE_ID;
> -		break;
> -	default:
> -		dev_err(component->dev, "unexpected private driver data\n");
> -		return -EINVAL;
> -	}
> -
> -	if (device_id != expected_device_id)
> +	if (device_id != tas5720->variant->device_id)
>  		dev_warn(component->dev, "wrong device ID. expected: %u read: %u\n",
> -			 expected_device_id, device_id);
> +			 tas5720->variant->device_id, device_id);
>  
>  	/* Set device to mute */
>  	ret = snd_soc_component_update_bits(component, TAS5720_DIGITAL_CTRL2_REG,
> @@ -637,7 +622,6 @@ static int tas5720_probe(struct i2c_client *client,
>  {
>  	struct device *dev = &client->dev;
>  	struct tas5720_data *data;
> -	const struct regmap_config *regmap_config;
>  	int ret;
>  	int i;
>  
> @@ -646,20 +630,10 @@ static int tas5720_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	data->tas5720_client = client;
> -	data->devtype = id->driver_data;
>  
> -	switch (id->driver_data) {
> -	case TAS5720:
> -		regmap_config = &tas5720_regmap_config;
> -		break;
> -	case TAS5722:
> -		regmap_config = &tas5722_regmap_config;
> -		break;
> -	default:
> -		dev_err(dev, "unexpected private driver data\n");
> -		return -EINVAL;
> -	}
> -	data->regmap = devm_regmap_init_i2c(client, regmap_config);
> +	data->variant = (const struct tas5720_variant *)id->driver_data;
> +
> +	data->regmap = devm_regmap_init_i2c(client, data->variant->reg_config);
>  	if (IS_ERR(data->regmap)) {
>  		ret = PTR_ERR(data->regmap);
>  		dev_err(dev, "failed to allocate register map: %d\n", ret);
> @@ -678,42 +652,36 @@ static int tas5720_probe(struct i2c_client *client,
>  
>  	dev_set_drvdata(dev, data);
>  
> -	switch (id->driver_data) {
> -	case TAS5720:
> -		ret = devm_snd_soc_register_component(&client->dev,
> -					&soc_component_dev_tas5720,
> -					tas5720_dai,
> -					ARRAY_SIZE(tas5720_dai));
> -		break;
> -	case TAS5722:
> -		ret = devm_snd_soc_register_component(&client->dev,
> -					&soc_component_dev_tas5722,
> -					tas5720_dai,
> -					ARRAY_SIZE(tas5720_dai));
> -		break;
> -	default:
> -		dev_err(dev, "unexpected private driver data\n");
> -		return -EINVAL;
> -	}
> -	if (ret < 0) {
> -		dev_err(dev, "failed to register component: %d\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> +	ret = devm_snd_soc_register_component(&client->dev,
> +					      data->variant->comp_drv,
> +					      tas5720_dai,
> +					      ARRAY_SIZE(tas5720_dai));
> +	return ret;
>  }
>  
> +static const struct tas5720_variant tas5720 = {
> +	.device_id = TAS5720_DEVICE_ID,
> +	.reg_config = &tas5720_regmap_config,
> +	.comp_drv = &soc_component_dev_tas5720,
> +};
> +
> +static const struct tas5720_variant tas5722 = {
> +	.device_id = TAS5722_DEVICE_ID,
> +	.reg_config = &tas5722_regmap_config,
> +	.comp_drv = &soc_component_dev_tas5722,
> +};
> +
>  static const struct i2c_device_id tas5720_id[] = {
> -	{ "tas5720", TAS5720 },
> -	{ "tas5722", TAS5722 },
> +	{ "tas5720", (kernel_ulong_t)&tas5720 },
> +	{ "tas5722", (kernel_ulong_t)&tas5722 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tas5720_id);
>  
>  #if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id tas5720_of_match[] = {
> -	{ .compatible = "ti,tas5720", },
> -	{ .compatible = "ti,tas5722", },
> +	{ .compatible = "ti,tas5720", .data = &tas5720, },
> +	{ .compatible = "ti,tas5722", .data = &tas5722, },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, tas5720_of_match);
> 
