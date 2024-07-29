Return-Path: <linux-acpi+bounces-7117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE86F93FD2A
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941AE28319F
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84211741D9;
	Mon, 29 Jul 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3SWqDxy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C51E86F;
	Mon, 29 Jul 2024 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276782; cv=none; b=EcTGwE7+NVTz7ftLp1LKCQ8TWNKoxtk9cJd3+Fzug++O0kfWKLAv1cmNVHvtSxSwuAzSW0DDqDXEtJAPAHs0DpI2OGc/LVBAOatP7lhl65C0U/AkZ0aLwZDKJJoELUcEJLNqgVvi5fQXytGjb6NHcF3o3lw3PPdRsa1kx8yEG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276782; c=relaxed/simple;
	bh=AzNAwI/ne+wD5qq6RAFny5ViOebGt5pg329AYSpvHbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MarBtYtg8UAlK4VqUltCFOvjS2mU465m3pIPw/VW7WQ9c0lBZdItZ1GWIjblBd7rJUgNhdj2DoG3B6VMcLXFEnm1PPyI5Fw55AY6jNmQEqiKq5OVMROXpuxBUakp4UV7rKxCEb5eUIiZN1pue0eK+I+ckv2FXOwgOnlaKHND/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3SWqDxy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so10189475a12.0;
        Mon, 29 Jul 2024 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722276780; x=1722881580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2o9tbrRNJztyGaC7CsiVIizsTOg81f2IAETQUiCaIk=;
        b=e3SWqDxyFNs41smbdJ4tvxuh+wO5oDL6s41/PsbmZjc9X3atbL2q1Hs7jkzwvAlqU7
         Fb8o+OlRVkWl2lU0gy46Gt8XmiEaFzN7Z7yCPicBpF6kMs7mZW44l/znUp44STYfvdNn
         dCexq0FsdHcEXXRMQZjgt7MKtXtFt+pZWObAidTwRtprMksxLj1lIaQIdmWRuJkJdsYr
         TdIGILc7G08DwEalmoxJydGHA7ZjSWe6Jh1VWkio5WQuPUfGSGv2fxYEl1vLAbLY0j2A
         wxOMIwgfbSrqguFwkJVM4NCF2ruPjTwGEMzDEDlyMg9ZG+5Xx/meIDVVMBf4aNwdhQ/x
         m6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722276780; x=1722881580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2o9tbrRNJztyGaC7CsiVIizsTOg81f2IAETQUiCaIk=;
        b=A2Sd2SMEIgysdxxh/JNnPvv9fDck8oZRXdfI8n83BNh+JdWrSHFlTN+++I4FxOxqoX
         1MXhSA4XemP9PA17eUrjT4j5/w/7KMnOSCQTOo4H62rvT/yk/ECbGLT6PzRr0S9RrDZf
         qYCNccKkzEISyqyIiulrrMo/7V30eg14cO1d6qRCdCtwldBNSck5FtPq93sqsMCHIuXt
         35BFFujkV70W3WuH9IsHkqDyai69t0EF3doWvzrjZgvKom/SskeTQsZWvX9CiUSsVajC
         oNnK14A8tmhhibr6oFDIWzvKexrVnUqfayjmfj+KCaKzmQ1XHDN6agzlbfCnlWhJqqnN
         UTeA==
X-Forwarded-Encrypted: i=1; AJvYcCUQi26RPb1bkt+FfVm61J72usSBz7Y0DrjethDAdW6LksKHcAvXdMdeOzbWBBURqNpay4E3r+WX+kodEe94fkNNex8PJKR2i8zdWWfQj0zBPsFHcCE5pZjOyrqzOLNQfInNYAvlgrE+xSTuij0XWxCHb4Vx27XZst7SX8kGT0ElLhu61mwWZjUTdofsQijme5TV5Rsp40u3ixM3W8iO
X-Gm-Message-State: AOJu0YwHd8zC6Q/ZhtM2VriwpytWpiDdxMjdgcOpFANhBQnLORk04cyP
	A+Q1Kz6oaLWmo6WrGAccWG+M4BA4sBhW56nGVDIfpYxyXWpjZdNy
X-Google-Smtp-Source: AGHT+IG9qVVXsIUW0OFo0CJRTHe1S38d2WNiUPdTn17ou6Xg2MuSv4rzj8sX9L+7lES4C5nwHETYaA==
X-Received: by 2002:a50:bb49:0:b0:585:5697:b882 with SMTP id 4fb4d7f45d1cf-5b016cdb714mr8666310a12.3.1722276779350;
        Mon, 29 Jul 2024 11:12:59 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b104aece48sm3272231a12.37.2024.07.29.11.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 11:12:58 -0700 (PDT)
Message-ID: <094c7d7f-749f-4d8f-9254-f661090e4350@gmail.com>
Date: Mon, 29 Jul 2024 20:12:55 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v2 0/6] use device_for_each_child_node() to
 access device child nodes
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
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
 <172192488125.1053789.17350723750885690064.b4-ty@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <172192488125.1053789.17350723750885690064.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/07/2024 18:28, Lee Jones wrote:
> On Sun, 21 Jul 2024 17:19:00 +0200, Javier Carrasco wrote:
>> This series aims to clarify the use cases of:
>>
>> - device_for_each_child_node[_scoped]()
>> - fwnode_for_each_available_child_node[_scoped]()
>>
>> to access firmware nodes.
>>
>> [...]
> 
> Applied, thanks!
> 
> [3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
>       commit: 75d2a77327c4917bb66163eea0374bb749428e9c
> [4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
>       commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
> [5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
>       (no commit info)
> 
> --
> Lee Jones [李琼斯]
> 

Hi Lee,

could you please tell me where you applied them? I rebased onto
linux-next to prepare for v3, and these patches are still added on top
of it. Can I find them in some leds/ branch? Thank you.

Best regards,
Javier Carrasco

