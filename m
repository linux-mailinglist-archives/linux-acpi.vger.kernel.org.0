Return-Path: <linux-acpi+bounces-768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AEF7D032F
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 22:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FD21C20ADD
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98433DFFF
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI1IaOYN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1716354EC
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 19:20:21 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB4CF;
	Thu, 19 Oct 2023 12:20:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso71657b3a.2;
        Thu, 19 Oct 2023 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697743220; x=1698348020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AeyNKDmA955jN+KZgs+inpu81A+J9sy8jsLFlkqKpzs=;
        b=bI1IaOYNwUy4W64ovDrR8WFt6Nl9VDa2CCoAnT3egfVRF/VUVCZmPfBVWO+QUdmEi+
         Ex3li9eWI/lvUwrTPA47seYbyung37Gom4sHp3xF7Ueqp7KwEOAsVNrC6uaOKP42j2a8
         m1INE9x583Zk+eMRPhfztRyyFPj73dCN0AqihYmMgNhGJfZWBhQYHubMsLIZ4Or2Ceci
         yysXOH/EcAz+eNHu8Q+Op14WsKwD9dXs5M7WgB0S/Nb7qxGWT5dKhyWoZsFydL/D10cY
         xqcVUUCKsFCrfl4+t7z6LxcTeXRfC251lCwvJcXrSHhx0r6emz54GJY5V8CFGoLmksX9
         h/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743220; x=1698348020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeyNKDmA955jN+KZgs+inpu81A+J9sy8jsLFlkqKpzs=;
        b=Ync1q4I/I6pfvNmWCXGlOOtABF7zKFmgO5xLhERZ0WwfPhkW0EsuuzmntZ7jIf+Xre
         osSWPtcaseJARnQKx8kd2AgRuQvJewWTDGLGPt+WUoQVDTxw6Iuy7xOBjyOQchkEKdbf
         ey13HI8MGV0H/vTiVnwylDz4hV/SwFpeNnizSlrtG0cz3kvDldU1o1KxoDqoZqVX1Hmx
         HmvWr54xKftpn1XrfWZBodroSomIZMrhDpO8AighVhdcjjnbhtsa22DfxOb9+eeAFvn4
         viFJfiq6yQlXxG3I6tK5amNkxiFkAcuIqW/X+Bx8YDzTIjVuUPD9P82aRd1jJR78Tl8D
         qwZw==
X-Gm-Message-State: AOJu0YyU8dIPTNox/VV6VmXPAnyjN+VfZHH8uh0rFjDK7qBpUFKVBEA+
	/6dtcO65rYKVjBn+0qusUUI=
X-Google-Smtp-Source: AGHT+IFhlfOh/+tg7nt9+VsjFFMdrAMcbrKIPmMw9i4sfhyKEat5Hd6wb9YCwxAydwhF8kkmKiknuQ==
X-Received: by 2002:a05:6a00:b43:b0:6b7:cc4b:21d8 with SMTP id p3-20020a056a000b4300b006b7cc4b21d8mr2927304pfo.1.1697743220101;
        Thu, 19 Oct 2023 12:20:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c4c4:bbd9:2220:727f])
        by smtp.gmail.com with ESMTPSA id b6-20020a639306000000b0059d6f5196fasm106836pge.78.2023.10.19.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:20:19 -0700 (PDT)
Date: Thu, 19 Oct 2023 12:20:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Hans de Goede <hdegoede@redhat.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/3] gpiolib: acpi: Add missing memset(0) to
 acpi_get_gpiod_from_data()
Message-ID: <ZTGBcJl2flL_HVX_@google.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
 <20231019173457.2445119-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019173457.2445119-2-andriy.shevchenko@linux.intel.com>

On Thu, Oct 19, 2023 at 08:34:55PM +0300, Andy Shevchenko wrote:
> When refactoring the acpi_get_gpiod_from_data() the change missed
> cleaning up the variable on stack. Add missing memset().
> 
> Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 16ba046e86e9 ("gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Although I think it would be better to change
acpi_gpio_resource_lookup() to take an index and return a gpiod
descriptor and have a local copy of the lookup structure. 

> ---
>  drivers/gpio/gpiolib-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index fbda452fb4d6..51e41676de0b 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -951,6 +951,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
>  	if (!propname)
>  		return ERR_PTR(-EINVAL);
>  
> +	memset(&lookup, 0, sizeof(lookup));
>  	lookup.index = index;
>  
>  	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
> -- 
> 2.40.0.1.gaa8946217a0b
> 

Thanks.

-- 
Dmitry

