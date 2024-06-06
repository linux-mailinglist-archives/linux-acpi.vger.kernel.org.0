Return-Path: <linux-acpi+bounces-6236-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B88FF2AF
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8770D1F2270B
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07BB19884A;
	Thu,  6 Jun 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrmS2OSU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3E197A88
	for <linux-acpi@vger.kernel.org>; Thu,  6 Jun 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691946; cv=none; b=rEOl5RWkdaHpGDJWpkDaYRrAmFtmnikcMt5ulTFJIZ1UITDYNJnuf8gauUIk86QCDJ5KGnwDS1/g9tI6Pd78LtUFcGFJ/NHezIeqe1xMQyPn0TxdSih7lE7XX6PDxUkPvTcuAxAKMfh6cBRISeMdzGIZI1RHrBVXGMDEuM6ickM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691946; c=relaxed/simple;
	bh=0sUhzePxA5ILJh6kcxhT9jhNMheNOJsBhpMUA+zrAr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FU3QaZUEqZY2OiRKpRYjqPHvAqShmgEPlPIT7vVFtCAmF55GyXHr3wYrjB7aiPn4Yu3IwevrZbb46Kb937gPHOlyM88W4P719lDcSt7kk++0n8jmaOR25lX8XZd4PVwW8+airos8lw5pW8OtQzob4DaRAZ8HMLKVB9IPbeI13lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LrmS2OSU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35dceef429bso671337f8f.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jun 2024 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717691943; x=1718296743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXdSRq/xXQtY4fK65pJyyKeGGdpvh+lT4zYhLPfTB4c=;
        b=LrmS2OSUCUbTBiodfAgWSYWBnMDqVBYu654UCCncw8BnmKEab2fmtG3UBUnMs/iZ4U
         Y6rR4or+YvlJn3ET8aiaNNIMcJh8yC2MqGvhYuFS9fM/aGPSHmwYXKdaSbKfCFfsOdU2
         mdkhX48BAncBwkaRhRb3JlYBtUyqkoz+iL6HwJpYZEvxVScQtXMKno38jZpOzuLt0leq
         w50y1EQSsgPA0+YNZK36o9GjH8ixnSawCSVNUnzlLZRqCJGYBm5bHo7Ciyt6E0SG2HS7
         vVzeFAOPa7hESOy3Zaa0LmlnB1sHGLAsWo63dAkbMTRo7r2iM9HXh7mr0oFH1CJR//B0
         vUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691943; x=1718296743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXdSRq/xXQtY4fK65pJyyKeGGdpvh+lT4zYhLPfTB4c=;
        b=aFaU+AfEFPCnK0wl7C3KN306siz97XI5RNqu/tQ8rO4QWTM63gurz1k/WWkIJdfcoc
         3MNYwlXIjaHsDNix6XYvv/lLsVd21+IjPUmDAQVW/pf8H+wb4a+qDzgy6FBHzpqn+MWO
         5rlDPqQ+AhEGh749fQIUuH+3kdBn8QEgjy6eFDXTuAMsyTxG4jBLBTJLWcO6rs4O1s58
         jp0L/5XymqQPo3UTFNS798Fh1eEdjJgqzfliQSg2S2O6WRvJ888FIPmDRwEvvtyBPmo9
         t34AMywEUpJ61C7d+x3rN5vI1La0WLrBTxAg7BCegy8CyVQVN/oKrxkwfASWbgphu+gT
         ODIQ==
X-Gm-Message-State: AOJu0Yz4Kw+FJsdFbH/oMK44rj4d5UtZBtzrfuK61RgcwQ7i1bcCtcsl
	mBfk8RYSCdOuX2pdgILGXRzhIz+Ipn2bS4zLqwYE/nfcKX57Qnus2afOYJDtM8w=
X-Google-Smtp-Source: AGHT+IFtjI2uG5kxWT0xfMI3B/djVg1/Aj63CZXkzzrEcegz3u68SQVBpTCW8tUcw72ZesSgllhIjA==
X-Received: by 2002:adf:ed52:0:b0:355:b9d2:4667 with SMTP id ffacd0b85a97d-35efea6fa89mr211455f8f.29.1717691943486;
        Thu, 06 Jun 2024 09:39:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f9a9:3740:b905:9995? ([2a05:6e02:1041:c10:f9a9:3740:b905:9995])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35ef5d4a827sm1984629f8f.36.2024.06.06.09.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 09:39:03 -0700 (PDT)
Message-ID: <a5476bdb-da6f-40d5-baa9-fa2caea72e3d@linaro.org>
Date: Thu, 6 Jun 2024 18:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, Laura Nao <laura.nao@collabora.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <6056838.lOV4Wx5bFT@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6056838.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2024 18:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
> Accordingly, modify __thermal_cooling_device_register() to avoid calling
> thermal_debug_cdev_add() instead of returning an error if the initial
> .get_cur_state() callback invocation fails.
> 
> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
> Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>     * Instead of making the thermal debug code effectively ignore the invalid
>       initial cooling device state, simply don't register thermal debugfs for
>       a cooling device if its initial state returned by the driver's
>       .get_cur_state() is invalid (Daniel).
> 
> Laura, please test this one even though I don't see why it wouldn't work for
> you if the v1 did.
> 
> ---
>   drivers/thermal/thermal_core.c |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1001,7 +1001,7 @@ __thermal_cooling_device_register(struct
>   
>   	ret = cdev->ops->get_cur_state(cdev, &current_state);
>   	if (ret)
> -		goto out_cdev_type;
> +		current_state = ULONG_MAX;

Why not move the section ? So we end up below.

>   
>   	thermal_cooling_device_setup_sysfs(cdev);
>   
> @@ -1016,7 +1016,8 @@ __thermal_cooling_device_register(struct
>   		return ERR_PTR(ret);
>   	}
>   
> -	thermal_debug_cdev_add(cdev, current_state);
> +	if (current_state <= cdev->max_state)
> +		thermal_debug_cdev_add(cdev, current_state);

	ret = cdev->ops->get_cur_state(cdev, &current_state);
	if (!ret)
		thermal_debug_cdev_add(cdev, current_state);

Additionally a comment here to explain why get_cur_state can fail and 
telling it is up to the driver to fix its routine?


>   	/* Add 'this' new cdev to the global cdev list */
>   	mutex_lock(&thermal_list_lock);
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


