Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6E2E9AD1
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbhADQOW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 11:14:22 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:57864 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbhADQOV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 11:14:21 -0500
Received: from [192.168.0.20] (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2C0A32E0;
        Mon,  4 Jan 2021 17:13:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1609776817;
        bh=tBO6/vy63OMHcgEJzQHG0zb8EpUFO8rmJl7CgaObhFs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CezDxqU1xjoKhg3UnPmUebPyFnZcWUVfF081DSthSQGNXZHa1zlfytFjkqChOgBn/
         01TjyPEdgDyP7FhNvMKbTSNh2xqbxAsheVM5B2WZu3yd8NhTLrAVf5XXlp7effFFrS
         2RZgEDgsjn+W+Ly0PJjTSNiW5/zpHwHccTfgO/HA=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH v4 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
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
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 WZw01QYHU/GUV/zHJSFk
Organization: Ideas on Board
Message-ID: <b0a99dba-4176-009a-07c7-7ad6701c2b48@ideasonboard.com>
Date:   Mon, 4 Jan 2021 16:13:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b85c0e71-6068-de43-1b80-97c519eeb9c4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dan,

On 04/01/2021 15:31, Daniel Scally wrote:
> Hi Kieran
> 
> On 04/01/2021 15:13, Kieran Bingham wrote:
>> Hi Dan,
>>
>> On 04/01/2021 13:55, Daniel Scally wrote:
>>> Hi Kieran
>>>
>>> On 04/01/2021 13:35, Kieran Bingham wrote:
>>>>> +/*
>>>>> + * Extend this array with ACPI Hardware IDs of devices known to be working
>>>>> + * plus the number of link-frequencies expected by their drivers, along with
>>>>> + * the frequency values in hertz. This is somewhat opportunistic way of adding
>>>>> + * support for this for now in the hopes of a better source for the information
>>>>> + * (possibly some encoded value in the SSDB buffer that we're unaware of)
>>>>> + * becoming apparent in the future.
>>>>> + *
>>>>> + * Do not add an entry for a sensor that is not actually supported.
>>>>> + */
>>>>> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
>>>>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>>>>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>>> I don't know if these are expressed anywhere else but would it be
>>>> helpful to add a comment, or indicator as to what the actual sensor is
>>>> that is represented by this HID?
>>>>
>>>> I can make an assumption about what an OVTI2680 might be, but the
>>>> INT33BE is quite opaque. It's not clear what support that adds.
>>>>
>>>> Unless no one cares what the sensor is that is, but I would anticipate
>>>> anyone looking here to add a new sensor might want to investigate what
>>>> was already in the table?
>>> Yeah good point. I'll probably alternate comment and entry then, like:
>>>
>>>
>>> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
>>> +	/* Sensor OVTI5693 */
>>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>>> +	/* Sensor OVTI2680 */
>>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>>
>>> As an inline comment won't fit for the sensors that we know link-frequencies for. That sound ok?
>> I might put the whole vendor name in, and no need to prefix 'Sensor' IMO.
>>
>> +	/* Omnivision OV5693 */
>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>> +	/* Omnivision OV2680 */
>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>
>> but otherwise, yes a comment the line before works for me, as you are
>> right - at the end would not be practical.
> Works for me
>>>>> +static void cio2_bridge_create_fwnode_properties(
>>>>> +	struct cio2_sensor *sensor,
>>>>> +	const struct cio2_sensor_config *cfg)
>>>>> +{
>>>>> +	unsigned int i;
>>>>> +
>>>>> +	sensor->prop_names = prop_names;
>>>>> +
>>>>> +	for (i = 0; i < CIO2_MAX_LANES; i++)
>>>>> +		sensor->data_lanes[i] = i + 1;
>>>> Does something support lane swapping somewhere?
>>>> I assume this is just mapping each lane directly through.
>>> I think Sakari said remapping isn't supported in the CIO2 - so yeah this
>>> is just mapping them directly
>> So is this needed? Or is it some future compatibility thing?
>>
>> I haven't seen where it's used yet, but I'm not too worried about it
>> though, just not sure what value an array of [1, 2, 3, 4] gives if it's
>> constant...
> 
> The endpoints need to have the data-lanes property which passes an array
> of data lanes, but there may well be a better way of doing this. I'm
> just using the lanes member of the ssdb data structure to tell the
> property how many members of the array to look at:
> 
> 
> +    sensor->cio2_properties[0] = PROPERTY_ENTRY_U32_ARRAY_LEN(
> +                    sensor->prop_names.data_lanes,
> +                    sensor->data_lanes,
> +                    sensor->ssdb.lanes);
> 
> 
> So if sensor->ssdb.lanes is 2, even though it's passed a pointer to the
> first member of an array of 4 members, the size calculation of that
> macro limits it to just those in use. I.E. if sensor->ssdb.lanes is 2
> then the property will be given the size 2 * sizeof(u32), and so when
> its parsed only [1, 2] will be read.


Aha, I see, ok - so we are populating an array of [1, 2, 3, 4] for each
sensor that we add.

What about creating the data_lanes once as a const static array and
mapping to that?

/*
 * Map the lane arrangement, which is fixed for the IPU3.
 */
static const int data_lanes[CIO2_MAX_LANES] = { 1, 2, 3, 4 };


...

   sensor->cio2_properties[0] = PROPERTY_ENTRY_U32_ARRAY_LEN(
                    sensor->prop_names.data_lanes,
                    data_lanes,
                    sensor->ssdb.lanes);
...

Then we don't need the loop to populate the array for each sensor
anymore, or the data_lanes in the sensor struct?

-- 
Regards
--
Kieran
