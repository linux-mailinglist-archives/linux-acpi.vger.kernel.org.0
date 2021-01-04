Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E042E956B
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 14:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhADNBI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 08:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbhADNBH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 08:01:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276F0C061574;
        Mon,  4 Jan 2021 05:00:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m5so32034721wrx.9;
        Mon, 04 Jan 2021 05:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yUSkEu4lGmCervkfJjuKF5lqMKOD9UYsJ21YQPlNxDc=;
        b=BFd2VIB8t/OIKdnPaQavNdz/098etQaF8TWPHinKBCx4S9OGkEKVGTg14FAAywQVX1
         GsfWXz4Zj3GElXMMssN7QLZDON+SBl5kYIua7KLAGO+l5C4bCJUW5WKSDlmOJ/SuN6Kq
         UhLpsnyIUUVBg0wd9L2vML+q4+ltRalRCv/5LILkCFUlphq81GIWBTmIXn2QVzp5gwUM
         BhcwIgqRNauocOmKQF18/NkJyzWBGkFSayBbFtarznnP+uqIKNGWQKPyl/OWWCw8qqt/
         dsd+Z7t+tYwQ5ihlHrg9XJbUWGhPkRx/8k38a5n00dRyhcGKnMabgEas1vqq+/Yfi85R
         PUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yUSkEu4lGmCervkfJjuKF5lqMKOD9UYsJ21YQPlNxDc=;
        b=hcKW1wyrEdfbccH7l1/IiZXtbc1fDW8nWOlsUbhVCuw1b6jHWa95gghcB9QbscbjVN
         7QZyylrP2o8hljP/oObpAdD7J1m5N6ZxhpQxVrJ4OQRT/uxAhV/XwHYt6x7lm41dHv7E
         UHOdsvp9a18k/EBEJBkBp7JJrbKQjPQyR4V/Z+NOt0RTzx8mICDTlNsDTnNPPP6RmVDw
         TFixv6aliWFLk/3A+y4ED5EGvb3W0siYtRvZgR6klevEt0gGUCmsjSZgara6FpVycShu
         1kWKKIybu2n6d0zd8e255dOGQMwEg541gpIDi2opk2Z2snDXL8XBY81Vn+6zsEsutZ60
         EsyQ==
X-Gm-Message-State: AOAM5330qsd8gre/OwyZZhe8OJvpywD+QJ3C56ZMM8zXKxjiviJVwqIg
        RTxk912+XoMS4CqjFdMshf8=
X-Google-Smtp-Source: ABdhPJzzElzWCLuOAZX/aveakTw9Mro3YlY3O9EV9OSeH/Ie5WqkuTdf70o8VBKvuDNyMUPUBkNZfQ==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr79763062wru.84.1609765225908;
        Mon, 04 Jan 2021 05:00:25 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id x25sm32596429wmc.3.2021.01.04.05.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 05:00:25 -0800 (PST)
Subject: Re: [PATCH v4 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org, lenb@kernel.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
 <20210103231235.792999-16-djrscally@gmail.com>
 <20210104120905.GR4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <2f64873d-0413-3614-34e2-139b4a4d9da6@gmail.com>
Date:   Mon, 4 Jan 2021 13:00:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104120905.GR4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 04/01/2021 12:09, Andy Shevchenko wrote:
> On Sun, Jan 03, 2021 at 11:12:35PM +0000, Daniel Scally wrote:
>> Currently on platforms designed for Windows, connections between CIO2 and
>> sensors are not properly defined in DSDT. This patch extends the ipu3-cio2
>> driver to compensate by building software_node connections, parsing the
>> connection properties from the sensor's SSDB buffer.
> Few nitpicks below (I consider it's good enough as is, though).
Thanks!
>> +static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>> +				      struct cio2_bridge *bridge,
>> +				      struct pci_dev *cio2)
>> +{
>> +	struct fwnode_handle *fwnode;
>> +	struct cio2_sensor *sensor;
>> +	struct acpi_device *adev;
>> +	int ret;
>> +	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> (1)
>
>> +		if (bridge->n_sensors >= CIO2_NUM_PORTS) {
>> +			dev_err(&cio2->dev, "Exceeded available CIO2 ports\n");
>> +			cio2_bridge_unregister_sensors(bridge);
>> +			ret = -EINVAL;
>> +			goto err_out;
>> +		}
>> +		if (!adev->status.enabled)
>> +			continue;
> A nit: this would be better to be at (1) location.


Yep, agreed

>
> Then possible to factor out the rest of the body of this loop as well.
>
> (Also can be considered as a hint for the future improvement)
Yeah I can look at this, there will probably be some future changes
anyway as we discover more details about the data in the SSDB buffer and
so on
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
> new file mode 100644
> index 000000000000..3ec4ed44aced
> --- /dev/null
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
> @@ -0,0 +1,125 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Author: Dan Scally <djrscally@gmail.com> */
> +#ifndef __CIO2_BRIDGE_H
> +#define __CIO2_BRIDGE_H
> +
> +#include <linux/property.h>
> +#include <linux/types.h>
> +
> +#include "ipu3-cio2.h"
> +
> +#define CIO2_HID				"INT343E"
> +#define CIO2_MAX_LANES				4
> +#define MAX_NUM_LINK_FREQS			3
> +
> +#define CIO2_SENSOR_CONFIG(_HID, _NR, ...)	\
> +	{					\
> +		.hid = _HID,			\
> +		.nr_link_freqs = _NR,		\
> +		.link_freqs = { __VA_ARGS__ }	\
> +	}
> Perhaps also good to declare it as a compound literal.
>
> (Means to add (struct ...) to the initializer.
>
Yep ok
>> +#define NODE_SENSOR(_HID, _PROPS)		\
>> +	((const struct software_node) {		\
>> +		.name = _HID,			\
>> +		.properties = _PROPS,		\
>> +	})
>> +
>> +#define NODE_PORT(_PORT, _SENSOR_NODE)		\
>> +	((const struct software_node) {		\
>> +		.name = _PORT,			\
>> +		.parent = _SENSOR_NODE,		\
>> +	})
>> +
>> +#define NODE_ENDPOINT(_EP, _PORT, _PROPS)	\
>> +	((const struct software_node) {		\
>> +		.name = _EP,			\
>> +		.parent = _PORT,		\
>> +		.properties = _PROPS,		\
>> +	})
> In all three I didn't get why you need outer parentheses. Without them it will
> be well defined compound literal and should work as is.
The code works fine, but checkpatch complains that macros with complex
values should be enclosed in parentheses. I guess now that I'm more
familiar with the code I'd call that a false-positive though, as nowhere
else in the kernel that I've seen encloses them the same way.
>>  static int cio2_pci_probe(struct pci_dev *pci_dev,
>>  			  const struct pci_device_id *id)
>>  {
>> +	struct fwnode_handle *fwnode = dev_fwnode(&pci_dev->dev);
>>  	struct cio2_device *cio2;
>>  	int r;
>>  
>> @@ -1715,6 +1732,22 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
>>  		return -ENOMEM;
>>  	cio2->pci_dev = pci_dev;
>>  
>> +	/*
>> +	 * On some platforms no connections to sensors are defined in firmware,
>> +	 * if the device has no endpoints then we can try to build those as
>> +	 * software_nodes parsed from SSDB.
>> +	 */
>> +	if (!cio2_check_fwnode_graph(fwnode)) {
> A nit:
> I prefer form of
>
> 	r = cio2_check_fwnode_graph(fwnode);
> 	if (!r) { // alternatively if (r == 0), depends on maintainer's taste
This is fine by me; I can switch to that
>
>> +		if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary)) {
>> +			dev_err(&pci_dev->dev, "fwnode graph has no endpoints connected\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		r = cio2_bridge_init(pci_dev);
>> +		if (r)
>> +			return r;
>> +	}
>> +
>>  	r = pcim_enable_device(pci_dev);
>>  	if (r) {
>>  		dev_err(&pci_dev->dev, "failed to enable device (%d)\n", r);
>> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.h b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
>> index 62187ab5ae43..dc3e343a37fb 100644
>> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
>> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
>> @@ -455,4 +455,10 @@ static inline struct cio2_queue *vb2q_to_cio2_queue(struct vb2_queue *vq)
>>  	return container_of(vq, struct cio2_queue, vbq);
>>  }
>>  
>> +#if IS_ENABLED(CONFIG_CIO2_BRIDGE)
>> +int cio2_bridge_init(struct pci_dev *cio2);
>> +#else
>> +int cio2_bridge_init(struct pci_dev *cio2) { return 0; }
> static inline?

Ah, yes - thanks. Hadn't read about inline until now

