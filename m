Return-Path: <linux-acpi+bounces-6799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ADD92990D
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 18:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1491F2144A
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87F54FAD;
	Sun,  7 Jul 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsjlzvyW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463E4D8DF;
	Sun,  7 Jul 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371580; cv=none; b=ir7JR+PwGlVPeZ3C/d21+UWTRdknKLDgIIZzAR5VhsR3InIx2a83ePcvHo947KnZxIN7BkrfpIPD6Z7TesPgws8/ts6kiLNnNeQ1lgl0xwWrMdzvsFiS5fPqIMOsvOY4gKkeSLFKuF23HjhHTCcpX/zNPqG8e7bR+vLmmQqsRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371580; c=relaxed/simple;
	bh=xT1ziNJA/xAO/tLDQLg/t8ceseRnsib1OpUFbyHOV1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T43HUm9cfeG1Q4P6G/cxKmIRGvP9bfuts+Jiv6zQx1swHzZc4OFrC3kCp5qN5LPjEmP00WZs2xm1Nncc490TbaHskSISug2s6+wDhA/wkFVno6O+dxtEN6eB72AxPhcF9d0H7etnjUb7ZTt3h1JwzzPF9zbwdQ0CFDEj5gj/Yk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsjlzvyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1FFC3277B;
	Sun,  7 Jul 2024 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371580;
	bh=xT1ziNJA/xAO/tLDQLg/t8ceseRnsib1OpUFbyHOV1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DsjlzvyWRe0wAmR+4HEz3fC8k7/rXVERuLQ5n13s20TFUN1FhQ5gcE9LXpB4zGqi3
	 bb43w1zq+BlkVD4P+J8/iAMwxdcA+swiNL9ncBL7BhjCOUv4m9fRr+W2pQ9vbJLmqq
	 joT24C1fS4nQ372a2mozXR46n6PwswvFMhw1bZ1t/8MIqhCGrXHGsvBDG+FGcP3I9X
	 z69TVvwSfQX+8s7ZwFyT6VMKM2OCr2q3kk1VIWE6COSQyfjXjgIXo70LA+JH/66u+C
	 Ux9k4VLvJ1QIFhMfrL27zGg5o+Zzxr1YQLJHilIVR28atvMaD+ncyYyoxc8sPSEeGJ
	 fH/k5uSzQb8AQ==
Date: Sun, 7 Jul 2024 17:59:27 +0100
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
Subject: Re: [PATCH 5/6] leds: pca995x: use device_for_each_child_node() to
 access device child nodes
Message-ID: <20240707175927.18c4340e@jic23-huawei>
In-Reply-To: <20240706-device_for_each_child_node-available-v1-5-8a3f7615e41c@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
	<20240706-device_for_each_child_node-available-v1-5-8a3f7615e41c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jul 2024 17:23:37 +0200
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

