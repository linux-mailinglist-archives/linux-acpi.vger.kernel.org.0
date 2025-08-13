Return-Path: <linux-acpi+bounces-15637-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0F3B24918
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14487BC159
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37A2FE568;
	Wed, 13 Aug 2025 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHm4nDIj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE72F83CC
	for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086623; cv=none; b=AN3p+WjrVBe70xEfUP11yDYN3zMWY9p+xekChzvZXxru+K4OAFPCqVNH/mZkrDKM67wsiUNcNrNars2cpkrwDXrbTPMdT4I63b5K89OOc0W2lhpHRRl0R3NEiEjsbtw1LW4Wv3gaBxZO9WO/co/Slp+DPYiYRH7XYUIOl4iHIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086623; c=relaxed/simple;
	bh=WELsSM3AtKEclzA9q3wHWqr7DDhmuuJHaSOln9m13CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xrw271K9ZD/jlW+rVyXdNWSNYviQhEWmoXX/d8X7kSsT0MwsL49hEv/B4gsi7QlZRrYvtIYRtE0+suBe0XEsojmXbQJzshKjb5ZOIkHZU5ILE2lrdJYE28WTmuY7p8R4lAow+NeZ/tj3GooxoEUxZga8i1Vg5EvWGqQ8tMPVDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xHm4nDIj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b913a76ba9so1557458f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2025 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755086619; x=1755691419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3XvjMpS+8oWnYVArmJHtXmTPeaMaVACHoQ9sHAWIeo4=;
        b=xHm4nDIjOqFxlLk/Teb0mz3eMj9EIniQGMZwIHny6e4tAB/zWyIy7+xJt5ugZxRr8o
         0vaFwpP7I9eK91sghw/hfuk6XuchQ69X010eoav7Wo71pfQWXrbuBWDeh9JQb8pIVJAl
         JZPZYPUa5s3GrH7TtTNzduNwjZ5uFoSEFZYv1hjUgxF+CSdPtJLxZkli+q4PNSNQJn6P
         RHora+2TNPW0m8xS574D1yi7fBTlta9LcyXQ2g1hx/iJMZNF4x+hfmfBB8l6Cd0D7Fni
         u/6zTscajhXVODNiSvL7Xkf12ve9Hby8W2ss1q+s+gg5rqFXwgIq3apxk0DBZ0yD9cjT
         Y9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086620; x=1755691420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XvjMpS+8oWnYVArmJHtXmTPeaMaVACHoQ9sHAWIeo4=;
        b=Upo0TpSXwCLNYlAjr1LGtDAmBXZIombw6cIL4Rkd5JLI/XUgMBzX0rrG80oLHRUHDw
         C3TWq47qUn0xekbw7wl1tC+pphAuo9FmqwNUyDPdl5K2Goptq/G0bo74nIsmjNIPRQ4Z
         oxOABp3D24MRakIjKCtNgJ0rzWE5Fy0uAqMjRr0psidwH5xizDd452QVyo5HsNMzlsZ/
         zt9oM++V9CZO69Jy1q13Pi/1X9GW0lkYts4WI1FmfRQwL1y9Ms7c0/lAUKLBXkFyTYwf
         EhUk3bY03E/uxG6iBLoiiq0APgc0expb1jjjQ39rgIeG0N+WfMwDSnvR2KdaYDLV3Hz8
         bRGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0ZpOCXO2bDl+k8VIcfWw0aPDXD9bwD/iV+io1mQYM38ClkzXoEcYYLEw1CR1mPSSlWK1BnmsIHs4Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3s3sWlBjHw29CCUcURru6vfBnRtlNKURqjrcTd04QMLFMR8Q1
	1ny+UzXa/JfM/PMG7140wdTTxOtDFPKsUGflfDQHgyfwUskwXUb9Op0lQ+WkR9dJrxQ=
X-Gm-Gg: ASbGnctdxvO/ahSi6B897wkZis2Bmh0TmUnYA+IfXtVaH8MVh9M5Z4XaF71LuC/vlGF
	yb1KUdvAtqNzQ2yBfiZPFaUYiFctgwJDNMnGH82N11yEvi9w6SEhsvWhIzVL3gGBDqlihEk0vnX
	eoiCleH8d19+N4mBJvUs86cifUfHgzf+kprcyPv/VZ0HwJHYLEGq3qyVSF0IWS9rmaQiPzTE0Gr
	9tYPPXjDd1R2vBQzDKVjNXNJpPQsxxAPfmD/baX8dHggwNtSUPSjKmfQMLcre8DKmB5o5m5hi6d
	+/w1tn/tDA8x6M+mpX5wVEfF4vV8VKvX7YkM5JPsHJUwnnEb6wW1xtYKzWWcz2A1D9iy9jFLjJW
	hgCzUBm3iCV/oN8cXjsakZGV0+CcdNy1CMLI3RUFu6RU/zXUZjs9996We+3exXQ==
X-Google-Smtp-Source: AGHT+IHxp+VeWjHiqQ8aBd+gz91GtrFP/7x1AqDysrQKifIk/EESEugnh5wrM4RvHZhNCnsTelpLKQ==
X-Received: by 2002:a05:6000:290c:b0:3a6:f2a7:d0bb with SMTP id ffacd0b85a97d-3b917d29dacmr2224481f8f.12.1755086619388;
        Wed, 13 Aug 2025 05:03:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b90fdc85a4sm8298461f8f.60.2025.08.13.05.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:03:38 -0700 (PDT)
Message-ID: <f7f01234-ce5f-41d2-8a73-17f6b86dcd1f@linaro.org>
Date: Wed, 13 Aug 2025 14:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clocksource: Add standalone MMIO ARM arch timer
 driver
To: Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>
References: <20250807160243.1970533-1-maz@kernel.org>
 <20250813-macho-snobbish-alpaca-ff07fa@sudeepholla> <aJx4g8z3l438Qgnv@raptor>
 <86ikir8mqw.wl-maz@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <86ikir8mqw.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/08/2025 13:49, Marc Zyngier wrote:
> On Wed, 13 Aug 2025 12:35:31 +0100,
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:

[ ... ]

>> ls: cannot access '/dev/kvm': No such file or directory
>>
>> With this series, if firmware doesn't configure access to the memory-mapped
>> timer:
>>
>> [    0.549399] kvm [1]: Hyp nVHE mode initialized successfully
>> ..
>> [    2.018050] arch-timer-mmio 2a810000.timer: Unable to find a suitable frame in timer @ 0x000000002a810000
>> [    2.018123] arch-timer-mmio 2a810000.timer: probe with driver arch-timer-mmio failed with error -22
> 
> Ah, you have managed to test the error path. Thanks for that!

Applied (including patch 1/4)

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

