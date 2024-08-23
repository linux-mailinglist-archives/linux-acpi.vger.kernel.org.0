Return-Path: <linux-acpi+bounces-7795-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF3B95C51D
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 08:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3381F2549A
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 06:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFD15381A;
	Fri, 23 Aug 2024 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idrD5mn5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9B566A;
	Fri, 23 Aug 2024 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392992; cv=none; b=ryL6ihvJIkqkTVlojy9MQ9oK0LSZo6wMLcrCcDv7BoC0KvA5SGc9JbXARS7cwfJWxpTa0buf8+41DZB3e8k1sZ+IXYHVLwhG615FRYmGB1baXI3YE4joBgVa30csTKB+wrqVkrmPAG5f+VznfVVt+0cJBYgsUT6YtQei0uYyJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392992; c=relaxed/simple;
	bh=ytk+sLpp8KqzSkh06D/oXYBaN8RAPndQfdDvPdxgwa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTsxqpKiWUbY3RnYzeMQKIvjqVktY/2NWgnLnhOmlX1+S9FpzyM5iZoM4V7hus7zHBBJ0CKNcey1IVGtmYnXTkuVJQ/0/IA8s+cqJK4RW4B85+BK0jjNnCTX5tzH3ytu+M/aqeK3N8j7AmR+fgH0K7NR2ij1pp5y+R32S+kglWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idrD5mn5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71446fefddfso216436b3a.0;
        Thu, 22 Aug 2024 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724392989; x=1724997789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5ZZZRXqGHpwCrnylRMJIEvKCNTrtQURLa2u1zNNyKU=;
        b=idrD5mn5+RF8K3Yv9UaQf55ir0T+xrRv9auIozZHr2YP0SfrIRAyqhcswD+pOiCvou
         RmduPfYt63LCpQANxXDd0o+BKgCXcluaEJVyuod/xx8JwtIrHiL4hVhOjOSqRc3mrztw
         FLoRyDC2nMDyhfogXfULTW4Xk4auQuic6qfeG+kRK8hszq7cO8Bk0T6UyapN0ROcdPW8
         3lf2miL9trd2Gk9LIysMJFtMzDFdjhhH1xbWAR73kgktdaARJhqejgYVOOhHDuq9fkRL
         I4ka1U33apdEMgbqLEcMtNSdGj8+vfUTaJPkkDMYokJkV/06ykFoShhE8ePTIc4nglNr
         MjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724392989; x=1724997789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5ZZZRXqGHpwCrnylRMJIEvKCNTrtQURLa2u1zNNyKU=;
        b=jtvCveQORap81ubVcxJ6LpS4L0Q+bNB4P9/si/UZY8LqQWhym8mM1aSy8afsORuyy6
         VkbDGUk9XoU8u/u/iJWK8VUOjAGyyfYtbaBxpIxvqYxlyp61bgFaxmGtL93q+UO4myIg
         XAz/oIc+bI1UI6Niou9Bd3kp7zdjb1XABQMAjJ1k3Rc7jIGu8QE2BgDg/wqIQRS+B1vR
         8KHd/YvrdKUc+IhNugLdbOG4kTGvj7bXn1qdo9c1/vvElmzo9h/YYw1V0E9y5PGAzMBB
         IQ/SpNvaTfgTroScynvfIC140RXq2DgXHjTp0Fv83ErjVadZctS9/0Ny10XNNUgUCigx
         CTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7NhaQ2oNZrUFRRqsZYq1Toh0zabmd30/0FfMPWYaTFdJm33ugRKZOdnCCUR6tOmlnLtIl0aiIqwzvcvf9+yi5PRvPJQ==@vger.kernel.org, AJvYcCVaR6hFe6SQYaG4+/ILV2aNpVIqq4ax9UGmO96P1He20xCP8MgiTVMjK9dCRAjoWZ5TvVNfjys8w8pY@vger.kernel.org, AJvYcCWzQXbue/Tw7s4JRi0FZkMrQ/JYLYpsmUcEVMkruCtWC3GBkHenCOY6ydLIRgYYGuKc1ReMac1wruGltcgw@vger.kernel.org, AJvYcCXlTNJgykN29Q4P+bERd1HIk8X2Igv8ZuNii/TbGIDW0US8xglumGSS0KgFbWH9kaMpittR0qxF+dm3k/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCFPx3Bx0VPInQiUtVHgYoCcZ5EtL8EWRctJ9Tq+VbbsK+ew0
	1EVOgz6PsfMilDKQ3fUnCkmse2rV2QZX9g3lYkUf0rwOu0iXdEjJ
X-Google-Smtp-Source: AGHT+IFSwpaQ10nUvqrj5mT2/M+NHrOJ36ytjj0aGSC6N5+KSZMqxM8Ejz3524DzDZv2T4yDD9F2yw==
X-Received: by 2002:a05:6a00:13a7:b0:705:a450:a993 with SMTP id d2e1a72fcca58-714457f30a0mr1512921b3a.17.1724392988832;
        Thu, 22 Aug 2024 23:03:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434339ad2sm2284696b3a.209.2024.08.22.23.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:03:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 22 Aug 2024 23:03:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com,
	luke@ljones.dev, matan@svgalib.org, coproscefalo@gmail.com,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org, lenb@kernel.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] hwmon: (hp-wmi-sensors) Check if WMI event data
 exists
Message-ID: <6778868c-d562-472c-80b2-cd9849a171d2@roeck-us.net>
References: <20240822173810.11090-1-W_Armin@gmx.de>
 <20240822173810.11090-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822173810.11090-3-W_Armin@gmx.de>

On Thu, Aug 22, 2024 at 07:38:07PM +0200, Armin Wolf wrote:
> The BIOS can choose to return no event data in response to a
> WMI event, so the ACPI object passed to the WMI notify handler
> can be NULL.
> 
> Check for such a situation and ignore the event in such a case.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/hp-wmi-sensors.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
> index 6892518d537c..d6bdad26feb1 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -1628,6 +1628,9 @@ static void hp_wmi_notify(union acpi_object *wobj, void *context)
>  	 * HPBIOS_BIOSEvent instance.
>  	 */
> 
> +	if (!wobj)
> +		return;
> +
>  	mutex_lock(&state->lock);
> 
>  	err = populate_event_from_wobj(dev, &event, wobj);
> --
> 2.39.2
> 
> 

