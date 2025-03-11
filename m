Return-Path: <linux-acpi+bounces-12103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E5A5CDD8
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 19:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B175916B5F1
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC682627E1;
	Tue, 11 Mar 2025 18:25:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6341C72;
	Tue, 11 Mar 2025 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717555; cv=none; b=S2KvJZEhZSQoxXPauY0ovDWBufeY6p3Q/0l9X+iXpcggBoxScdaO6Tta64XsFxKgxcG3EPaj+v8a0bQSISQpAOaKhPI8Xp29S9LqyqwaTQo0f/6UYCLbBoLcyu1Bfu2ACbLllDGBM7JI7Pd9zZgi19jY9ImUyqIKyT01p6+1weU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717555; c=relaxed/simple;
	bh=wqRGd9aY+2+mbyav8XTN1xcMeuNHpDV+Zkes4FCyOtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6BktLRazALInMQEqiJZIlJf2g+97IaG2BMNtBJf5f7mlh4K/6n23wHXlc4RxjR9V3HE+jvBltpZ28ed8H1f5moaAkJIb6VaKVY8NF/LuUoP4pV6x44srjMdaYRC5YX+YMNIv+EJtDVouFcB1cdmWvOmAsQ/YPq1CsNWFNQ5Lks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57EF1424;
	Tue, 11 Mar 2025 11:26:02 -0700 (PDT)
Received: from [10.118.109.66] (G9L3377F54.austin.arm.com [10.118.109.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 482773F694;
	Tue, 11 Mar 2025 11:25:51 -0700 (PDT)
Message-ID: <23c77291-7c6e-45ea-b1ad-952c01882579@arm.com>
Date: Tue, 11 Mar 2025 13:25:50 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build error on -next due to tpm_crb.c changes?
To: Thorsten Leemhuis <linux@leemhuis.info>, jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 lenb@kernel.org, rafael@kernel.org, jgg@ziepe.ca, peterhuewe@gmx.de,
 sudeep.holla@arm.com, linux-integrity@vger.kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
 <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>
 <92bc0a65-608f-4307-bb1c-16d8836d42e5@arm.com>
 <77fb9077-f598-4308-8862-6d09b23688bb@leemhuis.info>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <77fb9077-f598-4308-8862-6d09b23688bb@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/25 11:51 AM, Thorsten Leemhuis wrote:
> On 11.03.25 16:53, Stuart Yoder wrote:
>> On 3/11/25 10:21 AM, Thorsten Leemhuis wrote:
>>> On 05.03.25 18:36, Stuart Yoder wrote:
>> [...]
>> So, it should not be possible on one had have
>> CONFIG_TCG_ARM_CRB_FFA being true when building tpm_crb.c
>> and false resulting in the tpm_crb_ffa.o not being
>> picked up in the build.
> 
> Many thx for the answer. Maybe Fedora's way to prepare the .config files
> (which my package builds use to be close to Fedora's official packages)
> is doing something odd/wrong. Will take a closer look and report back.

I've been experimenting with some different build config combinations
and have reproduced what must be the issue.

This works fine:
<*>   TPM 2.0 CRB Interface 
                                         < >   TPM CRB over Arm FF-A 
Transport

This works fine:
< >   TPM 2.0 CRB Interface 
                                         <*>   TPM CRB over Arm FF-A 
Transport

This works fine:
<*>   TPM 2.0 CRB Interface 
                                         <*>   TPM CRB over Arm FF-A 
Transport

This works fine:
<M>   TPM 2.0 CRB Interface 
                                         <M>   TPM CRB over Arm FF-A 
Transport

This fails:
<*>   TPM 2.0 CRB Interface 
                                         <M>   TPM CRB over Arm FF-A 
Transport

The 2 drivers are coupled, so we can't have one built as a module
and the other built-in.

I'm not a Kconfig expert, and need to do some fiddling to see
if I can find a Kconfig syntax that prevents that failure scenario.

Thanks,
Stuart



