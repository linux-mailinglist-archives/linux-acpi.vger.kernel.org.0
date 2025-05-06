Return-Path: <linux-acpi+bounces-13507-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF62AACEAE
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 22:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C93C7A66CE
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 20:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1891946DF;
	Tue,  6 May 2025 20:11:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9784B1E58;
	Tue,  6 May 2025 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746562284; cv=none; b=VvPHkR6fhZMDNYxfaJ4QCHPb0dSvxUXRu4hkZy/s6QlcLZCZs4ttGk/wBob0E1QZF8YSZWOrHsgQC+qwf9dNE4LNWguWW83LKe+kuS5P59lFC7i0Ksad4ttZ78zZAH48OGYZr5Qq3vYD7BhgkFwoAzlkOyEhXSTiU6f/tYON0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746562284; c=relaxed/simple;
	bh=OkWPbya/hM7MMHxCUYNACsb0CJBvtrYiw/Bjr2XFv2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8Iuhcw/61jSD9iYBXvSr2TtkR+T5oz/E4b4ZNrjZTF85H+MjoTrlktRXeg3qsCiUdqhdznUWx9Qqs4aI0Z+A7ktDnWv2VIgPnDhCALsPY/nhYTEldBDpTwJidXC8GAv+qkl8RHG4D++cLuCiA913SXuOU7xJJKKFCCq9WLc5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B6A02F;
	Tue,  6 May 2025 13:11:11 -0700 (PDT)
Received: from [172.27.42.98] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFD4B3F5A1;
	Tue,  6 May 2025 13:11:20 -0700 (PDT)
Message-ID: <35895e57-bbe2-4ff9-b1d4-4b70e28ed8a1@arm.com>
Date: Tue, 6 May 2025 15:11:20 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI/PPTT: fix off-by-one error
To: Sudeep Holla <sudeep.holla@arm.com>, "Heyne, Maximilian"
 <mheyne@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250506-draco-taped-15f475cd@mheyne-amazon>
 <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250506-shapeless-merciful-inchworm-7bfdb4@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/6/25 8:43 AM, Sudeep Holla wrote:
> On Tue, May 06, 2025 at 01:13:02PM +0000, Heyne, Maximilian wrote:
>> Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
>> sizeof() calls") corrects the processer entry size but unmasked a longer
>> standing bug where the last entry in the structure can get skipped due
>> to an off-by-one mistake if the last entry ends exactly at the end of
>> the ACPI subtable.
>>
> 
> Unless the firmware has populated an incorrect value for the header length, I
> don't see how this is possible. The table_end should point to the address
> immediately following the last byte of the table. None of the headers are only
> one byte long, so what am I missing that could explain this apparent
> off-by-one issue?.

More likely its because the sizeof() fix was merged without proper 
review and is wrong because the type isn't actually known on the object 
until the header is checked.





