Return-Path: <linux-acpi+bounces-8707-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76503999F1C
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 10:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3755B225DB
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288020B200;
	Fri, 11 Oct 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj5HQyPX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6875207A0C;
	Fri, 11 Oct 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635678; cv=none; b=BeFljWO3PZtSRg1NdvLSU1Qkcu58ihc2DIWrj9F2HgFWDGF4fivfKmWojXnFjNSu3rS7+3GpR2IKywGj5KS5umwGORP6iOKsB87midlTCle5SfW16IRRCp//aoZbDFhKa9vC3RLB1/g7wCBKNC3PkX8AhQQCQ3Or2NvoB0zUhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635678; c=relaxed/simple;
	bh=LmjhTY6GCu3+5OjscFIYDFmoiR0z3ORGCyKHXVkHpPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4acPXxuDYqlQYn7X5UwgEBW6IjvoQ3InihTuy/nc8tTLepWfGCwoG4rMUIbU0pMUr+neIatN7P9VYQqONuh0WWR/mEXOqM4pG8gEhrqJj46sQWK6L6oPa8WIbI1an7Mk9VYVuL/Za92Xbi7vWScEx4+w4nFrce8I5JldzpdB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj5HQyPX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99422c796eso292725166b.3;
        Fri, 11 Oct 2024 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728635675; x=1729240475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EABHLkxzcxramcO6WPe0bwKdtq63PUVd8Arf5wK5V0E=;
        b=Vj5HQyPXfVnGYu9JjGXX1vXIX8/I6Woxy7Ue5T/FE4eZTdohj7ciKcrNBFbShCCpLx
         WR0ROSgvGTIIxil5HtWHJ3UEUqgQCmLLfpGxneMoJXVNACZd5kOO+Nh8Xvry/MN428eF
         hSCWBTl3GKYMESInfuuzTiDjexOm9CIDVSXcsVkvjwdnY1JAqhVyv8n2OnVlU/uvj6ff
         0dBkhtMS7Z9Eh5FTB/gODEDN6ojcaEfrQKGovYb3414tSE6o6b7H3cJ9BAiLnRu6Btxj
         O8XUFMpY6WLqsHKjU2uhJ92euvYIwpk/LQV6ZNN9tWFUjVb2kPTZ9/wZVS2qJGJOQgfq
         WbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728635675; x=1729240475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EABHLkxzcxramcO6WPe0bwKdtq63PUVd8Arf5wK5V0E=;
        b=ZZIjebM933uNcic8fr6B4rpb0j7/W17ulbnKp+JQMQj6vfUKjmqykV1miLoIAys+iC
         9PJVLuouV/6oAsC/SfWwGTPApjh9nCdSxdtOr6KqlZt3kM9n9oLMioeDV0sBXXDpsM/e
         ZAkfHADfyDyY1f6xQg9CoQiN0OD0w15R0ZtgYmhLEyCKk+EwkAdWwD2/3tz573ImYcMg
         Srq70zOM/zzP/G6s9XSlgMVgbkr0u1P6KOkOrY02mXNEgqnpb6IGWPMEA2uq5WmMrDpf
         z63N+kgu0OfaD36rrqVI1TnpNmKFs+wOJ34t6q6PlK7XwKCNy3fzpskjWpgQnZPjP3aQ
         DMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQckc74jgGhYRqPHqmbLB/3jbQXfJ8XnzINMkb+650NtfrWBwwnlpZSjwX/qYn1SuybgvmvQ8l@vger.kernel.org, AJvYcCVGuYPaYU23ECX569mQKXo0GrHteNMO0pt3qQOrnALmpGzEYGCqzWGKxrOFR2WvzoaGMPjfg6OSVkAA@vger.kernel.org, AJvYcCXWR8KY4QiC6HuQxE0SRWuEdiH6vP5e5jpebWlqfWghoGenzCgl8CuzL2EnGH7Yly3bsKLIPqER6S0R8u5t@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9lv7ihDq+PqGv1Ra9R8WscpBUqCrEC2TBLgfNuJL2aJhgrDv
	OleeDNMx25Wm5Ytae9WjU6HHTaJPnvB+pVOTM7/2yLm5WvzaS9O80mDLZXoP
X-Google-Smtp-Source: AGHT+IEoHStOPruhFTLxbvfOGdkbObqF0fHHUkLsQl/p5cE5+vMJvg0KwdzS8imp9pLoy542WyuRJw==
X-Received: by 2002:a17:907:9724:b0:a99:528f:2200 with SMTP id a640c23a62f3a-a99b93c8da1mr125834866b.28.1728635674572;
        Fri, 11 Oct 2024 01:34:34 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec54cesm186137866b.32.2024.10.11.01.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 01:34:33 -0700 (PDT)
Message-ID: <07ec0837-d7a3-413e-a281-e06feafe7f34@gmail.com>
Date: Fri, 11 Oct 2024 10:34:32 +0200
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
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <Zwi6Dn4yJxst4xv2@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2024 07:39, Sakari Ailus wrote:
> Hi Javier,
> 
> On Tue, Oct 08, 2024 at 06:10:27PM +0200, Javier Carrasco wrote:
>> Introduce the scoped variant of the
>> fwnode_for_each_available_child_node() to automatically decrement the
>> child's refcount when it goes out of scope, removing the need for
>> explicit calls to fwnode_handle_put().
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  include/linux/property.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/property.h b/include/linux/property.h
>> index 61fc20e5f81f..b37508ecf606 100644
>> --- a/include/linux/property.h
>> +++ b/include/linux/property.h
>> @@ -168,6 +168,11 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>>  	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
>>  	     child = fwnode_get_next_available_child_node(fwnode, child))
>>  
>> +#define fwnode_for_each_available_child_node_scoped(fwnode, child)	       \
>> +	for (struct fwnode_handle *child __free(fwnode_handle) =	       \
>> +		fwnode_get_next_available_child_node(fwnode, NULL); child;     \
>> +	     child = fwnode_get_next_available_child_node(fwnode, child))
>> +
> 
> On OF, the implementation of the .get_next_child_node() fwnode op is:
> 
> static struct fwnode_handle *
> of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>                               struct fwnode_handle *child)
> {
>         return of_fwnode_handle(of_get_next_available_child(to_of_node(fwnode),
>                                                             to_of_node(child)));
> }
> 
> On ACPI we currently have .device_is_available() returning false but that
> probably should be returning true instead (it's been virtually unused
> previously).
> 
> That makes fwnode_get_next_available_child_node() and
> fwnode_get_next_child_node() equivalent on both ACPI and OF. Presumably
> creating unavailable nodes would be useless on swnode, too.
> 
> So my question is: what do we gain by adding all these fwnode_*available()
> helpers?
> 
>>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>>  						 struct fwnode_handle *child);
> 

Hi Sakari, thanks for your feedback.

I thought that the difference is not in OF (which either way ends up
calling __of_device_is_available()), but in ACPI.

For fwnode_for_each_child_node(), the ACPI callback is
acpi_get_next_subnode(), and I don't see that the device_is_available()
callback is used in that case.

For fwnode_for_each_available_child_node(),
fwnode_get_next_available_child_node() is used, which checks
fwnode_device_is_available(), which then calls device_is_available().

What's the catch?

Thanks again and best regards,
Javier Carrasco

