Return-Path: <linux-acpi+bounces-5947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297F78CC6BB
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 21:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2881C20D85
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890C11422C6;
	Wed, 22 May 2024 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+NLAyyB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFC20DF4;
	Wed, 22 May 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404898; cv=none; b=Jl6SBMt9YpBZprZA3Cpno9JfhFOwz1amG5QTqoO5X3UIID2P65yJ+XCS7Uq68EvjMYj1byCqs0i4oSjbfa44kK3+WUJn1XxcDqE2rclkRWEbQYTbZIBHqB9C+l/KzwokjjfouaVqeDpX9sKrxS5+xJXJVpM8gb/FGGNlNLPoJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404898; c=relaxed/simple;
	bh=srDestDcRngwkBYzq2+QVTUC/g+LpjcoHXg2XIj/WUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ee8aG5JWP7NFXYY8GcI4DKteNLuP4l2rsSkkgU5KzXzcKkW++EAgPnsLF9zdI8G52ekvsUEOSAxestSPvKq1G6q6wQsBEH7GpZsrnvMZQKgSQT905m8ssNi8J/zVCbl3Hvt9OV5XosfrOvf/a0CLY2sjXxeO59PECNhPfuDdrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+NLAyyB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f472d550cbso2586190b3a.1;
        Wed, 22 May 2024 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716404896; x=1717009696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HHe0J+axw65labUCdXoK8uIN+8G/Ed6hXruWWV5tTq0=;
        b=Z+NLAyyB/ku+YJIn8N32UXP7Y2duZc0rl54zZftT63XIGs/rJ6OQgWpipAfmnLgEuG
         n3PO8IiqCsrt9z3YOZ+aqI1PMSorZwYeuYHZrGAiMZyXjrvMMMMdkpQTWWq5exsmQoCs
         y493oWd2j8IJ/J2Sk3AqqJq9HSqQMVa54ofr3zaq1BHUFhdyr+tGufrCK7Zv9jxTf5Tx
         it3+5fRbtlqvSs2rGCTJ1XbVuSaoGC7fLgM5B1UI06YddtPN0EqaVxESxeatJQe34fSy
         D8L11ADPuaversVKobsYraYvca2fadEvY0GTpcfc5NQHeyoUWcLbjWBx8d7gArZb0RPk
         fQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716404896; x=1717009696;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHe0J+axw65labUCdXoK8uIN+8G/Ed6hXruWWV5tTq0=;
        b=CFDFpBtE8VbuEjW1rwtPiBIkzXvnLM3r9RlXvJwtYJauIym1QBSTVIDfwnn4wePTzC
         2HwnXe/BFpJhv9ZDcXC+72F6dAo9RUFlRQuBlnLdGIgythMNIqfm8hnQoBsv4IIVqeH9
         Pwqq6UkuTnxwjxz9hIK8JUdf47eByJSBHIo8q0VIZ1SCIwNj5aAl4tUyIUa/D0zgPbhs
         i94QG9c5ZLPi+BHPswF468ByWW2f9rMCl4Pk+V6NvhZsv4YdXVhxC00FXculYZaxtfhx
         fa/+RYC5KPr5tafggAzY/dnc2E55yXUsN3iYmhVmNB52p/EZgsxAlhFEk+zD9En1QWTP
         xybg==
X-Forwarded-Encrypted: i=1; AJvYcCVmsJ+ENDhvHdYBau40Q1IBRVvHBiAYfVLowxjb0ak5Vk1vnKd/rh7tT9duhd8LgXxuRrJ/DS+3M4AYc5Zpcb5CZXEeOdWdpQjNxxHINLnLkqp84Z+u118HDMbYqfYOquxPvKNsd914OXQ=
X-Gm-Message-State: AOJu0YyZDKLzgApXggaQ5+iyyhhkJF+vSwW0rVB84lhKN6RMyZad4MUt
	WBvbMYtuxB53UGELcG6R5XOTiHJOWP1/sGXGF5EWKaCkJ01KHC/6
X-Google-Smtp-Source: AGHT+IEipXKKTiG1L46xo/nJ3t/vVfMMPrtmKPX++7PZb3z6qzXlboeQk5rOYPt5CPWAWw9tdjdGPw==
X-Received: by 2002:a05:6a20:9194:b0:1b1:ebf2:d767 with SMTP id adf61e73a8af0-1b1f8a3fd12mr4314194637.43.1716404895884;
        Wed, 22 May 2024 12:08:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2fb19sm22744023b3a.207.2024.05.22.12.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 12:08:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <57645247-fb14-4180-bef0-1638e9f522fe@roeck-us.net>
Date: Wed, 22 May 2024 12:08:12 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (ltc2992) use
 fwnode_for_each_available_child_node_scoped()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240522-fwnode_for_each_available_child_node_scoped-v1-0-1188b0da12dc@gmail.com>
 <20240522-fwnode_for_each_available_child_node_scoped-v1-2-1188b0da12dc@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240522-fwnode_for_each_available_child_node_scoped-v1-2-1188b0da12dc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 02:18, Javier Carrasco wrote:
> The error path from a zero value of the "shunt-resistor-micro-ohms"
> property does not decrement the refcount of the child node.
> 
> Instead of adding the missing fwnode_handle_put(), a safer fix for
> future modifications is using the _scoped version of the macro,
> which removes the need for fwnode_handle_put() in all error paths.
> 
> The macro defines the child node internally, which removes the need for
> the current child node declaration as well.
> 
> Fixes: 10b029020487 ("hwmon: (ltc2992) Avoid division by zero")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

I really don't like fixes which depend on an API change.

Guenter

> ---
>   drivers/hwmon/ltc2992.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
> index 229aed15d5ca..3feee400ecf8 100644
> --- a/drivers/hwmon/ltc2992.c
> +++ b/drivers/hwmon/ltc2992.c
> @@ -855,24 +855,19 @@ static const struct regmap_config ltc2992_regmap_config = {
>   static int ltc2992_parse_dt(struct ltc2992_state *st)
>   {
>   	struct fwnode_handle *fwnode;
> -	struct fwnode_handle *child;
>   	u32 addr;
>   	u32 val;
>   	int ret;
>   
>   	fwnode = dev_fwnode(&st->client->dev);
>   
> -	fwnode_for_each_available_child_node(fwnode, child) {
> +	fwnode_for_each_available_child_node_scoped(fwnode, child) {
>   		ret = fwnode_property_read_u32(child, "reg", &addr);
> -		if (ret < 0) {
> -			fwnode_handle_put(child);
> +		if (ret < 0)
>   			return ret;
> -		}
>   
> -		if (addr > 1) {
> -			fwnode_handle_put(child);
> +		if (addr > 1)
>   			return -EINVAL;
> -		}
>   
>   		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
>   		if (!ret) {
> 


