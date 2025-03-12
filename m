Return-Path: <linux-acpi+bounces-12144-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4EEA5E699
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7139C1887215
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 21:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C591EF096;
	Wed, 12 Mar 2025 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRSLU4Y7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CB15CD74;
	Wed, 12 Mar 2025 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814879; cv=none; b=GiwSmOVN/S0pYYANOk0M7ujxLiTUvCoBOarnpsKEwE57EVxxYxjRsUd4rqou+fcqKL+zBFMGMt1D2KHZ3nIsEUlY0JYfUXKo45xRvRkrDnwsfm8ljtmcInbav7RHFWUccP2VYMb2Eg9IEYxkaf55kqHPITkXYTWBU1If7djAwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814879; c=relaxed/simple;
	bh=U/K4ghgdDMZqhVdOkbTux0NzP/wpTcuqS0NSyHrGk7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gl91geekA2PARZ6uvR1/5GOUh+hi11L/xdV91p2NX+/triRjLWk/qh3mDUpYAvgetBGQkOpvsHptWEekIGY8nJfuC4KQoggCBCO4EpDX7syoxx+La3eqeabp3KfYdPzcsTIasoiqUvchRQzb2RaTrZ1EtHqYEGYSFR9sAqbppGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRSLU4Y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51188C4CEDD;
	Wed, 12 Mar 2025 21:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741814878;
	bh=U/K4ghgdDMZqhVdOkbTux0NzP/wpTcuqS0NSyHrGk7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HRSLU4Y75hRJh2aS8mvRR+HgOCr2dG6Xk8lx9yk4MBe2M6zUS+AmWyM8KtvNcTVHF
	 TWk8lsTNiMNgj3meQQgVJzRa9+NL65oRaSGyqfDFvOJPnoDAX2xQhTr1ujCTjQbQJM
	 IuuIhwqVFTVHYkU6PcZWG2SaRLkWrHfyJBZ0yboZtJpWIG+kzystb27WJJEAv1JLr4
	 cEOlKp+HW6MpgFVKc22W+wj26V35mAIGA/vRU/+/q4a2kLh0A9HnT/d1cw6BDJYjqJ
	 JPooKkrriQKQXCeORKoUjNDYvOvD2DrSg/3U4F+OjzCQCLySqI7t5baev9hoV5nuGp
	 scMopgxog4ixA==
Message-ID: <88e95b2f-3ffa-4876-a83b-38d25ac9cbc2@kernel.org>
Date: Wed, 12 Mar 2025 16:27:48 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd: pmf: Fix missing hidden options for
 Smart PC
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, "Luke D . Jones" <luke@ljones.dev>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Yijun Shen <Yijun.Shen@dell.com>
References: <20250306034402.50478-1-superm1@kernel.org>
 <50adcc9d-241d-19b6-7b03-2e91ef7d017b@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <50adcc9d-241d-19b6-7b03-2e91ef7d017b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/10/25 12:19, Ilpo Järvinen wrote:
> On Wed, 5 Mar 2025, Mario Limonciello wrote:
> 
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> amd_pmf_get_slider_info() checks the current profile to report correct
>> value to the TA inputs.  If hidden options are in use then the wrong
>> values will be reported to TA.
>>
>> Add the two compat options PLATFORM_PROFILE_BALANCED_PERFORMANCE and
>> PLATFORM_PROFILE_QUIET for this use.
>>
>> Reported-by: Yijun Shen <Yijun.Shen@dell.com>
>> Fixes: 9a43102daf64d ("platform/x86/amd: pmf: Add balanced-performance to hidden choices")
>> Fixes: 44e94fece5170 ("platform/x86/amd: pmf: Add 'quiet' to hidden choices")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/platform/x86/amd/pmf/spc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
>> index f34f3130c3307..1d90f9382024b 100644
>> --- a/drivers/platform/x86/amd/pmf/spc.c
>> +++ b/drivers/platform/x86/amd/pmf/spc.c
>> @@ -219,12 +219,14 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>>   
>>   	switch (dev->current_profile) {
>>   	case PLATFORM_PROFILE_PERFORMANCE:
>> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>   		val = TA_BEST_PERFORMANCE;
>>   		break;
>>   	case PLATFORM_PROFILE_BALANCED:
>>   		val = TA_BETTER_PERFORMANCE;
>>   		break;
>>   	case PLATFORM_PROFILE_LOW_POWER:
>> +	case PLATFORM_PROFILE_QUIET:
>>   		val = TA_BEST_BATTERY;
>>   		break;
>>   	default:
> 
> Hi Mario,
> 
> Just for me to be sure what I'm supposed to do with all these patches
> related to this platform profile legacy handling... :-)
> 
> So this fix is necessary in addition to the 3 patches that got already
> merged through Rafaels tree?
> 
> What about this patch from Luke:
> 
> https://patchwork.kernel.org/project/platform-driver-x86/patch/20250224223551.16918-1-luke@ljones.dev/
> 
> Is that also needed?
> 
> Thanks in advance.
> 

Yes; this was another finding that Yijun discovered missing as part of 
testing Rafael's tree.  It can go through your tree or Rafael's.  It 
doesn't really matter.

Luke's patch isn't needed anymore.

