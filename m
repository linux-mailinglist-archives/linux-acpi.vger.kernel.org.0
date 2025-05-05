Return-Path: <linux-acpi+bounces-13452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D6AA96B6
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C0E17CE96
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7025B67E;
	Mon,  5 May 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih5oqGMz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368425A2C6
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457085; cv=none; b=cYEfBWkwvXdgJNYQf3nixEXUYwVqz35tj7pY//NwyeBzAogq3/G1P4RVm2O+I3dCskJKa52oZiUAo8w/A6guN13GooFx1OPlcZ8ek3mNS9NH3Zmw+ZCZc94nV6B47X68wJAYExvq3jXOOId9Edt4/m/AQWtPMRXBXd+PVLA6JrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457085; c=relaxed/simple;
	bh=r8E0B5L+bhH5azUa0DQ8lvoBvo3+64o1Hm3e4UgRkfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VabwuHgVRby/fHv5DVMwpdXA00tvcIXo5WgYuOphT7tdJMpF6fgk67e4+CRG5cHyZpoIUUI1ZKhIH4MgiScTjzN22K4Ma0uWMRy3Pf2Ota+W93BsiU+E8K2Jt41CIhBXC36xtVyfdvgP+yhhYMFHxtVr4KetfMRmJPwAO2zY3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih5oqGMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9192DC4CEE4;
	Mon,  5 May 2025 14:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746457084;
	bh=r8E0B5L+bhH5azUa0DQ8lvoBvo3+64o1Hm3e4UgRkfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ih5oqGMzTlBHyMqh3LSa9mQSlosupG1rNDx9axQ9UgZPtYWNlPfYuWEDMBI6QoEzc
	 ghCiAtzApG6vuBYupR2i9wcvTMW5iUwYzyk3tI+gYTYn0SemB7cIdk2c8cHBjb8dNt
	 7nMR7tCIMuLE4Ux7yb3UrMdwcHbbQdUn4gSsqG9Iiu8H9BG1nHpgv1QE+/IYB5pRmh
	 L8dX9tT7wzPjTeKDrDmKJ1n0/r4wm6Ts1t58/wGjyXF+cW3dPIbEOjv/TaPKOtiCMx
	 qxlPbwNAmwy7D6vG+MX62NDA5gO5T0X6sjSv8g7IyMFcSwfJAI6/S2lGg6onbNxISC
	 kD5SxFB1O9U1w==
Message-ID: <54cbc6d5-1102-45f4-8b71-97bccd717416@kernel.org>
Date: Mon, 5 May 2025 09:58:03 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: Enable CONFIG_ACPI_DEBUG by default
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org
References: <20250415212740.2371758-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250415212740.2371758-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/2025 4:27 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> CONFIG_ACPI_DEBUG can be helpful for getting debug messages on OEM
> systems to identify a BIOS bug.  It's a relatively small size increase
> to turn it on by default (50kb) and that saves asking people to enable
> it when an issue comes up because it wasn't in defconfig.
> 
> Enable it by default.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Rafael,

Any thoughts on this?  Especially in seeing Ingo trying to modernize 
more of the defconfig [1]?

[1] 
https://lore.kernel.org/lkml/20250505110946.1095363-1-mingo@kernel.org/#t

> ---
>   drivers/acpi/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7f10aa38269d2..cb190686499b9 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -394,6 +394,7 @@ config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
>   
>   config ACPI_DEBUG
>   	bool "Debug Statements"
> +	default y
>   	help
>   	  The ACPI subsystem can produce debug output.  Saying Y enables this
>   	  output and increases the kernel size by around 50K.


