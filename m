Return-Path: <linux-acpi+bounces-10497-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487CA0823F
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 22:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B589188A022
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21442040B7;
	Thu,  9 Jan 2025 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXAqpExJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB241ACEAE
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jan 2025 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736458572; cv=none; b=Th1nnIfCNnEwV3OdSIJ6Ei2DamK5XEgCTPvjcwfl7ZA2zav+vK/aml4mE0/lBc9JKvyS05hIIHEbGdT63HHV+JgUJ8Y2QDnu6ANcon8geUkXKpVMDyhTAHUSHwhJznGW/4Pv9HzP4LAqGtN83ljW5jK0Ie/n7spCYWQzY1Ahtj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736458572; c=relaxed/simple;
	bh=nbxjV6qH6DUpf33ktiDfaWFETdM3EiHJyKTeJVx0V54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOaItekBQnUIYVjH5xg0ACCdQ/ca0kD0JzeG+0KA5jyZcsroWnGyVrY6pnMYfRkewU9JLh/nYWf37/0JX18vP2vH66MSFq1Vwbs3sE2WnvnekAmiu4i39ySc08edJr4PJXcKfX48qFYOMVUNr7u141h9kXnuS1XEbHL2fpbh3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qXAqpExJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43634b570c1so11014555e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jan 2025 13:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736458569; x=1737063369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9HPQZCVUAnZ7shlzpjc+vwRiCC2uUgOzI+dVfgh5t0=;
        b=qXAqpExJbMxlHiQiayDWaVGxG6w3ALvCr+w65mAIMPqeM5pOeQ3WtmN7pb7fy8ucL0
         OnLMUSK5sW1ZxT2cF9og3ZIIn+Xt3tFFHWd4nkl0jYsQw2cY6V2m3GBL89pQZtT1as4K
         q8Ehdtc2KSgvTHGpLBS8AtUIaULFmpl/wwCrgtHItjhNzVlt/yDhJtltDg7qYWGucRuE
         +tzb54JIN4QowCcTEV0HuSb1ZGbihh1el4AvhJFycgt2bSF8Fgv/vTEIx0W6RjpkQAnm
         aumxc3UOx9fhr263SspdGLzoy2swZtWblV5jmWphmu8k8396PAIg7ec+bAKZNlHpZJbz
         76JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736458569; x=1737063369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9HPQZCVUAnZ7shlzpjc+vwRiCC2uUgOzI+dVfgh5t0=;
        b=QC5R7oP97IWm/XCcZmsxUdNgE/6BLqsUdyvJiclLeoW/Fvis4UyGEMKrlmmBFPbxZt
         hYCoqYJlC7vBhcYa6WQO5CKH/gsa5uQxkaMQzj313y6xk4576EIqAPqM+x/P+QdtAaxK
         BVUcFhVl0d0AJD7ISJszjdRofLHhIVxe6x8+H8sRNBs4vUU/U1NgvexnMqpt+zX3E+Hp
         UksnYFPvwLhj+dn9E80r8gj9/rDK2kzlip6sYEHEInDB4PQjbo7lmuOsX0uawA9tUmy5
         AVtBGIAlauKv6G1Z1wyTDGSJA1Jn/shTltUZjojVb97HacsR59BzwyG3baY7IJwdmWw/
         x/XA==
X-Forwarded-Encrypted: i=1; AJvYcCX21QI0sbzCUxFfSLvE8ymCPz2OP6+O3TUAPmhI2QyzWB+6yOWTy/f0BNQCy9QYgPv3kREJpmsp76mT@vger.kernel.org
X-Gm-Message-State: AOJu0YxfF8ey0M36ySxXx56c/5i5+f3/g+F9STYq7okh9x0wnbmMUNxi
	S/7qYi1ZtLWARZCpU8JliY49m84WGXDIEqD3E04B0WlDnTkvHiRSoL0HJQ1ibTg=
X-Gm-Gg: ASbGnctSy5DUBAeiLEDkrbxjF9FGFOdByfNFOnRhyGpHlLHg/1pTZzwOODSKFHZSRk1
	odwLRKoi291ajx9xKX1kcM6+xmCkS7S5ugM7JacGfaFzZFMfJMWgWQAjoj+Ce2lz/hjae1u/cNV
	ub8M7CAxfRFBZzSEqObKgxSBZ30C3+dv6JU9YbJz4mh3HAO0HhdJJWE1N96avb9KNcMp5XLH8mD
	i73eAdBxkUftBp6VGKnIKx3/GZAeHmpSNusSJ7wrneYtAGMlDX4ztCQwEFYCY0ZoeAe+kn0M4Na
	oXluC1vjvjlSRPsx/n+u
X-Google-Smtp-Source: AGHT+IHX1eZQUCDD13aWYdJo9a1TwhTHPCfOsRihU3pob2ooEDoyXQhIkgJP+CnttpbBtjp0u3RDiQ==
X-Received: by 2002:a05:600c:4e92:b0:434:fdbc:5ce5 with SMTP id 5b1f17b1804b1-436e2707f4amr75406735e9.29.1736458569346;
        Thu, 09 Jan 2025 13:36:09 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e38ef6asm2845178f8f.60.2025.01.09.13.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 13:36:08 -0800 (PST)
Message-ID: <6ed0eb0c-c31b-41b0-93ca-c6581249c7b7@linaro.org>
Date: Thu, 9 Jan 2025 22:36:07 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thermal driver with safeguards
To: Werner Sembach <wse@tuxedocomputers.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, Hans de Goede <hdegoede@redhat.com>,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
References: <41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/12/2024 15:52, Werner Sembach wrote:
> Hi,
> 
> given a pair of a temperature sensor and a fan, I want to implement a 
> driver. that allows userspace to directly control the fan if it wants 
> to. But have a minimum fan speed when certain high temperatures are 
> reached to avoid crashes or hardware damage.

 From the userspace, use directly the thermal-engine which is currently 
under development [1]. You can add your platform specific code in a 
plugin while the thermal engine will catch all the thermal events and 
pass them to it [2].

The thermal engine has a configuration file which will setup the thermal 
framework to be woken up at different temperatures.

The thermal engine will be proposed for a distro package, so the 
platform support will be automatically supported.

Beside the trip points can be setup in the device to act on higher 
temperature.

What is unclear is how the fan is managed. I suggest to have a look at 
pwm-fan.c in drivers/hwmon

> e.g.
> 
> - temperature of target die is 80°C -> fan speed must be at least 30%
> 
> - temperature of target die is 90°C -> fan speed must be at least 40%
> 
> - temperature of target die is 105°C -> fan speed must be 100%
> 
> - temperature of target die is 110°C -> device shuts off to protect the 
> hardware
> 
> Would the thermal subsystem be the right place for this to implement 
> this protection in driver?
> 
> It already has functions around periodic temperature polling and trip 
> points.

[1] https://github.com/Linaro/libpm/tree/master
[2] 
https://github.com/Linaro/libpm/blob/master/thermal-engine/plugins/te-plugin-example-game.c


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

