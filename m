Return-Path: <linux-acpi+bounces-6580-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06551912E29
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DAE1C20E83
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5BA15F336;
	Fri, 21 Jun 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0mLGEEh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A35664;
	Fri, 21 Jun 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999921; cv=none; b=oVBGa/GGg7SYdzmJ1xT0wJx3pl8u4h3Ra+Fxw+S6TyTlzqQ1g9Z7XJp22x4ghbF0nAvpXhpg2ouprtkoN7LdjQUOOpDo2q6FBPLdDaonCeuq76JyRGGL00st6eXLTJI8Y5aNxC01grDmqJe/9BqbdbEveWp+4/nzjYWEzSnPY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999921; c=relaxed/simple;
	bh=XyJ6ZKYOxBuwdpsCynz52u9C7vHXEfljd7bOrtd+TQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqEBHqaqrsy0snUhipRgXFVDq4IV7J7qOgdopPU9+9mxU1bVmmRBrCSoTlHGY5SpoC20Zp0Wlp6sDI9lXELwJFHr+No/jYZ1XwHp3Utod3XS3LtVRcz55hmGLg56BCPrNnxBQRkjserOo1knLh/ovRsF3bFciNjMMDukwwQWKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0mLGEEh; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c1a6685cd5so1223989eaf.1;
        Fri, 21 Jun 2024 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718999918; x=1719604718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZT85xg/u3etg74tod0wWvhARm1bf9HjZcOhri8SiLA=;
        b=C0mLGEEhcsI2qGET320c5uo5bncJ0r78t7CkkKqT2tHWwB/ESoRybzlOl7nGWj6tTf
         42zVG66c0TNOqRUuiTQuw59LLNLL3G9yQYUFduwiw52dD9ZwyX2Tk0wJ0FVVb2QHcGck
         J+W+7oaTe4pDacCJ+RlWzOx5+s7xys9e0j00pJh4BSexj0qeFNeYYHtGqN6SUF3RjH5Y
         BTb1Wvd+aFggneYj8IsCW1cXCNLPW4FLGgdisTOUmjuuLxxEvXKkELG4vDMe+gA8deJh
         txZLG+LsdaTkvNPfbb2mxMVbyUFEN7XveVx+KPJVThRC56jZgx1BWB1V8z5chb3uzVHQ
         zWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718999918; x=1719604718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZT85xg/u3etg74tod0wWvhARm1bf9HjZcOhri8SiLA=;
        b=oTB+/yrLcR2jXJyVd3ik+tuqiOwYQPpC25iZagSHgXD9fo0Ez8tAOrBBJ5xCOLY5x0
         AgOutCxp2qOpAUFn/osE3j4iUfawJ/ivEtBW1v+lJTOWwnu/5+jaDNE29ruYYsaG82Pa
         /Ya8sTaYTUWgP1prLlGELs50gKTsKEZYtiwwiOmZQMtR9rXTY6jfLzvmqkA3JdrNRJ0V
         ja5WV4/Ou+gCgApTX4lEFeoCH6KaL0lLletODApqz/HgDJnEFfjdiD+O8YiwgFLCLvJU
         0sCvL7bBgrJLDFFjN2NMqkGFGNj4drkTWXHtXWQWWY1PFyg3ztkY/iOdTMsDlR3Sriaq
         wttw==
X-Forwarded-Encrypted: i=1; AJvYcCWlWr/PqrRYT/kWn1z/a0suBWBlmb2jlduI8/AFj6KnG+C8cbAgnk3R5nGGOCVN8EX/NJxjBTqC6Te6LWSEkFQ5sY3kJKco6l8ABERmQLMAFoy0UoM1l4SY7DPg6N6EU86fdKzFgxIHZA==
X-Gm-Message-State: AOJu0YzWgykNdNxJY+8/9/d4x9jvUYzrYzZGgzDVeJsTS2CifcjT4YLR
	Q+z+z1exxsbwsJbdxeycdPSnkjNlFODHOvPLTyS9hgJCp0HAUzJv
X-Google-Smtp-Source: AGHT+IFczQG/r/FziE5lHomIhZKAzT1QDlQTYWIYUS249ULPQp3760g6B/uCINnT2+aOuTODaKtM9Q==
X-Received: by 2002:a05:6358:7e87:b0:19f:6bb4:e23b with SMTP id e5c5f4694b2df-1a1fd45b454mr1045049155d.18.1718999918391;
        Fri, 21 Jun 2024 12:58:38 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:30ae:a791:227a:a35f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba6aa524sm1468593a12.63.2024.06.21.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 12:58:37 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:58:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3] software node: Implement device_get_match_data fwnode
 callback
Message-ID: <ZnXbaubPVAUdDIu0@google.com>
References: <20240427203650.582989-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427203650.582989-1-sui.jingfeng@linux.dev>

Hi Sui,

On Sun, Apr 28, 2024 at 04:36:50AM +0800, Sui Jingfeng wrote:
> Because the software node backend of the fwnode API framework lacks an
> implementation for the .device_get_match_data function callback. This
> makes it difficult to use(and/or test) a few drivers that originates
> from DT world on the non-DT platform.
> 
> Implement the .device_get_match_data fwnode callback, which helps to keep
> the three backends of the fwnode API aligned as much as possible. This is
> also a fundamental step to make a few drivers OF-independent truely
> possible.
> 
> Device drivers or platform setup codes are expected to provide a software
> node string property, named as "compatible". At this moment, the value of
> this string property is being used to match against the compatible entries
> in the of_device_id table. It can be extended in the future though.

I am sorry, but this is not really correct. Software nodes are used to
augment missing or incomplete parameters, but are never primary objects
in the matching process. Sometimes "compatible" property is used with
software nodes, but it does not participate in the matching process.

There are several ways for various buses to match a device and a driver,
but none of them operate on software nodes. Consider for example how
devices on SPI bus are matched (see
drivers/spi/spi.c::spi_match_device()):

1. OF/device tree based match. It *requires* the device to have
dev->of_node which is coming from a DTB. It does not work on software
nodes. In case of match the match data should come from of_device_id
entry.

2. ACPI-based match. The match is done based either on OF-compatible
data (which includes "compatible" property) in _DSD (if driver supports
OF-based matching), or based on HID/CID data. In the latter case the
match data is coming from acpi_device_id entry.

3. Name-based match, typically used for board-instantiated devices. In
this case match is done by comparing device name under which it was
instantiated against names listed in the drivers id_table. The match
data is coming from spi_device_id entry.

Similar matching processes are implemented for i2c and platform buses,
as well as others.

Your patch is effectively hijacks the #3 matching process and
substitutes the bus-specific match data (from
spi_device_id/i2c_device_id/etc) with OF data. This is not expected and
while we may want this in a long term (so we can eventually remove these
bus-specific device ids and only have ACPI/OF ones) I do not think we
are ready for this yet. At the very least this needs to be very clearly
documented.

> 
> Fixes: ffb42e64561e ("drm/tiny/repaper: Make driver OF-independent")
> Fixes: 5703d6ae9573 ("drm/tiny/st7735r: Make driver OF-independent")

As other people mentioned this patch does not fix the aforementioned
commits because they are not broken. In case of non-OF match (which
includes the case where you use software nodes) the match data is coming
from matching spi_device_id entry in the driver.

Thanks.

-- 
Dmitry

