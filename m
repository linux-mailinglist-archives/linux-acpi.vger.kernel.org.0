Return-Path: <linux-acpi+bounces-7003-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD7C938A42
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2024 09:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B52819DD
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2024 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7613E02A;
	Mon, 22 Jul 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdxOoj9F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33883770E6;
	Mon, 22 Jul 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634012; cv=none; b=EZO8XB0HoSaxwIHv+CriAq6Sy4Rpgc6dkX0n96AV53y3kx3BYv1Tlv3rYIClMLdnMZe6/YxkLrcoMA83GVUMPU2KiebuY00XFfy9T9agNh3YJjnZvUlhhyzYybKodfixV+pa50LIQZDGfJ66UH8j58SoPFWUMxbOplrFPUqlQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634012; c=relaxed/simple;
	bh=Gds3YGJhwEOU78oLrFElHnVTEhE1tgxeRJe3NKZ8Gpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM7/QrR4f3dVlF1Wcyk9+/3DBNHM+cRLvcKBQCUaYoNCwJ7bIjYLdK+646DYTLs8AkwzQ4N1yDwkbZUb3pcpNqVZpa1/4h1Y5zs7auxuF5PaoptUTJFnn8SynCoAW6HudNLRR2kJYE0iBYQbgzix2IR0+9gOgpoun2x3njRXsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdxOoj9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B84BC116B1;
	Mon, 22 Jul 2024 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721634011;
	bh=Gds3YGJhwEOU78oLrFElHnVTEhE1tgxeRJe3NKZ8Gpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdxOoj9FPY8C+BCuN42ENUA2/9pA0cg0lsa+aoLUeXx8AicRmp5ZZ27oDRIec6zJU
	 KqMVc6ztS1/K4aJmnzriiAWzzh0jag02HX3PAEpmm3xEw6FzAAFBQT99HqirhlWaS8
	 zkZWqwKJbB7Qqq27dwtbxg641Awi8YTSz+oeMhSM=
Date: Mon, 22 Jul 2024 09:40:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?iso-8859-1?Q?G=FCnter_R=F6ck?= <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/6] device property: document
 device_for_each_child_node macro
Message-ID: <2024072204-jester-exploit-d249@gregkh>
References: <20240721-device_for_each_child_node-available-v2-1-f33748fd8b2d@gmail.com>
 <73b3e14a-c1c3-4f7b-aea8-2108912e21ca@web.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73b3e14a-c1c3-4f7b-aea8-2108912e21ca@web.de>

On Mon, Jul 22, 2024 at 09:15:26AM +0200, Markus Elfring wrote:
> …
> > + * Unavailable nodes are skipped i.e. this macro is implicitly _available_.
> …
> 
> How good does presented information fit together in this comment line?


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

