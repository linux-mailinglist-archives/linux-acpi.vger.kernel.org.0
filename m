Return-Path: <linux-acpi+bounces-8366-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A374D97E0A0
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9486D1C20A03
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C27193406;
	Sun, 22 Sep 2024 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+raVW/5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB029D06;
	Sun, 22 Sep 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726995198; cv=none; b=mIWPhXMiph7IlzwcEpl2gt9ChrUaeQAvJkbxCh3219zJJT2OV/W67WLOUWIwwJqkMTT4hHmPcBKysCiVx/D6QEQvfXDdw9nwvgyKy7PzepYUQfjXpV0VJQhGD4ZUGc4vAkMMkpU7b01xhwDcDkteG4SA0Ica28q40k2RCYbwgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726995198; c=relaxed/simple;
	bh=xhIq2xevMCSzlU0Hmtp6h+xdSzl4EfZoj7nSFX62t00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikjZWWVJKo5EYxJKGDthyk3zSYsZib8kPQOku4myEXwvzyN6dZINE2COnz4I8I9o4NAV1F3oStbegRRbxYbrPe2xNzWRekqMjoP2YzL/b+9WbNFJWzyx0waBlb0kjgQbn7/zrzqycbLZjyjjaquFMCNHaTDGjkjtkpNMNu9yjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+raVW/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028D7C4CEC3;
	Sun, 22 Sep 2024 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726995197;
	bh=xhIq2xevMCSzlU0Hmtp6h+xdSzl4EfZoj7nSFX62t00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+raVW/5OQSxtZnPfvPdx80alm+wy0WGTvZqrb7XUfGj2oi6Kof0dLoWeng0ZkKn8
	 M+yMK7044feu71yOVWtWMK9U4TGDot6V0eHd0AFcqTi5j+wYgU3kOvwFBVY1vwPOyk
	 vlJfIxWoDZjL+1OE7e5XqtsBgAbZLIMiZHbxJ0ACiS7xVxE9dYd2RHS49Iq/axytOJ
	 jey8M3RZI36ufnUjWqlutWkcMUPN9+PXAmYv5JfgTCbL+KFeefrLoGi7fWMmhXF43J
	 S/GWSlbMQhYDq9q9UysQE6w9jsNajKssvr8jMd7aNr4mn9FbgMkeJ1IHT+MErXUSTC
	 V9byr8EpGCINQ==
Received: by pali.im (Postfix)
	id DEA3B816; Sun, 22 Sep 2024 10:53:10 +0200 (CEST)
Date: Sun, 22 Sep 2024 10:53:10 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andres Salomon <dilinger@queued.net>
Cc: Armin Wolf <W_Armin@gmx.de>, mjg59@srcf.ucam.org, rafael@kernel.org,
	lenb@kernel.org, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] platform/x86: dell-laptop: Battery hook fixes
Message-ID: <20240922085310.sa3gwbsobd54vufg@pali>
References: <20240922064026.496422-1-W_Armin@gmx.de>
 <20240922034513.330343fb@5400>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922034513.330343fb@5400>
User-Agent: NeoMutt/20180716

On Sunday 22 September 2024 03:45:13 Andres Salomon wrote:
> On Sun, 22 Sep 2024 08:40:23 +0200
> Armin Wolf <W_Armin@gmx.de> wrote:
> 
> > This patch series fixes some issues around the battery hook handling
> > inside the ACPI battery driver and the dell-laptop driver.
> > 
> > The first patch simplifies the locking during battery hook removal as
> > a preparation for the second patch which fixes a possible crash when
> > unregistering a battery hook.
> > 
> > The third patch allows the dell-laptop driver to handle systems with
> > multiple batteries.
> > 
> > All patches where tested on a Dell Inspiron 3505 and appear to work.
> 
> Can you tell me more about the system? What type of battery is the second
> battery, and how is it attached? What do the kernel logs look like when the
> two batteries are registered? I'm still confused as to how the same
> battery->dev ends up being reused for multiple physical batteries.
> 
> The patches look good to me, btw; feel free to add my Reviewed-by
> if that's helpful.

For me these patches also looks good, so you can add also my
Reviewed-by. But please wait for the review from ACPI people.

> Also, with the caveat that I'm not quite understanding the aforementioned
> battery->dev conflict - worth noting that dell-laptop isn't the only driver
> that could have this problem with multiple batteries. A quick glance
> through some other drivers:
> 
>  - asus-wmi.c does basically the same thing in checking for just the first
>    battery, and the comment implies that there may be multiple batteries.
> 
>  - system76.c claims that the EC only supports one battery, so maybe that
>    one is okay? But to be on the safe side, it should probably do the same
>    thing.
> 
>  - thinkpad_acpi.c actually supports multiple batteries, so maybe it
>    doesn't have the problem. But if tpacpi_battery_probe() fails for one
>    of the batteries and the battery->dev is shared between the two
>    batteries, then same issue?

It is possible that there is same issue.

> 
> > 
> > Changes since v1:
> > - fix the underlying issue inside the ACPI battery driver
> > - reword patch for dell-laptop
> > 
> > Armin Wolf (3):
> >   ACPI: battery: Simplify battery hook locking
> >   ACPI: battery: Fix possible crash when unregistering a battery hook
> >   platform/x86: dell-laptop: Do not fail when encountering unsupported
> >     batteries
> > 
> >  drivers/acpi/battery.c                  | 27 ++++++++++++++++---------
> >  drivers/platform/x86/dell/dell-laptop.c | 15 +++++++++++---
> >  include/acpi/battery.h                  |  1 +
> >  3 files changed, 31 insertions(+), 12 deletions(-)
> > 
> > --
> > 2.39.5
> > 
> 
> 
> 
> -- 
> I'm available for contract & employment work, please contact me if
> interested.

