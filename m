Return-Path: <linux-acpi+bounces-19208-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1AC80A64
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 14:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2273A3101
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5373303C93;
	Mon, 24 Nov 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LnR1xXKS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C81E4AF;
	Mon, 24 Nov 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989434; cv=none; b=ScwY6e1S6GjjCG6i3DJ+bOITutR9JDt4W0F7h5K2B7w+4nQA1w8Juc4rt3H9Z/j9PTKga03UUX8PamqyoF7qj9kVEIqwdyU9fZBgyYnjNwdIdBizNHW5nNQ0cyp40m9BzB4/cfjeNRmLjlI47r3LLcApWlXA9QZ2MDwXiU1W09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989434; c=relaxed/simple;
	bh=u9QmXLpBiycpZDzHIopSNexoAtuQE08B6uvYL51nlzY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R0iuBjv0M++Q0KCuuzjoMAd9WHF5gYw0VAX9yv70coNJlma97+yRS0/li85lw1fe9fC7cVSNntMAAPwdmEZD6dYcFei8TW2pMIF9EAvShIe8tTb7T6aQVEM8FdA3QwfG8MWYk6cJYgg1LC54GkZSFREaOGzmwlDKscFK+9ZH7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LnR1xXKS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763989430;
	bh=u9QmXLpBiycpZDzHIopSNexoAtuQE08B6uvYL51nlzY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LnR1xXKSG2vr8muOeSaS7s3TN6ejmuJU6IYniGu+1bLi2hymCElZip9In0M+xFvZF
	 zZ/BN4SFBUoXo0UETuRLGyqqmJIEH7xvxYyqVYNVHwS4QQGvpWRdKuC1fPuw8FBuhW
	 J6AJJKLSLBMXKCigW4MFRbbgASGt6k3s0s0ZueHYH2X+hr9LFvm9kL+nDtuE71SnTm
	 ONqpu6xyx6v99ewsM7IsyNKqf26Lb1GxNjLKH9fpUFSrgE+gybGNZZu/pI8/8YxelH
	 UgXlAPOfLO4W7vRm85x6H4nsA36QrLtwu50pStwJG/Jv3YzjStItcU2t0OoNT+GwJ5
	 QYSvOCT3F/mBQ==
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0369917E0ECB;
	Mon, 24 Nov 2025 14:03:46 +0100 (CET)
Message-ID: <9c61f778-fd65-4b28-8bda-e8463dda2862@collabora.com>
Date: Mon, 24 Nov 2025 18:03:16 +0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com,
 Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PM: Hibernate: Add hibernation cancellation support
To: "Rafael J. Wysocki" <rafael@kernel.org>, superm1@kernel.org
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20251107184438.1328717-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Please review the patches when you have time. 

On 11/7/25 11:44 PM, Muhammad Usama Anjum wrote:
> On a normal laptop/PC, the hibernation takes 15-20 seconds which is
> considerable time. Once hibernation is triggered from command line or by
> some GUI option, the hibernation cannot be cancelled until completed.
> Its not a blocker, but poor user experience.
> 
> When power button is pressed during hibernation, it generates interrupt
> and then the event is routed to userspace. If systemd is being used, the
> logind handles these events and performs the specific action.
> 
> During hibernation, the first stage is to freeze the userspace. Hence
> even if the power button is pressed, it doesn't aborts the hibernation
> as user space daemon is frozen.
> 
> My device takes ~19 seconds to hibernate. When I was testing hibernation
> using rtcwake with timeout of 10 seconds, I found out that hibernation
> gets canceled around 10 seconds mark when the interrupt fires.
> 
> In this series, the idea is to find a way to cancel the hibernation.
> With this series applied, the hibernation gets cancelled gracefully.
> 
> The hibernation cancellation support isn't present in very last stage
> just before power_down(). I've not been able to handle the error paths
> correctly there yet as logs aren't available from that stage. I'll send
> that patch separately when it works.
> 
> Cc: rafael@kernel.org
> Cc: superm1@kernel.org
> ---
> Changes since RFC:
> - Update description of patches
> - Use pm_sleep_transition_in_progress() instead of
>   hibernation_in_progress()
> 
> Muhammad Usama Anjum (4):
>   PM: hibernate: export pm_sleep_transition_in_progress()
>   ACPI: button: Cancel hibernation if button is pressed during
>     hibernation
>   Input: Ignore the KEY_POWER events if hibernation is in progress
>   PM: sleep: clear pm_abort_suspend at suspend
> 
>  drivers/acpi/button.c     | 12 +++++++++---
>  drivers/base/power/main.c |  2 ++
>  drivers/input/input.c     |  6 ++++++
>  kernel/cpu.c              |  1 +
>  kernel/power/hibernate.c  |  5 ++++-
>  kernel/power/main.c       |  1 +
>  kernel/power/process.c    |  1 +
>  7 files changed, 24 insertions(+), 4 deletions(-)
> 


-- 
---
Thanks,
Usama

