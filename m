Return-Path: <linux-acpi+bounces-6585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E86913581
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2024 20:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126831C20D90
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jun 2024 18:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FAF18651;
	Sat, 22 Jun 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a6Rnzcar"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBD37708
	for <linux-acpi@vger.kernel.org>; Sat, 22 Jun 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719079454; cv=none; b=W9j4q6wrVkyzzZQFRKWN9jRRhN6GJwYtWvn99MUQ5wrmh3s9CllokfQcy9aKTDFZslqOD/9nFLzRdLNslg5KfLNuFoXYe4S4mN5SyksvlJ/WOuA9bNBYRxoHhBYpWPYIWLNdxph8H4gw1H4Q8s2MYRtDJfNLPgacihI/Fwq4jTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719079454; c=relaxed/simple;
	bh=uA6nP3zEheU4SmiDm9dlto0Jyss6DiFWNREamUjsUaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnfL5lQZ+pMafdUnMTZ9Ysc/b0xvu1mivjg4jDMQW+aK0jTWDOQIU0o+3iW4I1chrxnMCPuT7w1r8d1WGih0sLdImgWaH502MESaEB43o2GdkZ+C7XkcPhlNSfcnzKNIs2sx1gdpHOvdN3TZmmK69zQQsf005M/yB4ryCADViuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a6Rnzcar; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dmitry.torokhov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719079449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PieRDxt8sae1r1qWViM3cVK60T5YSH347BUB6yM6sk8=;
	b=a6RnzcarK8AEn6uN0SzTV/x5Jpos5RWALU+ORdgKsbhsVWu1fTFJ76eD5h7Vp/HyBIqYi5
	64dVVHzN1W5JIDaOkY7x4WPMNoXrkFNTrnvSKUQ1kVZGFUjjtLV90Huoq8X1Qu+x4RX/GC
	dcwcf5Kv52y/5ShwSv2k5ep/MtgYqQU=
X-Envelope-To: andriy.shevchenko@linux.intel.com
X-Envelope-To: linux-acpi@vger.kernel.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: djrscally@gmail.com
X-Envelope-To: heikki.krogerus@linux.intel.com
X-Envelope-To: sakari.ailus@linux.intel.com
X-Envelope-To: gregkh@linuxfoundation.org
X-Envelope-To: rafael@kernel.org
X-Envelope-To: dmitry.baryshkov@linaro.org
Message-ID: <7b5305b6-78b0-4add-9e70-271159cfad95@linux.dev>
Date: Sun, 23 Jun 2024 02:04:00 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] software node: Implement device_get_match_data fwnode
 callback
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240427203650.582989-1-sui.jingfeng@linux.dev>
 <ZnXbaubPVAUdDIu0@google.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZnXbaubPVAUdDIu0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 6/22/24 03:58, Dmitry Torokhov wrote:
> Hi Sui,
> 
> On Sun, Apr 28, 2024 at 04:36:50AM +0800, Sui Jingfeng wrote:
>> Because the software node backend of the fwnode API framework lacks an
>> implementation for the .device_get_match_data function callback. This
>> makes it difficult to use(and/or test) a few drivers that originates
>> from DT world on the non-DT platform.
>>
>> Implement the .device_get_match_data fwnode callback, which helps to keep
>> the three backends of the fwnode API aligned as much as possible. This is
>> also a fundamental step to make a few drivers OF-independent truely
>> possible.
>>
>> Device drivers or platform setup codes are expected to provide a software
>> node string property, named as "compatible". At this moment, the value of
>> this string property is being used to match against the compatible entries
>> in the of_device_id table. It can be extended in the future though.
> 
> I am sorry, but this is not really correct. 

I fine if the maintainers of fwnode API want to reject this, but got
rejected is not really equals to "not correct".

Software nodes are used to
> augment missing or incomplete parameters, but are never primary objects
> in the matching process. Sometimes "compatible" property is used with
> software nodes, but it does not participate in the matching process. > There are several ways for various buses to match a device and a driver,
> but none of them operate on software nodes. 

It's not participate in the matching process in the *past*, but what
we present is something *new*. I fine if you adhere to *old* and/or
*subsystem-dependent* approach, but there really no need to persuade
other people to follow your "old" idea.

Consider for example how
> devices on SPI bus are matched (see
> drivers/spi/spi.c::spi_match_device()):


This only make the driver be able to probed in a non-DT way, but
it doesn't tell how does the *additional device properties* can
be get. This is the key point.


> 1. OF/device tree based match. It *requires* the device to have
> dev->of_node which is coming from a DTB. It does not work on software
> nodes. In case of match the match data should come from of_device_id
> entry.
> 
> 2. ACPI-based match. The match is done based either on OF-compatible
> data (which includes "compatible" property) in _DSD (if driver supports
> OF-based matching), or based on HID/CID data. In the latter case the
> match data is coming from acpi_device_id entry.
> 
> 3. Name-based match, typically used for board-instantiated devices. In
> this case match is done by comparing device name under which it was
> instantiated against names listed in the drivers id_table. The match
> data is coming from spi_device_id entry.

The statements here sound right, but it's useless. Because the problems
isn't solved yet, nor does you words point out a practical approach.

> Similar matching processes are implemented for i2c and platform buses,
> as well as others.
> 
> Your patch is effectively hijacks the #3 matching process and
> substitutes the bus-specific match data (from
> spi_device_id/i2c_device_id/etc) with OF data. This is not expected and

Please stop *contaminating* other people's patch, if you have better
idea you can posting it. My patch open a new door, and there do have
programmer in requesting(need) this in the past.


> while we may want this in a long term (so we can eventually remove these
> bus-specific device ids and only have ACPI/OF ones) I do not think we
> are ready for this yet. At the very least this needs to be very clearly
> documented.

This is your *personal* wants, if you want to remove something,
just do it. Keep quiet if you are not ready. Exposing your concerns
doesn't help to solve any problems.

Or, if you want it to be clear, you can contribute to Documentation/
gpu/todo.rst. Other peoples help you to become clear there, thanks.

Please note that we are talking about the completeness of the fwnode
APIs, what's you say above has nothing to do the device fwnode APIs.
Hence, is not revelant to my patch, again is out of scope.

>>
>> Fixes: ffb42e64561e ("drm/tiny/repaper: Make driver OF-independent")
>> Fixes: 5703d6ae9573 ("drm/tiny/st7735r: Make driver OF-independent")
> 
> As other people mentioned this patch does not fix the aforementioned
> commits because they are not broken. 

You still not really understand what other people does, I'm not saying
it broken. I'm talking about the completeness.

In case of non-OF match (which
> includes the case where you use software nodes) the match data is coming
> from matching spi_device_id entry in the driver.


We don't care about much how it is probed now, rather, after the driver
probed by a non-OF way, how does the additional devices properties
can be get?


Say:

1) "device_property_read_u32(dev, "rotation", &rotation);" and
2) "!device_property_read_string(dev, "pervasive,thermal-zone", 
&thermal_zone))"


For those spi/i2c/platform devices, what we argues are that
those drivers really should just depend on "OF" before we have
a reliable fwnode API backend to redirect to.

Where the additional device_property_read_xxxx() calls redirect to?

What if users want to invoke more device_property_read_xxxx() function?

