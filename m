Return-Path: <linux-acpi+bounces-6795-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A679298F0
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 18:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AEE1C20E6F
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E924D11D;
	Sun,  7 Jul 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxR8DmPe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77174654E;
	Sun,  7 Jul 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371226; cv=none; b=NKkbim48V+c4wWoYDA9iCXSo+iOmh2H62F82ETqcZGB19J4yrJSaVIX680UcSN2oiw3J6yS3LIAZqAKtdLv8kwSH+ECje6AWxAsTdIz0UJrfWHkjp46vCuu0zp8FpBM51gF8t9fy4PYPablgDxvqBU+p8YDtO+y1QXOGExZZKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371226; c=relaxed/simple;
	bh=LO+JAK2kFx7TUk6Rns6hr7HIOLavQDXDT6QwVoDH924=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIXlX9A75ZsAEWgh0evJKK9gb4WE9kTLJwfGDAAi/j6tpPNi8ShtV7Z2VPSjYrW3I/Aqu7WV9k+WlzNt0+aZFB9h+cgSJVrHdbaw6L/Jl+AvQ/w0c0girBqD39TlI9xqDhTSXHkKonjH4VSqW8eez1u6uy9N3ZZTa/J9M634Glo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxR8DmPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB5DC32781;
	Sun,  7 Jul 2024 16:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371226;
	bh=LO+JAK2kFx7TUk6Rns6hr7HIOLavQDXDT6QwVoDH924=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PxR8DmPedXrCCP0XME8n551nlcjprlutZZPfIk6n5MRaKHGv5891jLauSifacmz8m
	 6DPL4t8smgNlMKuPQ55Wyxn4Yj9GBG8wxjU5MjbgB0uojFlym7TA/qYLgfU4ggbwzy
	 bUG9MXkkynOZ29wDWeFHwf5fJRMNaisN7P2baSjOWYMQDqOC3By3ItZ2gb8u6boWeq
	 kFJTdBCihK8Z1DPGVeBFxyxVkrmASrr4PVFq9DBPtsIE4ZlOH39Q0BFj647eZTZcFH
	 IM763w1rxz2v5MbJ+JV/8of1NHggFKw/vR0Uy7QsQyyrBLi8JsrZKBX6z0kFjGAUBb
	 bwi0/McI6+ZTw==
Date: Sun, 7 Jul 2024 17:53:39 +0100
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
Subject: Re: [PATCH 1/6] device property: document
 device_for_each_child_node macro
Message-ID: <20240707175339.427ab29f@jic23-huawei>
In-Reply-To: <20240706-device_for_each_child_node-available-v1-1-8a3f7615e41c@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
	<20240706-device_for_each_child_node-available-v1-1-8a3f7615e41c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jul 2024 17:23:33 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> There have been some misconceptions about this macro, which iterates
> over available child nodes from different backends.
> 
> As that is not obvious by its name, some users have opted for the
> `fwnode_for_each_available_child_node()` macro instead.
> That requires an unnecessary, explicit access to the fwnode member
> of the device structure.
> 
> Passing the device to `device_for_each_child_node()` is shorter,
> reflects more clearly the nature of the child nodes, and renders the
> same result.
> 
> In general, `fwnode_for_each_available_child_node()` should be used
> whenever the parent node of the children to iterate over is a firmware
> node, and not the device itself.
> 
> Document the `device_for_each_child node(dev, child)` macro to clarify
> its functionality.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

LGTM but I think needs at least a DT and ACPI ack.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One trivial tweak inline.

> ---
>  include/linux/property.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 61fc20e5f81f..ba8a3dc54786 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -171,6 +171,16 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  						 struct fwnode_handle *child);
>  
> +/**
> + * device_for_each_child_node - iterate over available child nodes of a device
> + * @dev: Pointer to the struct device
> + * @child: Pointer to an available child node in each loop iteration, if found

If it's not found then there are no loop iterations. So could drop the ,if found
I think.

> + *
> + * Unavailable nodes are skipped i.e. this macro is implicitly _available_.
> + * The reference to the child node must be dropped on early exits.
> + * See fwnode_handle_put().
> + * For a scoped version of this macro, use device_for_each_child_node_scoped().
> + */
>  #define device_for_each_child_node(dev, child)				\
>  	for (child = device_get_next_child_node(dev, NULL); child;	\
>  	     child = device_get_next_child_node(dev, child))
> 


