Return-Path: <linux-acpi+bounces-6697-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C210A91DB8D
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 11:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BE51C212CB
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF747C086;
	Mon,  1 Jul 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC8ySdEb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB58524C9;
	Mon,  1 Jul 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826547; cv=none; b=HIadCvsIIL93cRYXd18PCYTHYmDVIFfelOAO/oyMNhlGwdhVvmg3cG1vZshvktoqXbQSXDjIWnQn1e+5zcLcWFbA/O7oOabxcknICYnKndNIYOKDE2WJlf+o4/A+99aC/+hvEVHQnMbiZgZ9wmZViBTXB4KMyF641l/j6zpL1wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826547; c=relaxed/simple;
	bh=59nWDz5KyWpQYxZk1EUqpoOhyJdMTuiAo37okGxi7JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8xdIO1j6r0VeV2aoLNl0QGV72VK9/noJDuirDLyhPfKibEY5ewy+xVDi/K4OFX9XxuWWKT3+t9fXzciQd+G+tXCCCOTz9L93vRzJ0/jDwpsCFUq9WAK8Wk8t9TMeYEM1UPhbsUazximeuNcNzk3YLK9nBi8xQAejM5wB3b4U/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC8ySdEb; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e8b27f493so640506e87.2;
        Mon, 01 Jul 2024 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719826543; x=1720431343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNtVDXlUBrpuhb54W707Pwv7hKueeWy4QSQTipfsCuo=;
        b=NC8ySdEbINopdim8LCsHMC+6sZuSZcEiJsIvxMsYxaA48jb8cX6C2OrKpwgaDCgTiw
         /O8LB1SSHG+zXfOmd7/ku4d6wC4OFIWZp0V6HPTXC09/VdGEngT2CQgr6QUDAFwkvEsR
         anwx4fxFJAaWAXUMGhyTEo98M/dKf6o0ALZdC/sSsIPirhA99BR/DJxyGXzV8IgCZWtq
         Mpwv1e6odbeYrMEVGJFIY/3M/Q4RMkcQj4YN01PcvcMb+GR4EGIPlhs6gJ4H04jL8wTa
         zCGDMl2MPms7Jdl1phQcIUzkIOc9FaQ+pxM/5RyBvpFmyeWjN84TCDn1tOdlI7cN+J3Y
         tlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719826543; x=1720431343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNtVDXlUBrpuhb54W707Pwv7hKueeWy4QSQTipfsCuo=;
        b=R2goiGMfMAA6sQhAm/teST/6ICjHWlZk6zFkdPi0HHO22OEYJX87SIGnRba5F0bJAM
         KUeDMlYM4dz8+gRRT+0AHSSqM58Nns5tnNLXG9Cwk2l+76g/1hulE2eYmkYAsdv4AngH
         BF3P71FOJkEhcdPUUbMf5Wc4Ky69r4SjvD0ir8hjcf+Ta5Fh8kK9of4vghOkv20i4Ilk
         4fF8zJJxtTTFIxbaTWsZs+xWX4G/ONBxUwINIhuQBEL2n2u9jjRCIQ4+T92OrphxEQkt
         9vy+XJn+GuKgTD5PWKbxsp4uIjTTYk2WAaMRsyltvLK8zSk9OE+F9fYhG0cvsTFPYe30
         tIKw==
X-Forwarded-Encrypted: i=1; AJvYcCW2+GKET32uuUnU0p0BheqXwtxYb1PAJW0TJ6PNHPU1YqcmhxQxTnJknVi4/N6x9zzKYdvguHgdBQDHPaH6wItcmh2ndLQILleaUddd6UOYdus4Q0f5/HCvMPld44NiZzasItrssWjMyuj+ZS14nJTCyHwN0UR2K83fGvuDoSrTTf6085WnDCNMpjXi2V8Evqvt2DEe3CXRP4uz7KWDIRljKQ==
X-Gm-Message-State: AOJu0YxQwAQ9frmG6WP7gt4+c/UA7o0E4qr8Gdsyo70qno211bF3ayBv
	HZAw8m7ySBMlYv9Jr6Y3tbc6NkoIg95a2VenfC5ApohpYzFDmIuS
X-Google-Smtp-Source: AGHT+IGTWlXt5GwVSpONKN18jUPqOio2BQyzMNx8kLyn1xpM2UpBf6ISd9dLJbwj/YGEYvPKtguBoQ==
X-Received: by 2002:a05:6512:e93:b0:52e:7f3c:6b81 with SMTP id 2adb3069b0e04-52e82687479mr4007321e87.32.1719826543231;
        Mon, 01 Jul 2024 02:35:43 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf18c99sm314224466b.2.2024.07.01.02.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 02:35:42 -0700 (PDT)
Message-ID: <cffb5885-3cbc-480c-ab6d-4a442d1afb8a@gmail.com>
Date: Mon, 1 Jul 2024 11:35:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hwmon: (ltc2992) Use
 fwnode_for_each_available_child_node_scoped()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
 <20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
 <20240526144851.493dd3f2@jic23-huawei>
 <3a16dc06-81df-4493-bac6-216e9c6ea16e@gmail.com>
 <20240630124157.07bf97d9@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240630124157.07bf97d9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/06/2024 13:41, Jonathan Cameron wrote:
> On Mon, 24 Jun 2024 23:45:42 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> On 26/05/2024 15:48, Jonathan Cameron wrote:
>>> On Thu, 23 May 2024 17:47:16 +0200
>>> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>>>   
>>>> The scoped version of the fwnode_for_each_available_child_node() macro
>>>> automates object recfount decrement, avoiding possible memory leaks
>>>> in new error paths inside the loop like it happened when
>>>> commit '10b029020487 ("hwmon: (ltc2992) Avoid division by zero")'
>>>> was added.
>>>>
>>>> The new macro removes the need to manually call fwnode_handle_put() in
>>>> the existing error paths and in any future addition. It also removes the
>>>> need for the current child node declaration as well, as it is internally
>>>> declared.
>>>>
>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  

...

> 
> Straw man for people to shoot at:
> 
> I think where possible rely on device_for_each_child_node[_scoped]()
> actually meaning the available nodes.  In cases where it applies that
> is normally cleaner anyway.
> 
> If you find cases where there is no relevant device (I'm sure there are some)
> just provide fwnode_for_each_available_child_node() and not the non-available
> one.  If that means switching some drivers to use the available form as
> part of cleanups, at that point we consider if there is a special reason
> it actually wants the non available modes.
> 
> Ideally we also add documentation to say the device_for_each_child_node()
> will (at least mostly) not consider non available nodes.  It might
> be always, I'm still personally not sure on that!
> 
> Jonathan

There are multiple cases where fwnode_for_each_available_child_node()
seems to be used just to get a macro that explicitly guarantees node
availability i.e. they retrieve ’fwnode’ out of ’device' by means of
dev_fwnode() to pass it to the loop.

In those cases, device_for_each_child_node[_scoped]() could be used if
it guarantees availability, which no one could refute so far.

On the other hand, there are other uses that do need the fwnode_*
variants because they iterate over nodes inside another node which is
usually retrieved via device_get_named_child_node().

If there are no objections or better proposals, I will proceed as follows:

1. Document that device_for_each_child_node() means availability.
2. Use device_for_each_child_node[_scoped]() instead of the fwnode_*
variant where it makes sense.
3. Provide fwnode_*_scoped() macros.
4. Use the new macros where needed.
5. Use fwnode_for_each_available_child_node() as the default where
unavailable nodes are not explicitly required.

Any additional feedback, especially to clarify _availability_ in the
device_for_each_child_node macros, or to provide a case where
unavailable nodes must be considered (Nuno mentioned CPUs, but just as a
vague idea) is more than welcome.

Best regards,
Javier Carrasco


