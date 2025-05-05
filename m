Return-Path: <linux-acpi+bounces-13458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD1AA9828
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 18:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA363167F3B
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B51266EF0;
	Mon,  5 May 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CggIkxAy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253F266594
	for <linux-acpi@vger.kernel.org>; Mon,  5 May 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460776; cv=none; b=BZ9SeDP8Zsu2GGELy/n9Qj+B8civhYYXoEY2xITzcjnOvPLRTS2gNsgZ0Y45216CJgnfSNBLnwNixWZWghNVKVNSA/S32EbxKL7cakFGAM3w8FVQclabVBNEZ2obdeWpwzE51n7ia4OR/t0xbAolEJy3TgjQLzIyquIkRlxPEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460776; c=relaxed/simple;
	bh=D+SEWPPKnbfXnYnSrStrOJ3HaN5rsdTg7mS/BE3YNCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwqWDDvlJh08ELPsYTsaffiBoW2drKARK6m8hWDjg6cTdC1gd2GnZO9kI3QMvfd8i3in1xpgAmMzmtuqPnd9vlB95TnOpmihAgvXh7rQlRGJfvK12yhr1QBjazUK8UHVavf/YJJKGDshXyVYECGTGb2JoC9JukFpjsWb9cXQikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CggIkxAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE18C4CEEE;
	Mon,  5 May 2025 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746460776;
	bh=D+SEWPPKnbfXnYnSrStrOJ3HaN5rsdTg7mS/BE3YNCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CggIkxAyVgyGn1YLRND+EZ/n5z9aC6SkrKNLQ7rSkts9cRnRlQcOelyfQ6PCf9ya8
	 Ugep8H/8DZkQMQ8Dulj8uojDI2sNebascG81YTJxsSUqdE7Q5s2MT8gOenUpgKmR8J
	 GBGjWTBxIZQsaCxMNpEHVdXF6DHaurysqXU7VX+EqbcujqQAl2os9pFUp67QaUnCVm
	 x06xlyt5DqONUGYqoYphs81v9gZutZf8bM3mD+olrGTM/O/fa/tFXFObpR3dfuUP1c
	 Eq88nM4xPvDYY8Mq/ELYCYtKNlAmSj7DSxJ/yJbBRFrlcXr5pdQR+F+Tnw8BFTbS7R
	 ORsLsi9MnaQ1Q==
Message-ID: <ee7b40ab-3949-426a-bbcf-e6038208e1ff@kernel.org>
Date: Mon, 5 May 2025 10:59:34 -0500
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
 <d93c8d7a-5f79-4dca-b14b-cf637b3b0779@kernel.org>
 <CAJZ5v0iXK+Tqu0wyRU5fkHe5JpAqM5L30dDyr+J6d348tPo1Mw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0iXK+Tqu0wyRU5fkHe5JpAqM5L30dDyr+J6d348tPo1Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/2025 10:55 AM, Rafael J. Wysocki wrote:
> On Mon, May 5, 2025 at 5:32 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 5/5/2025 10:27 AM, Rafael J. Wysocki wrote:
>>> On Mon, May 5, 2025 at 5:15 PM Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> On 5/5/2025 10:03 AM, Rafael J. Wysocki wrote:
>>>>> On Mon, May 5, 2025 at 4:58 PM Mario Limonciello <superm1@kernel.org> wrote:
>>>>>>
>>>>>> On 4/15/2025 4:27 PM, Mario Limonciello wrote:
>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>
>>>>>>> CONFIG_ACPI_DEBUG can be helpful for getting debug messages on OEM
>>>>>>> systems to identify a BIOS bug.  It's a relatively small size increase
>>>>>>> to turn it on by default (50kb) and that saves asking people to enable
>>>>>>> it when an issue comes up because it wasn't in defconfig.
>>>>>>>
>>>>>>> Enable it by default.
>>>>>>>
>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>
>>>>>> Rafael,
>>>>>>
>>>>>> Any thoughts on this?  Especially in seeing Ingo trying to modernize
>>>>>> more of the defconfig [1]?
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/lkml/20250505110946.1095363-1-mingo@kernel.org/#t
>>>>>
>>>>> I'm not sure if this is a good idea TBH.
>>>>>
>>>>> The risk is that people will start reporting issues that have been
>>>>> there already, but now they become visible due to enabling ACPI_DEBUG
>>>>> by default.
>>>>
>>>> As several distros already enable it by default I would have expected
>>>> some "noise" like this to have settled down.
>>>>
>>>> Do you have specific messages in mind you think could be turning noisy
>>>> from the extra debug statements?
>>>
>>> Nothing in particular, mostly messages coming from ACPICA, like the
>>> ones complaining about missing objects that have always been missing
>>> and the firmware is now too old for anyone to really care.
>>>
>>> Those messages are only really useful when there is someone willing to
>>> fix the issues that trigger them.  Otherwise, they are just noise.
>>
>> Ah I see.  I suppose we could always have this on by default and if it
>> becomes untenable from reports flip it back to off.
> 
> The problem is that we'd only see the impact after the distros picked
> up the new default config, which would take some time and then it
> might not be practical to disable it again.

Good point.

> 
> I guess enabling it by default could be combined with changing
> ACPI_DEBUG_DEFAULT to ACPI_LV_REPAIR, say, but then you'd probably
> still need to ask people to make it more verbose to see the
> interesting messages.

To me having ACPI_DEBUG enabled and ACPI_DEBUG_DEFAULT turned down is 
totally fine.  I find that the trace_* parameters are totally fine for 
what I've used it for so far.  IE set appropriate trace values, load 
your module and report results.
Or set trace values on the kernel command line and report results for 
boot issues.

> 
>>>
>>> Though if it is enabled by default by distros used by the vast
>>> majority of people, it could be enabled by default in the mainline
>>> too.
>>>
>>> Do you know which distros enable it by default?
>>
>> I know Ubuntu and CachyOS both do today.  Fedora did it in some of their
>> kernels and they're pushing a change to enable it in more of them right now.
> 
> So why don't we let them do it and then decide?

Sure, we can revisit next cycle.

