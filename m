Return-Path: <linux-acpi+bounces-13454-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD967AA9718
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213453A742F
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71025C713;
	Mon,  5 May 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by/D59uD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA118132A
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458111; cv=none; b=C9kHP73Wbn5RmF3aX8UDO+7L3zSW71xTkeHQixFIy5Yvf2gO2GWX6yewrzvlnamkJUZuGAmNquEQOA24mZ4ZEg92ClvQBLn5APMC+TJ/jN6oLFMi2I7Xeq0ydOp2eSxbaB8Et7g/89q5wFffkVjE34k7OnrOxMs9cpQLpkw1BvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458111; c=relaxed/simple;
	bh=rObpqv471NRZVsg3D3Mot87cIeCoz0lsmIw1H/n64ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPHHWE4DaKCgdAcl1L/NG2m56PDMZbX0ZSqDc2Wzz8sOqn44Tg5lVk1UOTNUocE0ch8b/cy5FkLLHXheJZ7DOUPU9xMT9D5XCwXCOOEyqfh8uW99bX8FqBbFzZUXPalcrLO8DoZ390MSQC2F5yIn87fBP8tp8ZQH69//cxCAUJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by/D59uD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DB6C4CEE4;
	Mon,  5 May 2025 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458109;
	bh=rObpqv471NRZVsg3D3Mot87cIeCoz0lsmIw1H/n64ZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=by/D59uDxxFP8PIEOSIleuTleu3CczTGcyOX5DWNARLQmQ18UczTM27nSz7BThp7N
	 FpCccEVGlnPL78qr/MjGk7qYq0mMeZRrbR1BfOA8trB0xhFm99uIyBXZ0f6tNoUynm
	 LGyzlGjrdt6hUv5ncaIypXxZPORCtKPINb8M0Dl69Vi7Jetkn2ez9swdidhAwm5Jg3
	 Cbnjy/MOzlY5+3BsUVsdg476gh7L87xG6OM6Z5jCGCI1exTlVHZwUD9T0xUIrnovug
	 46FfkxAS7EC/8fTCWG0rB9fuQMHBwoZy0Do+bt90VHwb8OArt3M0Yqu+RgsvAIXRyP
	 beirtA/ot8Zng==
Message-ID: <db06f729-50dc-48b3-a001-70f4a2b54963@kernel.org>
Date: Mon, 5 May 2025 10:15:08 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: Enable CONFIG_ACPI_DEBUG by default
To: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-acpi@vger.kernel.org
References: <20250415212740.2371758-1-superm1@kernel.org>
 <54cbc6d5-1102-45f4-8b71-97bccd717416@kernel.org>
 <CAJZ5v0jdR1agmiFaPyGjrSoozCBot4tW8MV_diPDfXrOURvPww@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jdR1agmiFaPyGjrSoozCBot4tW8MV_diPDfXrOURvPww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/2025 10:03 AM, Rafael J. Wysocki wrote:
> On Mon, May 5, 2025 at 4:58 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 4/15/2025 4:27 PM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> CONFIG_ACPI_DEBUG can be helpful for getting debug messages on OEM
>>> systems to identify a BIOS bug.  It's a relatively small size increase
>>> to turn it on by default (50kb) and that saves asking people to enable
>>> it when an issue comes up because it wasn't in defconfig.
>>>
>>> Enable it by default.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Rafael,
>>
>> Any thoughts on this?  Especially in seeing Ingo trying to modernize
>> more of the defconfig [1]?
>>
>> [1]
>> https://lore.kernel.org/lkml/20250505110946.1095363-1-mingo@kernel.org/#t
> 
> I'm not sure if this is a good idea TBH.
> 
> The risk is that people will start reporting issues that have been
> there already, but now they become visible due to enabling ACPI_DEBUG
> by default.

As several distros already enable it by default I would have expected 
some "noise" like this to have settled down.

Do you have specific messages in mind you think could be turning noisy 
from the extra debug statements?

> 
>>> ---
>>>    drivers/acpi/Kconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index 7f10aa38269d2..cb190686499b9 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -394,6 +394,7 @@ config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
>>>
>>>    config ACPI_DEBUG
>>>        bool "Debug Statements"
>>> +     default y
>>>        help
>>>          The ACPI subsystem can produce debug output.  Saying Y enables this
>>>          output and increases the kernel size by around 50K.
>>


