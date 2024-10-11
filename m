Return-Path: <linux-acpi+bounces-8721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D5C99A941
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95412B22F5C
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB37919F11B;
	Fri, 11 Oct 2024 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnOeV937"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C619E994;
	Fri, 11 Oct 2024 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665823; cv=none; b=IhgPT9mHox6V06x9I3M2u8pRGkRIec0TinyTd2LezdyhKQCqBQywhY5WXFKFHmxDGaQb/5UIj7qrADelKObTPIdsDE9mBvFW0gGl4FSJhj0xNS9DOw6Y6ZthBpYhSX3RcK/PwkaGyK89qjryEZf3kZHVhuaGSM+A9qgjP3fvdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665823; c=relaxed/simple;
	bh=uoyLTAzHWcX0+EeCNu0jv/0Mt41gfAa8d/08EnTMBIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQQ8/SpbsBAtZYW/idzyElFDG6OrC3PYCnqiq/Bh2kuLDCqxarwBDCP3/w7GIaZPEedmqEQl7QZHmPxKAVxM+JuMDay1I23qJ0QYgELpt25TiQVieG/NoOiqGcCZ1OgaK9qnMy8DiCRxQNN6wb9zn35cIWK2ZkoOsZ9wCDRc6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnOeV937; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso1675711a91.3;
        Fri, 11 Oct 2024 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728665821; x=1729270621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/gZ7WU3epDl0MNeUQNpbfA3Lo5bZa7Q463uEngrdlU=;
        b=KnOeV937/OFkmFZiwhsHa/tETRCK4EMQILDF6gVcUtgpSz9IEJoeBLIv7PRcOaicrr
         cPvUGLkeXom5xf7jSJ+7ebDsOum/uzB4nWSGusjP+Vc7rU6fNcP8jj4ubaoY7SD+/Ecj
         6sv9EU3JFdZOF1+el8K+qeEu5dKDPk2jNU54aUrFLCDfynLWcgdBEos7E4JyjYT0q2I4
         vrG0xo4GlVs1yEO7s5wdwDIPtlXUf0uNiG2ZszkHUJ/xOHOHcbpcBkKyZy3ydtNKA2a0
         bMe8ARvBIUNce0UfaXm/7UUpqZXMmpOLQMDhMoiY+YKA7/cYLo6Ts9aZSRQV9GNlA9IO
         JAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728665821; x=1729270621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/gZ7WU3epDl0MNeUQNpbfA3Lo5bZa7Q463uEngrdlU=;
        b=m1b+bEu7N38UetPvEz8rIiyb09hs6JNg0HA6PqB0BG3M0cFE4cqrddyTpk5SCmoeWG
         710YGqTlJZVGzVAt8JhSAzjZPinlqWPpEBGVJadxRx5k+xOmKcS+wNY94PaefX1cJObl
         jj8qxRXz2xIQrg+tvpLM2exSRFa2hoXNdOFoJFk2Z4lItfJ68/3H/Ga+FP4JDH8CA3bf
         y/eA3naWYDvsBt0QIBJ7W+iGs1K7vd/hcLXwi1bzWrI5OQbFM6OrzaR4NCyIhYq+D+Y3
         GL+t9d4qBLD1kEc0ancgkKPFkThndLyu+XwBgdLzewWGVo1eQzQVn80FOvM5JuQ9n9P4
         dLAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLhkLWiUZZsC0CJiOfc13zifSwFPRGCVO0hjuidJTQ72pxuagCuy/MVAwKV2FtUyGrelTifomvG1ueuEIl@vger.kernel.org, AJvYcCWXlLqqzSg7jfjfv2gEuo8OANzm1y83q28OFc8z68k/U8m/wak3TpXa7e4+YchoZ2//+iVb29RdpxM59vakc6l3UlmmVg==@vger.kernel.org, AJvYcCWlvmfVmdfcgf8cm3UP9vYY75cZ5bJQSwa+qLRH74OT9hE7oN8rq3n2vLS8Qlk0W007p3KJ6IgOhxRuzCI=@vger.kernel.org, AJvYcCXxZF+TH2vhqMXA8jOhA4g81QqRakKl4vId6hmbTKS62bA7V5tjCUDDeHlPoIElhXKZoDM9V+VEYVIi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2QoPOQpg90VmYFffi3OcBTA/JDoPj2WlZj0XY7PD+FWfbG9j
	0CmEfoUPrmB24ixPvxLTWlTYhmDZDfPV30td1do2byPh1CbyJHBz
X-Google-Smtp-Source: AGHT+IESG1hwpRHIPFN0MQ+z/WFeOm+Mh6P7QP6AxSbUvtNXisX6ZsJFLqUnhgLNECh/coDUZtLN4g==
X-Received: by 2002:a17:90b:e8c:b0:2e0:a77e:8305 with SMTP id 98e67ed59e1d1-2e31536f27cmr39108a91.39.1728665821031;
        Fri, 11 Oct 2024 09:57:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5dd423asm3433210a91.4.2024.10.11.09.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:56:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 11 Oct 2024 09:56:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] acpi: make EC support compile-time conditional
Message-ID: <3075ecd1-491b-477c-89a7-d8f8b081d0a1@roeck-us.net>
References: <20241011061948.3211423-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011061948.3211423-1-arnd@kernel.org>

On Fri, Oct 11, 2024 at 06:18:17AM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The embedded controller code is mainly used on x86 laptops and cannot
> work without PC style I/O port access.
> 
> Make this a user-visible configuration option that is default enabled
> on x86 but otherwise disabled, and that can never be enabled unless
> CONFIG_HAS_IOPORT is also available.
> 
> The empty stubs in internal.h help ignore the EC code in configurations
> that don't support it. In order to see those stubs, the sbshc code also
> has to include this header and drop duplicate declarations.
> 
> All the direct callers of ec_read/ec_write already had an x86
> dependency and now also need to depend on APCI_EC.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/Kconfig               | 11 ++++++++++-
>  drivers/acpi/Makefile              |  2 +-
>  drivers/acpi/internal.h            | 25 +++++++++++++++++++++++++
>  drivers/acpi/sbshc.c               |  9 +--------
>  drivers/char/Kconfig               |  1 +
>  drivers/hwmon/Kconfig              |  3 ++-

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

