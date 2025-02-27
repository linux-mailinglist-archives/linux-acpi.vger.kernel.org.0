Return-Path: <linux-acpi+bounces-11580-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFBA489F5
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 21:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24813B2890
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE07922759D;
	Thu, 27 Feb 2025 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBDDvKdz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852BE19DF52;
	Thu, 27 Feb 2025 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688672; cv=none; b=FWExR87f0VPxfpRA7f6IWiI7DzyWr6ZHynMj1FvqB/zRg9CADcJ34rsJP67bIrFveHzOYgoM4D8nHMvvOpHYuK8NPMgzP3wdlMMHJmPOMfBT2TeeM8+QN8hBrq1SblM4iDEPLlX0Yi2AlceE8JMB8QpXlkgUL1XKSX1cuOMd+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688672; c=relaxed/simple;
	bh=wMJGaU3+wrCbxdqg90t2a+vJoNum6pPv/0htQmjA+nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzbfkAkN2XYlgMKteiP0vK2nhpjgN0b7J9ZWbkTmDVlGPNvApr4tbZepY+zBrEdQBezzgIJtDNIXy5fUEk+ndV7XIFbichWlIZTGTT3wB/hfgvlTzrZ20n66J89i+Od8WyPqAX+abV+sxWJ3SK0/Tczvl0tSNVWYoAvTIbJ4FF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBDDvKdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAEBC4CEDD;
	Thu, 27 Feb 2025 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740688672;
	bh=wMJGaU3+wrCbxdqg90t2a+vJoNum6pPv/0htQmjA+nI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mBDDvKdz3aEh4vQEbHqvRgGcegsoxGlOuP6hA1wVNCQy1A5XMMJYNirZ9Ogrn43oj
	 de5jkEu5QL9GhzIf36qLzvC5mN8ErQNQ78jn90u9He9iJdIxLcoCqu5o8c78vjBVu6
	 bLWsCuCDSrWEyYfh/JHsGq6Wj+FPeoGpiKOyqPW+XIUR0rGGCRf8fJUAM4KjCtZFEe
	 iYj8Pq+D6pKK74lcshzuG9boadJCiG3lyxzATwEaHRtH+uE6XBBlhW5amlvkoPZfMX
	 +G75XOt7XZTZk/3HQfw994Y/D9yA4t9UrHbLyiUk0CfeNxHVz1Xet1PnMQl2OlWYge
	 A3kP0JYn8EXHg==
Message-ID: <ef7c9b7a-de50-4b84-ab16-4af567758550@kernel.org>
Date: Thu, 27 Feb 2025 14:37:50 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pinctrl: amd: Add an LPS0 check() callback
To: Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: mario.limonciello@amd.com, Basavaraj.Natikar@amd.com,
 Shyam-sundar.S-k@amd.com, linux-gpio@vger.kernel.org
References: <20250219145338.3306745-1-superm1@kernel.org>
 <20250219145338.3306745-3-superm1@kernel.org>
 <CACRpkdaCUx5EW-CzHgNiKgQF6FxKbFP0_pHC3LnfgEKpksTJtw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CACRpkdaCUx5EW-CzHgNiKgQF6FxKbFP0_pHC3LnfgEKpksTJtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/27/2025 14:34, Linus Walleij wrote:
> Hi Mario,
> 
> thanks for your patch!
> 
> On Wed, Feb 19, 2025 at 3:54 PM Mario Limonciello <superm1@kernel.org> wrote:
> 
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> During suspend the pinctrl_amd driver disables the interrupts for
>> any GPIOs that are not marked as wake sources.
>>
>> This however does not prevent them from changing the wake status
>> bit during suspend, it just stops the system from waking.
>>
>> If the system wakes from hardware sleep for another reason (such
>> as plugging in the AC adapter) this wake bits might be active.
>>
>> This could potentially cause problems with going back to hardware
>> sleep.  Add an extra debugging message when PM debugging is enabled
>> to help identify if this is happening.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> I don't understand the ACPI part of this patch, and I think I was
> not even CC:ed on 1/2 so I haven't seen it.
> 
> Anyway:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> if you want to apply it in the ACPI tree.
> 
> Yours,
> Linus Walleij

Thanks, there was a problem reported by LKP robot on v2 for the ACPI patch.

I have a v3 but was waiting for feedback on this one.
Will add your tag and send v3, thanks!

