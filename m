Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D46D5F24E
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 07:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfGDFgx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jul 2019 01:36:53 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:33430 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfGDFgx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jul 2019 01:36:53 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id C9E644D456; Thu,  4 Jul 2019 07:36:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id C6CB14D452;
        Thu,  4 Jul 2019 07:36:48 +0200 (CEST)
Date:   Thu, 4 Jul 2019 07:36:48 +0200 (CEST)
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
Subject: Re: [PATCH v2 1/2] ASoC: tas5720.c: cleanup variant management
In-Reply-To: <4897e119-28fa-aa2c-aa06-2534af6b4c62@ti.com>
Message-ID: <alpine.DEB.2.20.1907040731270.27853@fox.voss.local>
References: <20190628143037.GH5379@sirena.org.uk> <cover.1561988282.git.nikolaus.voss@loewensteinmedical.de> <c79df50175d59265a37c5e7c8a0cfbf8119bcf78.1561988282.git.nikolaus.voss@loewensteinmedical.de> <80af3fca-f71b-c118-e5d8-fde8b7d21705@ti.com>
 <alpine.DEB.2.20.1907011633310.4353@fox.voss.local> <074d4df3-51d8-6e20-869d-5f88b46cc172@ti.com> <alpine.DEB.2.20.1907020855240.10248@fox.voss.local> <4897e119-28fa-aa2c-aa06-2534af6b4c62@ti.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1780306468-1562218608=:27853"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1780306468-1562218608=:27853
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 3 Jul 2019, Andrew F. Davis wrote:
> On 7/2/19 6:12 AM, Nikolaus Voss wrote:
>> On Mon, 1 Jul 2019, Andrew F. Davis wrote:
>>> On 7/1/19 11:35 AM, Nikolaus Voss wrote:
>>>> On Mon, 1 Jul 2019, Andrew F. Davis wrote:
>>>>> On 7/1/19 9:42 AM, Nikolaus Voss wrote:
>>>>>> Replace enum tas572x_type with struct tas5720_variant which aggregates
>>>>>> variant specific stuff and can be directly referenced from an id
>>>>>> table.
>>>>>>
>>>>>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>>>>>> ---
>>>>>>  sound/soc/codecs/tas5720.c | 98
>>>>>> +++++++++++++-------------------------
>>>>>>  1 file changed, 33 insertions(+), 65 deletions(-)
>>>>>>
>>>>>> diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
>>>>>> index 37fab8f22800..b2e897f094b4 100644
>>>>>> --- a/sound/soc/codecs/tas5720.c
>>>>>> +++ b/sound/soc/codecs/tas5720.c
>>>>>> @@ -28,9 +28,10 @@
>>>>>>  /* Define how often to check (and clear) the fault status register
>>>>>> (in ms) */
>>>>>>  #define TAS5720_FAULT_CHECK_INTERVAL        200
>>>>>>
>>>>>> -enum tas572x_type {
>>>>>> -    TAS5720,
>>>>>> -    TAS5722,
>>>>>> +struct tas5720_variant {
>>>>>> +    const int device_id;
>>>>>> +    const struct regmap_config *reg_config;
>>>>>> +    const struct snd_soc_component_driver *comp_drv;
>>>>>>  };
>>>>>>
>>>>>>  static const char * const tas5720_supply_names[] = {
>>>>>> @@ -44,7 +45,7 @@ struct tas5720_data {
>>>>>>      struct snd_soc_component *component;
>>>>>>      struct regmap *regmap;
>>>>>>      struct i2c_client *tas5720_client;
>>>>>> -    enum tas572x_type devtype;
>>>>>> +    const struct tas5720_variant *variant;
>>>>>
>>>>> Why add a new struct? Actually I don't see the need for this patch at
>>>>> all, the commit message only explains the 'what' not the 'why'. We can
>>>>> and do already build this info from the tas572x_type.
>>>>
>>>> As the commit message says, the purpose is to aggregate the variant
>>>> specifics and make it accessible via one pointer. This is a standard
>>>> approach for of/acpi_device_id tables and thus makes the code simpler
>>>> and improves readability. This is a maintenance patch to prepare using
>>>> the device match API in a proper way.
>>>>
>>>
>>>
>>> "make it accessible via one pointer" is again a "what", the "why" is:
>>>
>>> "This is a standard approach"
>>> "makes the code simpler and improves readability"
>>>
>>> Those are valid reasons and should be what you put in the commit message.
>>
>> ok
>>
>>>
>>>
>>>>>
>>>>> Also below are several functional changes, the cover letter says
>>>>> this is
>>>>> not a functional change, yet the driver behaves differently now.
>>>>
>>>> Can you be a little bit more specific? The code should behave exactly as
>>>> before.
>>>>
>>>
>>>
>>> Sure, for instance the line "unexpected private driver data" is removed,
>>> this can now never happen, that is a functional change. The phrase "no
>>> functional change", should be reserved for only changes to spelling,
>>> formatting, code organizing, etc..
>>
>> "unexpected private driver data" was unreachable code before, but you're
>> right, debug output has changed a little, but the functional part is
>> exactly the same.
>>
>>>
>>>
>>>> Niko
>>>>
>>>>>
>>>>> Andrew
>>>>>
>>>>>>      struct regulator_bulk_data supplies[TAS5720_NUM_SUPPLIES];
>>>>>>      struct delayed_work fault_check_work;
>>>>>>      unsigned int last_fault;
>>>>>> @@ -179,17 +180,13 @@ static int tas5720_set_dai_tdm_slot(struct
>>>>>> snd_soc_dai *dai,
>>>>>>          goto error_snd_soc_component_update_bits;
>>>>>>
>>>>>>      /* Configure TDM slot width. This is only applicable to
>>>>>> TAS5722. */
>>>>>> -    switch (tas5720->devtype) {
>>>>>> -    case TAS5722:
>>>>>> +    if (tas5720->variant->device_id == TAS5722_DEVICE_ID) {
>>>
>>>
>>> I also don't like this, TAS5722_DEVICE_ID is the expected contents of a
>>> register, you are using it like the enum tas572x_type that you removed.
>>> I'd leave that enum, the device ID register itself is not guaranteed to
>>> be correct or unique, which is why we warn about mismatches below but
>>> then continue to use the user provided device type anyway.
>>
>> Strange, with me it's the other way round, I don't like the enum. The
>> mismatch behavior hasn't changed a bit, the same warning is printed. If
>> the device ID is no longer unique in the future (apparently it is for
>> now) the driver should explicitly handle this instead of printing a
>> warning, because warnings should be reserved for an indication of any
>> kind of misconfiguration and not of expected behavior.
>>
>> That said the variant struct can of course replace the enum in every
>> aspect, even for what you describe above. The enum was an ordinal
>> representation of the user-selected i2c_device_id, the variant struct* is
>> a pointer representation of the user-selected i2c/of/acpi_device_id. The
>> only difference is that it directly points to the variant specific parts
>> of the driver instead of resolving those via multiple switch/case
>> statements.
>
> The enum identifies the device type, easy as that, if you want to
> instead do all the logic switching on some internal ID register value
> code then make a patch for just that and explain what is gained. Don't
> do that into this one.

I don't do and I don't want to. The struct pointer identifies the device 
type the same way as the enum does. I guess we better leave things as they 
are. Anyway, thanks for your time and effort.

Nikolaus

--8323329-1780306468-1562218608=:27853--
