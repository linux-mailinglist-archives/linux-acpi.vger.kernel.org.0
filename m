Return-Path: <linux-acpi+bounces-8715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1399A338
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839721C21223
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D92216A2A;
	Fri, 11 Oct 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvbF05Ki"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C820C49B;
	Fri, 11 Oct 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648271; cv=none; b=KaHmziGNIOjLwIR+OJ1pQvmhW62lwpAl6tNSowbBzOFyZJ8TNsCz4TDyIssKfFvAQy4qeCNe1ienXUyZztzmfbC6pkzE8XhYRMVQYlBU8u7LE5DnqorbUwaPgYp/ZvetIufs4fjhyA6MWZwjva1nytIJyqHCAZ2ZltiXhE2deGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648271; c=relaxed/simple;
	bh=d2lsdLlJ23PzLx+t87PT/SQoDACaRKM+kkKERIEh25I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U063Nmb5AgUDJOkKFFscX6BrtXQeuDszyA9+/SO7Qo0qA8v1HAQswU3VUPNG3GRxHGn5Rlh2mwSVQiHIge9H1QVBEp5k4DS1XOAwepZExj9J9krmHDR+jgpOiK4I6EoouFJmJJaEf0XftLwDuZklFBt2zA/XcQ5DbbRPRc/TlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvbF05Ki; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398e53ca28so2175172e87.3;
        Fri, 11 Oct 2024 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728648267; x=1729253067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyShL+hX7deCzpof4F0fbg7eMw0Pnc7HEQfvWtO/NKM=;
        b=NvbF05KiYYLN+x6VhpmQSaX8F3M6JPZDpqyioxOHzQ+u9P3BcelVt2acAP6hS/dFaJ
         +vuNZhXQnHRc+KM2WK2DPbum0shqeAu/KOvIBZ0tEAt+hORzJLdHRnFEc+juq8CbOfRE
         7v3sJ9tbSMM9ztvXodUesLvWFKygA7iF2H7Unyh5fjlq7L/eHsexEGEiZoFDxPtk4Jr8
         DjndUI5yO/LWc0TmFiIyCAwVsdFanyeBG/+Lq66cqe4+PcLSWWOF1l8C8F6Xl+zuX+7I
         gUYefWfW3j6T1jJtOJokeWSuLJh6QbYcYZfL30rozsg50l5ui+uTdCfTFGDMwwp7XKya
         jOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648267; x=1729253067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyShL+hX7deCzpof4F0fbg7eMw0Pnc7HEQfvWtO/NKM=;
        b=qx4dTOvJlUrp3yxy1/rfUblwOtvS+lUSvf79MAFwFzjS8lwVoMUnt4TeFGfQWGaSEB
         tt1mVqYpl8IWfTQ2OeEqZsmHCBcijYYy+PmGP8NysK+VcmEIWOO0S7PpUdLE8uikebx7
         pz2kaiskDum+5JEY3ABWZQ5PqzDGOp7UJujIgtsbcWBaZWn38gP1pm0GktbpfHyHvz+1
         GPZp6zBHpmymsVD2bpkY/8vBRKMec7s48a3aSK6CmjPncqncBWvF6T5ljQic3v4IAXdX
         qzrTMXqpE3J+Nr0pskiyXTbJzMaC3/PfC2svWNkxMb4fOE/8RBoP4zg7N1Y2rxfEw/FU
         yiIw==
X-Forwarded-Encrypted: i=1; AJvYcCVtg4YBJbx/NpTi4t0iv4yfXLyqhldh8wzs3K74WIXSZD4VrU6kXOCZVxH84e2ccyzKimSeCnG//yu/@vger.kernel.org, AJvYcCWS7u4ZR0vh0919JoxmRmNe64RjUjoF6xK0S6SpbgrFXWr5aSkBpTvg0vcgzIvVGwrId1Sch+bv@vger.kernel.org, AJvYcCXv1y1Xo+S3TGHNMhwmajRdAwIVpEXVzOdtMEQeOZ1grFDvuMzE6ZhMIktQKmFcoV76YZ9mu/LYcZ6bGuTO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mhNtLMwhJzEidr8pgp3SbXZDcmMZmuHaR1FlYDStSWHtLhBd
	203P5Ywjla7zsquNDCya9o1rq/V/r/PgpgD523jSfZvF/5snniFJT5WL5NDB
X-Google-Smtp-Source: AGHT+IEFmewdlQ1CPXu2nV+GJbqCzq5j5B1b19TApH5sZAJ+BffXTe4lNLUiGOh2G3Wr71IqwpAF9A==
X-Received: by 2002:a05:6512:3b24:b0:539:9717:7ea0 with SMTP id 2adb3069b0e04-539da58b296mr1527424e87.55.1728648267031;
        Fri, 11 Oct 2024 05:04:27 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5c4c3sm206188966b.95.2024.10.11.05.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 05:04:26 -0700 (PDT)
Message-ID: <105dfbaa-0b7f-4e9e-8ab8-16d35ec165d7@gmail.com>
Date: Fri, 11 Oct 2024 14:04:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] device property: Introduce
 fwnode_for_each_available_child_node_scoped()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-1-cfd7758cd176@gmail.com>
 <Zwi6Dn4yJxst4xv2@kekkonen.localdomain>
 <07ec0837-d7a3-413e-a281-e06feafe7f34@gmail.com>
 <Zwj12J5bTNUEnxA0@kekkonen.localdomain>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <Zwj12J5bTNUEnxA0@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2024 11:54, Sakari Ailus wrote:
> Hi Javier,
> 
> On Fri, Oct 11, 2024 at 10:34:32AM +0200, Javier Carrasco wrote:
>> On 11/10/2024 07:39, Sakari Ailus wrote:
>>> Hi Javier,
>>>
>>> On Tue, Oct 08, 2024 at 06:10:27PM +0200, Javier Carrasco wrote:
>>>> Introduce the scoped variant of the
>>>> fwnode_for_each_available_child_node() to automatically decrement the
>>>> child's refcount when it goes out of scope, removing the need for
>>>> explicit calls to fwnode_handle_put().
>>>>
>>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>>> ---
>>>>  include/linux/property.h | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/include/linux/property.h b/include/linux/property.h
>>>> index 61fc20e5f81f..b37508ecf606 100644
>>>> --- a/include/linux/property.h
>>>> +++ b/include/linux/property.h
>>>> @@ -168,6 +168,11 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>>>>  	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
>>>>  	     child = fwnode_get_next_available_child_node(fwnode, child))
>>>>  
>>>> +#define fwnode_for_each_available_child_node_scoped(fwnode, child)	       \
>>>> +	for (struct fwnode_handle *child __free(fwnode_handle) =	       \
>>>> +		fwnode_get_next_available_child_node(fwnode, NULL); child;     \
>>>> +	     child = fwnode_get_next_available_child_node(fwnode, child))
>>>> +
>>>
>>> On OF, the implementation of the .get_next_child_node() fwnode op is:
>>>
>>> static struct fwnode_handle *
>>> of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>>>                               struct fwnode_handle *child)
>>> {
>>>         return of_fwnode_handle(of_get_next_available_child(to_of_node(fwnode),
>>>                                                             to_of_node(child)));
>>> }
>>>
>>> On ACPI we currently have .device_is_available() returning false but that
>>> probably should be returning true instead (it's been virtually unused
>>> previously).
>>>
>>> That makes fwnode_get_next_available_child_node() and
>>> fwnode_get_next_child_node() equivalent on both ACPI and OF. Presumably
>>> creating unavailable nodes would be useless on swnode, too.
>>>
>>> So my question is: what do we gain by adding all these fwnode_*available()
>>> helpers?
>>>
>>>>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>>>>  						 struct fwnode_handle *child);
>>>
>>
>> Hi Sakari, thanks for your feedback.
>>
>> I thought that the difference is not in OF (which either way ends up
>> calling __of_device_is_available()), but in ACPI.
>>
>> For fwnode_for_each_child_node(), the ACPI callback is
>> acpi_get_next_subnode(), and I don't see that the device_is_available()
>> callback is used in that case.
> 
> fwnode_get_next_available_child_node() also calls
> fwnode_device_is_available() and that returns false on all non-device nodes
> right now. As noted above, fwnode_device_is_available() should probably
> return true for non-device nodes on ACPI. I'll post a patch.
> 

fwnode_device_is_available() is indeed called in
fwnode_get_next_available_child_node(), as I stated a couple of lines below.

My question on the other hand was how that is called in
fwnode_for_each_child_node(), as I could not see any call to check
availability in acpi_get_next_subnode().
That is what confused me about the _available_ macros being the same as
their counterparts without the _available_.

Could you please clarify that? Thanks again.

>>
>> For fwnode_for_each_available_child_node(),
>> fwnode_get_next_available_child_node() is used, which checks
>> fwnode_device_is_available(), which then calls device_is_available().
>>
>> What's the catch?
> 


