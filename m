Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230EA2DF217
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Dec 2020 00:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgLSXZd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 19 Dec 2020 18:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgLSXZc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Dec 2020 18:25:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8CC0613CF;
        Sat, 19 Dec 2020 15:24:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v14so6253350wml.1;
        Sat, 19 Dec 2020 15:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b0TK+e8Qjjv1MixV6HMg5PDHcj6mTSKLtcNqevp3glo=;
        b=s5lTyfVHYAPCC8r+MPcSHNyRX6QnVvFCRtchbVXuCm6w6zQzDzLp09e3OnUAFqx2IP
         exEsNJr2df/PQ8vpA+/yZsxacCIuIjjrOlg7cXC/IFdXR9+VguOh9sYW7q/scnJVH6E3
         yuk7JM9+I8STzEpPc/8tEgjn+anJ2qNlCJ3djw4aPQupePPpP1O+ydehYT7wDP0JfLVo
         R+KtTicLUWrAp55Ooq1sjjgHydA3739lNXjZ1UzJKDEi2Nu6F2I9CP3Ig3iq9iKrUvH6
         YkS0V/XK+VpbJuyJHOoQfutSRGlGlQoALaFWca7Agt6ekwCVAmeTR6lNqmYQ02qA+V3l
         1oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b0TK+e8Qjjv1MixV6HMg5PDHcj6mTSKLtcNqevp3glo=;
        b=CLvtdLJdJfj/9qj9SexJiwrQTSBfXqkujU05QXg7pCjmtcTaCM2oZ0m7JMzBTpIUDm
         FCn9zqkN5nm7XPrXcz/6g+CsLzjqpN2DfoEBQAg06QF93g+ys5wlbOObjexc4QscyTcZ
         oLMEM3+H5zAaC1sumGGu5PXSepCVUiuhCspnmNgPfjgX5mQIX9QEg3eTdFoasC4RLE5V
         5q5TcHtVo87qJaMPrXgMRc5Hp5G88K3TZpQ2ll08prrxDrJhFv7rE7MMsYOWTe2XFB3g
         YIvo+NeJRtBA353dga29WsBBkj5uSZqy7rKoaOUU3GswXOAPG0EFIIviYBVESxJndOOX
         ECNQ==
X-Gm-Message-State: AOAM531ZB+bfcXtqz17FuSxpCDZPMS2oKW8KXtTwsuJjsDw7sZWOtLRc
        OWvtUUWjpWL4pxP0YrY8EL0=
X-Google-Smtp-Source: ABdhPJw2c1Pa8dqLQOTk1GNNIo4kFBuMGzfpICg6aEdfwvrKvLLN7AXXMrFpf4QsFGSop2tPpJrvFQ==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr9731950wmc.156.1608420290111;
        Sat, 19 Dec 2020 15:24:50 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b7sm14238305wru.33.2020.12.19.15.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 15:24:49 -0800 (PST)
Subject: Re: [PATCH v2 12/12] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-13-djrscally@gmail.com>
 <X9zehD1xtQP/bxXu@pendragon.ideasonboard.com>
 <5c0ae9f8-ba58-a26c-400b-7d85d01087a3@gmail.com>
 <X91Lum0ZPDjo1cTt@pendragon.ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <5515a4df-d224-1279-ab8d-40b848a74c38@gmail.com>
Date:   Sat, 19 Dec 2020 23:24:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X91Lum0ZPDjo1cTt@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 19/12/2020 00:39, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Fri, Dec 18, 2020 at 11:57:54PM +0000, Daniel Scally wrote:
>> Hi Laurent - thanks for the comments
>>
>> On 18/12/2020 16:53, Laurent Pinchart wrote:
>>>> +static void cio2_bridge_init_property_names(struct cio2_sensor *sensor)
>>>> +{
>>>> +	strscpy(sensor->prop_names.clock_frequency, "clock-frequency",
>>>> +		sizeof(sensor->prop_names.clock_frequency));
>>>> +	strscpy(sensor->prop_names.rotation, "rotation",
>>>> +		sizeof(sensor->prop_names.rotation));
>>>> +	strscpy(sensor->prop_names.bus_type, "bus-type",
>>>> +		sizeof(sensor->prop_names.bus_type));
>>>> +	strscpy(sensor->prop_names.data_lanes, "data-lanes",
>>>> +		sizeof(sensor->prop_names.data_lanes));
>>>> +	strscpy(sensor->prop_names.remote_endpoint, "remote-endpoint",
>>>> +		sizeof(sensor->prop_names.remote_endpoint));
>>>> +	strscpy(sensor->prop_names.link_frequencies, "link-frequencies",
>>>> +		sizeof(sensor->prop_names.link_frequencies));
>>>
>>> Just curious, was there anything not working correctly with the proposal
>>> I made ?
>>>
>>> static const struct cio2_property_names prop_names = {
>>> 	.clock_frequency = "clock-frequency",
>>> 	.rotation = "rotation",
>>> 	.bus_type = "bus-type",
>>> 	.data_lanes = "data-lanes",
>>> 	.remote_endpoint = "remote-endpoint",
>>> };
>>>
>>> static void cio2_bridge_init_property_names(struct cio2_sensor *sensor)
>>> {
>>> 	sensor->prop_names = prop_names;
>>> }
>>>
>>> It generates a warning when the string is too long for the field size,
>>> which should help catching issues at compilation time.
>>
>> Yes, though I don't know how much of a real-world problem it would have
>> been - if you recall we have the issue that the device grabs a reference
>> to the software_nodes (after we stopped delaying until after the
>> i2c_client is available), which means we can't safely free the
>> cio2_bridge struct on module unload. That also means we can't rely on
>> those pointers to string literals existing, because if the ipu3-cio2
>> module gets unloaded they'll be gone.
> 
> But the strings above are not stored as literals in .rodata, they're
> copied in prop_names (itself in .rodata), which is then copied to
> sensor->prop_names.

Yeah, my bad; I also had changed the struct definition to:

struct cio2_property_names {
	char *clock_frequency;
	...
};

And that behaves differently - apologies. I'll change to your proposal.
