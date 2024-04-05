Return-Path: <linux-acpi+bounces-4663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B28995D2
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Apr 2024 08:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B671F22B8B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Apr 2024 06:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4E23759;
	Fri,  5 Apr 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOJjR2Vb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A11370
	for <linux-acpi@vger.kernel.org>; Fri,  5 Apr 2024 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299722; cv=none; b=K7XsNz1r3a2GHWEOBYcBxhKRyet3YU6Dx0qs4bvK4vvWTLXjV/uLMVst+wEMlYXQzXV9XaC+mkDWjiBAOglX/nAPZVQV1TmWfHT54SfPjoYCe6avbdm/6BjJ8ZEpNufgJ0CVaN5Z1h7iC/2iRTiCuNYx2TvcuwzTfeCoA/Lj8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299722; c=relaxed/simple;
	bh=/b8O9gBIJDbC8t7IFTk9NqyR6nI2lxc2utw0dqInQsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE0zSN3vgCGEEh0R+zPSn7jpm1igUwIbRNy1mlo5qwoOyoxXBbPaNJvk6GA7pe39nPpbXn6aGk+C+nFo4cX1HXoJx0PPKjeMLt3aTak1oWthVzv1+JooDt2sAw9eqpUp0FakBmiuwO9J6msA40gV1FKbZAeDYVVX62QD77Fvlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GOJjR2Vb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4162f7ea4d0so1082575e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 04 Apr 2024 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712299719; x=1712904519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYA+SCSxfqEp0pTsowJFPNSyASe14I0IoFn+b3BXCPQ=;
        b=GOJjR2VbhaWghYSpgpGMaJ55VbLAVo4eRP4Jy9UQWcbgGOlZVsxneNgy0j2bSoSu73
         TWNG/fUOm25MJa3cUMBeUkosVHkLLLm+BHFjKSzGGMQEhC0epWGnnMh125ZMIBMkkqXX
         4hPmgntGYtMGZI0ueyS+CZHhffj6h2Fj6fmuBDwJFlgiUpFQnu/nS1Vf3k9EC/K3XEv4
         B5uPqpAsX8BrkS+IzjmP467HyB9bjCBA6mYfAIpq4CsSrjO2S7lvzc6/sccmrGULnViF
         E/ZPTRXJZ2v8/ublop7vSuA6HyaxVtlB7yqKXpYOIJeKhhdxWWKJOgsHlE9haN9AL38U
         zQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712299719; x=1712904519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYA+SCSxfqEp0pTsowJFPNSyASe14I0IoFn+b3BXCPQ=;
        b=p2t4uY/QgXByRXqEjQL7PzntI/0Dyk1+T4+7xcqQVvRSKRBCDGFSWULdmvflF2YB9L
         ssArthd/Cd7zhCVCuML/duW7NWTeih4y9z6ZPt8RGvcK3IRtY+HaptrKCSYPvF1rNNG1
         sFUmWNMbLQmTsRYP3OZvB0gTklX6baeAzCmi+ykAIWNL3VEvEe7Bb61NvM4WFHZxIo8O
         DmMZ+dJfDVc3jIg2gd5aFAv7Sss5QGwJ8yyEpZ4E0Wlsk4lgGijvK0wZSyPLPvNMefP7
         spaOzJFocpT5An7PiHBFopK45SCvvMKFtTHh+93VQtuEaatYgEVsdJG8lj0eu3ROUIcc
         QWzA==
X-Gm-Message-State: AOJu0YzksfML0v/DORA1/yPt6OmiZBbQv7wtiyPdp5A9iFQFg0QGY+JQ
	Fut8c4Msmf/OQm5Fv8QCtSampAojIAy496vlMJlMwqBISkyT9X/Qr9KVI3A/BDM=
X-Google-Smtp-Source: AGHT+IHTVPfI8wZQVwV/WvqRqm+1jQjfgbqg3npICXYzkU+J+sod8+GGneWqQf8O0E1jNH0kGbGDDg==
X-Received: by 2002:a05:600c:3b26:b0:416:235d:7635 with SMTP id m38-20020a05600c3b2600b00416235d7635mr628935wms.9.1712299719505;
        Thu, 04 Apr 2024 23:48:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m32-20020a05600c3b2000b004154e48bcdesm5303559wms.14.2024.04.04.23.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 23:48:39 -0700 (PDT)
Message-ID: <87d38d4c-14e2-4c64-baba-c9b8bd694339@linaro.org>
Date: Fri, 5 Apr 2024 08:48:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] ACPI: platform-profile: add
 platform_profile_cycle()
Content-Language: en-US
To: Gergo Koteles <soyer@irl.hu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1712282976.git.soyer@irl.hu>
 <fdc1b0b9f910753967b7a9b1996e4923cc63124f.1712282976.git.soyer@irl.hu>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <fdc1b0b9f910753967b7a9b1996e4923cc63124f.1712282976.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Gergo,

please Cc people who commented your changes.

see below:

On 05/04/2024 05:05, Gergo Koteles wrote:
> Some laptops have a key to switch platform profiles.
> 
> Add a platform_profile_cycle() function to cycle between the enabled
> profiles.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>   drivers/acpi/platform_profile.c  | 42 ++++++++++++++++++++++++++++++++
>   include/linux/platform_profile.h |  1 +
>   2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d418462ab791..1579f380d469 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -136,6 +136,48 @@ void platform_profile_notify(void)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>   
> +int platform_profile_cycle(void)
> +{
> +	enum platform_profile_option profile;
> +	enum platform_profile_option next;
> +	int err;
> +
> +	err = mutex_lock_interruptible(&profile_lock);
> +	if (err)
> +		return err;
> +
> +	if (!cur_profile) {
> +		mutex_unlock(&profile_lock);
> +		return -ENODEV;
> +	}
> +
> +	err = cur_profile->profile_get(cur_profile, &profile);
> +	if (err) {
> +		mutex_unlock(&profile_lock);
> +		return err;
> +	}
> +
> +	next = ffs(cur_profile->choices[0] >> (profile + 1)) + profile;
> +
> +	/* current profile is the highest, select the lowest */
> +	if (next == profile)
> +		next = ffs(cur_profile->choices[0]) - 1;
> +
> +	if (WARN_ON((next < 0) || (next >= ARRAY_SIZE(profile_names)))) {
> +		mutex_unlock(&profile_lock);
> +		return -EINVAL;
> +	}

Why do you need to do this?

That can be simplified by:

	[ ... ]

	err = cur_profile->profile_get(cur_profile, &profile);
	if (err)
		goto out;

	profile = (profile + 1) % ARRAY_SIZE(profile_names);

	err = cur_profile->profile_set(cur_profile, next);
out:
	mutex_unlock(&profile_lock);
	
	[ ... ]

> +	err = cur_profile->profile_set(cur_profile, next);
> +	mutex_unlock(&profile_lock);
> +
> +	if (!err)
> +		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_cycle);
> +
>   int platform_profile_register(struct platform_profile_handler *pprof)
>   {
>   	int err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index e5cbb6841f3a..f5492ed413f3 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -36,6 +36,7 @@ struct platform_profile_handler {
>   
>   int platform_profile_register(struct platform_profile_handler *pprof);
>   int platform_profile_remove(void);
> +int platform_profile_cycle(void);
>   void platform_profile_notify(void);
>   
>   #endif  /*_PLATFORM_PROFILE_H_*/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


