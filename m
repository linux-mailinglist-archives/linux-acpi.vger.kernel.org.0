Return-Path: <linux-acpi+bounces-5979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792488CF46B
	for <lists+linux-acpi@lfdr.de>; Sun, 26 May 2024 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36148281293
	for <lists+linux-acpi@lfdr.de>; Sun, 26 May 2024 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73865EADD;
	Sun, 26 May 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdkeXcWb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4508F55;
	Sun, 26 May 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716731346; cv=none; b=g2lNeyf37OZFy3I35gJxFdRRGToat73qB6NYzS9jY4lEovxsMjmTLR0QmXHw6xhjXUynoDkVw0HPitQgyjyUAzmlryURUAqPSKsrDH9O7GF3uRL4dIJ5A2bk+3f+i1ZA8gHP7Otdsj9KZtseW/rA4NgbEFMTOxrA0dScA+IFR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716731346; c=relaxed/simple;
	bh=Fvd2yMfinY76Ir6MHTON59Mb9cqtnlP19SKf1KtXrYE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pd4JNOhzDWOu6GZ0wdU4GBA6eTYLo2ukFlWjVaVnQgDxAfXJv9VxIH83b4r7srlpop7a7DoWphGp4nRiLWNiG58NrUhExCgI0YWuq1u5jG1k9OPz9qF8/SxZTceM+5Lf0xQwkrf2WG3StT85ygh5I2mdnz9B9d6FDZdHIxPTiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdkeXcWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58E6C2BD10;
	Sun, 26 May 2024 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716731346;
	bh=Fvd2yMfinY76Ir6MHTON59Mb9cqtnlP19SKf1KtXrYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AdkeXcWbj4BASWi1RboTFZxjneV9YZ7iD+i0qZXEJ/XKBGDVuWZU6D0z9bMK8xjtd
	 56Zdjbtj54wEyiFsRtMMSXyPiSCLv0tQdMyxMouPtW21NGQJh76YyLv4+Vod0id1Ba
	 jPwbTR5PP1BDJ67vgu3RUK7oye27YS5aNeWQbWRH4Xx/t64qc8jCIFazET3xz/1z9s
	 y4nfOcFu2fOrmEfzeHBDJ8YfdL9N/QQX03Z4xuvE4/OOnD92NJcFk27a8PJDBXisLR
	 7bBbEkU+v7wCFkAl/k/4h22utLuO5weEJnMYNyr3MriayQTxbngoGmVWJcpBmbTEGz
	 xAqWvJAR7ZwGg==
Date: Sun, 26 May 2024 14:48:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (ltc2992) Use
 fwnode_for_each_available_child_node_scoped()
Message-ID: <20240526144851.493dd3f2@jic23-huawei>
In-Reply-To: <20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
References: <20240523-fwnode_for_each_available_child_node_scoped-v2-0-701f3a03f2fb@gmail.com>
	<20240523-fwnode_for_each_available_child_node_scoped-v2-3-701f3a03f2fb@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 17:47:16 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The scoped version of the fwnode_for_each_available_child_node() macro
> automates object recfount decrement, avoiding possible memory leaks
> in new error paths inside the loop like it happened when
> commit '10b029020487 ("hwmon: (ltc2992) Avoid division by zero")'
> was added.
> 
> The new macro removes the need to manually call fwnode_handle_put() in
> the existing error paths and in any future addition. It also removes the
> need for the current child node declaration as well, as it is internally
> declared.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

This looks like another instances of the lack of clarify about 
what device_for_each_child_node[_scoped]() guarantees about node availability.
On DT it guarantees the node is available as ultimately calls
of_get_next_available_child()

On ACPI it doesn't (I think).
For swnode, there isn't an obvious concept of available.

It would be much better if we reached some agreement on this and
hence could avoid using the fwnode variants just to get the _available_ form
as done here.  Or just add the device_for_each_available_child_node[_scoped]()
and call that in almost all cases.

In generic code, do we ever want to walk unavailable child nodes?

Jonathan





> ---
>  drivers/hwmon/ltc2992.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
> index d4a93223cd3b..3feee400ecf8 100644
> --- a/drivers/hwmon/ltc2992.c
> +++ b/drivers/hwmon/ltc2992.c
> @@ -855,32 +855,25 @@ static const struct regmap_config ltc2992_regmap_config = {
>  static int ltc2992_parse_dt(struct ltc2992_state *st)
>  {
>  	struct fwnode_handle *fwnode;
> -	struct fwnode_handle *child;
>  	u32 addr;
>  	u32 val;
>  	int ret;
>  
>  	fwnode = dev_fwnode(&st->client->dev);
>  
> -	fwnode_for_each_available_child_node(fwnode, child) {
> +	fwnode_for_each_available_child_node_scoped(fwnode, child) {
>  		ret = fwnode_property_read_u32(child, "reg", &addr);
> -		if (ret < 0) {
> -			fwnode_handle_put(child);
> +		if (ret < 0)
>  			return ret;
> -		}
>  
> -		if (addr > 1) {
> -			fwnode_handle_put(child);
> +		if (addr > 1)
>  			return -EINVAL;
> -		}
>  
>  		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
>  		if (!ret) {
> -			if (!val) {
> -				fwnode_handle_put(child);
> +			if (!val)
>  				return dev_err_probe(&st->client->dev, -EINVAL,
>  						     "shunt resistor value cannot be zero\n");
> -			}
>  			st->r_sense_uohm[addr] = val;
>  		}
>  	}
> 


