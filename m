Return-Path: <linux-acpi+bounces-7108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BA93F0EB
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55090282E8A
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 09:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CFC13DDAF;
	Mon, 29 Jul 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN9CfDdA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776E13B783;
	Mon, 29 Jul 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245033; cv=none; b=ug38GetPSZs6V32S+0LGzx63G5KdY7diP9l1LeHKEReQvE0mtEMittEUjCvBndvBASj9b6xGzgbroqF+g0CAquU5nXZ5yy6qyzJ9Hmlpq5Dy7TEgDEdqFcpu3OciqV7fiJNFaBfwiDXyyevlqyIwgEdIudR32bdUGwF6V7ZAPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245033; c=relaxed/simple;
	bh=XKN7XFfEIp2MjF6RtZI622rgCm1T1kZTq0UGNj31nmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEhCyPM4wEfHnILQ5ko7MgsV1LJzT7SxoXKanwKKjDeZvGa8GjUOIerJuQS3Dch/xsuFJLuMDR9gqxUUzC/Zf0U4BlLtb8GzET9vJIQ8byD5zDXuGmPmtxSKXF5GzFVrLFkci6uikg7X76sMkkqKQ04pVPokN/UVSN29i+vym2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN9CfDdA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so5697503a12.3;
        Mon, 29 Jul 2024 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245029; x=1722849829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fTK+lSGaCTp89FJAQ+TaUZXly+QdYorHRE6pRbkPRc=;
        b=lN9CfDdA3JJd0lYYF1mUfIm+SQX3gu48XtzC2xf/4+dTSwaWj2YNkKPxr3PUeGAgDG
         CWxm8Cb5G8u4N+meR89/eInhHnlqr6jZsGFxTXhl+eyTYMAhHlpUtvtVpxI/gDbK2GHb
         6/iUKzsu5XzknwkbiGCw9ADCElZoz3+rqbXRtrGu477GYjt6f2ZHfeFJ9olKFD3SjPjd
         mHDO0CMCzhEC+7dDKJMrdwV2NL4eUoyWabknJnXXq5qrwANjw4Pa26LWAEzsKw8x48gH
         mFJp32lxBUuTdf82MMGNolGcWVtK9rOw2Gg9qIKBbS4GHoO2lRj5kyo84PkixGBTafCz
         cIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245029; x=1722849829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fTK+lSGaCTp89FJAQ+TaUZXly+QdYorHRE6pRbkPRc=;
        b=F5YwS7vj5SvIhGY7MusxJWJLEsE0FNOExZAy14E23sC7kDL5jfeJpEWlK6fZBuSWvQ
         bIDk6wjBwSPTUEmelJgUQwZ39vlevuP2N/JmamoBJPk5BSPViF3Jsbfzk+WENgQks6dF
         Fe9LJmpLY2C0Qwc9YPVsdOjIq1H9S1UOy0v81t7xTVkssbIB+EpUY6Rovd1FqOtQc4ge
         3QMw7AyM7ipST9b2pV5geD6Iyp4xJRJ/3tnkIrEXDBfhJlyEjAJ9trlCYwgxMqHORjWx
         1lC0DcoXTRLveONXj+l5YENu3B69vzOdH5aQ1O4BT237j2VtMhoz6HASVRakRFddgnWW
         4OSA==
X-Forwarded-Encrypted: i=1; AJvYcCUHSJB+MqJN3LixKrOLkx3B1PNhZJMYq8z4+/JHJ2tg8ahb2FM5jrrCdTASopEHtqjTl2kUdcVH+sp07tPLds26VWKodCV/F4yqM2kRqKpR2+RXDrKOpECftZUPqSfSwsrnutr9yLXyhU2q+Ju/dJAF66BCPOo0XV1n5czwiuC6hcPl4zY9xjTtwMJcJRTyEvljyNRgO1Ykanp6V3Ffhsy+IY4KK/TDxY0RHnBjInKtNBlnrpVp+iGM3w==
X-Gm-Message-State: AOJu0Yy5IGFU+hBDgLbPIdDKtxiSJAU3qVadtPdKt01W9sDRtRGyR8Si
	BAyihPk0oRqkhDvx3BoQ0Wi5Mn3aHZwbPBvMA3YvnfxhnXLRKnqT
X-Google-Smtp-Source: AGHT+IGUtqllS+X3QoqebDkqy6SK7g6E4MjjUsj4CDEh9KNQatJAye5U4PR+9MmRZtHaOIJp66JhIQ==
X-Received: by 2002:a05:6402:3487:b0:5a3:b45:3979 with SMTP id 4fb4d7f45d1cf-5b020ba8a06mr4708013a12.17.1722245029234;
        Mon, 29 Jul 2024 02:23:49 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b0491sm5493664a12.8.2024.07.29.02.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 02:23:48 -0700 (PDT)
Message-ID: <aa440f7c-0ccc-443c-8435-50c864edd1c2@gmail.com>
Date: Mon, 29 Jul 2024 11:23:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] net: mvpp2: use device_for_each_child_node() to
 access device child nodes
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
 <20240706-device_for_each_child_node-available-v1-6-8a3f7615e41c@gmail.com>
 <ZqdRgDkK1PzoI2Pf@shell.armlinux.org.uk>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <ZqdRgDkK1PzoI2Pf@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/07/2024 10:23, Russell King (Oracle) wrote:
> On Sat, Jul 06, 2024 at 05:23:38PM +0200, Javier Carrasco wrote:
>> The iterated nodes are direct children of the device node, and the
>> `device_for_each_child_node()` macro accounts for child node
>> availability.
>>
>> `fwnode_for_each_available_child_node()` is meant to access the child
>> nodes of an fwnode, and therefore not direct child nodes of the device
>> node.
>>
>> The child nodes within mvpp2_probe are not accessed outside the lopps,
> 
> "lopps" ?
> 
>> and the socped version of the macro can be used to automatically
> 
> "socped" ?
> 

I'll fix the typos for v3.

>> decrement the refcount on early exits.
>>
>> Use `device_for_each_child_node()` and its scoped variant to indicate
>> device's direct child nodes.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> index 9adf4301c9b1..97f1faab6f28 100644
>> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
>> @@ -7417,8 +7417,6 @@ static int mvpp2_get_sram(struct platform_device *pdev,
>>  
>>  static int mvpp2_probe(struct platform_device *pdev)
>>  {
>> -	struct fwnode_handle *fwnode = pdev->dev.fwnode;
>> -	struct fwnode_handle *port_fwnode;
>>  	struct mvpp2 *priv;
>>  	struct resource *res;
>>  	void __iomem *base;
>> @@ -7591,7 +7589,7 @@ static int mvpp2_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	/* Map DTS-active ports. Should be done before FIFO mvpp2_init */
>> -	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
>> +	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
>>  		if (!fwnode_property_read_u32(port_fwnode, "port-id", &i))
>>  			priv->port_map |= BIT(i);
>>  	}
>> @@ -7614,7 +7612,7 @@ static int mvpp2_probe(struct platform_device *pdev)
>>  		goto err_axi_clk;
>>  
>>  	/* Initialize ports */
>> -	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
>> +	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
>>  		err = mvpp2_port_probe(pdev, port_fwnode, priv);
>>  		if (err < 0)
>>  			goto err_port_probe;
>> @@ -7653,10 +7651,8 @@ static int mvpp2_probe(struct platform_device *pdev)
>>  	return 0;
>>  
>>  err_port_probe:
>> -	fwnode_handle_put(port_fwnode);
>> -
>>  	i = 0;
>> -	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
>> +	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
>>  		if (priv->port_list[i])
>>  			mvpp2_port_remove(priv->port_list[i]);
>>  		i++;
>> @@ -7677,13 +7673,12 @@ static int mvpp2_probe(struct platform_device *pdev)
>>  static void mvpp2_remove(struct platform_device *pdev)
>>  {
>>  	struct mvpp2 *priv = platform_get_drvdata(pdev);
>> -	struct fwnode_handle *fwnode = pdev->dev.fwnode;
>>  	int i = 0, poolnum = MVPP2_BM_POOLS_NUM;
>>  	struct fwnode_handle *port_fwnode;
>>  
>>  	mvpp2_dbgfs_cleanup(priv);
>>  
>> -	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
>> +	device_for_each_child_node(&pdev->dev, port_fwnode) {
>>  		if (priv->port_list[i]) {
>>  			mutex_destroy(&priv->port_list[i]->gather_stats_lock);
>>  			mvpp2_port_remove(priv->port_list[i]);
> 
> This loop is just silly. There is no need to iterate the child nodes.
> port_fwnode is not used, and the loop boils down to:
> 
> 	for (i = 0; i < priv->port_count; i++) {
> 		mutex_destroy(&priv->port_list[i]->gather_stats_lock);
> 		mvpp2_port_remove(priv->port_list[i]);
> 	}
> 
> Not only is walking the child nodes not necessary, but checking whether
> the pointer is NULL is also unnecessary. mvpp2_port_probe() populates
> the array using:
> 
>         priv->port_list[priv->port_count++] = port;
> 
> and "port" can not be NULL here, so we're guaranteed that all port_list
> entries for 0..priv->port_count will be non-NULL, and the driver makes
> this assumption in multiple places.
> 
> In fact, I'd say that using fwnode_for_each_available_child_node() or
> device_for_each_child_node() is buggy here if the availability of the
> children change - it could leave ports not cleaned up.
> 

I will add your suggestions in a separate patch with the corresponding
Suggested-by: tag. In that case, and taking into account that the
pointer check is unnecessary, the loop after a goto err_port_probe will
turn into this:

err_port_probe:
	for (i = 0; i < priv->port_count; i++)
		mvpp2_port_remove(priv->port_list[i]);

and the loop in mvpp2_remove() will be exactly the one you suggested.

Apart from that, there is a suspicious check towards the end of the same
function:

 if (is_acpi_node(port_fwnode))
		return;

At the point it is called in the current implementation, port_fwnode
could have been cleaned. And after removing the loop, it is simply
uninitialized. Was that meant to be pdev->dev->fwnode?

Thanks and best regards,
Javier Carrasco


