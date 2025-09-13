Return-Path: <linux-acpi+bounces-16850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D82B56000
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 12:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570D8583317
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F362EB844;
	Sat, 13 Sep 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZ+303Xg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B42E88AA
	for <linux-acpi@vger.kernel.org>; Sat, 13 Sep 2025 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758225; cv=none; b=c3x+Jxrh2+MHnUrYQiQ2oshSHf9yrC0GJ34MdA7ssjwn7WdzX0F/FpuZJqjw2yLyZdYLwRSJPrmxBKBEV02xVFZ8EeM/SXz3szbhwhJUXvQvD8VoztwKQoxwkmIOPouhMNGsRx0IDj5nlgJRHh7OKzZWeOTWEOFOuzwR2vRxQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758225; c=relaxed/simple;
	bh=aMFcNbEXukY3wSbBUT3r/l3d6jo7BfE6/IqgJ5N4Gns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjiTS2e4yUKgBdKrTQssK7N7BIC5Q2CpXzKtEhU67PtOx9hoOFJL7zoC87OM1Vbmwqo7NgwSvoii3hBITGCPYwLnJvzKnZ3UoJwnFzARvNpiH8R6G9ODHqG/XVUAFO6BgtniLoK98Ww5yGGwEF8cLyCSzhmv/fWwAU3MbioMKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZ+303Xg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757758222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/X0kD5TMeuhtLYcyW6WkVUV2HWQ4P43mTqPAQRNK6Gg=;
	b=PZ+303XgwtlF6w58U3NtVwSAfIIbn0tvcKi5roZ+Pyi6lkLbIzZH/niJItbZA0bo3dUtaB
	hNGwAMY+ycxZd7Nw1z9eiupr8ANH9g6yxgbC7IjlbqRq+BReMT31eI1SPBcYsTrMDIHohT
	MAp3tUrJgfK+hBeT5/dM7Xny/yT7aHM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-HbCCXIpnP0-elaBKypZ3qw-1; Sat, 13 Sep 2025 06:10:21 -0400
X-MC-Unique: HbCCXIpnP0-elaBKypZ3qw-1
X-Mimecast-MFC-AGG-ID: HbCCXIpnP0-elaBKypZ3qw_1757758220
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-62b77ca3f64so2517620a12.3
        for <linux-acpi@vger.kernel.org>; Sat, 13 Sep 2025 03:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757758220; x=1758363020;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/X0kD5TMeuhtLYcyW6WkVUV2HWQ4P43mTqPAQRNK6Gg=;
        b=t9v0rA2QMQdWrAkWrX/mIiw6+aNg0ahMdNskG7j9IfxbtwrdOFy2hTV6opXC/aPjfm
         8thfIO5fv1pIQqvDu6JLrVrTzPrvYe9CYOPzKn+dR/Nha/LHAX1TS1aeHBoJgaCJD062
         FrOCxMqqYbHvcAqRs0Er46xyvCbwS5D4LgzgLosgVV5sTXcM5Mzky+I6Rb02JVIf31lK
         3dDKwmEoPRcUe0ehq1vV8ECX/OsP0SnNGyKtEF6xruL3+LDBlijISyflPdck5kTRH09M
         GyhQM8JYHk4cfVNgBRmybT2r1zBAKWTgGRJKCPhzPjKa/Lj1cABEQZ8Z0hyCCMQqCT9T
         FEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGksgZmWn3on+e7Jazya8B3cqF+Zj9DO6i/U9k4+TM6EcEV8l5+mcEzcUF12TbwWrqV4Vbpmd9/+ZN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0UViidtzFXHkbml3uqoyRo+qmkPZhsaG5Hhf5ga8ir7noF1P
	n45xDTN0gZ3SGeC51lVhH1KSk9hOJAsLXZea4kONK/INJa/PDeGKPXSJRUUDxFcoZx0AtcMe/gy
	R+fn3gz9uCYpUFUwt+3dYSfQoxy2jD+w34lCZRsO8WNltBjuX2GzC2erY7lEC8e8=
X-Gm-Gg: ASbGncvdmoQuQqV6HS8LwOuU9sQ1KMe9isaoPwaSHAZrhHlI4k9w5iw2wJbuhN+GlSO
	8ot1PTx1kw7APP7BU9QQmMeqePU6aLZPvkeZ7eQdt/fWAI/iXJZOaeuc+gor7a24hOY2D+QDzYK
	RaiC/Vs5j/q8kmmeWF/1wEkKR6iqoHu3stuIrfulfR9vOC/UwewM9bOwfoW4o+40MluoHhkLOTR
	dnEvv9F1kl/QrUjOiSpvubMAy/DSZGpofMa99P/+PrRi+dTrvRWts1pU9VZM8G/73WpJ/mS9bJm
	uiSbKEN/gfEaJtPqLN5UHvC+Dj0i7uAJzbQ7ED/fbWYi8bI7sIF1GIpE1YRmKQr1Zd8FubghDS+
	5N2447ldKZ89RJ9bsLz3Se4i5VI2CgZS5++xX9aKFOh0blLsn/pA44nyVhGy7YpHFRXZR8NBvCc
	z/H1h/m8Z49Eq7zms=
X-Received: by 2002:a05:6402:23ce:b0:62e:d3ad:4234 with SMTP id 4fb4d7f45d1cf-62ed82a387cmr6390170a12.27.1757758220005;
        Sat, 13 Sep 2025 03:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzGFTc+umJVfpKHiGkDlXcO9PAfX5mtXhZmf88VgVq426cJGCxE0aidol2RE7F7DixDEkZtg==
X-Received: by 2002:a05:6402:23ce:b0:62e:d3ad:4234 with SMTP id 4fb4d7f45d1cf-62ed82a387cmr6390154a12.27.1757758219562;
        Sat, 13 Sep 2025 03:10:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f0dae0140sm957804a12.48.2025.09.13.03.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 03:10:18 -0700 (PDT)
Message-ID: <c9b7abc9-5009-4846-8327-e8d2acdc2457@redhat.com>
Date: Sat, 13 Sep 2025 12:10:18 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: initialize acpi_gpio_info struct
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>
From: Hans de Goede <hdegoede@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12-Sep-25 10:18 PM, Sébastien Szymanski wrote:
> Since commit 7c010d463372 ("gpiolib: acpi: Make sure we fill struct
> acpi_gpio_info"), uninitialized acpi_gpio_info struct are passed to
> __acpi_find_gpio() and later in the call stack info->quirks is used in
> acpi_populate_gpio_lookup. This breaks the i2c_hid_cpi driver:
> 
> [   58.122916] i2c_hid_acpi i2c-UNIW0001:00: HID over i2c has not been provided an Int IRQ
> [   58.123097] i2c_hid_acpi i2c-UNIW0001:00: probe with driver i2c_hid_acpi failed with error -22
> 
> Fix this by initializing the acpi_gpio_info pass to __acpi_find_gpio()
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220388
> Fixes: 7c010d463372 ("gpiolib: acpi: Make sure we fill struct acpi_gpio_info")
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Thanks, I hit and debugged the same problem myself:

https://lore.kernel.org/linux-acpi/20250912221859.368173-1-hansg@kernel.org/

But your patch is better since I only fixed 1 of the 2 uninitialized
struct cases:

Tested-by: Hans de Goede <hansg@kernel.org>
Reviewed-by: Hans de Goede <hansg@kernel.org>

Andy, Mika this is a pretty serious regression in 6.17-rc# can you please
make sure to get this fix merged before 6.17 final.

Regards,

Hans


> ---
>  drivers/gpio/gpiolib-acpi-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> index 12b24a717e43f17621c054bfc4e9c2e287236d8c..d11bcaf1ae88421e5e5a11a2ba94983f437c413a 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -942,7 +942,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>  {
>  	struct acpi_device *adev = to_acpi_device_node(fwnode);
>  	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
> -	struct acpi_gpio_info info;
> +	struct acpi_gpio_info info = {};
>  	struct gpio_desc *desc;
>  
>  	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
> @@ -992,7 +992,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
>  	int ret;
>  
>  	for (i = 0, idx = 0; idx <= index; i++) {
> -		struct acpi_gpio_info info;
> +		struct acpi_gpio_info info = {};
>  		struct gpio_desc *desc;
>  
>  		/* Ignore -EPROBE_DEFER, it only matters if idx matches */
> 
> ---
> base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
> change-id: 20250912-gpiolib-acpi-fix-7ee492ebd5e8
> 
> Best regards,


