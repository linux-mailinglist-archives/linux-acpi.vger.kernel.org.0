Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FCF2E966E
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 14:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhADN4l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 08:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADN4l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 08:56:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462AC061574;
        Mon,  4 Jan 2021 05:56:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i9so32258898wrc.4;
        Mon, 04 Jan 2021 05:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CCvC21o9OsNFmgIrFS9AYf7dFaGLBEiMu0yr8eIRMIU=;
        b=DEupxNit6gyIpbepsZC6hVsP7vcOAq9v32qn8wJm32kcamwEXhOUXlhbl5L3BsuJK5
         3v8YzfjiyohG0RsVSmPBFQCwgmJ4hh+tRLzxK3bvA776WIuBfoAoREaQcWMi7PDDJy+s
         mqW44us/HCI2TQDxRaHafsCV2Lt0PZpp8FkWh1ep8URJ9JymJw64Rli8FRQ9P9jZd3Gw
         R9rs3P6IWWSdwII3VHFwZx6ophrdcdv8kW+i9uZEj9qmNsoHoPHOidS+lKSII0vQuKQF
         dXKNmDZbINRhc+FUKfjf6+nvvcjU5QJbiyoeIhRXIckGB5ZCz9NpRbCgpl9pKyCdMV7i
         KNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CCvC21o9OsNFmgIrFS9AYf7dFaGLBEiMu0yr8eIRMIU=;
        b=b5VcgV777vXR5qmzmvlWZCdmVXHb33j89Ggtlf+xBv8IojBbxfVIR11DV30JGgFoLk
         /qyxqJuDzbHjZABSaRNjqRpy/NQMXeMdOvesiFJ202wStoDBxZhwLjU8ZH9+LpvlIdpD
         htOsRtrQ3vvdsRcrb8roVW3YX64jA/Ycy6IS2BDgA9hbv528D3GYFfr4PI7OKOqrhF8D
         YwpEAu8uVelWN8u5H94Vpv6+wCVMrWPY1TCMdBiUcpVEnHT9njpD5VFOhMCreheE2Rnf
         rnafL0XokcnBMFHRq3P4g5FzXv3Rhru5WayaPPQztIWQY3LHyqzUatqDxCB/uvZp7Lw+
         3G0g==
X-Gm-Message-State: AOAM532RDutEXULCBCd7WG9iyMrLtFJuP4MFxbSMZQtVR4Ag7FTrIe50
        tM+YdGI7YH8dCpmP1Jc5HbY=
X-Google-Smtp-Source: ABdhPJy2qULUem6CigST3WkOD65aKMFtRUq9Mxf6BDbNL0ehCvca8zkraANPX7kaKxUov6zg1eXB9g==
X-Received: by 2002:a5d:464b:: with SMTP id j11mr80173026wrs.227.1609768559273;
        Mon, 04 Jan 2021 05:55:59 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id k1sm90550691wrn.46.2021.01.04.05.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 05:55:58 -0800 (PST)
Subject: Re: [PATCH v4 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     kieran.bingham+renesas@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
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
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <9026519f-1f33-9df0-de18-0881069f7aaa@gmail.com>
Date:   Mon, 4 Jan 2021 13:55:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3d881e2b-747f-dcd7-a0cf-e7309419914b@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Kieran

On 04/01/2021 13:35, Kieran Bingham wrote:
>> +/*
>> + * Extend this array with ACPI Hardware IDs of devices known to be working
>> + * plus the number of link-frequencies expected by their drivers, along with
>> + * the frequency values in hertz. This is somewhat opportunistic way of adding
>> + * support for this for now in the hopes of a better source for the information
>> + * (possibly some encoded value in the SSDB buffer that we're unaware of)
>> + * becoming apparent in the future.
>> + *
>> + * Do not add an entry for a sensor that is not actually supported.
>> + */
>> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
>> +	CIO2_SENSOR_CONFIG("INT33BE", 0),
>> +	CIO2_SENSOR_CONFIG("OVTI2680", 0),
> I don't know if these are expressed anywhere else but would it be
> helpful to add a comment, or indicator as to what the actual sensor is
> that is represented by this HID?
>
> I can make an assumption about what an OVTI2680 might be, but the
> INT33BE is quite opaque. It's not clear what support that adds.
>
> Unless no one cares what the sensor is that is, but I would anticipate
> anyone looking here to add a new sensor might want to investigate what
> was already in the table?

Yeah good point. I'll probably alternate comment and entry then, like:


+static const struct cio2_sensor_config cio2_supported_sensors[] = {
+	/* Sensor OVTI5693 */
+	CIO2_SENSOR_CONFIG("INT33BE", 0),
+	/* Sensor OVTI2680 */
+	CIO2_SENSOR_CONFIG("OVTI2680", 0),

As an inline comment won't fit for the sensors that we know link-frequencies for. That sound ok?

>> +static void cio2_bridge_create_fwnode_properties(
>> +	struct cio2_sensor *sensor,
>> +	const struct cio2_sensor_config *cfg)
>> +{
>> +	unsigned int i;
>> +
>> +	sensor->prop_names = prop_names;
>> +
>> +	for (i = 0; i < CIO2_MAX_LANES; i++)
>> +		sensor->data_lanes[i] = i + 1;
> Does something support lane swapping somewhere?
> I assume this is just mapping each lane directly through.

I think Sakari said remapping isn't supported in the CIO2 - so yeah this
is just mapping them directly

> Otherwise, I'm quite looking forwards to all of this ;-)
>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Thanks very much!
