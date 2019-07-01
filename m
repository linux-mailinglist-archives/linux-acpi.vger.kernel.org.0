Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D945B74C
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2019 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfGAI4s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jul 2019 04:56:48 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:50160 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfGAI4s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2019 04:56:48 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 9AE16440A7; Mon,  1 Jul 2019 10:56:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 99AB343D57;
        Mon,  1 Jul 2019 10:56:46 +0200 (CEST)
Date:   Mon, 1 Jul 2019 10:56:46 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     "Andrew F. Davis" <afd@ti.com>
cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/tas5720.c: add ACPI support
In-Reply-To: <ec84d05f-af14-33dd-5f04-6e5525baf138@ti.com>
Message-ID: <alpine.DEB.2.20.1907011056070.2390@fox.voss.local>
References: <20190628123416.16298-1-nikolaus.voss@loewensteinmedical.de> <ec84d05f-af14-33dd-5f04-6e5525baf138@ti.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 28 Jun 2019, Andrew F. Davis wrote:
> On 6/28/19 8:34 AM, Nikolaus Voss wrote:
>> Add support for ACPI enumeration for tas5720 and tas5722.
>> Use device_match API to unify access to driver data for DT and ACPI.
>> Aggregate variant stuff into its own struct and directly reference
>> it in variant data for i2c/of/acpi_device_id.
>>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>> ---
>>  sound/soc/codecs/tas5720.c | 215 +++++++++++++++++--------------------
>>  1 file changed, 99 insertions(+), 116 deletions(-)
>>
>> diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
>> index 37fab8f22800..ea973764c745 100644
>> --- a/sound/soc/codecs/tas5720.c
>> +++ b/sound/soc/codecs/tas5720.c
>> @@ -7,6 +7,7 @@
>>   * Author: Andreas Dannenberg <dannenberg@ti.com>
>>   */
>>
>> +#include <linux/acpi.h>
>>  #include <linux/module.h>
>>  #include <linux/errno.h>
>>  #include <linux/device.h>
>> @@ -28,9 +29,10 @@
>>  /* Define how often to check (and clear) the fault status register (in ms) */
>>  #define TAS5720_FAULT_CHECK_INTERVAL		200
>>
>> -enum tas572x_type {
>> -	TAS5720,
>> -	TAS5722,
>> +struct tas5720_variant {
>> +	const int device_id;
>> +	const struct regmap_config reg_config;
>> +	const struct snd_soc_component_driver comp_drv;
>>  };
>>
>>  static const char * const tas5720_supply_names[] = {
>> @@ -44,7 +46,7 @@ struct tas5720_data {
>>  	struct snd_soc_component *component;
>>  	struct regmap *regmap;
>>  	struct i2c_client *tas5720_client;
>> -	enum tas572x_type devtype;
>> +	const struct tas5720_variant *variant;
>>  	struct regulator_bulk_data supplies[TAS5720_NUM_SUPPLIES];
>>  	struct delayed_work fault_check_work;
>>  	unsigned int last_fault;
>> @@ -179,17 +181,13 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
>>  		goto error_snd_soc_component_update_bits;
>>
>>  	/* Configure TDM slot width. This is only applicable to TAS5722. */
>> -	switch (tas5720->devtype) {
>> -	case TAS5722:
>> +	if (tas5720->variant->device_id == TAS5722_DEVICE_ID) {
>>  		ret = snd_soc_component_update_bits(component, TAS5722_DIGITAL_CTRL2_REG,
>>  						    TAS5722_TDM_SLOT_16B,
>>  						    slot_width == 16 ?
>>  						    TAS5722_TDM_SLOT_16B : 0);
>>  		if (ret < 0)
>>  			goto error_snd_soc_component_update_bits;
>> -		break;
>> -	default:
>> -		break;
>>  	}
>>
>>  	return 0;
>> @@ -277,7 +275,7 @@ static void tas5720_fault_check_work(struct work_struct *work)
>>  static int tas5720_codec_probe(struct snd_soc_component *component)
>>  {
>>  	struct tas5720_data *tas5720 = snd_soc_component_get_drvdata(component);
>> -	unsigned int device_id, expected_device_id;
>> +	unsigned int device_id;
>>  	int ret;
>>
>>  	tas5720->component = component;
>> @@ -301,21 +299,9 @@ static int tas5720_codec_probe(struct snd_soc_component *component)
>>  		goto probe_fail;
>>  	}
>>
>> -	switch (tas5720->devtype) {
>> -	case TAS5720:
>> -		expected_device_id = TAS5720_DEVICE_ID;
>> -		break;
>> -	case TAS5722:
>> -		expected_device_id = TAS5722_DEVICE_ID;
>> -		break;
>> -	default:
>> -		dev_err(component->dev, "unexpected private driver data\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	if (device_id != expected_device_id)
>> +	if (device_id != tas5720->variant->device_id)
>>  		dev_warn(component->dev, "wrong device ID. expected: %u read: %u\n",
>> -			 expected_device_id, device_id);
>> +			 tas5720->variant->device_id, device_id);
>>
>>  	/* Set device to mute */
>>  	ret = snd_soc_component_update_bits(component, TAS5720_DIGITAL_CTRL2_REG,
>> @@ -462,24 +448,6 @@ static bool tas5720_is_volatile_reg(struct device *dev, unsigned int reg)
>>  	}
>>  }
>>
>> -static const struct regmap_config tas5720_regmap_config = {
>> -	.reg_bits = 8,
>> -	.val_bits = 8,
>> -
>> -	.max_register = TAS5720_MAX_REG,
>> -	.cache_type = REGCACHE_RBTREE,
>> -	.volatile_reg = tas5720_is_volatile_reg,
>> -};
>> -
>> -static const struct regmap_config tas5722_regmap_config = {
>> -	.reg_bits = 8,
>> -	.val_bits = 8,
>> -
>> -	.max_register = TAS5722_MAX_REG,
>> -	.cache_type = REGCACHE_RBTREE,
>> -	.volatile_reg = tas5720_is_volatile_reg,
>> -};
>> -
>>  /*
>>   * DAC analog gain. There are four discrete values to select from, ranging
>>   * from 19.2 dB to 26.3dB.
>> @@ -558,40 +526,6 @@ static const struct snd_soc_dapm_route tas5720_audio_map[] = {
>>  	{ "OUT", NULL, "DAC" },
>>  };
>>
>> -static const struct snd_soc_component_driver soc_component_dev_tas5720 = {
>> -	.probe			= tas5720_codec_probe,
>> -	.remove			= tas5720_codec_remove,
>> -	.suspend		= tas5720_suspend,
>> -	.resume			= tas5720_resume,
>> -	.controls		= tas5720_snd_controls,
>> -	.num_controls		= ARRAY_SIZE(tas5720_snd_controls),
>> -	.dapm_widgets		= tas5720_dapm_widgets,
>> -	.num_dapm_widgets	= ARRAY_SIZE(tas5720_dapm_widgets),
>> -	.dapm_routes		= tas5720_audio_map,
>> -	.num_dapm_routes	= ARRAY_SIZE(tas5720_audio_map),
>> -	.idle_bias_on		= 1,
>> -	.use_pmdown_time	= 1,
>> -	.endianness		= 1,
>> -	.non_legacy_dai_naming	= 1,
>> -};
>> -
>> -static const struct snd_soc_component_driver soc_component_dev_tas5722 = {
>> -	.probe = tas5720_codec_probe,
>> -	.remove = tas5720_codec_remove,
>> -	.suspend = tas5720_suspend,
>> -	.resume = tas5720_resume,
>> -	.controls = tas5722_snd_controls,
>> -	.num_controls = ARRAY_SIZE(tas5722_snd_controls),
>> -	.dapm_widgets = tas5720_dapm_widgets,
>> -	.num_dapm_widgets = ARRAY_SIZE(tas5720_dapm_widgets),
>> -	.dapm_routes = tas5720_audio_map,
>> -	.num_dapm_routes = ARRAY_SIZE(tas5720_audio_map),
>> -	.idle_bias_on		= 1,
>> -	.use_pmdown_time	= 1,
>> -	.endianness		= 1,
>> -	.non_legacy_dai_naming	= 1,
>> -};
>> -
>>  /* PCM rates supported by the TAS5720 driver */
>>  #define TAS5720_RATES	(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
>>  			 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
>> @@ -637,29 +571,25 @@ static int tas5720_probe(struct i2c_client *client,
>>  {
>>  	struct device *dev = &client->dev;
>>  	struct tas5720_data *data;
>> -	const struct regmap_config *regmap_config;
>> +	const struct tas5720_variant *type;
>>  	int ret;
>>  	int i;
>>
>> +	type = device_get_match_data(&client->dev);
>> +	if (!type && id)
>> +		type = (const struct tas5720_variant *)id->driver_data;
>> +
>> +	if (!type)
>> +		return -EINVAL;
>> +
>>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>  	if (!data)
>>  		return -ENOMEM;
>>
>>  	data->tas5720_client = client;
>> -	data->devtype = id->driver_data;
>> +	data->variant = type;
>>
>> -	switch (id->driver_data) {
>> -	case TAS5720:
>> -		regmap_config = &tas5720_regmap_config;
>> -		break;
>> -	case TAS5722:
>> -		regmap_config = &tas5722_regmap_config;
>> -		break;
>> -	default:
>> -		dev_err(dev, "unexpected private driver data\n");
>> -		return -EINVAL;
>> -	}
>> -	data->regmap = devm_regmap_init_i2c(client, regmap_config);
>> +	data->regmap = devm_regmap_init_i2c(client, &type->reg_config);
>>  	if (IS_ERR(data->regmap)) {
>>  		ret = PTR_ERR(data->regmap);
>>  		dev_err(dev, "failed to allocate register map: %d\n", ret);
>> @@ -678,51 +608,104 @@ static int tas5720_probe(struct i2c_client *client,
>>
>>  	dev_set_drvdata(dev, data);
>>
>> -	switch (id->driver_data) {
>> -	case TAS5720:
>> -		ret = devm_snd_soc_register_component(&client->dev,
>> -					&soc_component_dev_tas5720,
>> -					tas5720_dai,
>> -					ARRAY_SIZE(tas5720_dai));
>> -		break;
>> -	case TAS5722:
>> -		ret = devm_snd_soc_register_component(&client->dev,
>> -					&soc_component_dev_tas5722,
>> -					tas5720_dai,
>> -					ARRAY_SIZE(tas5720_dai));
>> -		break;
>> -	default:
>> -		dev_err(dev, "unexpected private driver data\n");
>> -		return -EINVAL;
>> -	}
>> -	if (ret < 0) {
>> -		dev_err(dev, "failed to register component: %d\n", ret);
>> -		return ret;
>> -	}
>> +	ret = devm_snd_soc_register_component(&client->dev,
>> +					      &type->comp_drv,
>> +					      tas5720_dai,
>> +					      ARRAY_SIZE(tas5720_dai));
>>
>> -	return 0;
>> +	if (ret < 0)
>> +		dev_err(dev, "failed to register component: %d\n", ret);
>> +
>> +	return ret;
>>  }
>>
>> +static const struct tas5720_variant variant[] = {
>> +	{
>> +		.device_id = TAS5720_DEVICE_ID,
>> +		.reg_config = {
>
>
> This patch would be a lot more simple if you leave the regmap_config and
> snd_soc_component_driver definitions where they are above and just store
> a pointer to them down here in this new struct. That also would allow
> for new devices to use them in this list should they ever match.
>
> If you really want to move the data down here for some reason, do it in
> a separate patch at least, this isn't needed as part of adding ACPI support.

Ok, thanks for the feedback, I'll prepare a series.

Nikolaus

>
> Andrew

[...]
