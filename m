Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D31A2EA117
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 00:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbhADXsm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 18:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbhADXsm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 18:48:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0502C061793;
        Mon,  4 Jan 2021 15:48:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q75so798316wme.2;
        Mon, 04 Jan 2021 15:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pf6hy2sekXXdsG+H+oZN0AKCFDEay39UaF3x6GqJwJ0=;
        b=KI3pnjA5vDziWUwLxdM1XaCReBk4az64AIN1M4HP9FHuEoP2hBIJb79WYOLd1SwFxp
         CrNz9UmFjQcUuCswJO77jgJmn1UgCzb0saeyZpbeB+14fg+uwaP3O+2RgHZtQ8EbBAhd
         pg/4qwIP/5zyhXPR+7AkEUpqrvetUu1vm0SiCrqdRVsN1dTTUaTlj/7nZgNDr0R2uJ05
         GPok8LIcbMoVq1DghatYcf7kUf55Spvii7YtDT8khwWBWuP65OnxD9u66/Vc8n0RQzjy
         ZCh6dwzntWQzN8ohVCLASOfzpP5TBJ1nTkuXUAbjKvCXqtMFi9e2izM4OpgiBy0dLGLE
         cyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pf6hy2sekXXdsG+H+oZN0AKCFDEay39UaF3x6GqJwJ0=;
        b=EM4MuUtCFUu9RnF2XqFluwl/H2rTM49xOerWEXqJsctzLIML+269+j5F4HtCcVWsbp
         46WdVfo9iX3Q3dh5ckdf1OZQJU1E630CubhzdCuZMV+QKewZKmUWXhFJHZiQef1xaZ5p
         0pYhxplbBOYqfLHDTj2sUwkj8AhwY9IDWr5lEzsE/CReHmQS9SG0qthOi2XZxgQdb9YY
         zrGecA9jbJUs/XhsgTJ18NJmvzCsuA5GcK2X3If/GMBYso0bjTAHkjS6vasox65srgXR
         gtTY8kepW6//q1IeOS1BnBzPl5lvKlTvozFcHBrwd5smA3t50C04bqgc/5ngocbCyUDl
         pAZg==
X-Gm-Message-State: AOAM533Jd5TH8uxTgBpwSmNaDcR7VHGyaeyVJt8am/Co0DHE3xyYPFcF
        kLTDJIfJLWI2HfoyE2nYc+iZ1GgHbRwQRcnh
X-Google-Smtp-Source: ABdhPJycKUkx8yN7Bt/JgmIToTshR1iQ8vdB3MPNQ0/+cwk4XaT0RSzT+vwlJ98LDuGbE6xntR8Ucw==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr758444wml.155.1609797781691;
        Mon, 04 Jan 2021 14:03:01 -0800 (PST)
Received: from [192.168.1.158] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o74sm1449106wme.36.2021.01.04.14.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 14:03:00 -0800 (PST)
Subject: Re: [PATCH v4 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     kieran.bingham@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        devel@acpica.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org
Cc:     lenb@kernel.org, yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, hverkuil-cisco@xs4all.nl,
        m.felsch@pengutronix.de, niklas.soderlund+renesas@ragnatech.se,
        slongerbeam@gmail.com, heikki.krogerus@linux.intel.com,
        linus.walleij@linaro.org,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-16-djrscally@gmail.com>
 <3d881e2b-747f-dcd7-a0cf-e7309419914b@ideasonboard.com>
 <9026519f-1f33-9df0-de18-0881069f7aaa@gmail.com>
 <249b8ad1-5616-596d-4ee6-efcfdda2ca64@ideasonboard.com>
 <b85c0e71-6068-de43-1b80-97c519eeb9c4@gmail.com>
 <b0a99dba-4176-009a-07c7-7ad6701c2b48@ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <03dc26d0-39d3-174d-f269-426dbc38e62e@gmail.com>
Date:   Mon, 4 Jan 2021 22:02:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b0a99dba-4176-009a-07c7-7ad6701c2b48@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Kieran

On 04/01/2021 16:13, Kieran Bingham wrote:
> Hi Dan,
> 
> On 04/01/2021 15:31, Daniel Scally wrote:
>> Hi Kieran
>>
>> On 04/01/2021 15:13, Kieran Bingham wrote:
>>> Hi Dan,
>>>
>>> On 04/01/2021 13:55, Daniel Scally wrote:
>>>> Hi Kieran
>>>>
>>>> On 04/01/2021 13:35, Kieran Bingham wrote:
>>>>>> +/*
>>>>>> + * Extend this array with ACPI Hardware IDs of devices known to be working
>>>>>> + * plus the number of link-frequencies expected by their drivers, along with
>>>>>> + * the frequency values in hertz. This is somewhat opportunistic way of adding
>>>>>> + * support for this for now in the hopes of a better source for the information
>>>>>> + * (possibly some encoded value in the SSDB buffer that we're unaware of)
>>>>>> + * becoming apparent in the future.
>>>>>> + *
>>>>>> + * Do not add an entry for a sensor that is not actually supported.
>>>>>> + */
>>>>>> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
>>>>>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>>>>>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>>>> I don't know if these are expressed anywhere else but would it be
>>>>> helpful to add a comment, or indicator as to what the actual sensor is
>>>>> that is represented by this HID?
>>>>>
>>>>> I can make an assumption about what an OVTI2680 might be, but the
>>>>> INT33BE is quite opaque. It's not clear what support that adds.
>>>>>
>>>>> Unless no one cares what the sensor is that is, but I would anticipate
>>>>> anyone looking here to add a new sensor might want to investigate what
>>>>> was already in the table?
>>>> Yeah good point. I'll probably alternate comment and entry then, like:
>>>>
>>>>
>>>> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
>>>> +	/* Sensor OVTI5693 */
>>>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>>>> +	/* Sensor OVTI2680 */
>>>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>>>
>>>> As an inline comment won't fit for the sensors that we know link-frequencies for. That sound ok?
>>> I might put the whole vendor name in, and no need to prefix 'Sensor' IMO.
>>>
>>> +	/* Omnivision OV5693 */
>>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>>> +	/* Omnivision OV2680 */
>>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>>
>>> but otherwise, yes a comment the line before works for me, as you are
>>> right - at the end would not be practical.
>> Works for me
>>>>>> +static void cio2_bridge_create_fwnode_properties(
>>>>>> +	struct cio2_sensor *sensor,
>>>>>> +	const struct cio2_sensor_config *cfg)
>>>>>> +{
>>>>>> +	unsigned int i;
>>>>>> +
>>>>>> +	sensor->prop_names = prop_names;
>>>>>> +
>>>>>> +	for (i = 0; i < CIO2_MAX_LANES; i++)
>>>>>> +		sensor->data_lanes[i] = i + 1;
>>>>> Does something support lane swapping somewhere?
>>>>> I assume this is just mapping each lane directly through.
>>>> I think Sakari said remapping isn't supported in the CIO2 - so yeah this
>>>> is just mapping them directly
>>> So is this needed? Or is it some future compatibility thing?
>>>
>>> I haven't seen where it's used yet, but I'm not too worried about it
>>> though, just not sure what value an array of [1, 2, 3, 4] gives if it's
>>> constant...
>>
>> The endpoints need to have the data-lanes property which passes an array
>> of data lanes, but there may well be a better way of doing this. I'm
>> just using the lanes member of the ssdb data structure to tell the
>> property how many members of the array to look at:
>>
>>
>> +    sensor->cio2_properties[0] = PROPERTY_ENTRY_U32_ARRAY_LEN(
>> +                    sensor->prop_names.data_lanes,
>> +                    sensor->data_lanes,
>> +                    sensor->ssdb.lanes);
>>
>>
>> So if sensor->ssdb.lanes is 2, even though it's passed a pointer to the
>> first member of an array of 4 members, the size calculation of that
>> macro limits it to just those in use. I.E. if sensor->ssdb.lanes is 2
>> then the property will be given the size 2 * sizeof(u32), and so when
>> its parsed only [1, 2] will be read.
> 
> 
> Aha, I see, ok - so we are populating an array of [1, 2, 3, 4] for each
> sensor that we add.
> 
> What about creating the data_lanes once as a const static array and
> mapping to that?
> 
> /*
>  * Map the lane arrangement, which is fixed for the IPU3.
>  */
> static const int data_lanes[CIO2_MAX_LANES] = { 1, 2, 3, 4 };


Can't do exactly this; the bridge needs to store everything on heap
incase the module is unloaded, but I could move the data_lanes array to
the struct cio2_bridge instead of against each sensor and then we're
only doing it once.

> ...
> 
>    sensor->cio2_properties[0] = PROPERTY_ENTRY_U32_ARRAY_LEN(
>                     sensor->prop_names.data_lanes,
>                     data_lanes,
>                     sensor->ssdb.lanes);
> ...
> 
> Then we don't need the loop to populate the array for each sensor
> anymore, or the data_lanes in the sensor struct?
> 

