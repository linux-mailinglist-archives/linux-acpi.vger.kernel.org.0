Return-Path: <linux-acpi+bounces-6880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A541930171
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 23:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13ED2B21EF7
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A147F41;
	Fri, 12 Jul 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gSpGb5Qt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31D219FF;
	Fri, 12 Jul 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818450; cv=none; b=fWq56q6arKRbKVw3qpAC40Znu07ekXhMXgtMzc7nhc8/rRa/gTfZvM7aRk1h4Ua7TUFsJK3ejBciKIsxqPHipY+tqqfzYUiYsNWedPwundi6gs72kc8flJq9BM/KERYp/Cf/LNdrj5RsbV394Aki7uiZmk/tgm7WGm3TvLploVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818450; c=relaxed/simple;
	bh=vKFZ7VhhVPwDMBl1L3Jwa9uOyxKi/wF0dZAUg/xUYoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcfxGAhNmJ0i1diy3a30bthBXK33ExUGsqvErnBM/DBf2H806IdKuwtLzvW9a08/gJ6jR6mXPqmCzqdxAQsyBDYU0zsoZzg23RtpjH2+490xl4iA0SIIeX/hKwL9Ny+hYR2VEekJ26mYRZV5BfM2mWcoghKkEC0PCdwHa2Hsyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=gSpGb5Qt; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4fyXkYyDXPeoIA7KiK11Pb/8YiiA2kBtTpxn1oy5Xfg=; b=gSpGb5Qt1QavJ4twGDivqpU9x1
	kJt7FGBvbK2aTCJXowAhCepe19G36RO0QZWmVH4ZPnVqIYIfznu7g94inYaiaa4BZwbr0mfO7JKmq
	hYRy6/W3yREkiAKPS246SXVVNa0BVKo1HZe+daKDFlZ9wbhS0rpTOJi6AfDKYl1fydKTSjE4zeaFA
	T2PD/MI/JPC74BKmrhhAdrEh2TjJz5S2lgouEjh1E/aDlO28e1Khlw1472v0LlmBo1AWQJStJIzSv
	XuNycvvbN48jEJAU5oiGYqzSk8+UlLvMw5zPEmKVQbAREOVeGYIr8Ia4mlMgVp51XfHHXOziLrjME
	hkmO4NzA==;
Date: Fri, 12 Jul 2024 23:06:56 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring
 <robh@kernel.org>, Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
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
Message-ID: <20240712230656.67e89eb2@akphone>
In-Reply-To: <2cd45260-e737-43e9-9bf6-c267d6f86ad3@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
	<20240706-device_for_each_child_node-available-v1-3-8a3f7615e41c@gmail.com>
	<20240707175713.4deb559f@jic23-huawei>
	<4cf71de7-dc47-475c-bba0-a9e755f66d49@gmail.com>
	<2cd45260-e737-43e9-9bf6-c267d6f86ad3@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.37; aarch64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 17:45:43 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 08/07/2024 10:14, Javier Carrasco wrote:
> > On 07/07/2024 18:57, Jonathan Cameron wrote:  
> >> On Sat, 06 Jul 2024 17:23:35 +0200
> >> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >>  
> >>> The iterated nodes are direct children of the device node, and the
> >>> `device_for_each_child_node()` macro accounts for child node
> >>> availability.
> >>>
> >>> `fwnode_for_each_available_child_node()` is meant to access the
> >>> child nodes of an fwnode, and therefore not direct child nodes of
> >>> the device node.
> >>>
> >>> Use `device_for_each_child_node()` to indicate device's direct
> >>> child nodes.
> >>>
> >>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> >> Why not the scoped variant?
> >> There look to be two error paths in there which would be
> >> simplified. 
> > 
> > I did not use the scoped variant because "child" is used outside
> > the loop.
> > 
> > On the other hand, I think an fwnode_handle_get() is missing for
> > every "led_fwnodes[reg] = child" because a simple assignment does
> > not increment the refcount.
> > 
> > After adding fwnode_handle_get(), the scoped variant could be used,
> > and the call to fwnode_handle_put() would act on led_fwnodes[reg]
> > instead. 
> 
> Actually, the whole trouble comes from doing the processing in two
> consecutive loops, where the second loop accesses a child node that
> gets released at the end of the first one. It seems that some code
> got moved from one loop to a new one between two versions of the
> patchset.
> 
> @Andreas Kemnade: I see that you had a single loop until v4 (the
> driver got applied with v6), and then you split it into two loops,
> but I don't see any mention to this modification in the change log.
> 
> What was the reason for this modification? Apparently, similar drivers
> do everything in one loop to avoid such issues.
> 
The reason for two loops is that we check in the first loop whether
broghtness can be individually controlled so we can set max_brightness
in the second loop. I had the assumption that max_brightness should be
set before registering leds.

Some LEDs share brightness register, in the case where leds are defined
with a shared register, we revert to on-off.

> Maybe refactoring to have a single loop again (if possible) would be
> the cleanest solution. Otherwise a get/put mechanism might be
> necessary.
> 
I had no idea how to do it the time I wrote the patch.

Regards,
Andreas

