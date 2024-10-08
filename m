Return-Path: <linux-acpi+bounces-8630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B91995BAA
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 01:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CB61C21639
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 23:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC81217906;
	Tue,  8 Oct 2024 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTHIxwpA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348D216439;
	Tue,  8 Oct 2024 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430283; cv=none; b=aQHvXvO3l2B5V50gG47uYePS+JPd00AuLUxkZOTvFdLHfigzzQOTmuD2fXGWLFkAtaOtcehghn8N3dlhjo5sfOuMLYMVct9QYxPpqbaKfGj/4bY0fFWCDKb3GfZIn5aS9P6MSq/e7Rq2Lle18qYMXS4H0mWgBXf+XsG1oa5kz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430283; c=relaxed/simple;
	bh=VDGMU5WZHuvqxr7FgPWeyyE7QtGVwNYJyd8BIB0gy8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhO+EZqLKkeOlGVzgweu9i8gX4yEO5kVcpr8O8YSDDaSkAHkQX2EkBheVr1kLLOtHqmAXdb88u4iXCRKEwcA9ziN0NTOQ590W4ZtGuHXvn9B9Jo7eunmweK0eWgrNKSsbMazVIXbKDNTKWvY/yIIssNZUOshX+vKjvMJwm5o4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTHIxwpA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e5e758093so54801725e9.1;
        Tue, 08 Oct 2024 16:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728430280; x=1729035080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFPM3Wu9TF6M2qSYi4YrdZFh2UBbej9+288IJ9sOEks=;
        b=kTHIxwpAJYm93NvZB6H6HaY84dlmDj65BPvl+6+42MwxR3/q+OCNNNSAdkoh2NQTDU
         s/BTfPj41wKBx5sj5wjkLiad2sRNZ0kQniP9sJQHOlZkLdf2eLtQ6hAEDd7EyZ+PKIBd
         0L4qZQsEfs8Z1JiNBfB8iP0gs6NS2jJM4jvIR4bl9w1pnii0BBZGOlyuPKPJhxEBJF9l
         CtI3IySwZfdKumP3SGrakTE1a4JZxShdHsYmUM+BthN5QKwPg/PsIphg0uiYLjktmCTn
         mC4niirB8AqxCg0NH2WbT7Rj1YbkAd0hLQxZFGk+7QLqcLq2Ed1at0vi//33wPw+IA6j
         kh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430280; x=1729035080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFPM3Wu9TF6M2qSYi4YrdZFh2UBbej9+288IJ9sOEks=;
        b=th2slyC/c26/lrRXRojEHwTBqqd15icE72YcjJEau2MlNQ038trm6gzeihE3bN7fIS
         assiszcjva5xpnXd6RI/gLV4m92160Tenvr3QS/B72sPUlbmFoh+S/Ku5O3ZQhJfU86+
         gkO0WtySqDR9JBL/dzVRVVMOpUF7Pm15Oqsplno3MR6pE0/r55ZELiYWVyTeExpcKc08
         CnMGyAePgLlEZwlbz1nGkWQrvA3aNe6392/V6zWhgjCQHJxr7G6Ej7WIPD8juK7kacJX
         jOvFvSrpgp9k52F0NdHxwk37WD+qwsCl2akxsqGBqPb5PqPG70GbOMNJfrPeeISmkLXZ
         D1rA==
X-Forwarded-Encrypted: i=1; AJvYcCUu0/jZoo7cQ8Ed6kqRl/eBC86Bg8cKuOGrLIZw7LTQJEPs03sjBIhwS1viUnA2qwHOxFA+hAQe@vger.kernel.org, AJvYcCVMSuTYptPki7k1O01A/QnJIi4TFwzVGa2irXpCJls0+czfSVIs0bkPyUq8kcM8sbwLvAHWJhqbbVBP@vger.kernel.org, AJvYcCVu6xGschgeGDOZATjIrlSoA0ce9VbDf+WwC2booTF2quqD1JYPvv5kUzUx9guLsQd/hBA9pUzRRQ34nnJ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LNcWK0pNtNI4B2S9qtaKMnvr6fIzrgntpTSz5iMnEJ+9rXk1
	ytNM9qti1U10s3LpwG0RvjRNa4nZ2v8n7g/f7yt+5RFn6FRrG+93
X-Google-Smtp-Source: AGHT+IElCc/NZmfKE5im85XAtFU56QqkH32fN2ZtakhdcpQajRct3r2xKETt6ywaKeiJ0dt5pk97sw==
X-Received: by 2002:a05:600c:34c8:b0:42f:8ac6:5198 with SMTP id 5b1f17b1804b1-430ccf31c52mr1897525e9.18.1728430280175;
        Tue, 08 Oct 2024 16:31:20 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:9b9e:5f2c:2784:bd78? (2a02-8389-41cf-e200-9b9e-5f2c-2784-bd78.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:9b9e:5f2c:2784:bd78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b41bfsm2733565e9.29.2024.10.08.16.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 16:31:18 -0700 (PDT)
Message-ID: <3a325efb-af05-4e39-b9ae-587d55af9b0b@gmail.com>
Date: Wed, 9 Oct 2024 01:31:14 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: dsa: mv88e6xxx: leds: fix leds refcount
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-3-cfd7758cd176@gmail.com>
 <3efe3c1a-7ce6-4055-a9b1-31a7e23f9417@lunn.ch>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <3efe3c1a-7ce6-4055-a9b1-31a7e23f9417@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2024 18:40, Andrew Lunn wrote:
>> -	leds = fwnode_get_named_child_node(p->fwnode, "leds");
>> +	struct fwnode_handle *leds __free(fwnode_handle) =
>> +		fwnode_get_named_child_node(p->fwnode, "leds");
> 
> https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
> 
>   Low level cleanup constructs (such as __free()) can be used when
>   building APIs and helpers, especially scoped iterators. However,
>   direct use of __free() within networking core and drivers is
>   discouraged. Similar guidance applies to declaring variables
>   mid-function.
> 
>     Andrew
> 
> ---
> pw-bot: cr


Hi Andrew,

Thanks for your review. I have seen that the __free() macro is used in
multiple net drivers, especially (but not only) __free(kfree). Why would
this one would be discouraged?

I would have nothing against declaring the variable at the top and
initializing it to NULL if that is the preferred way in the networking
subsystem, but the __free() macro seems to be well established, and it
simplifies the code.

Otherwise 4 calls to fwnode_handle_put() or a couple of goto jumps will
be required to get the same result. Moreover, if any other error path is
introduced, the mechanism will automatically account for it.

Best regards,
Javier Carrasco

