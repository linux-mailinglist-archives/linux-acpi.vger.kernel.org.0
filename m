Return-Path: <linux-acpi+bounces-19447-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B1CA86D9
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 17:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F5A03021172
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23C331A4E;
	Fri,  5 Dec 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWtriqX6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D782866;
	Fri,  5 Dec 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953222; cv=none; b=UVPDERzltqYfHmI8xdVB+SiViHMiTzN0k7pVQ6tTCgD++ChA2F83Q7CfY4oaBPaZZt8jrJMDgTc0dcI8Jrret/jDRXjYvnF7Mj9gM81Q4EtLwRcOCytnOvBl1m+rwx3XPGrnbG1McZgIJMXEanyitPdDHalDAOAZuS5Z7xsSrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953222; c=relaxed/simple;
	bh=JiYxUETYwRFcHRI7a2AmpY0VXLcP+iKzcU06H8ZQG5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSuNEe7lgmABAevoONDM7yca/o7aZdkDNNi6/ADB3oNwsGq/yxDgCnHFYBGCpb4oSNHsemYEKirxHD8r0mv3XoTja21kVnx19lqnBilnT47uTu9MMlYJWQ+4htMDV9elN+B0CkvYXEcMm1cMjrVloKnDmzmD+XaDqdLrtNnIQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWtriqX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705D3C4CEF1;
	Fri,  5 Dec 2025 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764953221;
	bh=JiYxUETYwRFcHRI7a2AmpY0VXLcP+iKzcU06H8ZQG5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KWtriqX6BFFZVocPfrRYTlv1DCDa/sfEd6s3LlPZu/XRkPon+6pfWjisoZZZfRkXI
	 fc/MQ23aUe/wGZizgchFTBCG5JBE1S6CqbTX7e6MNZSHVeLjX2LTBvgEsOMtaaq+EX
	 OORkyA+N5aALdWutxOuF1NvM2sORgceaNf6n02KnDLxv+0H/1osxX2+i4f87cNJWyj
	 dDuZHINz5DPr2IeHikcDhd+xRXeQB4YFbL6krpsZ/XkTaJseWJPHUfpWzyRW/tIsaS
	 4nbaUWYF9Maz2T0Kq6yyOJ4QSNFNyr1c/B1BonAOo5WVJu0QncGbZvkLX2wCvCX2a/
	 gnTxOQkq6OX4Q==
Message-ID: <a0d91fa6-bf95-4bbb-a4f9-9d8cceae5543@kernel.org>
Date: Fri, 5 Dec 2025 10:46:59 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Antheas Kapenekakis <lkml@antheas.dev>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>,
 systemd-devel@lists.freedesktop.org,
 Lennart Poettering <lennart@poettering.net>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
 <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> I would start with the graphics stacks and teach them to
> runtime-suspend the HW when the displays go off.  No firmware
> notifications are needed for this to work.  

Well the problem with this is there is a sizable latency to runtime 
suspend hardware when displays go off.  For example you would need to 
redo link training when you spin the hardware back up.

What we do today (AMD *dGPU* centric) is runtime suspend the hardware 
when no displays are connected and nothing else is using the GPU (for 
offload purposes).

On AMD APU we don't use runtime suspend.  If you ignore the latency I 
could see an argument for proxying the status of displays to indicate 
runtime suspended, but I don't know what it really buys you.

> Then, I would teach
> graphics drivers to leave the devices in runtime-suspend if they are
> runtime-suspended when system suspend starts and to leave them in
> runtime-suspend throughout the system suspend and resume, so they are
> still runtime-suspended whey system resume is complete.  I'm not sure
> how far away graphics stacks are from this, but at least some of them
> support runtime PM, so maybe the fruits don't hang very high.  With
> that, you'd just need a way to trigger a system suspend after a period
> of inactivity when the displays are off and you have your "dark mode".

I think even without kernel changes this can be accomplished today with 
userspace.

There will be change events when the displays are turned off and you can 
listen to and set a timer to enter system suspend based upon how long 
they are off.

