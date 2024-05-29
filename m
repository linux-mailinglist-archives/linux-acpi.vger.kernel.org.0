Return-Path: <linux-acpi+bounces-6102-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869198D4171
	for <lists+linux-acpi@lfdr.de>; Thu, 30 May 2024 00:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FFE1C22DA5
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2024 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93019176FD6;
	Wed, 29 May 2024 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgrlXmL7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13032169ADC;
	Wed, 29 May 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022113; cv=none; b=tMobQCyhZAXvDNERpbgeNvQ16m7IIkZZRqj4rkeofJLUTtsX+FbUnPaRQ+vvBaY3cEHWrr5c3JGHYatLITE8F24xqWAeCkvuZQfxfNa5x/fJYAgR5RFBc2fbUvoHWmtRqv/NSl765EFYb3lhyqGrZYV0nabyXvOGOu6lsIhDQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022113; c=relaxed/simple;
	bh=B5hvaFVG7YU+FAqWqO6NYlaM4U8myrItdnQs/64YBLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuixQpSLOJLR/eswXnPt1OMbhWSsCudK+pSPGkV6dab5x4ReZst6mYX/TV813954ucYpiIRa64ED2rkpEi2Iy0Nb1YUIQYAE9XGG6fLqUbV9vMiE2gut3Tohx1yDWqIRbAdOwiexTTRF3O516xwkJMAmbPl+Xe+NFH9BsKA9jYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgrlXmL7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f082d92864so2393515ad.1;
        Wed, 29 May 2024 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717022111; x=1717626911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PKXIGJClXO6XAR8p5BSrXpvC9eow4Z4B6WrKMzRXUQ=;
        b=HgrlXmL77IBlbDM/qXOsRRXDifT5th8zkdU0X7UkJt56h5QsK7VGSzl7+14pskiTg4
         RMWHfVl4NLd5jytSz4lOOxITutoq57cJ+0N7F73uFvEHr5QXMUuDLDHzpA/HGJkf220D
         ux1F/u2q/DipatWEfWG+AlmtVOVlathmz3ob15Bp8L248bJpV5spSklmeCIszA0byBab
         jIt310APGIT6+Cpyt9nlmvQUZ36GpdcD5UJtcxuKsgzKDSiDUdgbc2q9NKaKPHVFl8kh
         it/2OfKAGqPgQPClGYfxqW+sKOYZ3n1P/lQevKDoFscj8XCnY2WkytI5SUzllrsynHxi
         JeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022111; x=1717626911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PKXIGJClXO6XAR8p5BSrXpvC9eow4Z4B6WrKMzRXUQ=;
        b=ZCcP2i89bEgtg9cq8UTtQWHts3lxPzukv2dSa2iiybLN/va2Lx3Mx0n+GKS2mijDqs
         FzwyjKgS+3YdfyFRRyic1vTLaarha1fr+jk10TfTmkc8ETJtk+ENDX472+oC4d646JKv
         8VX+tqFlkKcJFcU9pVbf95qSaOUXqOLICMI22lbqJ4312a7L6ck9VjpADmTqp34BuCkR
         xPAbTrGebS5yZjNLjZSIItPbQ0dyyQFMwpYWD4wsjOx6W/ZWnFvWOWVxirYgVnt0l2Ks
         LB5c1xvwYqKt7qXYVpELdgSz4ABe+RMU/xYTv2clRnrfxsfu7uDDti3/4bkWtwgAmcFA
         Ck3g==
X-Forwarded-Encrypted: i=1; AJvYcCVWtP4uY6RFDyX+h7yIjNe+YuULSNr7XYqlbH/a4YMuO7FuvcLlgnsmJXJEilF0eJMJwOhlFB0R5rOS9CEAv3auAh8aAa97B1Mdl2IHMWuqFIHQT0IbjxanBddxjt35e0qQ7gWbqcMXPS/HnNWxXTLp/sp/xyyq4cofq/LxF7+GCusIPqla7tbg4qbq86J37ewpYEKFZ6aJI8OcBjsh
X-Gm-Message-State: AOJu0YxMLMytyPAT8iOStetIPyh2qrTJf+xHfrbzZ/4AbOlTba0GnMas
	bC9HljLbtQaL34fCAmmzC1/KCAwD/w/LwiLWDza7azNNYbwX2DvSkaa8Lg==
X-Google-Smtp-Source: AGHT+IG1NrCLle47DLbyygolIxX5Tco70P9/XgtD5t9zZDYX0lW5PrdLLaWKjqhcaq4HgMEUKqMrZg==
X-Received: by 2002:a17:902:c94b:b0:1f4:89e2:b47b with SMTP id d9443c01a7336-1f61992ee59mr4102995ad.50.1717022111255;
        Wed, 29 May 2024 15:35:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75783asm105081475ad.23.2024.05.29.15.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:35:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 May 2024 15:35:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: (ltc2992) Fix memory leak in
 ltc2992_parse_dt()
Message-ID: <a44d1612-0731-4f9f-aa93-04864599251c@roeck-us.net>
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
 <20240523-fwnode_for_each_available_child_node_scoped-v2-1-701f3a03f2fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-fwnode_for_each_available_child_node_scoped-v2-1-701f3a03f2fb@gmail.com>

On Thu, May 23, 2024 at 05:47:14PM +0200, Javier Carrasco wrote:
> A new error path was added to the fwnode_for_each_available_node() loop
> in ltc2992_parse_dt(), which leads to an early return that requires a
> call to fwnode_handle_put() to avoid a memory leak in that case.
> 
> Add the missing fwnode_handle_put() in the error path from a zero value
> shunt resistor.
> 
> Cc: stable@vger.kernel.org
> Fixes: 10b029020487 ("hwmon: (ltc2992) Avoid division by zero")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ltc2992.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
> index 229aed15d5ca..d4a93223cd3b 100644
> --- a/drivers/hwmon/ltc2992.c
> +++ b/drivers/hwmon/ltc2992.c
> @@ -876,9 +876,11 @@ static int ltc2992_parse_dt(struct ltc2992_state *st)
>  
>  		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
>  		if (!ret) {
> -			if (!val)
> +			if (!val) {
> +				fwnode_handle_put(child);
>  				return dev_err_probe(&st->client->dev, -EINVAL,
>  						     "shunt resistor value cannot be zero\n");
> +			}
>  			st->r_sense_uohm[addr] = val;
>  		}
>  	}

