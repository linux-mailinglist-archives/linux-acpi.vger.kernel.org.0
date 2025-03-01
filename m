Return-Path: <linux-acpi+bounces-11668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCA0A4AB68
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 14:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECE016F128
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF711DF255;
	Sat,  1 Mar 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwDH8z8O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8231E522;
	Sat,  1 Mar 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740837140; cv=none; b=ZGevIo7FxDJX70XF54z50P4qvzc/UgSXj9HawKlpLvihbrTH8oZrtok2HPr00eH9wX1izrSFIru7hsyuwriSyoQK3wdTq7vbHpsuYgJmR18hnODClueE/vxEFxsEGwqQkip2BYgxoxZRunA7gku7NOlKgM0y6JvilLLU2hcejog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740837140; c=relaxed/simple;
	bh=6Bih9s9N8cIQd39nOyUIaKyFZAl5RW/d0MiIvTb1BN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcuPRCZUhI5YLOX0KplHDE3K8H6GgUCC1rrD/xYQQscKLiLk3iA+KswnSHRtFKl0mqXUVsQV9UJPnwCT7R8ftsqMVnO1QVcQDKb4orTcvzMDpz8Qd30pryNBned/HSDIiRmn4+KqRoeJ1ygOC6VgX14v1gM6Y6o6LzOse+0ruhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwDH8z8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D41C4CEDD;
	Sat,  1 Mar 2025 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740837139;
	bh=6Bih9s9N8cIQd39nOyUIaKyFZAl5RW/d0MiIvTb1BN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gwDH8z8OahVL4xJA79BSFzl7HEPM7doRZjfSKnxZoU3kMzB88v6kMiOVpXDcpFdJh
	 zs6W07NQU7AzganEDppq2f1uCUY58tpTK/I9Z47WpICjT2jLgGwX7ZpVlHfzxKNApJ
	 nGNFq4BEUatEqqM2QD3AssKKV7ZXQLYLZmQHgx/0B2gqhzqmXyfsxn5+LsOruDVzkg
	 XkMn9rM866oirhkmt0sRNbw2PKuzs82YlG8ksdSUtA92Ee+5b1K2ZlV/msHFfkjEVP
	 FedWp37l2KN3BSG9vQec8hZhCCxbV4o2y/I2soiRGLD7W262fUpWjO9T+ap+W67o0L
	 ikCxpsnK+lzjw==
Message-ID: <09674d15-d639-4cb3-837a-9575f0028a76@kernel.org>
Date: Sat, 1 Mar 2025 07:52:15 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: platform_profile: Add support for hidden
 choices
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Kurt Borja <kuurtb@gmail.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Mark Pearson
 <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
References: <20250228170155.2623386-1-superm1@kernel.org>
 <20250228170155.2623386-2-superm1@kernel.org>
 <D84F6QF8EU3D.3RUI1PKXP2DZ3@gmail.com>
 <6f56571a-3090-4323-a29d-008b916abf39@kernel.org>
 <CAGwozwGFLQxGEQ-nb+d9yrikz=fx+u48mpTYUyUtvgFD-9ypQg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwGFLQxGEQ-nb+d9yrikz=fx+u48mpTYUyUtvgFD-9ypQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> Let me know what you think!
>>
>> I don't really like that profiles can get out of sync, this is asking
>> for a non-deterministic behavior that can be difficult to diagnose
>> issues and also difficult for userspace to work with.
> 
> I agree with Mario here. Imagine two drivers, one with low-power and
> one with quiet. They both begin at performance.
> 
> Then, userspace software gets confused (incl. ppd) and sets firmware
> profile to low-power. The latter gets left in performance, causing
> excess drain.
> 
> I do not believe the legacy interface should be deprecated. Right now,
> amd-pmf is a NOOP in most devices 

"Most" devices is not accurate.  There are a lot of devices that it does 
enable.  In the gaming space right now it's often behaving as a no-op.

> so there is actually 0 reason for
> generic power handlers to move to the new API. Just extra work. So
> lets make sure the legacy endpoint works properly for the foreseeable
> future.
> 
> Also, when power handlers start moving to the new interface, they will
> hardcode choices based on the name. As they should. TDP needs to be
> customized per device/manufacturer. So moving handlers between
> low-power and quiet will not be possible.
> 
> @Mario: I do not have a device with an amd-pmf integration. All of
> mine have stub handlers. I would expect that a properly configured pmf
> handler for e.g., Asus would do the same as the armoury interface, so
> that users do not have to rely to vendor software on WIndows. Then
> power profiles would be synced between windows and armoury. In that
> case, we have a problem of setting the power mode twice. What would be
> the mitigation for something like that?
> 
> Antheas

"Power mode" is a concept, it doesn't just apply to configuring sPPT and 
fPPT.  I envisage that a vendor that actively uses PMF and their own 
interface would be changing different things by the different interfaces.

For "example" PMF may reconfigure sPPT, fPPT, STT and STAPM but their 
driver may notify their EC to change a fan curve.

If we really end up with a situation that vendor interface and PMF do 
the same thing we can cross that bridge then.

