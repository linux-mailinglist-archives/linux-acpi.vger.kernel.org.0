Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45175ECBB
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 21:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCTYz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 15:24:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41446 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCTYz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 15:24:55 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x63JO3Fc056323;
        Wed, 3 Jul 2019 14:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562181843;
        bh=hdkWWlkE1Pov+QpahnmFk2wqv+OXG0rwblyu9V8WEVM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aT//gTj/zBqGhmJAbE6kYfTV+dbaKY8dG45gnAsszKDwl6pzFrbadyk/YdOUgn8Ot
         JUJkMoHJQTYap8Ckiuild/L2fx1xuCW3wlKbqcrTiShVcsdN3WYPtNCoft0KbyCHnD
         3zwbK0UZaiz+m/B2AFzBwsIYxwA+ZKYEQH0/PaGs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x63JO33J118481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Jul 2019 14:24:03 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Jul
 2019 14:24:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Jul 2019 14:24:03 -0500
Received: from [10.250.81.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x63JO2PS107354;
        Wed, 3 Jul 2019 14:24:02 -0500
Subject: Re: [PATCH v2 1/2] ASoC: tas5720.c: cleanup variant management
To:     Nikolaus Voss <nv@vosn.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
References: <20190628143037.GH5379@sirena.org.uk>
 <cover.1561988282.git.nikolaus.voss@loewensteinmedical.de>
 <c79df50175d59265a37c5e7c8a0cfbf8119bcf78.1561988282.git.nikolaus.voss@loewensteinmedical.de>
 <80af3fca-f71b-c118-e5d8-fde8b7d21705@ti.com>
 <alpine.DEB.2.20.1907011633310.4353@fox.voss.local>
 <074d4df3-51d8-6e20-869d-5f88b46cc172@ti.com>
 <alpine.DEB.2.20.1907020855240.10248@fox.voss.local>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <4897e119-28fa-aa2c-aa06-2534af6b4c62@ti.com>
Date:   Wed, 3 Jul 2019 15:24:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1907020855240.10248@fox.voss.local>
Content-Type: text/plain; charset="iso-8859-15"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/2/19 6:12 AM, Nikolaus Voss wrote:
> On Mon, 1 Jul 2019, Andrew F. Davis wrote:
>> On 7/1/19 11:35 AM, Nikolaus Voss wrote:
>>> On Mon, 1 Jul 2019, Andrew F. Davis wrote:
>>>> On 7/1/19 9:42 AM, Nikolaus Voss wrote:
>>>>> Replace enum tas572x_type with struct tas5720_variant which aggregates
>>>>> variant specific stuff and can be directly referenced from an id
>>>>> table.
>>>>>
>>>>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>>>>> ---
>>>>>  sound/soc/codecs/tas5720.c | 98
>>>>> +++++++++++++-------------------------
>>>>>  1 file changed, 33 insertions(+), 65 deletions(-)
>>>>>
>>>>> diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
>>>>> index 37fab8f22800..b2e897f094b4 100644
>>>>> --- a/sound/soc/codecs/tas5720.c
>>>>> +++ b/sound/soc/codecs/tas5720.c
>>>>> @@ -28,9 +28,10 @@
>>>>>  /* Define how often to check (and clear) the fault status register
>>>>> (in ms) */
>>>>>  #define TAS5720_FAULT_CHECK_INTERVAL        200
>>>>>
>>>>> -enum tas572x_type {
>>>>> -    TAS5720,
>>>>> -    TAS5722,
>>>>> +struct tas5720_variant {
>>>>> +    const int device_id;
>>>>> +    const struct regmap_config *reg_config;
>>>>> +    const struct snd_soc_component_driver *comp_drv;
>>>>>  };
>>>>>
>>>>>  static const char * const tas5720_supply_names[] = {
>>>>> @@ -44,7 +45,7 @@ struct tas5720_data {
>>>>>      struct snd_soc_component *component;
>>>>>      struct regmap *regmap;
>>>>>      struct i2c_client *tas5720_client;
>>>>> -    enum tas572x_type devtype;
>>>>> +    const struct tas5720_variant *variant;
>>>>
>>>> Why add a new struct? Actually I don't see the need for this patch at
>>>> all, the commit message only explains the 'what' not the 'why'. We can
>>>> and do already build this info from the tas572x_type.
>>>
>>> As the commit message says, the purpose is to aggregate the variant
>>> specifics and make it accessible via one pointer. This is a standard
>>> approach for of/acpi_device_id tables and thus makes the code simpler
>>> and improves readability. This is a maintenance patch to prepare using
>>> the device match API in a proper way.
>>>
>>
>>
>> "make it accessible via one pointer" is again a "what", the "why" is:
>>
>> "This is a standard approach"
>> "makes the code simpler and improves readability"
>>
>> Those are valid reasons and should be what you put in the commit message.
> 
> ok
> 
>>
>>
>>>>
>>>> Also below are several functional changes, the cover letter says
>>>> this is
>>>> not a functional change, yet the driver behaves differently now.
>>>
>>> Can you be a little bit more specific? The code should behave exactly as
>>> before.
>>>
>>
>>
>> Sure, for instance the line "unexpected private driver data" is removed,
>> this can now never happen, that is a functional change. The phrase "no
>> functional change", should be reserved for only changes to spelling,
>> formatting, code organizing, etc..
> 
> "unexpected private driver data" was unreachable code before, but you're
> right, debug output has changed a little, but the functional part is
> exactly the same.
> 
>>
>>
>>> Niko
>>>
>>>>
>>>> Andrew
>>>>
>>>>>      struct regulator_bulk_data supplies[TAS5720_NUM_SUPPLIES];
>>>>>      struct delayed_work fault_check_work;
>>>>>      unsigned int last_fault;
>>>>> @@ -179,17 +180,13 @@ static int tas5720_set_dai_tdm_slot(struct
>>>>> snd_soc_dai *dai,
>>>>>          goto error_snd_soc_component_update_bits;
>>>>>
>>>>>      /* Configure TDM slot width. This is only applicable to
>>>>> TAS5722. */
>>>>> -    switch (tas5720->devtype) {
>>>>> -    case TAS5722:
>>>>> +    if (tas5720->variant->device_id == TAS5722_DEVICE_ID) {
>>
>>
>> I also don't like this, TAS5722_DEVICE_ID is the expected contents of a
>> register, you are using it like the enum tas572x_type that you removed.
>> I'd leave that enum, the device ID register itself is not guaranteed to
>> be correct or unique, which is why we warn about mismatches below but
>> then continue to use the user provided device type anyway.
> 
> Strange, with me it's the other way round, I don't like the enum. The
> mismatch behavior hasn't changed a bit, the same warning is printed. If
> the device ID is no longer unique in the future (apparently it is for
> now) the driver should explicitly handle this instead of printing a
> warning, because warnings should be reserved for an indication of any
> kind of misconfiguration and not of expected behavior.
> 
> That said the variant struct can of course replace the enum in every
> aspect, even for what you describe above. The enum was an ordinal
> representation of the user-selected i2c_device_id, the variant struct* is
> a pointer representation of the user-selected i2c/of/acpi_device_id. The
> only difference is that it directly points to the variant specific parts
> of the driver instead of resolving those via multiple switch/case
> statements.

The enum identifies the device type, easy as that, if you want to
instead do all the logic switching on some internal ID register value
code then make a patch for just that and explain what is gained. Don't
do that into this one.

Andrew

> 
> Niko
> 
>>
>> Andrew
>>
>>
>>>>>          ret = snd_soc_component_update_bits(component,
>>>>> TAS5722_DIGITAL_CTRL2_REG,
>>>>>                              TAS5722_TDM_SLOT_16B,
>>>>>                              slot_width == 16 ?
>>>>>                              TAS5722_TDM_SLOT_16B : 0);
>>>>>          if (ret < 0)
>>>>>              goto error_snd_soc_component_update_bits;
>>>>> -        break;
>>>>> -    default:
>>>>> -        break;
>>>>>      }
>>>>>
>>>>>      return 0;
>>>>> @@ -277,7 +274,7 @@ static void tas5720_fault_check_work(struct
>>>>> work_struct *work)
>>>>>  static int tas5720_codec_probe(struct snd_soc_component *component)
>>>>>  {
>>>>>      struct tas5720_data *tas5720 =
>>>>> snd_soc_component_get_drvdata(component);
>>>>> -    unsigned int device_id, expected_device_id;
>>>>> +    unsigned int device_id;
>>>>>      int ret;
>>>>>
>>>>>      tas5720->component = component;
>>>>> @@ -301,21 +298,9 @@ static int tas5720_codec_probe(struct
>>>>> snd_soc_component *component)
>>>>>          goto probe_fail;
>>>>>      }
>>>>>
>>>>> -    switch (tas5720->devtype) {
>>>>> -    case TAS5720:
>>>>> -        expected_device_id = TAS5720_DEVICE_ID;
>>>>> -        break;
>>>>> -    case TAS5722:
>>>>> -        expected_device_id = TAS5722_DEVICE_ID;
>>>>> -        break;
>>>>> -    default:
>>>>> -        dev_err(component->dev, "unexpected private driver data\n");
>>>>> -        return -EINVAL;
>>>>> -    }
>>>>> -
>>>>> -    if (device_id != expected_device_id)
>>>>> +    if (device_id != tas5720->variant->device_id)
>>>>>          dev_warn(component->dev, "wrong device ID. expected: %u
>>>>> read: %u\n",
>>>>> -             expected_device_id, device_id);
>>>>> +             tas5720->variant->device_id, device_id);
>>>>>
>>>>>      /* Set device to mute */
>>>>>      ret = snd_soc_component_update_bits(component,
>>>>> TAS5720_DIGITAL_CTRL2_REG,
>>>>> @@ -637,7 +622,6 @@ static int tas5720_probe(struct i2c_client
>>>>> *client,
>>>>>  {
>>>>>      struct device *dev = &client->dev;
>>>>>      struct tas5720_data *data;
>>>>> -    const struct regmap_config *regmap_config;
>>>>>      int ret;
>>>>>      int i;
>>>>>
>>>>> @@ -646,20 +630,10 @@ static int tas5720_probe(struct i2c_client
>>>>> *client,
>>>>>          return -ENOMEM;
>>>>>
>>>>>      data->tas5720_client = client;
>>>>> -    data->devtype = id->driver_data;
>>>>>
>>>>> -    switch (id->driver_data) {
>>>>> -    case TAS5720:
>>>>> -        regmap_config = &tas5720_regmap_config;
>>>>> -        break;
>>>>> -    case TAS5722:
>>>>> -        regmap_config = &tas5722_regmap_config;
>>>>> -        break;
>>>>> -    default:
>>>>> -        dev_err(dev, "unexpected private driver data\n");
>>>>> -        return -EINVAL;
>>>>> -    }
>>>>> -    data->regmap = devm_regmap_init_i2c(client, regmap_config);
>>>>> +    data->variant = (const struct tas5720_variant *)id->driver_data;
>>>>> +
>>>>> +    data->regmap = devm_regmap_init_i2c(client,
>>>>> data->variant->reg_config);
>>>>>      if (IS_ERR(data->regmap)) {
>>>>>          ret = PTR_ERR(data->regmap);
>>>>>          dev_err(dev, "failed to allocate register map: %d\n", ret);
>>>>> @@ -678,42 +652,36 @@ static int tas5720_probe(struct i2c_client
>>>>> *client,
>>>>>
>>>>>      dev_set_drvdata(dev, data);
>>>>>
>>>>> -    switch (id->driver_data) {
>>>>> -    case TAS5720:
>>>>> -        ret = devm_snd_soc_register_component(&client->dev,
>>>>> -                    &soc_component_dev_tas5720,
>>>>> -                    tas5720_dai,
>>>>> -                    ARRAY_SIZE(tas5720_dai));
>>>>> -        break;
>>>>> -    case TAS5722:
>>>>> -        ret = devm_snd_soc_register_component(&client->dev,
>>>>> -                    &soc_component_dev_tas5722,
>>>>> -                    tas5720_dai,
>>>>> -                    ARRAY_SIZE(tas5720_dai));
>>>>> -        break;
>>>>> -    default:
>>>>> -        dev_err(dev, "unexpected private driver data\n");
>>>>> -        return -EINVAL;
>>>>> -    }
>>>>> -    if (ret < 0) {
>>>>> -        dev_err(dev, "failed to register component: %d\n", ret);
>>>>> -        return ret;
>>>>> -    }
>>>>> -
>>>>> -    return 0;
>>>>> +    ret = devm_snd_soc_register_component(&client->dev,
>>>>> +                          data->variant->comp_drv,
>>>>> +                          tas5720_dai,
>>>>> +                          ARRAY_SIZE(tas5720_dai));
>>>>> +    return ret;
>>>>>  }
>>>>>
>>>>> +static const struct tas5720_variant tas5720 = {
>>>>> +    .device_id = TAS5720_DEVICE_ID,
>>>>> +    .reg_config = &tas5720_regmap_config,
>>>>> +    .comp_drv = &soc_component_dev_tas5720,
>>>>> +};
>>>>> +
>>>>> +static const struct tas5720_variant tas5722 = {
>>>>> +    .device_id = TAS5722_DEVICE_ID,
>>>>> +    .reg_config = &tas5722_regmap_config,
>>>>> +    .comp_drv = &soc_component_dev_tas5722,
>>>>> +};
>>>>> +
>>>>>  static const struct i2c_device_id tas5720_id[] = {
>>>>> -    { "tas5720", TAS5720 },
>>>>> -    { "tas5722", TAS5722 },
>>>>> +    { "tas5720", (kernel_ulong_t)&tas5720 },
>>>>> +    { "tas5722", (kernel_ulong_t)&tas5722 },
>>>>>      { }
>>>>>  };
>>>>>  MODULE_DEVICE_TABLE(i2c, tas5720_id);
>>>>>
>>>>>  #if IS_ENABLED(CONFIG_OF)
>>>>>  static const struct of_device_id tas5720_of_match[] = {
>>>>> -    { .compatible = "ti,tas5720", },
>>>>> -    { .compatible = "ti,tas5722", },
>>>>> +    { .compatible = "ti,tas5720", .data = &tas5720, },
>>>>> +    { .compatible = "ti,tas5722", .data = &tas5722, },
>>>>>      { },
>>>>>  };
>>>>>  MODULE_DEVICE_TABLE(of, tas5720_of_match);
>>>>>
>>>>
>>
