Return-Path: <linux-acpi+bounces-17152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F0B8D18D
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Sep 2025 23:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA204615AF
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Sep 2025 21:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBE2820D5;
	Sat, 20 Sep 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpseLoSw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5CA27F183
	for <linux-acpi@vger.kernel.org>; Sat, 20 Sep 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758403633; cv=none; b=JAorkmR1v5mqCYPfbjfEnnetATHZhkueG2/f2StynLN9nk8TeIHJH6RRNkBl2BcwG4S42HWwuKyv6KPV2Rb7k7tPJMg0AFS4OpOhRgqAA5iHDnd8hQ8aqtoxMDYz58mnIJMJZGRLfsVkQ7WoGyrXpN1I9YQLdWVRqu+WlqNCGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758403633; c=relaxed/simple;
	bh=f7gaqrL+IdTMhppclJNecJwlQYDnd8rNalUqZDwS9BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaT12kKsLBfv/v9tchKM+bKIYZYTZ3sI2Xd2Q3qoHc1BiggBhRN5lmKnVC8t8LTDhjxUOH9EJ7eEe+q2zfwlfgiqXVAjXasjgSOTERJX7uLcWr4D/VI26PgIj5mUWkh0b2VHX47SWMP+sjNvQy8Tz1MYiRx3T7lEVfGOoXGsl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpseLoSw; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54b0434101so3004918a12.2
        for <linux-acpi@vger.kernel.org>; Sat, 20 Sep 2025 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758403631; x=1759008431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZag6O+eNvRyqeUVqQW0eazqLmcxqUXmRta6WqjCdqc=;
        b=LpseLoSwx17AelclNn/2XNY/zir9cJREODHa8FLdRu/XsdAIBFMSa/TOfnGYbiZAvT
         zzYEzjixjmGq47BtsGNAb+AW7TOeBNs74QdPSrkqNY2kaSXTbg76UAsHMNtwW3yZxSAo
         7dQQATvqdlQ4c2BDc95hG1ukkUwaEGxoxhFb0Y+23UmiNgFzgFIB9o3nxsdTZawkIEw1
         Q1Y7DedOilyNaUjFYo23mXTt2xieoSIztniDsMB+Ebn6Kc+cvYkwgBF8Qd/qoYNbWiE2
         ZxgJRJqHFTHu+U0zBB2MDnS3QciMn7vsMP9T4BJ0e7LChGDKR6y1LjH5DsilqORReeMB
         SmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758403631; x=1759008431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZag6O+eNvRyqeUVqQW0eazqLmcxqUXmRta6WqjCdqc=;
        b=RmIm0GLeFFetv3Sgc1eplLQTC3ivlxSydq0KOzsK2ePkFHisIG7mahyc/rIi7AIzpd
         RAOTKk3secaCxOjJ01OR2I+iAQL5PJxGrMecRszNhRm7IV+0nd4RWgQfQhH/XgSuCbrz
         Tdu95GwInIsWQcB2Z2m6WqV7cMXtnmHOUlyeB2vCquJorxmHotM4KloIGwUL4x+kQDMz
         mPTjvDVNeizkuElMUETHP7jF12b3ampdd4p48OagS4wFZd6DHTR6hrYqaERl+1s+W0KV
         R3nv5k0MyJrlRZSSXV7rt9xEfHMmKvOsm8JFM5p6rOCIeBAcOKcrtuDn2OFIxSb+naIm
         jQgw==
X-Forwarded-Encrypted: i=1; AJvYcCUK4fEnp+SMIK5+WclUMWaFf702eL36/lzmAO44ttrFPh+wVArLn2JCln996rm90QG0+5n2Y1ikxiMf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kG5mZJVoGm++Kt4QO+edOcHfN7CmSLk1BZeDzIsI5H9jMLWD
	hgQp+HP9niZyaEaHzcrCOTrljuZVsnkgoB27NdkU/z7KOch8PqaRXEAMkxOY6w==
X-Gm-Gg: ASbGncvs1OWRnThiaxEY512UzDVwq25FMO+YpyM7xB1zDt1cDb5AYGxvil/WJcxrggK
	7CE1PUFim4CMR7UUeHTm10l8EwqCC3CnFABgJi6AeQhyeaji9KX7wFhCTKDuFmWG7h7uYF06Usu
	x3OkvoQwKXuaSvMpS8NqaUnsaAKP4TY52w2Z8BIVsgBEGms0uW/11doJ8u6XwtB7E56eZYlpmcB
	caC4vMJ8Wf/R2Sam6liZTFG/rr02+A+4MTJ4hkePhXfMnideQqmA6XOQUqclT0iohpSODoYH6iB
	kUm0YGMNefPS1bLrPHMNVWXFi4VS+YR0kAS0gxls5UwqXOAaY1KN59qZbCb9BI56rDbAZ0FScFn
	fm7qicEZyw99wUL19wih56ek=
X-Google-Smtp-Source: AGHT+IGITBO0tfJKLwT0mwSLK+UoL+A//Eq2cJmFH0SGOX6eRMi/hhWWMwDIlaR00acM/zLrO/w3rA==
X-Received: by 2002:a05:6a20:12c7:b0:263:5c8b:56f9 with SMTP id adf61e73a8af0-2925ca2bd9dmr11817653637.10.1758403631238;
        Sat, 20 Sep 2025 14:27:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fdae:ef9f:3050:cdfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b553e0c92acsm1054462a12.15.2025.09.20.14.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 14:27:10 -0700 (PDT)
Date: Sat, 20 Sep 2025 14:27:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: Extend software-node support to support
 secondary software-nodes
Message-ID: <w7twypwesy4t5qkcupjqyqzcdh2soahqpa35rqeajzh2syhtra@6trjploaie6g>
References: <20250920200955.20403-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920200955.20403-1-hansg@kernel.org>

On Sat, Sep 20, 2025 at 10:09:55PM +0200, Hans de Goede wrote:
> When a software-node gets added to a device which already has another
> fwnode as primary node it will become the secondary fwnode for that
> device.
> 
> Currently if a software-node with GPIO properties ends up as the secondary
> fwnode then gpiod_find_by_fwnode() will fail to find the GPIOs.
> 
> Add a new gpiod_fwnode_lookup() helper which falls back to calling
> gpiod_find_by_fwnode() with the secondary fwnode if the GPIO was not
> found in the primary fwnode.
> 
> Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")
> Cc: stable@vger.kernel.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Hans de Goede <hansg@kernel.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changes in v2:
> - Add a new gpiod_fwnode_lookup() helper instead of putting the secondary
>   fwnode check inside gpiod_find_by_fwnode()
> ---
>  drivers/gpio/gpiolib.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 0d2b470a252e..74d54513730a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4604,6 +4604,23 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
>  	return desc;
>  }
>  
> +static struct gpio_desc *gpiod_fwnode_lookup(struct fwnode_handle *fwnode,
> +					     struct device *consumer,
> +					     const char *con_id,
> +					     unsigned int idx,
> +					     enum gpiod_flags *flags,
> +					     unsigned long *lookupflags)
> +{
> +	struct gpio_desc *desc;
> +
> +	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
> +	if (gpiod_not_found(desc) && !IS_ERR_OR_NULL(fwnode))
> +		desc = gpiod_find_by_fwnode(fwnode->secondary, consumer, con_id,
> +					    idx, flags, lookupflags);
> +
> +	return desc;

Bikeshedding for later. Maybe do it like this in case we can have more
than 2 nodes at some point?

        do {
		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
		if (!gpiod_not_found(desc))
			return desc;

		fwnode = fwnode->secondary;
	} while (!IS_ERR_OR_NULL(fwnode));

	return ERR_PTR(-ENOENT);

> +}
> +
>  struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>  					 struct fwnode_handle *fwnode,
>  					 const char *con_id,
> @@ -4622,8 +4639,8 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>  	int ret = 0;
>  
>  	scoped_guard(srcu, &gpio_devices_srcu) {
> -		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> -					    &flags, &lookupflags);
> +		desc = gpiod_fwnode_lookup(fwnode, consumer, con_id, idx,
> +					   &flags, &lookupflags);
>  		if (gpiod_not_found(desc) && platform_lookup_allowed) {
>  			/*
>  			 * Either we are not using DT or ACPI, or their lookup

Thanks.

-- 
Dmitry

