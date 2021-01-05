Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77BD2EA68B
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbhAEIXo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 03:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAEIXo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 03:23:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162AEC061574;
        Tue,  5 Jan 2021 00:23:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a12so35246618wrv.8;
        Tue, 05 Jan 2021 00:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JtpG5y6lBKffq7UiWFtnl3/EfwEftB5IAC0Ubj5Tr7w=;
        b=FC1F+AksFq3ueToz7y/Ho5P9j3hW0brKRWZMlZpKBYrbTk0fvJBh/r9Vgw2egmY11+
         TwIyOiarwSTcJRfo8o97nMV8sXjbtmdOB092FWFjJWLoAJnsFGZ2mZ3PPbbFX8xk+/1C
         RC61quQjV1wJL1MbA8lJ4gbW2MUJbktUYCGDaDK/ZUXZXPAqp5CsmwB42DnOue8QYFsO
         D4kzWUKvgqfces9HL3ZvPey3uHr6uY0uwHOLo70d89+5bznFpMvkQLHDY/VVfLRp76AJ
         wRyKXTU0Du5BZMm3PSPkCxOP3CoBo17yqsgWXVQOnCIaFNJm49yODU9SmHDmHEBjd8Ao
         ijZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JtpG5y6lBKffq7UiWFtnl3/EfwEftB5IAC0Ubj5Tr7w=;
        b=c1koEdnREGKEDJTgGVaQ5BdgLUlHKSnfFDKFKqJb0FEMZo54KeumU9ykJk1icKw9gv
         tXK58mGFvhZur04RgjnStMT/48z8BXZdmed1mCE1Lf03lx1rV1FkBow8H1gnpm6+DDgB
         RlBJuxpa9TqhR8EaRieTZXBU+daaKGSRlbjMEqmy3sbwpMcVon9fHPGMYwrQrxwZDdWD
         f+oBZW1vqTS6uT6vXo8z626e8kU4wguveMZvchI4i62ixopBicnHtE+lE4ha5z3isUe7
         eHOlnSsUL+2u8Kr23s0CWuYXCqlImj68apFvuL2OzK6eE3EXFgvNMv09jk6+jRhFjZWz
         nYrw==
X-Gm-Message-State: AOAM530geNnWcYvR+Z2USw/5FW3IQ82AuS9dJa7Aho0S91LquCN/vDvt
        Zim3M2LQEJsVH8+CR0C/x7g=
X-Google-Smtp-Source: ABdhPJz29VFPnXexICzXGc+ePnPYId3YahHozpv9w7uYQR9w1dOWfWtfVw7Fykh3aq3IxrkhByovyQ==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr83557214wrq.265.1609834982682;
        Tue, 05 Jan 2021 00:23:02 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id d9sm104672934wrc.87.2021.01.05.00.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 00:23:01 -0800 (PST)
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
 <03dc26d0-39d3-174d-f269-426dbc38e62e@gmail.com>
 <68813554-c479-7354-26d4-df34f53dee32@ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <ce432d1e-6151-1a8b-1f97-f0c1b69b5656@gmail.com>
Date:   Tue, 5 Jan 2021 08:22:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <68813554-c479-7354-26d4-df34f53dee32@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Morning Kieran

On 05/01/2021 06:55, Kieran Bingham wrote:
> Hi Dan,
>
> On 04/01/2021 22:02, Daniel Scally wrote:
>>>>>> On 04/01/2021 13:35, Kieran Bingham wrote:
>>>>>>>> +/*
>>>>>>>> + * Extend this array with ACPI Hardware IDs of devices known to be working
>>>>>>>> + * plus the number of link-frequencies expected by their drivers, along with
>>>>>>>> + * the frequency values in hertz. This is somewhat opportunistic way of adding
>>>>>>>> + * support for this for now in the hopes of a better source for the information
>>>>>>>> + * (possibly some encoded value in the SSDB buffer that we're unaware of)
>>>>>>>> + * becoming apparent in the future.
>>>>>>>> + *
>>>>>>>> + * Do not add an entry for a sensor that is not actually supported.
>>>>>>>> + */
>>>>>>>> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
>>>>>>>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>>>>>>>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>>>>>> I don't know if these are expressed anywhere else but would it be
>>>>>>> helpful to add a comment, or indicator as to what the actual sensor is
>>>>>>> that is represented by this HID?
>>>>>>>
>>>>>>> I can make an assumption about what an OVTI2680 might be, but the
>>>>>>> INT33BE is quite opaque. It's not clear what support that adds.
>>>>>>>
>>>>>>> Unless no one cares what the sensor is that is, but I would anticipate
>>>>>>> anyone looking here to add a new sensor might want to investigate what
>>>>>>> was already in the table?
>>>>>> Yeah good point. I'll probably alternate comment and entry then, like:
>>>>>>
>>>>>>
>>>>>> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
>>>>>> +	/* Sensor OVTI5693 */
>>>>>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>>>>>> +	/* Sensor OVTI2680 */
>>>>>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>>>>>
>>>>>> As an inline comment won't fit for the sensors that we know link-frequencies for. That sound ok?
>>>>> I might put the whole vendor name in, and no need to prefix 'Sensor' IMO.
>>>>>
>>>>> +	/* Omnivision OV5693 */
>>>>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>>>>> +	/* Omnivision OV2680 */
>>>>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>>>>
>>>>> but otherwise, yes a comment the line before works for me, as you are
>>>>> right - at the end would not be practical.
>>>> Works for me
>>>>>>>> +static void cio2_bridge_create_fwnode_properties(
>>>>>>>> +	struct cio2_sensor *sensor,
>>>>>>>> +	const struct cio2_sensor_config *cfg)
>>>>>>>> +{
>>>>>>>> +	unsigned int i;
>>>>>>>> +
>>>>>>>> +	sensor->prop_names = prop_names;
>>>>>>>> +
>>>>>>>> +	for (i = 0; i < CIO2_MAX_LANES; i++)
>>>>>>>> +		sensor->data_lanes[i] = i + 1;
>>>>>>> Does something support lane swapping somewhere?
>>>>>>> I assume this is just mapping each lane directly through.
>>>>>> I think Sakari said remapping isn't supported in the CIO2 - so yeah this
>>>>>> is just mapping them directly
>>>>> So is this needed? Or is it some future compatibility thing?
>>>>>
>>>>> I haven't seen where it's used yet, but I'm not too worried about it
>>>>> though, just not sure what value an array of [1, 2, 3, 4] gives if it's
>>>>> constant...
>>>> The endpoints need to have the data-lanes property which passes an array
>>>> of data lanes, but there may well be a better way of doing this. I'm
>>>> just using the lanes member of the ssdb data structure to tell the
>>>> property how many members of the array to look at:
>>>>
>>>>
>>>> +    sensor->cio2_properties[0] = PROPERTY_ENTRY_U32_ARRAY_LEN(
>>>> +                    sensor->prop_names.data_lanes,
>>>> +                    sensor->data_lanes,
>>>> +                    sensor->ssdb.lanes);
>>>>
>>>>
>>>> So if sensor->ssdb.lanes is 2, even though it's passed a pointer to the
>>>> first member of an array of 4 members, the size calculation of that
>>>> macro limits it to just those in use. I.E. if sensor->ssdb.lanes is 2
>>>> then the property will be given the size 2 * sizeof(u32), and so when
>>>> its parsed only [1, 2] will be read.
>>>
>>> Aha, I see, ok - so we are populating an array of [1, 2, 3, 4] for each
>>> sensor that we add.
>>>
>>> What about creating the data_lanes once as a const static array and
>>> mapping to that?
>>>
>>> /*
>>>  * Map the lane arrangement, which is fixed for the IPU3.
>>>  */
>>> static const int data_lanes[CIO2_MAX_LANES] = { 1, 2, 3, 4 };
>>
>> Can't do exactly this; the bridge needs to store everything on heap
>> incase the module is unloaded, but I could move the data_lanes array to
>> the struct cio2_bridge instead of against each sensor and then we're
>> only doing it once.
> Ahh, yes I remember reading about that already.
>
> It maybe worth adding a comment about that in this file, to prevent
> other people from 'optimising' things out in 5 years ...
>
> It probably doesn't make much difference in that case if it's per sensor
> or per bridge. But indeed at least in the bridge it's only created once.
Yep ok; I moved it there and I'll add a comment explaining why it's done
a bit weird.
> --
> Kieran
>
>
>>> ...
>>>
>>>    sensor->cio2_properties[0] = PROPERTY_ENTRY_U32_ARRAY_LEN(
>>>                     sensor->prop_names.data_lanes,
>>>                     data_lanes,
>>>                     sensor->ssdb.lanes);
>>> ...
>>>
>>> Then we don't need the loop to populate the array for each sensor
>>> anymore, or the data_lanes in the sensor struct?
>>>
