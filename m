Return-Path: <linux-acpi+bounces-7373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C8A94996C
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 22:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E59AB27152
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E0D824A0;
	Tue,  6 Aug 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXQFa+4n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCA77F08;
	Tue,  6 Aug 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977165; cv=none; b=V6BRovo2OVTFRY9pluDKwL8JT7QvqATXmgi/0czlF/I6YYumeZvGjVdjeEyYL9h45DJFysvw8rSLkzRiWuPrnXySAjqWC+uctpglIHG6RBgvgfIPQdsRIkR1S1aIDQVzAJU/iMtdjkNHmslDoM+u4mXALmXYoFXgYoxlwR5k2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977165; c=relaxed/simple;
	bh=FBPPBXVWYgE3RuKywF6s6v5xBm5ttSryUiyb6Dp8Dg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeggYifhyeCQVKzlcB0g5RA5qdS6mNkxsksCiwmwtpzIIaXHaOWuxbHiDC1lxUprRahm6FtOKcB1b48aB7X/H0HQG1R/L4JDdT8wNvZeF58rH7Yqq+8XGECZvEWJA/pegRK//K48AtFmFz4VvJxG3t49eA4M1KSrjpVQeLnU12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXQFa+4n; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so11214011fa.3;
        Tue, 06 Aug 2024 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722977162; x=1723581962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LULBEc4FENaLMYCzin9zgQn6oarwP+ZKpZeZTtcHz6o=;
        b=VXQFa+4nbkeGhMZ9uZ2T5fSf+Fx1/qYR0E0kPzBPQwui69J1fqB046kpCTTqswN0bk
         viMcNvywbO+YzRQmSsVE/vK4zA67i1FgtVmFPghdFtLWqhbhVJrrHw8MQ/j8WcY/2Ly9
         sC3O9I5V7REVLnGa0ZhUU8bt8cHWlzpbuzD9zZ5fWWN6vM4TyKX+yBoMDoPzEUeYoVco
         rjOPlwd5526jO8VrEYzx+329qNqU4HJENWnc8q9E3gLRV+n8tSrUCg546ETY4jJoBsxr
         p6Ubw9DBtyb3/8Z1FnzhIZyYO4k+dcPc6pF/KR4hYQWO21o5kRE/PLpqlbICu8pQ8cEu
         tBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977162; x=1723581962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LULBEc4FENaLMYCzin9zgQn6oarwP+ZKpZeZTtcHz6o=;
        b=eWBdenwcaudBzPKXo2U+nWVE11dKsP3ExSiujC8jQNgg6T/mwZiMFxnp7BQzwcAwB7
         nQX6eEy/CFlmhcu9lGQzZ1TfRGUS6hJOeyQxyr74jSzoAJHIEZ3VcFw/LH4/PXt+z2AJ
         fLf52XD347nfgcXaHuwuYZAFTLCvqiFLPjPAUmBmDegd3rvvJJhby0Mv0pSKFIBtaVBf
         7BkxiFHFHBXzDoBoJlYaMZSRfGxllzqMnb+C3LyyTTjKfVGHNSRG61jvYYTSDj55sh2/
         tXDrdfvRIl1mdvtVcEElSGdD79BTee4/is8vdhzhNsg8Fy4D5yq6xJ0PvE2kOAoWERTn
         fHLA==
X-Forwarded-Encrypted: i=1; AJvYcCXGAIvF9K+y/wS3rnNP/i2ENMOkobhk46ml7sQn4uwrSnTgBIQr5bdj1wMb/FjKZk3jmFk7LlKDz3IQfhI2k43mIUprIxPa10T1oLbmAz5qOtYBfOXcHUQVB+vWF8QhB73Kx/ZdqM7U7nnR0xPylFknss/ezTJNDXs04amvhfv1QKFaMMzZ5Dp1gxX/8VP1oesuQMSaovvY52VPOc7T
X-Gm-Message-State: AOJu0Yx5Wa/Prd5OJxeyrtgtw9xWtbdwq5WfNNVCI3/guOQALcV/5Bzk
	37ldOi6SpxoQ4oRu40O2VtjQWOvbFoCFlzE3mCcrFyboW5aaTNh+
X-Google-Smtp-Source: AGHT+IFMeaFQDsf+dsHssdxOBCJ7gqaVJ+n/aCw9r/FzaHmGmbGdivVoVbMtHbP7QVFrNjeei9qk5g==
X-Received: by 2002:a2e:9f06:0:b0:2f0:1a36:1d79 with SMTP id 38308e7fff4ca-2f15ab24cfamr117939951fa.45.1722977161874;
        Tue, 06 Aug 2024 13:46:01 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839c23417sm6263082a12.29.2024.08.06.13.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 13:46:00 -0700 (PDT)
Message-ID: <14cd5fee-23f8-4265-96e7-22a5457627da@gmail.com>
Date: Tue, 6 Aug 2024 22:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 2/4] leds: pca995x: use
 device_for_each_child_node() to access device child nodes
To: Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Pavel Machek <pavel@ucw.cz>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andreas Kemnade <andreas@kemnade.info>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 netdev@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
 <20240805-device_for_each_child_node-available-v3-2-48243a4aa5c0@gmail.com>
 <172287362960.2885491.3573302906275384293.b4-ty@kernel.org>
 <20240805160153.GG1019230@google.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240805160153.GG1019230@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2024 18:01, Lee Jones wrote:
> On Mon, 05 Aug 2024, Lee Jones wrote:
> 
>> On Mon, 05 Aug 2024 16:49:45 +0200, Javier Carrasco wrote:
>>> The iterated nodes are direct children of the device node, and the
>>> `device_for_each_child_node()` macro accounts for child node
>>> availability.
>>>
>>> `fwnode_for_each_available_child_node()` is meant to access the child
>>> nodes of an fwnode, and therefore not direct child nodes of the device
>>> node.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [2/4] leds: pca995x: use device_for_each_child_node() to access device child nodes
>>       commit: 6eefd65ba6ae29ab801f6461e59c10f93dd496f8
> 
> I'm not sure what you rebased onto, but it wasn't LEDs or -next.
> 
> Anyway, I fixed-up the conflicts and pushed.
> 
> The patch should be in -next by tomorrow.
> 
> Please check it to ensure I didn't make any mistakes.
> 

Hi, I rebased onto next-20240805, and its commit ID matches the
base-commit provided in the cover letter (generated by b4). I wonder why
it did not work on your side, but thanks for fixing the conflicts and
applying (I checked it and it looks fine).

Best regards,
Javier Carrasco


