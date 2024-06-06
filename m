Return-Path: <linux-acpi+bounces-6244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E888FF5C9
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 22:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540BBB2168F
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3A73453;
	Thu,  6 Jun 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPY3czMJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D538F9C
	for <linux-acpi@vger.kernel.org>; Thu,  6 Jun 2024 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705257; cv=none; b=TqOcAnXB7GGk5y1jtFtvIn28ASUHIWbl5+NxJs0QhegjnDw2p+mECL8Jg+bNbJ8j+4c5ssbZjO/sfJwkUcK18VBhxlOaD7/LHk/i09ERZKDN6fMgWfkI13T5zxVPwFew1hNaJrjEm6brE+0xysGD0Y/tUzXtcZ/uVwONIzb8BwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705257; c=relaxed/simple;
	bh=ZhN5psr88O1rTZYnaj0Pp6eojbRqBJN+Mq+LrsdNdOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUk/uxueprWdkny31CErw2UbdOCPTdAKNbn/N7NL8aCU4zfX/Bvjlx/dGUVMIRdCd09/Jm1n0brtjQ/VV50uk0wPX0ty+ZbMgyCw61EVMBKkhio0VC8MZs0LdEH17P566yBs42UuPYDSWXJ13n7eT3+I5dbDxy3VEgN8HWCKj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VPY3czMJ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b9dda4906so1980144e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jun 2024 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717705253; x=1718310053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83UooEInBqzhI2DlCSt/csP7JuwUOhdJysD+ewzTrGo=;
        b=VPY3czMJ3YejXbhqCZ9aBdOLp6TvNZcxgEm59A0kdPfyU46Jc2JGICqxrFhqjmcWC0
         G5smW9rvX8Tc4sv89t4ZZ3LKMdYltI9p9AOFpVxPWeJkTxczd189ZFZXnHATg4StWRIE
         8i92JcUnhdWMchcVvHPFEW0i74qtynEelcagmJKlCf9ng2ruI4F6kqvQoTlHagU3qBsl
         VLCeFwV6TGNYAfuMjyfvIC4Wi2mEu55hczNFF1KIgFYm9oWF9WMsro3qaiCQEYfwOAeT
         G9wL6+NM+yk5pVKgxBRuuLmqU3SI7TonNHbSuJhOgRuOVSpGh4jxNNJthwmxECt9dIFO
         LegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717705253; x=1718310053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83UooEInBqzhI2DlCSt/csP7JuwUOhdJysD+ewzTrGo=;
        b=foQGBG0HuQjiZOer4TQow30Sh+7wuI0qnwv1ACC/F6Z5EjHLNiDZeP/VihH3lr6H3h
         r/wy3ZOjV4+PpYB9oTsWTMxv1PFBtzc9B4MourqYwe97ejA4kNmYNyJsa/yS8p2WzM7q
         6MftRk3Dla2HoFsQqk9lBRzkSOHI2Zb7iZg092wYg3CTUyyMtuOU6/l039AJmn2Ky2Ed
         ERjjnxhPN+vZ2d65oT+LEJlRKpgRQRh5G8oU3Oj7FgHYYruquFjjcUAds0cEVpVd5G7r
         ZA0fvRvNFaB0xaDAhe0o29qF4GkEigZ1vZn6dS2LSmAZrzGEcC3OyIum9uPAUUxpP8p3
         BIMQ==
X-Gm-Message-State: AOJu0Yx1YrL3LC1aBTO/v7KMn+8+pVhzYdOmFxF/I2dUJS1uAbi1zzWd
	CY8NfuGaZ1P0Tf2gkDzdz06mHjbmOOwqtkh4UcfyxmUFZr7g/ZNaEYT8ACLqktE=
X-Google-Smtp-Source: AGHT+IEdG8vgcBO9N+bQsEADxiJZEJ8P0VduttpUVKLHZAp+J5ZqcCuSthLDPZi8nT7v2tqh/BTMPA==
X-Received: by 2002:a05:6512:3e01:b0:520:ed4e:2203 with SMTP id 2adb3069b0e04-52bb9f64915mr689722e87.8.1717705253100;
        Thu, 06 Jun 2024 13:20:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f9a9:3740:b905:9995? ([2a05:6e02:1041:c10:f9a9:3740:b905:9995])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4214a4aab93sm70618805e9.0.2024.06.06.13.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 13:20:52 -0700 (PDT)
Message-ID: <710ce159-728b-4dec-854c-bbfd6b4bf6bf@linaro.org>
Date: Thu, 6 Jun 2024 22:20:51 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, Laura Nao <laura.nao@collabora.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12456961.O9o76ZdvQC@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12456961.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2024 20:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v3] thermal: core: Do not fail cdev registration because of invalid initial state
> 
> It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling
> device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> to fail probing on some systems which turns out to be due to the _FST
> control method returning an invalid value until _FSL is first evaluated
> for the given fan.  If this happens, the .get_cur_state() cooling device
> callback returns an error and __thermal_cooling_device_register() fails
> as uses that callback after commit 31a0fa0019b0.
> 
> Arguably, _FST should not return an invalid value even if it is
> evaluated before _FSL, so this may be regarded as a platform firmware
> issue, but at the same time it is not a good enough reason for failing
> the cooling device registration where the initial cooling device state
> is only needed to initialize a thermal debug facility.
> 
> Accordingly, modify __thermal_cooling_device_register() to avoid
> calling thermal_debug_cdev_add() instead of returning an error if the
> initial .get_cur_state() callback invocation fails.
> 
> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
> Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


