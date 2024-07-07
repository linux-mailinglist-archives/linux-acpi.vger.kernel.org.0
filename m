Return-Path: <linux-acpi+bounces-6796-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8499298F8
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A8F283AAB
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC941C697;
	Sun,  7 Jul 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwNTxpxs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BD4D8B5;
	Sun,  7 Jul 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371343; cv=none; b=HOdJeVCsJIhYsJ28F5KiGE/6+eBVdYxIvNKeoe63W8z7YAEy84GQj3gjxZS1Luni+x/VlWFfeA/VaCCj7cAVYvjWoXZwuqlnoHX8fKYrPE7PoKUslRIi/p04JKZcOvCQnWRpXtaNIgk2uxx1AW8tEhvYde+BVcrMGRoniO/q2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371343; c=relaxed/simple;
	bh=NjeOBV3u/kZpOrzed9JpT5y6p5ENE3Vlw88uLpTS/38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjpaKlgx7XB8kcY632qgu0iYfXppP2+UijLWzIV10umwxJNePXlFIMiNvHWpyGj5gAN6nHzRVvuYcYHqPsOjMO3QsItCyIigZZgRqFYHD3AZGiymWrZ4BQwlIYwqF75IrqFtwpF6lo76fs0ev2ybImBGTcRKaFPqi+tFMQt6984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwNTxpxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12059C32781;
	Sun,  7 Jul 2024 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371343;
	bh=NjeOBV3u/kZpOrzed9JpT5y6p5ENE3Vlw88uLpTS/38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jwNTxpxsIKqOZxsHDlY+b/0I59KBuqzZ34ZOMPs2TlSWYjKvPGlTHHn5DsWOmz8nK
	 Cj87npRIqZc/rxkeyhg9wXDMYInVDoNyCv4DbgqlCaJx/ajQfz9Uuw/T9+fyx4fK9T
	 pQ7TNWw7vT/tDNd1R1xo1LWB/DeL43hDTCxVAQ9CpI8avKq7ej7ti3LPZEIM6Jdj+T
	 W14zAbgJc5CQxU/r21Y8DBn1+1oTMjs5odPMB3j6MdTbl2zB5WeNxh+I8wJzOhei41
	 8MHLEv4H7zEPj7OGW2W0flmQG89+cFsyQ6Q0gLtPeokYXU844ASKW7qKXbs5gq4WoU
	 KWn2E/zopwUAQ==
Date: Sun, 7 Jul 2024 17:55:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-leds@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/6] hwmon: (ltc2992) use
 device_for_each_child_node_scoped() to access child nodes
Message-ID: <20240707175531.7cf207d0@jic23-huawei>
In-Reply-To: <20240706-device_for_each_child_node-available-v1-2-8a3f7615e41c@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
	<20240706-device_for_each_child_node-available-v1-2-8a3f7615e41c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jul 2024 17:23:34 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The iterated nodes are direct children of the device node, and the
> `device_for_each_child_node()` macro accounts for child node
> availability.
> 
> `fwnode_for_each_available_child_node()` is meant to access the child
> nodes of an fwnode, and therefore not direct child nodes of the device
> node.
> 
> In this case, the child nodes are not required outside the loop, and
> the scoped version of the macro can be used to remove the repetitive
> `goto put` pattern.
> 
> Use `device_for_each_child_node_scoped_scoped()` to indicate device's
> direct child nodes.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
One thing that is possibly a follow up suggestion but could maybe
be done in this patch.  Either way.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwmon/ltc2992.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
> index d4a93223cd3b..541fa09dc6e7 100644
> --- a/drivers/hwmon/ltc2992.c
> +++ b/drivers/hwmon/ltc2992.c
> @@ -854,33 +854,24 @@ static const struct regmap_config ltc2992_regmap_config = {
>  
>  static int ltc2992_parse_dt(struct ltc2992_state *st)
>  {
> -	struct fwnode_handle *fwnode;
> -	struct fwnode_handle *child;

I'd take the opportunity for
	struct device *dev = &st->client->dev;

Given there are several users and this modifies one of them.

>  	u32 addr;
>  	u32 val;
>  	int ret;
>  
> -	fwnode = dev_fwnode(&st->client->dev);
> -
> -	fwnode_for_each_available_child_node(fwnode, child) {
> +	device_for_each_child_node_scoped(&st->client->dev, child) {
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
> +
>  			st->r_sense_uohm[addr] = val;
>  		}
>  	}
> 


