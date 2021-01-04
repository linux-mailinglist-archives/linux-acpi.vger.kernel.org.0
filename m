Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28662E98D7
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 16:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbhADPcX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 10:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbhADPcW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 10:32:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1093C061574;
        Mon,  4 Jan 2021 07:31:41 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w5so32539151wrm.11;
        Mon, 04 Jan 2021 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c2CyyU0YUFW1iVnDDVY/o0T1XBTvxTOxtz0OqLFLmr0=;
        b=NiZ2TvQ677DWrc9C6QupE/Q/BtKeENgCR8GNtZJDxLLPw1E7uThvB5lzKbyrcGTTK7
         QVT04AKvXsdqas1DdILItTwRELq4kFSE1wnmoOZl6kOsdz4wHiwHlyq7nDe8mCqWdT+L
         d2AE5mFUrYRyqrV3oFGnpK27UZJaAEwx8RavUvwlAOtCYbpb6lqtkRiJEzjdGzmEEd3j
         7WOyMSmCNlYL8kc94XklYbdn5jAyhd+AkMH4U5dOwyzCuFNwkU91hfG0pkD8T+NFO+qd
         rQzHnL2+Nbjb3kggsXwLLBn5ZJwf0O+VkEEeWbSSoYF+3XEs+IKf7H2BbEAw2Tm55p7O
         PCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c2CyyU0YUFW1iVnDDVY/o0T1XBTvxTOxtz0OqLFLmr0=;
        b=IqGIBkBIO9fpq4G0BpoRFf1zelHfwqf39KjyrRPwVShKYl6iLiO/ncNwU7PSrA+a0W
         iYjbYKL384xFUI/9xIb3Egw9KOLm24evdStDtANxtzirn08vtD+UQ1TuZESUTlK/o72t
         EeE3JaXZbbpCmBRFf8bIclBwLvVPHEnZ8ztpSWNXGF0sw6VtQG3/SLo9I7Ikeq5qSlUT
         4qVBQLRZXFPlwOlwxQl8+5LP4mWzR5HFTBFcEmDM722j0yfIXVh0xLc//z43U65gJUwV
         kK/wLDbHEc3a7h9w5+hPF/nKSqQe2DG3vw4/2qEywYMOyYzmuUM+5TTeH/xvUWB+DACu
         KJ8Q==
X-Gm-Message-State: AOAM5306VVoqCClv6BZU1uSHSVmsDKe/ECDJC1pp3bHRpDAoUAUjrLUo
        DkIO1XhiC+/J09q05iqerb0=
X-Google-Smtp-Source: ABdhPJwfloBQF3WgJEHKrbDfP46t49akje/HhTrLUndlfuN43AyQ91wpJrmFXceLUPb+bLX4Pw+bHA==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr80613339wrv.37.1609774300746;
        Mon, 04 Jan 2021 07:31:40 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id q1sm89646593wrj.8.2021.01.04.07.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 07:31:39 -0800 (PST)
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
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <b85c0e71-6068-de43-1b80-97c519eeb9c4@gmail.com>
Date:   Mon, 4 Jan 2021 15:31:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <249b8ad1-5616-596d-4ee6-efcfdda2ca64@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Kieran

On 04/01/2021 15:13, Kieran Bingham wrote:
> Hi Dan,
>
> On 04/01/2021 13:55, Daniel Scally wrote:
>> Hi Kieran
>>
>> On 04/01/2021 13:35, Kieran Bingham wrote:
>>>> +/*
>>>> + * Extend this array with ACPI Hardware IDs of devices known to be working
>>>> + * plus the number of link-frequencies expected by their drivers, along with
>>>> + * the frequency values in hertz. This is somewhat opportunistic way of adding
>>>> + * support for this for now in the hopes of a better source for the information
>>>> + * (possibly some encoded value in the SSDB buffer that we're unaware of)
>>>> + * becoming apparent in the future.
>>>> + *
>>>> + * Do not add an entry for a sensor that is not actually supported.
>>>> + */
>>>> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
>>>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>>>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>> I don't know if these are expressed anywhere else but would it be
>>> helpful to add a comment, or indicator as to what the actual sensor is
>>> that is represented by this HID?
>>>
>>> I can make an assumption about what an OVTI2680 might be, but the
>>> INT33BE is quite opaque. It's not clear what support that adds.
>>>
>>> Unless no one cares what the sensor is that is, but I would anticipate
>>> anyone looking here to add a new sensor might want to investigate what
>>> was already in the table?
>> Yeah good point. I'll probably alternate comment and entry then, like:
>>
>>
>> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
>> +	/* Sensor OVTI5693 */
>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>> +	/* Sensor OVTI2680 */
>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>>
>> As an inline comment won't fit for the sensors that we know link-frequencies for. That sound ok?
> I might put the whole vendor name in, and no need to prefix 'Sensor' IMO.
>
> +	/* Omnivision OV5693 */
> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
> +	/* Omnivision OV2680 */
> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
>
> but otherwise, yes a comment the line before works for me, as you are
> right - at the end would not be practical.
Works for me
>>>> +static void cio2_bridge_create_fwnode_properties(
>>>> +	struct cio2_sensor *sensor,
>>>> +	const struct cio2_sensor_config *cfg)
>>>> +{
>>>> +	unsigned int i;
>>>> +
>>>> +	sensor->prop_names = prop_names;
>>>> +
>>>> +	for (i = 0; i < CIO2_MAX_LANES; i++)
>>>> +		sensor->data_lanes[i] = i + 1;
>>> Does something support lane swapping somewhere?
>>> I assume this is just mapping each lane directly through.
>> I think Sakari said remapping isn't supported in the CIO2 - so yeah this
>> is just mapping them directly
> So is this needed? Or is it some future compatibility thing?
>
> I haven't seen where it's used yet, but I'm not too worried about it
> though, just not sure what value an array of [1, 2, 3, 4] gives if it's
> constant...

The endpoints need to have the data-lanes property which passes an array
of data lanes, but there may well be a better way of doing this. I'm
just using the lanes member of the ssdb data structure to tell the
property how many members of the array to look at:


+    sensor->cio2_properties[0] = PROPERTY_ENTRY_U32_ARRAY_LEN(
+                    sensor->prop_names.data_lanes,
+                    sensor->data_lanes,
+                    sensor->ssdb.lanes);


So if sensor->ssdb.lanes is 2, even though it's passed a pointer to the
first member of an array of 4 members, the size calculation of that
macro limits it to just those in use. I.E. if sensor->ssdb.lanes is 2
then the property will be given the size 2 * sizeof(u32), and so when
its parsed only [1, 2] will be read.

