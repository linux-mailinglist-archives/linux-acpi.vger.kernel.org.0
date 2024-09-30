Return-Path: <linux-acpi+bounces-8496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED198A3F4
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98093B23F07
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 13:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC818E36E;
	Mon, 30 Sep 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0ecTz2j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4AD18E028;
	Mon, 30 Sep 2024 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701602; cv=none; b=tgUKIPH8GiHsROTlbapVpFKzMyPKdUZm85en1FQ1uLLq9c7ud3bCGlxyeJVij9FIv6kyNG2tsxC3Uuysvmw2Acwg0x5+4m5Qa6d4yUYbTwlXQYIX8IHz7rBoUZagVtwj4mrKry5dP6iktlQCkNF//HawO2k76KhkbHVl4yX4OWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701602; c=relaxed/simple;
	bh=k9HhX6mVAgfUlI2jzdcXzCBCDtSr0IR/SBeHvHmeGN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaQhAe+BAeDZtbchJJQrBRScm89O0yOd3STzk3qcq72yiRKZP7yWhxIkHGfL0Xq7Dn3A0euriPIKg8a6BnqpIH6v7GS2bdJ3a9xZaf+KhyZBNie/oA8IjbqpBUbtXuCTzkl7cqKEfalReoWC71Vvjhe9oQF1EasIheDx5g8mufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0ecTz2j; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2facf48157dso10567321fa.2;
        Mon, 30 Sep 2024 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727701599; x=1728306399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u82CJhAwF4wrvx/NhAEt7j3Fh6rF3J/up6OgwQM+4uY=;
        b=J0ecTz2jTURmmKpHdrmHyrsNvzbkjF7Evcvf/aAd1Vfo8xyhZrXc+yq2WntQua/bFx
         KIYomrF72DVvPi4ePBtv2g+LosUpvpxKhYwlpC+IBjE4Fsd+q14TWFo/S/1reMQ81ctF
         ImoCcNeDse1ryYpRTgbMxHyDisNhSLNVzG4FlzBLc2CRKlBvquIk0r0quDcFcM9xIYxC
         56gm0pnbXKJYAVO9+QaecQk+82x0aFknrZQhuotNLmSayeSla2PqrMDHXx/dFt+J3dWT
         M5mvZjBxBgK+LzaIOZO4GZl3/1xYD1c8D+27ohRp0Qz2NqjrnhNbDfssl2TcPsH2mVmQ
         HJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701599; x=1728306399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u82CJhAwF4wrvx/NhAEt7j3Fh6rF3J/up6OgwQM+4uY=;
        b=K0jts+O2ThhIUbCxofQ6ExpRXcis4vVrOCk1uAWcG1xaE5lvTLfXshrE663JPYbUAG
         EjZDtbCiVaI7zGiJkOLccay0LIzdurR3jxTNF0FtX7FH9/oYieLwqGrGF+W4Cise69x8
         /zbSD5iRQ7cVczQAbS8GI3f07WBS9BQ9Xp5eWiutp8m8/0bBd9tNzqm/i5hi1AwEiNtT
         m3FsNLfMwgfECmXCD7HzpB6cUNHwDOaGhQwCS/YLGcr7V4Jw/So5t1gDRiVxgHB/Bh+/
         gDaV6EIOtNJQAIDP6W4AyiFESEiBVPk/FeEU7X7fk5CDumYHKsohksCm56W/CJZB7WNf
         Eezg==
X-Forwarded-Encrypted: i=1; AJvYcCUT0XH1ncDRMpH5pPoM3SwlGADeDL0cOfsSDnEm8nrrR03klXwtBB4uV8v088NcEXyT24HXVbTSlIvQQdyy@vger.kernel.org, AJvYcCWR6kwyg+afx+ohC2gpyIwVun7IOjRjIWBFCWjGHjQjAIdKEzzUXiJvygTsbuTrZqk7KDdkcWQRwMzs@vger.kernel.org, AJvYcCWdZiFf9Us4jyHa3xqE0pltKHlhskpa8PXX4+io+veap+oTfpqPeNqSCmc+tQaU4UN02N48JRmDzBwa9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYFCbxa/dn+hBlk3G+/JQmMlek9IntuC5+EUdUC2R/Do5z7sr
	ymAYsd6kV9eeWeLx+mTsOjFX9lMYIPcHDEdcAZN4RBvMnDj2sEzx
X-Google-Smtp-Source: AGHT+IHH0o5GH3DGKhCASbDKiA/quy7Pz8CrVNMz6JQw2ZJhJAGpu4qxhVX/MfDPRVa4NaHbe0ivNg==
X-Received: by 2002:a05:651c:1503:b0:2f6:61d7:ab63 with SMTP id 38308e7fff4ca-2f9d3e5f104mr63563021fa.23.1727701598737;
        Mon, 30 Sep 2024 06:06:38 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d4618f39sm13893421fa.117.2024.09.30.06.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:06:38 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:06:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Hoan Tran <hoan@os.amperecomputing.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/3] gpio: dwapb: switch to
 device_for_each_child_node_scoped()
Message-ID: <kyjzvihhpsxkkuerkyg6ja6dcod7njgzmd6emz7rqd4c4lbn32@e7y4er3ngk3l>
References: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
 <20240928-gpio_device_for_each_child_node_scoped-v1-1-c20eff315f4f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928-gpio_device_for_each_child_node_scoped-v1-1-c20eff315f4f@gmail.com>

On Sat, Sep 28, 2024 at 09:47:35PM GMT, Javier Carrasco wrote:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for a  call to fwnode_handle_put() in the error path.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/gpio/gpio-dwapb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 798235791f70..bd374fc27174 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -571,7 +571,6 @@ static void dwapb_get_irq(struct device *dev, struct fwnode_handle *fwnode,
>  
>  static struct dwapb_platform_data *dwapb_gpio_get_pdata(struct device *dev)
>  {
> -	struct fwnode_handle *fwnode;
>  	struct dwapb_platform_data *pdata;
>  	struct dwapb_port_property *pp;
>  	int nports;
> @@ -592,7 +591,7 @@ static struct dwapb_platform_data *dwapb_gpio_get_pdata(struct device *dev)
>  	pdata->nports = nports;
>  
>  	i = 0;
> -	device_for_each_child_node(dev, fwnode)  {
> +	device_for_each_child_node_scoped(dev, fwnode)  {
>  		pp = &pdata->properties[i++];
>  		pp->fwnode = fwnode;
>  
> @@ -600,7 +599,6 @@ static struct dwapb_platform_data *dwapb_gpio_get_pdata(struct device *dev)
>  		    pp->idx >= DWAPB_MAX_PORTS) {
>  			dev_err(dev,
>  				"missing/invalid port index for port%d\n", i);
> -			fwnode_handle_put(fwnode);
>  			return ERR_PTR(-EINVAL);
>  		}
>  
> 
> -- 
> 2.43.0
> 

