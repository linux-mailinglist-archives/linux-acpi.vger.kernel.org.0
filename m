Return-Path: <linux-acpi+bounces-13456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A175AA9792
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A683A5E2F
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B964425C803;
	Mon,  5 May 2025 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/rxTGaR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E08494
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459177; cv=none; b=lzUiFd/Em3A6zVGe7uaVW+JosYAi07IDqijP+GTbvH4SLwK99LvaBWlGWilEJHDVYExYyku7PsNsduOzQrrrgbHCcrq5R1iQO8QV+MeK6xeuX23bsZpV7Ze7K3adbMy/Mi4ELbZ+4lGSN0CWquYywEYtJIJil0kz/OawgeG1Wks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459177; c=relaxed/simple;
	bh=qv0TIc1m7Y8fumSvgmYGDDgHJg0AfupoSGw3uABbt8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xcqt/3ylXvHvQoDYSJeE7P5G28HsylMHqWGBGceoIs9qnkgyovL46ENvVnDymG8RXPUhBmtGURipSEbwRbi4rk6ZrAW2hiDZlYPXO8wLkSJx1nsU2LqwL5CwH7TaUZ9wwziDoEQM3W4B7Mcp71zOXZ0ktwOwGRutjS8gu1eTElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/rxTGaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBC6C4CEE4;
	Mon,  5 May 2025 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746459176;
	bh=qv0TIc1m7Y8fumSvgmYGDDgHJg0AfupoSGw3uABbt8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c/rxTGaRlX14yYNwyMTg7mY2wkW2++me2CjrcAn1jPU74VCHI66Ew6cIo1ODCes+K
	 F4hb4BTjsSKVqc9TzePJ7o/x/FfiHSsYIZPoikxP8Zr+hxdx0mfllR+hylmoz71DFe
	 dBgM8R/o8CMQyOTwQNzJZhC+3J0cNRkeIZri2/Tx202KGIhR3kj8/sM27h4it/R4f1
	 VFtWmgbrB/49z0xpiDJm+7Zf+qpP9WD9kJnb8sgI+F2J8SDrdhfcL9vIwt0iiFKM+d
	 DZF6ROY1T7STyK4JytbiHbhxMuPDftVzsvKYY0V8dqKuNqy4/yz4ZgljWC3uCIWA+l
	 kPqZ+OSnQTb3g==
Message-ID: <d93c8d7a-5f79-4dca-b14b-cf637b3b0779@kernel.org>
Date: Mon, 5 May 2025 10:32:54 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: Enable CONFIG_ACPI_DEBUG by default
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-acpi@vger.kernel.org
References: <20250415212740.2371758-1-superm1@kernel.org>
 <54cbc6d5-1102-45f4-8b71-97bccd717416@kernel.org>
 <CAJZ5v0jdR1agmiFaPyGjrSoozCBot4tW8MV_diPDfXrOURvPww@mail.gmail.com>
 <db06f729-50dc-48b3-a001-70f4a2b54963@kernel.org>
 <CAJZ5v0iK8Q=Qak-RU3n3RCOWC-=2jiZXh_-EkMH1PdEQ_E+2iA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0iK8Q=Qak-RU3n3RCOWC-=2jiZXh_-EkMH1PdEQ_E+2iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/2025 10:27 AM, Rafael J. Wysocki wrote:
> On Mon, May 5, 2025 at 5:15 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 5/5/2025 10:03 AM, Rafael J. Wysocki wrote:
>>> On Mon, May 5, 2025 at 4:58 PM Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> On 4/15/2025 4:27 PM, Mario Limonciello wrote:
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> CONFIG_ACPI_DEBUG can be helpful for getting debug messages on OEM
>>>>> systems to identify a BIOS bug.  It's a relatively small size increase
>>>>> to turn it on by default (50kb) and that saves asking people to enable
>>>>> it when an issue comes up because it wasn't in defconfig.
>>>>>
>>>>> Enable it by default.
>>>>>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Rafael,
>>>>
>>>> Any thoughts on this?  Especially in seeing Ingo trying to modernize
>>>> more of the defconfig [1]?
>>>>
>>>> [1]
>>>> https://lore.kernel.org/lkml/20250505110946.1095363-1-mingo@kernel.org/#t
>>>
>>> I'm not sure if this is a good idea TBH.
>>>
>>> The risk is that people will start reporting issues that have been
>>> there already, but now they become visible due to enabling ACPI_DEBUG
>>> by default.
>>
>> As several distros already enable it by default I would have expected
>> some "noise" like this to have settled down.
>>
>> Do you have specific messages in mind you think could be turning noisy
>> from the extra debug statements?
> 
> Nothing in particular, mostly messages coming from ACPICA, like the
> ones complaining about missing objects that have always been missing
> and the firmware is now too old for anyone to really care.
> 
> Those messages are only really useful when there is someone willing to
> fix the issues that trigger them.  Otherwise, they are just noise.

Ah I see.  I suppose we could always have this on by default and if it 
becomes untenable from reports flip it back to off.

> 
> Though if it is enabled by default by distros used by the vast
> majority of people, it could be enabled by default in the mainline
> too.
> 
> Do you know which distros enable it by default?

I know Ubuntu and CachyOS both do today.  Fedora did it in some of their 
kernels and they're pushing a change to enable it in more of them right now.

