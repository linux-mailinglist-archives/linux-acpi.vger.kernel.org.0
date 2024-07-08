Return-Path: <linux-acpi+bounces-6817-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1EE92A602
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54216B21B67
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518EE13B7A3;
	Mon,  8 Jul 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5YbolPp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD59138C;
	Mon,  8 Jul 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453550; cv=none; b=SChIqXEUTz40+UbHFkq0xwaerX2a+Y9AkUcWMhmBnjNoA1G0Any2UZxn9mB+KCozZSqeNr4Z0VycAc8DtKR27iSXktCewKGqLUEY1A1/xpiDWPawc0n9PqWYexq3UFE6NsZjbDLLXenWIhHr79i7xqnOpCDIqy/cq9Q4rSxtJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453550; c=relaxed/simple;
	bh=Lno49dn6Wp3XRCaV6biRDC5IjTigepJR3LEZe26mXSY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A24uAfKHmLKocZlD/0pFwcHsfMKQ5kEc5aEeQIi36X0kp1rRBIfJhWPb/u7D75j9NQJSirprJ5KNONR6caP8WqynVHJLjT5OSrLig5rFPTpPNycaV1FYhJWfmOcd0GJJNmZJLCHRf3cTdpyhXzZxnmBsUwYgsQJl8OnS6Ir9fjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5YbolPp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so25028775e9.1;
        Mon, 08 Jul 2024 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720453547; x=1721058347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qkICa0ofvLlVTjjsmaahvBqbNaY6s0KcNDXv8H869/w=;
        b=j5YbolPpwdIiDL2vrPStJbRtMwyCeIJQEinF0UD+JHipfMcOY8zX5K57kby037aqV8
         7fms1x61VPzkPiTXt5OYAeEfyfk10Xxr30r2uaOQ6FPKvltT70vT7b7zwcFentHJWAJ4
         RgnZ37uchy9FSMA0RHJmlZffWgOArpfwFM3YqWCq1qvmITscGqg7Rqw1bikv/URwLdo0
         1Fb4YvNGfijIO9VSIIlxR/TobZc4ZLXY18gLuu51m2n9FRlhOTAB5CGdvbclX70scSSO
         fW5Uxg44HMx6xjQVJ9KpHcNPX8/yvkEmhiDUq0YuoiSbHSQOl5zZFBWF7EpVK77+FcKp
         L5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720453547; x=1721058347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkICa0ofvLlVTjjsmaahvBqbNaY6s0KcNDXv8H869/w=;
        b=MKi35TBQ/8all9UvLJ+PFVyuNtk/V8onrYNNIuJTu9Y9C/Ob3JA6ot8Hq+wHNFICFw
         EWhyMlSn/e7P/fbELFn/YcQyw2WwIP5KIvWDg2xKVAu4mJ4PtgO8XPEhMNwBdpIHhwp2
         svVBpIeVTBDC4V+uBmIP8Cf0byqb8bCV+Y+dZl6e35GvWBZuPWQRtmsF218jhuCYc/dJ
         hwbRLA0JTzRWfjjG7pUT80ZwkvTJuTuJj5wwgD0OQfkc+s5VwDDBtBfWiFRiVbKjh3lx
         AgUog321D9xLrHhoAftRK/IEOH1zJczzTUPUZo1vjA3ckh7AdudWwVJQu4abtGVTZxTI
         E8hA==
X-Forwarded-Encrypted: i=1; AJvYcCU7fPKnw6lsreEstvX5jU6z0p17ypTyPzTiaTdHJGg9DSchLYPZMIpxcsZ5PXQyd/le32ymIKSrJEJYZflTRGkdbcw20ul+4fxoI72R92qtMt2yeekz9kFQkRrr0yt74O2o3sYrLMDtT1Iaa16+73KE+i6JcKONdIAvYQbeaqnULR28TuXx0YUz0WhWJcf02+eoDkad1+g+uTh0b7PaLyP+w6Wef08k6/OQ7ySj1nc9X9LyOnN+V9ddLw==
X-Gm-Message-State: AOJu0Yx2Bp/gZk3Bd1SSa1/KmpUd6FBHGGssmR6fEFvJPMHIm6sLRkQ4
	ZXDk4GOX19jkKL9ILwUN8703QA1Bm/1qzzNh6nIRTyH1u6PvMsBL
X-Google-Smtp-Source: AGHT+IEPZ7bBGfEpmnLUfGsNXVTk4kA/uPf8kqKXrCigSFsssX0ifq5fYeIZEnN6//AqJ9JvXtUdhA==
X-Received: by 2002:a05:600c:1c98:b0:426:5fa7:b495 with SMTP id 5b1f17b1804b1-4265fa7b6c3mr55487905e9.15.1720453546702;
        Mon, 08 Jul 2024 08:45:46 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:2322:5f32:18e0:d6c4? (2a02-8389-41cf-e200-2322-5f32-18e0-d6c4.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2322:5f32:18e0:d6c4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09f1sm3388355e9.1.2024.07.08.08.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 08:45:46 -0700 (PDT)
Message-ID: <2cd45260-e737-43e9-9bf6-c267d6f86ad3@gmail.com>
Date: Mon, 8 Jul 2024 17:45:43 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] leds: bd2606mvv: use device_for_each_child_node() to
 access device child nodes
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 Andreas Kemnade <andreas@kemnade.info>
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
 <4cf71de7-dc47-475c-bba0-a9e755f66d49@gmail.com>
Content-Language: en-US, de-AT
In-Reply-To: <4cf71de7-dc47-475c-bba0-a9e755f66d49@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2024 10:14, Javier Carrasco wrote:
> On 07/07/2024 18:57, Jonathan Cameron wrote:
>> On Sat, 06 Jul 2024 17:23:35 +0200
>> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>>
>>> The iterated nodes are direct children of the device node, and the
>>> `device_for_each_child_node()` macro accounts for child node
>>> availability.
>>>
>>> `fwnode_for_each_available_child_node()` is meant to access the child
>>> nodes of an fwnode, and therefore not direct child nodes of the device
>>> node.
>>>
>>> Use `device_for_each_child_node()` to indicate device's direct child
>>> nodes.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> Why not the scoped variant?
>> There look to be two error paths in there which would be simplified.
>>
> 
> I did not use the scoped variant because "child" is used outside the loop.
> 
> On the other hand, I think an fwnode_handle_get() is missing for every
> "led_fwnodes[reg] = child" because a simple assignment does not
> increment the refcount.
> 
> After adding fwnode_handle_get(), the scoped variant could be used, and
> the call to fwnode_handle_put() would act on led_fwnodes[reg] instead.
> 

Actually, the whole trouble comes from doing the processing in two
consecutive loops, where the second loop accesses a child node that gets
released at the end of the first one. It seems that some code got moved
from one loop to a new one between two versions of the patchset.

@Andreas Kemnade: I see that you had a single loop until v4 (the driver
got applied with v6), and then you split it into two loops, but I don't
see any mention to this modification in the change log.

What was the reason for this modification? Apparently, similar drivers
do everything in one loop to avoid such issues.

Maybe refactoring to have a single loop again (if possible) would be the
cleanest solution. Otherwise a get/put mechanism might be necessary.

>>> ---
>>>  drivers/leds/leds-bd2606mvv.c | 7 +++----
>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/leds/leds-bd2606mvv.c b/drivers/leds/leds-bd2606mvv.c
>>> index 3fda712d2f80..4f38b7b4d9d1 100644
>>> --- a/drivers/leds/leds-bd2606mvv.c
>>> +++ b/drivers/leds/leds-bd2606mvv.c
>>> @@ -69,7 +69,7 @@ static const struct regmap_config bd2606mvv_regmap = {
>>>  
>>>  static int bd2606mvv_probe(struct i2c_client *client)
>>>  {
>>> -	struct fwnode_handle *np, *child;
>>> +	struct fwnode_handle *child;
>>>  	struct device *dev = &client->dev;
>>>  	struct bd2606mvv_priv *priv;
>>>  	struct fwnode_handle *led_fwnodes[BD2606_MAX_LEDS] = { 0 };
>>> @@ -77,8 +77,7 @@ static int bd2606mvv_probe(struct i2c_client *client)
>>>  	int err, reg;
>>>  	int i;
>>>  
>>> -	np = dev_fwnode(dev);
>>> -	if (!np)
>>> +	if (!dev_fwnode(dev))
>>>  		return -ENODEV;
>>>  
>>>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> @@ -94,7 +93,7 @@ static int bd2606mvv_probe(struct i2c_client *client)
>>>  
>>>  	i2c_set_clientdata(client, priv);
>>>  
>>> -	fwnode_for_each_available_child_node(np, child) {
>>> +	device_for_each_child_node(dev, child) {
>>>  		struct bd2606mvv_led *led;
>>>  
>>>  		err = fwnode_property_read_u32(child, "reg", &reg);
>>>
>>
> 


