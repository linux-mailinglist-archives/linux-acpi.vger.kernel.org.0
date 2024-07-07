Return-Path: <linux-acpi+bounces-6800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13311929915
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 19:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81ED3B2120C
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029FC54FAD;
	Sun,  7 Jul 2024 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+rVdNIk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10601DDE9;
	Sun,  7 Jul 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371713; cv=none; b=dRWgfLdutjVoNI0tP0jLXPB0hXx/+xeEJjasbvMhfHVzdp3yo1B7DBzce6xu8Yh4Vss5pzuWDibMW2UZzvIAUPPiDXa1koIE78lW2M07XzhgEyoagcMLTBtT6SqdkO+GugwM5FDZYI2Axa4UTDZLwABRQkl2OgZFB1eP5wBK0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371713; c=relaxed/simple;
	bh=HK1L7jh0P/SEwYcMi6wp3TyqcAZ+F1jnIRkjVnfrlPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLLU4G2/A+RAk3RhIkGIQMqcSupOg+Zw+kK54PgsPClguzbYFUCqQrcfU7Ec65IFXDIpnD7H3NWnFQ0ckuPimlsPczlygNI7cBN+ZOy1NyIZSQXnMCDqcMavu0CIuPL75DP4HMKlrc8fV2hS5MSha/yjfRenhnxa2Z78gBu17cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+rVdNIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB0DC3277B;
	Sun,  7 Jul 2024 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371713;
	bh=HK1L7jh0P/SEwYcMi6wp3TyqcAZ+F1jnIRkjVnfrlPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u+rVdNIkqy8Ozxch+7Z2P6gJrcXqqnHGO0K+9GlJvyL7g0g3/oOhTHfi1QyNqBzR8
	 vPSrJXfeTQV2NFMduTGx9DM+j/DVDykWMAm1LTvLKTZ39KHFTyHP6KzotVxAWNdv8M
	 hbu1a+L+uThwT6px2n2X09M1V9WF8XuN0m6lzPpZ2FjgMf4clMSNYQXlKoJjNY8VrT
	 1OI2Tzl/0zxMAqKny6PmGyRxIo3/JwMg7p09y7iA9G1KuqSjSmTHtM5QrvudjCg0Fh
	 Eum9mHjkpweOTAOnHBQB3ZMFkZ3hyKp7NaBWWnS+IWX0d8G7G4UnQL5o9Avm+ll8nQ
	 CigoGU/prZKmQ==
Date: Sun, 7 Jul 2024 18:01:40 +0100
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
Subject: Re: [PATCH 6/6] net: mvpp2: use device_for_each_child_node() to
 access device child nodes
Message-ID: <20240707180140.2982f04f@jic23-huawei>
In-Reply-To: <20240706-device_for_each_child_node-available-v1-6-8a3f7615e41c@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
	<20240706-device_for_each_child_node-available-v1-6-8a3f7615e41c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jul 2024 17:23:38 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The iterated nodes are direct children of the device node, and the
> `device_for_each_child_node()` macro accounts for child node
> availability.
> 
> `fwnode_for_each_available_child_node()` is meant to access the child
> nodes of an fwnode, and therefore not direct child nodes of the device
> node.
> 
> The child nodes within mvpp2_probe are not accessed outside the lopps,
> and the socped version of the macro can be used to automatically
> decrement the refcount on early exits.
> 
> Use `device_for_each_child_node()` and its scoped variant to indicate
> device's direct child nodes.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

