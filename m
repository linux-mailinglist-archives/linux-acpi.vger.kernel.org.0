Return-Path: <linux-acpi+bounces-6797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F09298FF
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 18:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63857B21501
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9AF52F9E;
	Sun,  7 Jul 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6ENFVWy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9B4F5EC;
	Sun,  7 Jul 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371447; cv=none; b=tabVhQ6WsEoDz5qrYPdnUyDicbiYmPt+ol57QcBmL1ANUJ2HBLmt/Z8lwMa5ifNMu9aT0IOtuy3ffV/yQ7C1qT/+eyJ9i+KDYm0s06yoMx9IKQWTUJXe0yPEX3f+LDAlvX65dgUE3kLhbxaU1DwBv59lsK0DWwGHLbBAXKbjeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371447; c=relaxed/simple;
	bh=7FQfAqx5QrqdtuO/noa37pWuVXAVEEJ9FdaqMS8ffPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9tr7mxxBN+U0pXmqjm+HU57jSeSWdfggbTTyMAcnSMkVWpOBU592Qt5+RCwT0KHXkiRaFFcF3gw7atOGZZVOYzCKuIoWKA9t1krrpzVz3qElzqQUBO035lelsOzIEcaOIdbiXlAhtsC3ZtFjaY4Wzjx3mhZms0CCOHA8JpOIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6ENFVWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91739C32781;
	Sun,  7 Jul 2024 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371447;
	bh=7FQfAqx5QrqdtuO/noa37pWuVXAVEEJ9FdaqMS8ffPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u6ENFVWy+DvAkOIvrXQXhRICTc6SKKJVLs8OEnaz7XXwf/CQ/v7YUkZjvnb7I/geJ
	 TX5PjmexYY+PBepSjKylsmL5zsNNYDEyG3lmz3AmeGPCs7U7tKS2IUi6J6CKS+a6hi
	 a7dVvLJJlZ+aHSqTL4e7+IIXBA8beBYgYCFPTaUywtnD5REmV7yDWMKnQaps4A/+8i
	 QNTqPVOIqM649hKog/eMvjP8yj8pI+7t/+jeWhB6xdnS+j0vycAv6VFoHemHnMYzoM
	 FeTfCSNwjoU9vxmzC+N1UYAfL8OZGW76/VNjg7tgmLUxcYqvnd8Ph1W5FJENI7kN1B
	 INInHKsWfNaFA==
Date: Sun, 7 Jul 2024 17:57:13 +0100
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
Subject: Re: [PATCH 3/6] leds: bd2606mvv: use device_for_each_child_node()
 to access device child nodes
Message-ID: <20240707175713.4deb559f@jic23-huawei>
In-Reply-To: <20240706-device_for_each_child_node-available-v1-3-8a3f7615e41c@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
	<20240706-device_for_each_child_node-available-v1-3-8a3f7615e41c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jul 2024 17:23:35 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The iterated nodes are direct children of the device node, and the
> `device_for_each_child_node()` macro accounts for child node
> availability.
> 
> `fwnode_for_each_available_child_node()` is meant to access the child
> nodes of an fwnode, and therefore not direct child nodes of the device
> node.
> 
> Use `device_for_each_child_node()` to indicate device's direct child
> nodes.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Why not the scoped variant?
There look to be two error paths in there which would be simplified.

> ---
>  drivers/leds/leds-bd2606mvv.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/leds/leds-bd2606mvv.c b/drivers/leds/leds-bd2606mvv.c
> index 3fda712d2f80..4f38b7b4d9d1 100644
> --- a/drivers/leds/leds-bd2606mvv.c
> +++ b/drivers/leds/leds-bd2606mvv.c
> @@ -69,7 +69,7 @@ static const struct regmap_config bd2606mvv_regmap = {
>  
>  static int bd2606mvv_probe(struct i2c_client *client)
>  {
> -	struct fwnode_handle *np, *child;
> +	struct fwnode_handle *child;
>  	struct device *dev = &client->dev;
>  	struct bd2606mvv_priv *priv;
>  	struct fwnode_handle *led_fwnodes[BD2606_MAX_LEDS] = { 0 };
> @@ -77,8 +77,7 @@ static int bd2606mvv_probe(struct i2c_client *client)
>  	int err, reg;
>  	int i;
>  
> -	np = dev_fwnode(dev);
> -	if (!np)
> +	if (!dev_fwnode(dev))
>  		return -ENODEV;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -94,7 +93,7 @@ static int bd2606mvv_probe(struct i2c_client *client)
>  
>  	i2c_set_clientdata(client, priv);
>  
> -	fwnode_for_each_available_child_node(np, child) {
> +	device_for_each_child_node(dev, child) {
>  		struct bd2606mvv_led *led;
>  
>  		err = fwnode_property_read_u32(child, "reg", &reg);
> 


