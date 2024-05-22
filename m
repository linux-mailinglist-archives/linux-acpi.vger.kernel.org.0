Return-Path: <linux-acpi+bounces-5952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8116E8CC933
	for <lists+linux-acpi@lfdr.de>; Thu, 23 May 2024 00:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704DC1C21222
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 22:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55B146A71;
	Wed, 22 May 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXihOJVa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10B81AC6;
	Wed, 22 May 2024 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418273; cv=none; b=mHoc44w1yafix+SY1i2l64ZpAP3qFzADqQBlXpMUpbOY7S3QpuHSuDztVNiXkRvj41SMANoezSrF+foZoympKVFITgGTKdiWIE1vRlp7+SuyKUGH5izn964UPnScG6dkBCg5XJZ22LU9YwhJoOIRmfN4ntzam6MXOFnzQrVZ6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418273; c=relaxed/simple;
	bh=jPpl63O0p6Rp21ZrFjNcB9apG31h1Zk+5mFlFQjc6Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDgJ3KqpaoFDAjQu4FPLab1AyERZsuYgUN8Ia1evcFTZmxqKkHvNhM6Y2rqHvpASGACJE5TioTr53rj+cyX4S+XWGpRBGQCVfdI0BRBbflGXQsK3U4dlv6MzpIFuD+4ZXNYY0nrCygGav24ruVwLHNuw08eJrV9OhfODgQVUF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXihOJVa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee5235f5c9so115407835ad.2;
        Wed, 22 May 2024 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716418271; x=1717023071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rmJLfKJR+Q2eeJtf3DVr6zWcjm+6oeXAsT8oHQhkVro=;
        b=KXihOJVaGQ08lAKLSKKNyiZ9DbJZ7Y4YomqtPE/WcqtRpDlALYoCXFC7p7L4pCAenc
         DJS21B5j6PgRqsLe/+V0qEVP2+7JCxN99/Rms8mgnvOo6GdjIcao6seXPmYqzxL8Ax+F
         MJSgcjpSY/gzEL56+lROWgymHnp0GnbNYfpahdIDj7WjKWJ2l4vecQzYmjwcw9sLW4dN
         BvFAVDSPYAkSKZxwvPZjUiWb0NMhGdLKym6n1BHajgoRDpGkT6A0yQoMBJbxlkFVZKcd
         TEg4rJiINePKz1hS779xFkOs8YJFRXnNI0JF5IJ+rH6sIGLEXDA808i170506iLuSZhV
         ZhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418271; x=1717023071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmJLfKJR+Q2eeJtf3DVr6zWcjm+6oeXAsT8oHQhkVro=;
        b=rRRFXKRyURQSzMNy127Bj2IBwQJuQgBqRW6l9uHgybIGvN0wVFgg/wFpExkPodhufv
         iEqMjiHLOaXJm9AAXU0ytbXt1mCugkP8zfdNqVwiqcpemp3iD0yMlQbUsdLvjW8+HvEH
         HmL8O5poZ1pog28dpPrrdIx1tJW9fyIBt+GTb7zOn4CifZdn2KwQ6fdRVj/3/vqEU2ut
         /6dPCrwBeqrQwU6GpJ7y64Qi32AmlBeVm2HXa7KFF1KbzKi4HIfgok2H0ii4IDGav+gM
         5gCnZ8MxCxOHORxZHghjYTpBs0tuw4C3Z5LngM1IHShF9TiWmg+hdMriFNp76MsSohiY
         pmHA==
X-Forwarded-Encrypted: i=1; AJvYcCWgZAXJPXdLI0AO/Gy1PfaiFPi24Mw7PxMhxq08Ps05k9v1krJDFXr5eMDP7Fe39q8xxPCCjYym+3tLz+J6jb3KILIUVkfo4gfZ+Jkn8i6pQCya3fnySKkrKb8VoriqesisO4WTeIvmLYQ=
X-Gm-Message-State: AOJu0YxVzrq32+4KWgMUfspO4p1ByZ1+vNbnMJRAEybyZ3QMFQcM64ob
	E//lxfPOe3ZzZn06mtw9hKGayCIAJ/FRyBOPPEqfxQB3kaYcr085d3lR2w==
X-Google-Smtp-Source: AGHT+IGN6bCpQ/1b5JF85qgdzaY2hm6RPXFnet/9PvIFqu6/jyx588MWzq78YovaHHcmZ7SV1Vb0mQ==
X-Received: by 2002:a17:902:e84c:b0:1f3:35e8:d315 with SMTP id d9443c01a7336-1f335e8d5f2mr12779395ad.63.1716418271124;
        Wed, 22 May 2024 15:51:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f33d551493sm1023955ad.13.2024.05.22.15.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 15:51:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aab6fafe-e7b3-4ee0-beb3-2eaca9d1a1ed@roeck-us.net>
Date: Wed, 22 May 2024 15:51:08 -0700
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
 <57645247-fb14-4180-bef0-1638e9f522fe@roeck-us.net>
 <97567de0-895d-4a23-907f-506551e86362@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <97567de0-895d-4a23-907f-506551e86362@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 12:46, Javier Carrasco wrote:
> On 22/05/2024 21:08, Guenter Roeck wrote:
>> On 5/22/24 02:18, Javier Carrasco wrote:
>>> The error path from a zero value of the "shunt-resistor-micro-ohms"
>>> property does not decrement the refcount of the child node.
>>>
>>> Instead of adding the missing fwnode_handle_put(), a safer fix for
>>> future modifications is using the _scoped version of the macro,
>>> which removes the need for fwnode_handle_put() in all error paths.
>>>
>>> The macro defines the child node internally, which removes the need for
>>> the current child node declaration as well.
>>>
>>> Fixes: 10b029020487 ("hwmon: (ltc2992) Avoid division by zero")
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>
>> I really don't like fixes which depend on an API change.
>>
>> Guenter
>>
> 
> We could split the fix into two steps as suggested by Andy, where the
> fix would simply add the missing fwnode_handle_put(), adding the
> corresponding tag to include it in the stable kernels (the bug was
> introduced with v6.7). By doing that, the new macro would not need to be
> backported, which is probably a safer approach.
> 
> The patch with the new macro would be left as it is, and another patch
> would convert the the loop to use the new macro to avoid that a similar
> bug arises again. That would be this 2/2 + dropping the additional
> fwnode_handle_put().
> 

Please do.

Thanks,
Guenter


> Best regards,
> Javier Carrasco
> 


