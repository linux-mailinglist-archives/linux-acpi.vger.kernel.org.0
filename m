Return-Path: <linux-acpi+bounces-19830-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEEFCD9BDF
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 16:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61BE83020CED
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B92882AF;
	Tue, 23 Dec 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="P7QybHIK";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="19WIdaLf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C2283FE5;
	Tue, 23 Dec 2025 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766502742; cv=none; b=MWVgK5Rb7SEO0H+3RgKHq3IWtlG/+ifuqUzKFSF+rxskXe8ZG7PvkMIzuU1KzYbsVw/AXro6geMUKy5vjRxyGfDSDmO6pLihU+mnHcXGwWM/KY72SG0pVb3DWAx4cO/3mIKCl9Mod8CDWtDHAcWgazyN4iPfTlXvGxeD+BD8D3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766502742; c=relaxed/simple;
	bh=HcTBJ7somqBw9Us4UHW5m/0VmA7i4Wy9sJgNAl3XCiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwrkUQZtvDDJsF8dT4wsYN9wpsAqzsH/XUQpFKxDWuhyzn5f80tF2w45slZo1nRSdpUtyAD7GLmha6JvprXn2KKtsTmhSHpp8f5w273eYfDh0yNGYOu6Q2c51oN4PO2OZ2LT8BSKtTJQmpPCOVWvy6/YGuXQs5kcYk5OngUqtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=P7QybHIK; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=19WIdaLf; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766502179; bh=/2hsXxLSgTGEY+YFJfMP8LC
	TwFoKI+Mdrh1mtytz0b4=; b=P7QybHIK1wiWbUg0VSSJml5uupgbRNy1jqFSNC2hbTbfNblPAc
	PPf+i2iL8Cohspymj34oai9LlYrCRFltDSElbtcNuiKYueZ3/shnLMkBhcf97gTDHtk3WO+WX4K
	3DFdOSjX9KL6eRKd8RFAh+IST7rNMyk/a/zfR5lBmbfLbFbOoyKWHtmmV72o7ZxhgcO4VjXDD7X
	YgjTQ81orS+n1BzALZJpIEMOvkiSSfk1wHLz5Sg9mx5KGTBEOyM3GlEpM4D+Qaqt7V8Np324cJZ
	IHswJUyntQLkyTc0Epg5kDB61CrCpLPHZT5uNfJ4zPJDRWN6bQa9n59QKkfE2N6NdFw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766502179; bh=/2hsXxLSgTGEY+YFJfMP8LC
	TwFoKI+Mdrh1mtytz0b4=; b=19WIdaLfXNDKmrFk8SX2KHuA2T/hJw8AySSLzdSX+M8QaMUW6i
	tQM1W+z5O/kTLWxGHmL4lfzOG2WcAhdw9jDA==;
Message-ID: <0c4e5168-49f8-409c-a6f2-ae5e9df29ded@foxido.dev>
Date: Tue, 23 Dec 2025 18:02:57 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] rust: implement wrapper for acpi_object
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@gmail.com>,
 Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <cover.1766331321.git.foxido@foxido.dev>
 <a28e83201e1413091333509628274807e50ec170.1766331321.git.foxido@foxido.dev>
 <DF4PPPGQBPNA.13TJNSRSRUW0A@kernel.org>
 <4266e3d2-141e-44bd-a4c1-b140674542e3@foxido.dev>
 <DF53YEJYNNBD.1W5RQEVY41RLP@kernel.org>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <DF53YEJYNNBD.1W5RQEVY41RLP@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/25 01:44, Danilo Krummrich wrote:
> On Mon Dec 22, 2025 at 10:47 PM CET, Gladyshev Ilya wrote:
>> I couldn't really decide between implementing all types or only the one
>> needed... Probably, I should provide simple implementations for all the
>> others, I will fix that.
> 
> If they are not needed by any of the drivers you're aiming at, you should
> probably just drop them.

Ack.

>> Wouldn't it be confusing to overload Deref on a non "pointer-like" type
>> just for an implicit cast?
> 
> What do you mean with overload Deref? What I mean is
> 
> 	impl Deref for AcpiBuffer {
> 		type Target = [u8];
> 
> 		[...]
> 	}

I meant the same, just used strange terminology, sorry. If I understand 
it correctly, Deref trait gives you "overloaded" dereference operator as 
well as implicit coercion in many cases, and I don't know if I want them.

Personally, I prefer the explicit style like:
```
let a: &AcpiInteger = /* ... */;
call_func(/* u64: */ a.val())
```

rather than:

```
let a: &AcpiInteger = /* ... */;
call_func(/* u64: */ *a)
```

The former feels clearer to me; the latter gives me "smart pointer" 
vibes and feels a bit confusing, because there are no smart pointers.

That said, I'm not a Rust expert at all -- so if you believe this change 
is better, I'll implement it your way.

