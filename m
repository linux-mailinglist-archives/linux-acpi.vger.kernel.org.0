Return-Path: <linux-acpi+bounces-19851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA8CDE179
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 21:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63DD0300940A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E426A088;
	Thu, 25 Dec 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="loml9M9S";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="qNVIhLNp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076FD2FB;
	Thu, 25 Dec 2025 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766695656; cv=none; b=nSFidFDsq0+G4LiblnYECQ8Lz2vF6awVYZ07n8A45GrRPavVQxAl05qw0/wQ7z603zM02A5b39XY8odzSrbC98AhEvFcCE9zlMDRDp1eFzwNzZQTlBLY7xTpS5c/nDJ7BG6y6aDNpl0AI0nBPhO0WM/PQf0GAG0HszXSKrdUQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766695656; c=relaxed/simple;
	bh=+VUsxms6XuIEXf0ITgVRPLsTPVCQ3XG+Rw0UrT4U5k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YC79no/uz57flCLMKUNbhLcMGutTr47Qav9l3Fs1ZoxFc3Pamlq3Ydm3b4ssAy14gO5K4s/edXe/WTGkEMIUP77a+ChMwygL/vTWcUzuwyhiIblkh5Bj+Ugk48bS7gCu6GaJEWpcla/Tr76C7csKZILAUS+pXmSF7kvC0b7YPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=loml9M9S; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=qNVIhLNp; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766695027; bh=ofefcj3scn+cCnfJfKQX4fW
	+uQ/wEt+D6ZHrKNrdewA=; b=loml9M9SO5QRx7P20UNFxBu3arOTxwdFfgSs+ZczhBBc3sfDIT
	EZLk0YUU8+qryOCPLRs5kIj9g9f8YDEJXTkxVcnyvjr8iQYp5sevD3l8Pk3jkyaELiiV0oRwnc8
	PrPKfYmhvcie/XOpAXskwGlfmixLdcmKyqJcjFiu5YyD5I9mVjJc8g+Vs2qn6GQfzeJLMH8uGNP
	JAqV0G9bH3YpVV1Yd2HiRGuM15zHmF7hgFK4VbAc064l1frvF0bByPrdfyfRAuPVs5bK05acYhi
	AKTXnK9Evd+9bnx+tfnEsA3LdjE0dHEVEjFQ3fi4/Ne1ejbVOW20Em4QO9MDZhkOQKg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766695027; bh=ofefcj3scn+cCnfJfKQX4fW
	+uQ/wEt+D6ZHrKNrdewA=; b=qNVIhLNpO62FvC+Z5dVYUBlmuDiGdt2UYcTjeh+2REST+Z5O5J
	ut5GPLyhihE34sUcnPB8ej5/eRG+n7jL/bBg==;
Message-ID: <d8033c40-9cac-4827-9d8a-5cb3d727ec5b@foxido.dev>
Date: Thu, 25 Dec 2025 23:37:05 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] rust: introduce WMI abstractions
To: Armin Wolf <W_Armin@gmx.de>
Cc: Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1766331321.git.foxido@foxido.dev>
 <cc4a2e7e9fd5f07f8a0831ca085e489f0ae87d1f.1766331321.git.foxido@foxido.dev>
 <854b4448-3ff1-4fb4-b58f-21136f5ec3e4@gmx.de>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <854b4448-3ff1-4fb4-b58f-21136f5ec3e4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/25/25 21:06, Armin Wolf wrote:
>> +// SAFETY: A call to `unregister` for a given instance of `RegType` 
>> is guaranteed to be valid if
>> +// a preceding call to `register` has been successful.
>> +unsafe impl<T: Driver + 'static> driver::RegistrationOps for 
>> Adapter<T> {
>> +    type RegType = bindings::wmi_driver;
>> +
>> +    unsafe fn register(
>> +        wdrv: &Opaque<Self::RegType>,
>> +        name: &'static CStr,
>> +        module: &'static ThisModule,
>> +    ) -> Result {
>> +        macro_rules! map_callback {
>> +            ($flag:ident -> $callback:ident) => {
>> +                if T::$flag {
>> +                    Some(Self::$callback)
>> +                } else {
>> +                    None
>> +                }
>> +            };
>> +        }
>> +
>> +        // SAFETY: It's safe to set the fields of `struct wmi_driver` 
>> on initialization.
>> +        unsafe {
>> +            (*wdrv.get()).driver.name = name.as_char_ptr();
>> +            (*wdrv.get()).driver.probe_type = 
>> bindings::probe_type_PROBE_PREFER_ASYNCHRONOUS;
>> +            (*wdrv.get()).id_table = T::TABLE.as_ptr();
>> +            (*wdrv.get()).probe = map_callback!(HAS_PROBE -> 
>> probe_callback);
>> +            (*wdrv.get()).notify = map_callback!(HAS_NOTIFY -> 
>> notify_callback);
> 
> I think it should be possible to handle WMI drivers 
> requiring .no_notify_data to be set. Is there
> a way to declare the WMI event data passed to the notify() callback as 
> optional? If yes, then i suggest
> that we always set .no_notify_data and simply require the WMI drivers 
> themselves to verify that a given
> WMI event does contain additional event data.

Yes, I can change the notify API to receive Optional<&AcpiBuffer> 
instead of &AcpiBuffer, so every driver will be forced to verify payload 
existence by Rust's type system.

IIRC, casting raw (C) pointer to Optional<&T> is actually a no-op in 
Rust, since NULL is automatically mapped to None (empty Optional), so it 
will be a zero-cost typesystem win :)

