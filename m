Return-Path: <linux-acpi+bounces-20112-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F11D08E8B
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 12:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64151301EF31
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB833590C6;
	Fri,  9 Jan 2026 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="XUbFeytf";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="lHrSMw5R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0C63168E8;
	Fri,  9 Jan 2026 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958304; cv=none; b=pi2vZFGqzVofb0JAXHJCzYAcquRByyj9WrKPCQYAbNFyh6oUoeWbw5f5U6AdFcmrKXxiMkSWdvYgBF+2XVbYEo4K/yK079lQRaxDil+mnBgno8rsTwSe3y7xKr1vzn/hkJ3k5Jbgfym2TE7sjtJDp4HUcmB4kZV05NSZzDo8o3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958304; c=relaxed/simple;
	bh=ugsAOZfphBhKRWRiP1eUSkvkC4NbACU3I+VJnhjNiJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5sKu6p2c3R37PpiPCDoEYjk1ptwqmeKVPJOhrkTOkkqohTNx1t2iXLYvGHaZ10z43XfHvGiekzOeNgOjrOOKi9LnqEejTqAHpxp3KaewEZnykLtGOunvKLR9mRjj4Dse50e8erWmjomZuHQDjh6dfXW1BeKpRyrA6IGlbN94zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=XUbFeytf; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=lHrSMw5R; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767958269; bh=HvhXiix4VgEJzf/Kvw/3TGg
	xljQ9Gg2tlxhZKWzIxUo=; b=XUbFeytfq99EG2/QvULh+zr+sA7bF6zvbv05SJWrefyqd90M63
	aGEpF1ra0HesrK35eFdlCvB5+JyFhFhNWqFYstIqJBhEeBcA1io9JcGEa7hkiv/rAL/sCfsTPHQ
	NlPfEH5vkUnCRmQLcb3f0JC1gfPsUQtqC2eI0lRy/vt6ya8WSGTD6mWJZZDW1AeWVyQMelZ3Vph
	lFvu56T1BZWD6sQ0MzBRZgVwNELxmMxfjJHxPRU5P18CuCiLO2WLUtqwLy3bwklnNaa3ce+sgw7
	k19XqnxmInN8140/Q2+le7Dbrsxet6Nsml7Yo+tFfNuVUloc65bjqyaAX5uDAZU2cbg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767958269; bh=HvhXiix4VgEJzf/Kvw/3TGg
	xljQ9Gg2tlxhZKWzIxUo=; b=lHrSMw5RY0SkOe8dERIUTHyFdBhpxBa8n0rcUogGCsysKZsumG
	SGJomNMzLD3nVzNDyRnlheklRAFFYbXqLxAw==;
Message-ID: <284c09c9-c4ed-4838-a76b-dc90210b0be6@foxido.dev>
Date: Fri, 9 Jan 2026 14:31:08 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust: add WMI abstractions
To: Kari Argillander <kari.argillander@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1767818037.git.foxido@foxido.dev>
 <a119094f2e248587c541daf7c5b65bf4398b281b.1767818037.git.foxido@foxido.dev>
 <CAKBF=psOiiakGigJj0Kee3Z5rym41eksSZTgzsO3H1gzUP6DjA@mail.gmail.com>
 <670cab36-3d32-4769-8a3c-a5d3e1bdd74a@foxido.dev>
 <CAC=eVgRHu9UzPyTMcWZFGAwo0+6wO+v-iuqmoKmznj_kSPVL=Q@mail.gmail.com>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <CAC=eVgRHu9UzPyTMcWZFGAwo0+6wO+v-iuqmoKmznj_kSPVL=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 14:15, Kari Argillander wrote:
> pe 9.1.2026 klo 13.01 Gladyshev Ilya (foxido@foxido.dev) kirjoitti:
>>
>> On 1/8/26 23:48, Kari Argillander wrote:
>>> On Wed, 7 Jan 2026 at 22:56, Gladyshev Ilya <foxido@foxido.dev> wrote:
>>> <snip>
>>>
>>>> +impl DeviceId {
>>>> +    /// Constructs new DeviceId from GUID string.
>>>> +    pub const fn new(guid: &[u8; bindings::UUID_STRING_LEN as usize]) -> Self {
>>>> +        // SAFETY: FFI type is valid to be zero-initialized.
>>>> +        let mut inner: bindings::wmi_device_id = unsafe { MaybeUninit::zeroed().assume_init() };
>>>> +
>>>> +        build_assert!(inner.guid_string.len() == bindings::UUID_STRING_LEN as usize + 1);
>>>> +
>>>> +        // SAFETY: It's safe to copy UUID_STRING_LEN, because we validated lengths.
>>>> +        // Also we leave last byte zeroed, so guid_string is valid C string.
>>>> +        unsafe {
>>>> +            ::core::ptr::copy_nonoverlapping(
>>>> +                guid.as_ptr(),
>>>> +                &raw mut inner.guid_string[0],
>>>> +                bindings::UUID_STRING_LEN as usize,
>>>> +            );
>>>> +        }
>>>
>>> Just use while here so no unsafe is needed at all. Then probably patch
>>> 1/3 is not needed.
>>
>> Overall this operation is still unsafe because we are constructing C
>> string in FFI object. So for me avoiding `unsafe` via less readable
>> (imo) loop will just mask unsafe operation without any real benefits.
> 
> It is not unsafe if you also use pin_init::zeroed()
>          let mut inner: bindings::wmi_device_id = pin_init::zeroed();
> 
>          let mut i = 0usize;
>          while i < bindings::UUID_STRING_LEN as usize {
>              inner.guid_string[i] = guid[i];
>              i += 1;
>          }
> 
> you can then also remove 'core::mem::MaybeUninit'

I was talking more about "constructing C string is still 'unsafe' 
because you shouldn't miss the \0 byte". IMO unsafe but primitive memcpy 
is more readable and alerting than while loop, but that's not something 
I will insist on

I'll play around more with `guid: &CStr` API, probably I missed 
something simple)

