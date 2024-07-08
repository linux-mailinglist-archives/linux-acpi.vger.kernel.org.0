Return-Path: <linux-acpi+bounces-6802-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67049929E1B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 10:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2D8283830
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 08:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F53BBE8;
	Mon,  8 Jul 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlyOZ6FR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8C39AFD;
	Mon,  8 Jul 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426491; cv=none; b=axAC+o24GmMzzADe4hfLB1p7KTjj1Ajp9FEzPYVVRXnCQM2S9q7asbWh5xlk25foqKGV1acWkaCcfGvlYQhKJ+mp5FNjiQK9wR3sXo50an6sPvGTpo4oJMnQA8nP7Grte9JCgNESuI2Ej5USVHZeQ6L4uMOcRuK9RtDh597NqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426491; c=relaxed/simple;
	bh=bW2kBwLh7hLCqFmQpvVPmf6stmpS/Uma1LaKPKgxZLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHVb96biTIJNwImR2xeGHHN+BusEcI2yZlaUxw/3jM7s69Q3uW3HaU30bNH2b4Wg2V1cSHLNSsLSSoN9NlgpJWvsCFeS6aC8CmSY+T37nDl72bJQXUWMBvf4x01hU1JecjuweG7SIznnuyWYN+VarX1tuK33kvONIokxNpIFHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlyOZ6FR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4265921b0f6so15154065e9.2;
        Mon, 08 Jul 2024 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720426488; x=1721031288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LB/Swk3ycn4H//NhFUYR9qWMXgjl7noaRfXFak1SvO8=;
        b=GlyOZ6FRwuPyUFnhN6P96zD9gvTFuYC6lXkbOoHbHGCw7kjqAEUh8eDPteQSRIO8Lv
         tc1d5ZDsFoSURb+ARE408OHeqAb72DPbYc0AJwYMHU9pyIR/Y8TgPnpiqfw5dQmyeQOk
         OJHV+LBMbHS+jZelhQg9kcwSjxmwg/Qes6dxXC9sycd8HN3ymdla1558si+1q+i1jFUa
         IykClgZEx135AVIMMvL/MPlBzhcg685+uH7Am+301D8LaHpWjPUGHXrWTp0Ra6B/nXsm
         pUMlyUpmfYjiBsaTs5iiB3eCFxroQpwLkNCcwF7Cmnb4NgCoFIZ4C/s/C8rDrWVvdVxb
         meFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426488; x=1721031288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LB/Swk3ycn4H//NhFUYR9qWMXgjl7noaRfXFak1SvO8=;
        b=ZSP6RXMG5HS5YAJfKXObUtVNe4B3Ek31zNhy2ZYqaJPXI8Oc0/UcJTT5R49jRtQy/X
         OEOo9wFX4C3xJDmO/p647jubDmeRzpIGK66phJ6jqPodVYvyv/eGZ0qyMYgO4L1ptrTC
         PtjdWxzKr2Dl55Ldcj4fBg+XfU+ke9EtXA3MIpOkP8G//ZNL+4lLhs9FDcYfhuEVTGEu
         luwaRGxmVbn+8eARp8gDHVKjLPDPdnu0L0UesDzS3VXVttgqow1H3f4Vh6bfvD6mIwbv
         tmwX24D9163mGG0qzMr1OstG9SaBD7almPtqNiD85xIvPSBrWzNbqxuq7k0N7Lg34BAF
         oagg==
X-Forwarded-Encrypted: i=1; AJvYcCUiGsWAeqC/Pzw1rceg7VjpgdnsvmeLTj34op70pL9i8Gv7xELv3wiF5pI0G/3hIvprH8zgtyrRlvR2qhxgZLAGhezSPzIGA36GKVPl85KvnSHPIrTRPJCI09y9s+UDV2uB26YSHpyEEr5qI4pGiVfD8cDDZN+GL6NhUjWJ/0xLNr98SfvO+VmzHLK3zfXdrwmOcq6MO4XhyGLdSF8BvCJSE4uIp5NsRSBh2FZdh8Sz1YI7ZiwdqGcx3Q==
X-Gm-Message-State: AOJu0YyHO+ksWWSKT92p7GRhx5i6D4NmX4S5a2biyV1bXdF8UBY/q7Fo
	IJoNTThijwxkkOi7ggZaCTdEmyTpritiIDFlFepkb4gTu64GKHlj
X-Google-Smtp-Source: AGHT+IG8F79NBHnf063XhYUCby0asGygjp8CO89/3eVOIoVh9aNxTtR8n7wvSe//36xefcMl+q9eLg==
X-Received: by 2002:a05:600c:6d2:b0:426:5ef6:f5a9 with SMTP id 5b1f17b1804b1-4265ef6f63fmr37710785e9.13.1720426488061;
        Mon, 08 Jul 2024 01:14:48 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:7e72:ed92:807f:1d20? (2a02-8389-41cf-e200-7e72-ed92-807f-1d20.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7e72:ed92:807f:1d20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d16b0sm152642145e9.7.2024.07.08.01.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 01:14:47 -0700 (PDT)
Message-ID: <4cf71de7-dc47-475c-bba0-a9e755f66d49@gmail.com>
Date: Mon, 8 Jul 2024 10:14:44 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] leds: bd2606mvv: use device_for_each_child_node() to
 access device child nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
 <20240706-device_for_each_child_node-available-v1-3-8a3f7615e41c@gmail.com>
 <20240707175713.4deb559f@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240707175713.4deb559f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/07/2024 18:57, Jonathan Cameron wrote:
> On Sat, 06 Jul 2024 17:23:35 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The iterated nodes are direct children of the device node, and the
>> `device_for_each_child_node()` macro accounts for child node
>> availability.
>>
>> `fwnode_for_each_available_child_node()` is meant to access the child
>> nodes of an fwnode, and therefore not direct child nodes of the device
>> node.
>>
>> Use `device_for_each_child_node()` to indicate device's direct child
>> nodes.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Why not the scoped variant?
> There look to be two error paths in there which would be simplified.
> 

I did not use the scoped variant because "child" is used outside the loop.

On the other hand, I think an fwnode_handle_get() is missing for every
"led_fwnodes[reg] = child" because a simple assignment does not
increment the refcount.

After adding fwnode_handle_get(), the scoped variant could be used, and
the call to fwnode_handle_put() would act on led_fwnodes[reg] instead.

>> ---
>>  drivers/leds/leds-bd2606mvv.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/leds/leds-bd2606mvv.c b/drivers/leds/leds-bd2606mvv.c
>> index 3fda712d2f80..4f38b7b4d9d1 100644
>> --- a/drivers/leds/leds-bd2606mvv.c
>> +++ b/drivers/leds/leds-bd2606mvv.c
>> @@ -69,7 +69,7 @@ static const struct regmap_config bd2606mvv_regmap = {
>>  
>>  static int bd2606mvv_probe(struct i2c_client *client)
>>  {
>> -	struct fwnode_handle *np, *child;
>> +	struct fwnode_handle *child;
>>  	struct device *dev = &client->dev;
>>  	struct bd2606mvv_priv *priv;
>>  	struct fwnode_handle *led_fwnodes[BD2606_MAX_LEDS] = { 0 };
>> @@ -77,8 +77,7 @@ static int bd2606mvv_probe(struct i2c_client *client)
>>  	int err, reg;
>>  	int i;
>>  
>> -	np = dev_fwnode(dev);
>> -	if (!np)
>> +	if (!dev_fwnode(dev))
>>  		return -ENODEV;
>>  
>>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> @@ -94,7 +93,7 @@ static int bd2606mvv_probe(struct i2c_client *client)
>>  
>>  	i2c_set_clientdata(client, priv);
>>  
>> -	fwnode_for_each_available_child_node(np, child) {
>> +	device_for_each_child_node(dev, child) {
>>  		struct bd2606mvv_led *led;
>>  
>>  		err = fwnode_property_read_u32(child, "reg", &reg);
>>
> 


