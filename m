Return-Path: <linux-acpi+bounces-17158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9AEB8DB88
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 15:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E098D3A33D4
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97B2D1301;
	Sun, 21 Sep 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShU0zxMN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C960145FE0;
	Sun, 21 Sep 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459613; cv=none; b=haAJfFYP+EOSUdy0WP5Nohg5OLpocK9oY+f4FlA6jxEana8JbKl+v93eKse/Iu7lsSnY71NabJO+C7jXXY+3C44LEz52m7x5oGvdDmolcJcUwHOSRY8DPULiRgTNA/+mCiVuMzpCeArZbFOrkLh0apoCkp8TX2R7C8Eycu04v4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459613; c=relaxed/simple;
	bh=hwGtzhPS1LT4OXFcGagFJgwnbLp6pqdMH96CIJJngB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6Z9I8rgtYcJtbxF3dbBytEW31eA3czfCG3RGEzYEvZHq7v3rJbaKnV0s2XzyxIMC5PwJqA5LfbxGAHSfeFtutPy6EFaxrX3Y9JKVUcGQeEIFvesuw1M3JcY+ZSjJLYfxOztttyJB7wE1nOisffaIBsdXxB8yXQ4qbWDtMn3aho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShU0zxMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A40C4CEE7;
	Sun, 21 Sep 2025 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758459612;
	bh=hwGtzhPS1LT4OXFcGagFJgwnbLp6pqdMH96CIJJngB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ShU0zxMNOMFa2FfRFbAaihO1SRyZEUJq+km+Prgkfrh3xgYYBXTg1IcRx+53PtGMq
	 ewVbNVsdQzj0pgkYG/IKPD2EKXLsQZTKDXNhxmLR3DsHd2i3dPmevkOvieftSJa6b0
	 YpsfD6BCiDtegsZeibjpm6gMGI4W6WHO9qFc0ZTyUwNHnCnTJdPIGnbDFKOyjUHG68
	 nxVcEpPlRKREf5BVzhgdbuK0JjlZ95vDG6wXzig2MjtjINi8yKLtwdmkxuQjpxezQa
	 YC1l79gUWB3BTkG5iJBTZw10XJCP4qAWqmeFBtyKieH/OlgDO5lw35PcIc4JyANDS3
	 Q01X+lF8XojmA==
Message-ID: <d8e90507-49d1-4afa-a71a-ceacf5f89f82@kernel.org>
Date: Sun, 21 Sep 2025 15:00:09 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpiolib: Extend software-node support to support
 secondary software-nodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20250920200955.20403-1-hansg@kernel.org>
 <w7twypwesy4t5qkcupjqyqzcdh2soahqpa35rqeajzh2syhtra@6trjploaie6g>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <w7twypwesy4t5qkcupjqyqzcdh2soahqpa35rqeajzh2syhtra@6trjploaie6g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20-Sep-25 11:27 PM, Dmitry Torokhov wrote:
> On Sat, Sep 20, 2025 at 10:09:55PM +0200, Hans de Goede wrote:
>> When a software-node gets added to a device which already has another
>> fwnode as primary node it will become the secondary fwnode for that
>> device.
>>
>> Currently if a software-node with GPIO properties ends up as the secondary
>> fwnode then gpiod_find_by_fwnode() will fail to find the GPIOs.
>>
>> Add a new gpiod_fwnode_lookup() helper which falls back to calling
>> gpiod_find_by_fwnode() with the secondary fwnode if the GPIO was not
>> found in the primary fwnode.
>>
>> Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")
>> Cc: stable@vger.kernel.org
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Hans de Goede <hansg@kernel.org>
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
>> ---
>> Changes in v2:
>> - Add a new gpiod_fwnode_lookup() helper instead of putting the secondary
>>   fwnode check inside gpiod_find_by_fwnode()
>> ---
>>  drivers/gpio/gpiolib.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index 0d2b470a252e..74d54513730a 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -4604,6 +4604,23 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
>>  	return desc;
>>  }
>>  
>> +static struct gpio_desc *gpiod_fwnode_lookup(struct fwnode_handle *fwnode,
>> +					     struct device *consumer,
>> +					     const char *con_id,
>> +					     unsigned int idx,
>> +					     enum gpiod_flags *flags,
>> +					     unsigned long *lookupflags)
>> +{
>> +	struct gpio_desc *desc;
>> +
>> +	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
>> +	if (gpiod_not_found(desc) && !IS_ERR_OR_NULL(fwnode))
>> +		desc = gpiod_find_by_fwnode(fwnode->secondary, consumer, con_id,
>> +					    idx, flags, lookupflags);
>> +
>> +	return desc;
> 
> Bikeshedding for later. Maybe do it like this in case we can have more
> than 2 nodes at some point?
> 
>         do {
> 		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
> 		if (!gpiod_not_found(desc))
> 			return desc;
> 
> 		fwnode = fwnode->secondary;
> 	} while (!IS_ERR_OR_NULL(fwnode));
> 
> 	return ERR_PTR(-ENOENT);

At a minimum this would need to a regular while () {} loop then,
the initial fwnode may also be NULL and we don't want to deref that.

Andy did mention turning the fwnode-s into a regular linked-list
in the future, but I think that would be using <linux/list.h> then,
replacing the secondary pointer with a list head ?

Regards,

Hans






> 
>> +}
>> +
>>  struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>>  					 struct fwnode_handle *fwnode,
>>  					 const char *con_id,
>> @@ -4622,8 +4639,8 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>>  	int ret = 0;
>>  
>>  	scoped_guard(srcu, &gpio_devices_srcu) {
>> -		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
>> -					    &flags, &lookupflags);
>> +		desc = gpiod_fwnode_lookup(fwnode, consumer, con_id, idx,
>> +					   &flags, &lookupflags);
>>  		if (gpiod_not_found(desc) && platform_lookup_allowed) {
>>  			/*
>>  			 * Either we are not using DT or ACPI, or their lookup
> 
> Thanks.
> 


