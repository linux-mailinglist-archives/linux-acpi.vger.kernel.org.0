Return-Path: <linux-acpi+bounces-3844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD7A85F5DB
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 11:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9D7284465
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364EF3F8E2;
	Thu, 22 Feb 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nubu1fyR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659339FFC
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598104; cv=none; b=MuyrxZbKInBPH/9KKKJLwjqa15a1+IsTusOH56itUF0CggIKSXCTpXWKp9OwgF+u9r6sapKhhljBFHjGOImzG8l2astdpRyjUSsAv7pp3JKN7X/j88bEuSIBplVoEBcngvpyqTVH0A4ysqqhQ32ie+1jwbvIGOt2n8CjOkB5tSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598104; c=relaxed/simple;
	bh=DUuD5h3whIgZurEejVIOfjuaYKqtr3eaOdEzgCLsmvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=To7D174enjBMEBkUzQD7hjbbTCR1xOgGBe4Q0mhZ0R4jp61r5Kbrp/H2vTwfKB0lO6WPnBAa0aU/BWupsgr7SkiVnpxz/LVgdnMOfcAhMQhnQ1nim/Egaof21BNqmJtlLz3OgokWDegBmwQrCd4lyeMNseAKo5AU2oVrat3ne+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nubu1fyR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4127a0d8ae1so7802835e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708598101; x=1709202901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=099bI5whegJNM3kSvHcOsymL7sW/VeG2lWeP0GznoQ8=;
        b=Nubu1fyRYOH6t1kPysYfEatDHrpl5VY0BVpl0kIxTt+qCR4zio9I5rE9UrXxu2ontI
         tK66eSnqk0TUKK0+zUPnHbG8/DkRlUpI/DnCRhuw5KSD/oswGITmVMkIKMP9F3AzNxzP
         9UrgrbGqwLkRLyTnTEUuC9NFwkQfaJfN96AAHpQnVQUQ67qFupTGLhBDNx8hLhLwbUX/
         cndoRs6jdqzxiY+BVn9q5dhuuj2rrLtkkAI3L6U9AkfyiUaKwDVnhwZTTdxSEBMUxL29
         d3oNMYEbcD5X4vdjD4rmoipYL0uM9XzzbNh/yDmYfHBurugfCJac3wmjGIY5yo/4x1Uu
         PWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598101; x=1709202901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=099bI5whegJNM3kSvHcOsymL7sW/VeG2lWeP0GznoQ8=;
        b=bLBJwNe78cJnz2q3L+u6FuMGIFjrx8AmmPZDI/Mpt9gGc7sukIM0vo7rDycYy967yu
         0ktrYYtLiDjIeIp7FGMzPFXMzDjcDpAAt514X5pKLry9ntIiqu/40fxlS2KUZ9yhd+BI
         eDd6L2IHPBmIb7+sQb2HF3o+q4Lx9efCXCzE/WOPnAFsoN6n2lTO43K5bz3vLCT8AYQQ
         +AbAgEd0iy7+SKhZiHnbgtH9Xga2QrFdwpHTJVaiuM5u3l+s9182Nbu6Y0GnLU5zkAWc
         qYktt82vEXAlbuNzRe7zIl+jXP7ZpJEwsJwgG9E0mn0LnRYwtv/69EygCGOTdFzrJzio
         y1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWyO5Iff0OXJUP4WJC0wnB83UlNi4GoL649N9YUg04XyR6eZjKlsOeZyveBebsDx8w7FPYimRwFKCo2uPkEz04haFSivNMYdJZN+w==
X-Gm-Message-State: AOJu0Yz2umhUd+dXlWlXSKm5uDxLhsoWRr7LYB9lSItgOFvesqrNj5Rh
	EwA+AB88hz0fn4TvPjrC20T/K5Zs970h+Sg5sO/pCNrLUlWJF5thP/LTXgQeA0s=
X-Google-Smtp-Source: AGHT+IFy8GOQQB6SlMWw6li/ppqbiYFPN6dz8gJI4RgkqeNAmBoIQEonmSoWKBV4qkxMOL7S4P+J7A==
X-Received: by 2002:a05:600c:5390:b0:411:c789:5730 with SMTP id hg16-20020a05600c539000b00411c7895730mr15352026wmb.35.1708598100671;
        Thu, 22 Feb 2024 02:35:00 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f9-20020a05600c44c900b00411e3cc0e0asm20587921wmo.44.2024.02.22.02.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:35:00 -0800 (PST)
Message-ID: <3669e59f-a8d5-4f29-a0d7-3b40938d84c2@linaro.org>
Date: Thu, 22 Feb 2024 11:34:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] thermal: intel: Discard trip tables after zone
 registration
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <3287354.44csPzL39Z@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3287354.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the thermal core creates and uses its own copy of the trips
> table passed to thermal_zone_device_register_with_trips(), it is not
> necessary to hold on to a local copy of it any more after the given
> thermal zone has been registered.
> 
> Accordingly, modify Intel thermal drivers to discard the trips tables
> passed to thermal_zone_device_register_with_trips() after thermal zone
> registration, for example by storing them in local variables which are
> automatically discarded when the zone registration is complete.
> 
> Also make some additional code simplifications unlocked by the above
> changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


