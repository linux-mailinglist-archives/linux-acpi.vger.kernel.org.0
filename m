Return-Path: <linux-acpi+bounces-7609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6730954232
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 08:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057D11C22B90
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFAB84A3F;
	Fri, 16 Aug 2024 06:59:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01A383A14;
	Fri, 16 Aug 2024 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791578; cv=none; b=eTF81euMjjeLojevYN03b3S8rT+O5evFj6AoKQ51ChRAtI+L+FjWtr8rjNAWZST+wSn+eV7i2d3UG8mZ4cB29FEJp74UTItWN+7JGrinnaFSgkTv2CKA0892ikw43bNRm1Tsr+FQadO7+d0JlnJlJLC1HXE75QNqCMNXkyFChEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791578; c=relaxed/simple;
	bh=oLjXu0BovmzaiWPPZC3G1gHwyZLxFoPoULSAR07tyZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbaG633wEvvv/N7QQoNvRUWs/ohLliw8yIEcixXM4QvqcYdA/3YTYXrEZeRcI2gutD0R2gwSfi5xpU3aYADsYS0MH5V07LvP1hticM5gI55GjjzJtO2JaM8FAuJhQhPzTDnXKpCrog0Qtnw99g3FXa/EtDE6n00XpH2pcjpoq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8C8D143D;
	Fri, 16 Aug 2024 00:00:01 -0700 (PDT)
Received: from [192.168.1.13] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 582E23F58B;
	Thu, 15 Aug 2024 23:59:30 -0700 (PDT)
Message-ID: <1605d622-faf5-4535-bd71-ba514ee102dd@arm.com>
Date: Fri, 16 Aug 2024 08:59:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] rust: cpufreq: Add rust implementation of
 cppc_cpufreq driver
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Robert Moore <robert.moore@intel.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Thomas Bertschinger <tahbertschinger@gmail.com>,
 Danilo Krummrich <dakr@redhat.com>, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
 rust-for-linux@vger.kernel.org, Metin Kaya <metin.kaya@arm.com>
References: <20240815082916.1210110-1-pierre.gondois@arm.com>
 <20240815082916.1210110-7-pierre.gondois@arm.com>
 <CANiq72mjvE7h_aH5tYnuuzdPHAzDUpioMi-h44HNCro8qFfDSw@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CANiq72mjvE7h_aH5tYnuuzdPHAzDUpioMi-h44HNCro8qFfDSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Greg, Miguel,

On 8/15/24 15:04, Miguel Ojeda wrote:
> On Thu, Aug 15, 2024 at 10:31 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> In an effort to add test/support the cpufreq framework in rust,
>> add a rust implementation of the cppc_cpufreq driver named:
>> `rcppc_cpufreq`.
> 
> Similar to what Greg said -- is this intended to be something like a
> "Rust reference driver" [1] for the subsystem?

The initial intent was to review/test Viresh's patchset [1]. I then
thought it would be a good idea to implement another cpufreq driver
to see if the provided interface would work.
As the cpufreq-dt driver is re-implemented in Viresh's patchset,
I thought it was also ok to have this driver.

> 
> [1] https://rust-for-linux.com/rust-reference-drivers
> 
>> +       depends on ACPI_PROCESSOR
>> +       depends on ARM || ARM64 || RISCV
> 

Yes right

> `depends on RUST`?
> 
> Also, I imagine you skipped all safety comments etc. since it is an
> RFC, but I thought I would mention it nevertheless.

Ok, if it is decided not to drop this patchset, I ll add some comments,

> 
> Thanks for experimenting with Rust!
> 
> Cheers,
> Miguel


Regards,
Pierre

