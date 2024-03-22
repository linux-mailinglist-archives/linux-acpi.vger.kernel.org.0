Return-Path: <linux-acpi+bounces-4425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA7F8868B6
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Mar 2024 10:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD83B2123F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Mar 2024 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8A51AAD9;
	Fri, 22 Mar 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TvFyWswn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186519BA6
	for <linux-acpi@vger.kernel.org>; Fri, 22 Mar 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098021; cv=none; b=scWpyhNemr7CWmpE/WNTupYAu+o4++AjLV8e3Vq+QAo4wOTgM07BKwm1xjijbTtzK2AafalBKOMjopDp5QORHyOGpW54DttrAXwmOTY2tbvPnWcq6eTbyCHWxx8+OKrDYdBRFOCqTGE5deuXlRsHSENVPRQ8GMR7xPSbbcewS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098021; c=relaxed/simple;
	bh=3urD6Vdt2WW0ib8DDeutjw62IAV/2eUGDv1FCkDcRcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRmA2ao5mXBCylKayWXpXGkFcc5XVAMomqZ+Tj1bCzJoxmirlAoFg7AedMatwhOjdDZYjC7zGmr/H1FmtDq9H5w17l47zrUWIo2Imh/rDnn8CGWnz+7mkVhIX3MHD8lrnp/culSAiuvp4xqEfdZEZCHvu9ehYv2/+R/TiANtX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TvFyWswn; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9644da91-f367-4083-a3e4-4d0677c8cbca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711098017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkGU8SEVxsquTva3VrVV1kZXNieUSV+Fr4bifOxZdIU=;
	b=TvFyWswnkmmZsZqyOV+fEQaWYgqlnQI40uVAj5T15qroJN4DfwvDXA/3Jj81M/TCL804O7
	6mh+5NJGfCvwNXBmoZpJa7LENLT3Sm1ZaZbI3uXlr63TEoIiCDw/1rk7UfS3z+wZt4KTXy
	wRp9ebHr8zCTLOGaOP1tv98GEThSIbA=
Date: Fri, 22 Mar 2024 17:00:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] software node: Implement device_get_match_data fwnode
 callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20240318234222.1278882-1-sui.jingfeng@linux.dev>
 <Zfq85f-Dp1S3CKuG@smile.fi.intel.com>
 <9ced20e0-dfbd-4337-b5df-223b7baffd9e@linux.dev>
 <ZftG6Q5AaG71dhWq@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZftG6Q5AaG71dhWq@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/21 04:28, Andy Shevchenko wrote:
>>>> By replacing it with device_get_match_data() and creating a software
>>>> graph that mimics the OF graph, everything else works fine, except that
>>>> there isn't an out-of-box replacement for the of_device_get_match_data()
>>>> function. Because the software node backend of the fwnode framework lacks
>>>> an implementation for the device_get_match_data callback.
>>> .device_get_match_data
>>>
>>>> Implement device_get_match_data fwnode callback fwnode callback to fill
>>> .device_get_match_data
>> OK, thanks a lot.
>>
>>>> this gap. Device drivers or platform setup codes are expected to provide
>>>> a "compatible" string property. The value of this string property is used
>>>> to match against the compatible entries in the of_device_id table. Which
>>>> is consistent with the original usage style.
>>> Why do you need to implement the graph in the board file?
>> It can be inside the chip, there is no clear cut.\
> Which chip? Flash memory / ROM or you meant something like FPGA here?
> For the latter there is another discussion on how to use DT overlays
> in ACPI-enabled environments for the FPGA configurations.


There are some hardware resource or software entity is created on the
driver runtime. But DT or DT overlays are compiled before device driver
get loaded. GPIO-emulated-I2C is just an example, this is kind of driver
level knowledge on the runtime. With the GPIO or programmable some
hardware IP unit, device driver authors can change the connection relationship
at their will at the runtime. While with DT, every thing has to be sure
before the compile time.

DT overlays can be a alternative solution, but this doesn't conflict with
this patch. This patch won't assume how device drives go to use it, and
allow device driver creating device instead enumerating by DT. In one
word: "flexibility".



-- 
Best regards,
Sui


