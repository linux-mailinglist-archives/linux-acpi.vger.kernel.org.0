Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF822DEC5B
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Dec 2020 01:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgLSAX2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 19:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgLSAX2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 19:23:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63EFC06138C;
        Fri, 18 Dec 2020 16:22:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k10so4101581wmi.3;
        Fri, 18 Dec 2020 16:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OncieEgm0eepoRss7G4i5BdrIAEupa2Kt6PNDbhIljY=;
        b=ZyPlwQg+U8unAghXms7NL7LOS/en136C7hTf8/n2MkYg+gE8XCSpuNx67HmykTMCto
         6OxtAKVxazMPhkdFOUrbhgdsXDV4qNDQgehkiZFVdo5Ie2au2NveAkLRMQs6lz5e411x
         lwXQrrM0SGdqwUrXzecRdmMOZaw7m/cTbeOqds+9VaMj2Ja8iK3/MUSJFm6gMiGJypXV
         9nJah/Jav52eMPN1xAiMQK1J1yue/VUwH3VufysBbSc/AWotEBW8aF2lmAF8KYJPP228
         FKxRamGIMcFf5+YWsC/DBlCiGEC/XbdoXGvqQWJEqVRhbn0NSTix7r3vWyQ2kEaUY/Io
         ABxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OncieEgm0eepoRss7G4i5BdrIAEupa2Kt6PNDbhIljY=;
        b=PnPgQRWx4LQgl1Mj7+MweCjb8c239ZfBztMzoVilpEzdVtxYyS/qK/t5yUOvKl2Dg4
         H1eD/uNhRZ3ETbeAG0PlGdxstvIkT/0JJYeSd9CRN628+d+s2Jgawo59isYqAduiIolU
         jQeaT/vIvoa06p9Y26ew0Fb/AXkW2ElwUCYI21Ift/SjB8kR1fn7ciyEh0OmPNE6dgxP
         UTYvkqNTXP52RjEVeRTN1JDLeFJSDMNC860k0fgw49ojVAsKYn8LzbbGdzDbhmcH7YZn
         6UQBButxCMbe9al3ET2eZFay0nBEJ+Ss1rQvNo+RNynOOWKSlBi2+kRfk4fAGYdeH7Li
         J15w==
X-Gm-Message-State: AOAM533bp9PCvHhMQcmtYtar8R1aCpLDBaIUJ/sdlEPT1zfLXFu2FNkO
        BYG0/eS2IVPTUedtvdaYUL4=
X-Google-Smtp-Source: ABdhPJyY/gCg5cjMyRe1orufLTyKi8MrwWW1nNPj2bBgfMOK3DTkAgHGLR5obZqJXBndEJLbrd6oUw==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr6090422wmh.111.1608337366384;
        Fri, 18 Dec 2020 16:22:46 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id x18sm18300760wrg.55.2020.12.18.16.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 16:22:45 -0800 (PST)
Subject: Re: [PATCH v2 12/12] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-13-djrscally@gmail.com>
 <20201218211732.GE4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <e2b4c35f-5020-c332-d97a-8ba25be0e55e@gmail.com>
Date:   Sat, 19 Dec 2020 00:22:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218211732.GE4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy, thanks for the comments

On 18/12/2020 21:17, Andy Shevchenko wrote:
> On Thu, Dec 17, 2020 at 11:43:37PM +0000, Daniel Scally wrote:
>> Currently on platforms designed for Windows, connections between CIO2 and
>> sensors are not properly defined in DSDT. This patch extends the ipu3-cio2
>> driver to compensate by building software_node connections, parsing the
>> connection properties from the sensor's SSDB buffer.
> 
> ...
> 
>> +	sensor->ep_properties[0] = PROPERTY_ENTRY_U32(sensor->prop_names.bus_type, 4);
> 
> Does 4 has any meaning that can be described by #define ?

It's V4L2_FWNODE_BUS_TYPE_CSI2_DPHY:

https://elixir.bootlin.com/linux/latest/source/drivers/media/v4l2-core/v4l2-fwnode.c#L36

That enum's not in an accessible header, but I can define it in this
module's header

>> +static void cio2_bridge_init_swnode_names(struct cio2_sensor *sensor)
>> +{
>> +	snprintf(sensor->node_names.remote_port, 7, "port@%u", sensor->ssdb.link);
> 
> Hmm... I think you should use actual size of remote_port instead of 7.

Yes ok


>> +	strscpy(sensor->node_names.port, "port@0", sizeof(sensor->node_names.port));
> 
> Yeah, I would rather like to see one point of the definition of the format.
> If it's the same as per OF case, perhaps some generic header (like fwnode.h?) is good for this?
> In this case the 5 in one of the previous patches Also can be derived from the format.

Okedokey. It is indeed intended to match OF and ACPI case, both of which
mandate that format (though only ACPI's functions seem to enforce it).
fwnode.h seems as good a place as any to me, though I'm not sure there's
anywhere in the driver code for OF or ACPI that would actually use it at
the moment.

>> +	strscpy(sensor->node_names.endpoint, "endpoint@0", sizeof(sensor->node_names.endpoint));
> 
> Similar here.
> 
>> +}
> 
> ...
> 
>> +	for (i = 0; i < ARRAY_SIZE(cio2_supported_sensors); i++) {
>> +		const struct cio2_sensor_config *cfg = &cio2_supported_sensors[i];
>> +
>> +		for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> 
>> +			if (bridge->n_sensors >= CIO2_NUM_PORTS) {
>> +				dev_warn(&cio2->dev, "Exceeded available CIO2 ports\n");
> 
>> +				/* overflow i so outer loop ceases */
>> +				i = ARRAY_SIZE(cio2_supported_sensors);
>> +				break;
> 
> Why not to create a new label below and assign ret here with probably comment
> why it's not an error?

Sure, I can do that, but since it wouldn't need any cleanup I could also
just return 0 here as Laurent suggest (but with a comment explaining why
that's ok as you say) - do you have a preference?

>> +			}
> 
> ...
> 
>> +			ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
>> +							   &sensor->ssdb,
>> +							   sizeof(sensor->ssdb));
>> +			if (ret < 0)
> 
> if (ret) (because positive case can be returned just by next conditional).

cio2_bridge_read_acpi_buffer() returns the buffer length on success at
the moment, but I can change it to return 0 and have this be if (ret)

>> +				goto err_put_adev;
>> +
>> +			if (sensor->ssdb.lanes > 4) {
>> +				dev_err(&adev->dev,
>> +					"Number of lanes in SSDB is invalid\n");
>> +				goto err_put_adev;
>> +			}
> 
> ...
> 
>> +			dev_info(&cio2->dev, "Found supported sensor %s\n",
>> +				 acpi_dev_name(adev));
>> +
>> +			bridge->n_sensors++;
>> +		}
>> +	}
> 
> 	return 0;

Okedokey

> 
>> +err_free_swnodes:
>> +	software_node_unregister_nodes(sensor->swnodes);
>> +err_put_adev:
>> +	acpi_dev_put(sensor->adev);
> 
> err_out:

Depends on question above I think

>> +	return ret;
>> +}
> 
> ...
> 
>> +enum cio2_sensor_swnodes {
>> +	SWNODE_SENSOR_HID,
>> +	SWNODE_SENSOR_PORT,
>> +	SWNODE_SENSOR_ENDPOINT,
>> +	SWNODE_CIO2_PORT,
>> +	SWNODE_CIO2_ENDPOINT,
> 
>> +	NR_OF_SENSOR_SWNODES
> 
> Perhaps same namespace, i.e.
> 
> 	SWNODE_SENSOR_NR

Yep, will do.

Thanks
Dan

