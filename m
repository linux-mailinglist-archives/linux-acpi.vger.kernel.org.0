Return-Path: <linux-acpi+bounces-9374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3F9BF82B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 21:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22751C2193E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3665F20C47F;
	Wed,  6 Nov 2024 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqzD8Wxb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DB20C322;
	Wed,  6 Nov 2024 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925881; cv=none; b=UTuJe8opnekSNhAViozhxg9xUlco26PMvm8uDOyc+h+5+8d9Lg77VhNQ8k5rTPCF8h7Hl9qBVjaakUQT6B8r0VNTNLdPHoH2jsP3IsgV4uDYHKSHYu9bvihpNBa+TwiF4VYti7SrQ2tGGfuWPQ5wrJzvNqntQN+1L3tmqPi8UVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925881; c=relaxed/simple;
	bh=q0JRBK+4x8auhFbRmkX2cxNPzWVh2GbjYYLjjrwiuYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7WpdqeiR/hYCW4k8H2mUlZT7TBCaL3P1JjHq8c0hGv4YfN/ohzv5OFyniRDN+NgQyuvw+gMarPo6wleFDpkAmrd9KXP3DideLoB03HhU0As+qxVK7ycy0MIFVfZsFbQuBzqnfQV7aC9Iqtj+khjQv2KYWejgXLABZMKsf+e55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqzD8Wxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAC9C4CEC6;
	Wed,  6 Nov 2024 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730925879;
	bh=q0JRBK+4x8auhFbRmkX2cxNPzWVh2GbjYYLjjrwiuYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qqzD8WxbX8IMLbOkK08c+D9/XWg6d87iApQrm0rPAV9e6VbZNDFO+DlwsgJtn9I+p
	 fUlZNE+JAhVVLf6AQTVJe1y0TXeOKGYPEHBrTlYa+rA7XJ02yhKvqUv5apP7ESaknd
	 hRL4Bt8ywgPOcoZD+0cKd8aRaBSqdNouAc4vCqFBhqV8vq5rx1OmK0/t36IzGwqgNS
	 VqbWokLa0THMx2df8W1hXutrflpWTDS8r7DxLpxLyrO60W9oAWLMG9opZzob0KaWr9
	 GXBxw+U/CY80yO8y6sel7vRivZzxxZCzaTuLcmAB52l7dHf4rBPdaBjuUmzx3kMWDs
	 W8oiqTXCMG1Ag==
Message-ID: <4b2d9200-cee9-484c-87c1-39542ccce8a5@kernel.org>
Date: Wed, 6 Nov 2024 14:44:36 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ACPI: processor: Move arch_init_invariance_cppc() call
 later
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, Ivan Shapovalov <intelfx@intelfx.name>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20241104222855.3959267-1-superm1@kernel.org>
 <CAJZ5v0iVfdfetFBrq93hcaTgVTN-=WoWYnK5G65q+kRA-qNtwQ@mail.gmail.com>
 <CAJZ5v0jLez+WcqMs4hWeTKdeSbBbAShWvbvGHVj--foZLQ_u6w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jLez+WcqMs4hWeTKdeSbBbAShWvbvGHVj--foZLQ_u6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/2024 14:33, Rafael J. Wysocki wrote:
> On Tue, Nov 5, 2024 at 9:17 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Nov 4, 2024 at 11:29 PM Mario Limonciello <superm1@kernel.org> wrote:
>>>
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> arch_init_invariance_cppc() is called at the end of
>>> acpi_cppc_processor_probe() in order to configure frequency invariance
>>> based upon the values from _CPC.
>>>
>>> This however doesn't work on AMD CPPC shared memory designs that have
>>> AMD preferred cores enabled because _CPC needs to be analyzed from all
>>> cores to judge if preferred cores are enabled.
>>>
>>> This issue manifests to users as a warning since commit 21fb59ab4b97
>>> ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"):
>>> ```
>>> Could not retrieve highest performance (-19)
>>> ```
>>>
>>> However the warning isn't the cause of this, it was actually
>>> commit 279f838a61f9 ("x86/amd: Detect preferred cores in
>>> amd_get_boost_ratio_numerator()") which exposed the issue.
>>>
>>> To fix this problem, change arch_init_invariance_cppc() into a new weak
>>> symbol that is called at the end of acpi_processor_driver_init().
>>> Each architecture that supports it can declare the symbol to override
>>> the weak one.
>>
>> "Define it for x86, in arch/x86/kernel/acpi/cppc.c, and for all of the
>> architectures using the generic arch_topology.c code."
> 
> I've added this to the patch changelog and queued it up as a 6.12 fix.
> 
> Thanks!

Thanks!

