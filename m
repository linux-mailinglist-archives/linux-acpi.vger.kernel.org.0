Return-Path: <linux-acpi+bounces-20105-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA3D08BF4
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 11:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 228C030031BC
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE3B33B96C;
	Fri,  9 Jan 2026 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="UwgBV2mU";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="R3PwjigY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF733B6F6;
	Fri,  9 Jan 2026 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956255; cv=none; b=X395BeDXiW7OKnfHEvT3iRwcEwp5b4hZOZDF9zOuIiRNIIGUWtEqvmBmr3zpA+ZPgb9N3yuO7a83OIf0N/MAFWCTwAM2p7Gs7FTmcffSnYaVoam2OoDM7ln/3DSGmkifL2MBI6dPHUtnYuhFiDCf0mY5rvfzod1zuXk/cLrlgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956255; c=relaxed/simple;
	bh=5DZime/BnLBOwZgd7Mk8F+ux9jj+zzKRNw5gSqaCoYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvgvijGdeUJA1WlLCn4DmJ8jwHsCO+rRgyMlihyYE+OqDp8bWPnfBBq/TvIj4WWFFIJk7W2sn5qEiolcro4+45LQfKdPi1RKgT15lAUx0Si6yZVoM8Dlcow9aL5gfK3OHtGliXiZwDv0Vkp2Buw+OdcRz6KYSnhY6dwxbK9KC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=UwgBV2mU; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=R3PwjigY; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767956226; bh=ldKHaU2jlESlMljrnBb3wCu
	ks7UcNv6E/iPuxj0KAyc=; b=UwgBV2mUt3t5wr6tX7wCcHHu+ivoyl2DGYjfCI+kwaYCUEhdpU
	sT06Yt03K3nEDhkJrjqO7PK5KcONgHZpf4lgQ6sp0ddROI+sBWG85UmQqslflYcWEFa5nuziY7Q
	TurfvxrQRVhW+pPKeuifo/AhRfwAPRB+9tZxK3KSzXzqi3zjLmGy0cHWm6LfgrYDYf6cfp+ksrk
	jDmk4vDNnVpDT5miF/vdRCaBlvCTVV5b8lTbw9JRmh0epKJyEv8bjaFCID9//RHPtwJd+LUtvgd
	HozSvk/aKGXDjHf8eCy2voMW2DHcRCi5I/jbxsoMCZUCt3EYyIIbGprdjrt2mPDmk/A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767956226; bh=ldKHaU2jlESlMljrnBb3wCu
	ks7UcNv6E/iPuxj0KAyc=; b=R3PwjigYAjMzWuhovQRJpw5kqmszVVNlR4BIstWQLODZ94T8mJ
	lBNj66Mg/9vZO3a17V2lWBBjWa8gO6jXtrBQ==;
Message-ID: <b8e2c3ed-7db1-48ca-8dc8-64dfa437c595@foxido.dev>
Date: Fri, 9 Jan 2026 13:57:03 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: implement wrapper for acpi_object
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org, foxido@foxido.dev
References: <cover.1767818037.git.foxido@foxido.dev>
 <05261e88ac8503e2af59d703389d94cc15f4450d.1767818037.git.foxido@foxido.dev>
 <20260108132141.6cce4827.gary@garyguo.net>
 <7b8130de-8096-4fcb-be84-c13209638b25@foxido.dev>
 <CANiq72=TAXwjjxFiKiiwh9m_rRK_yUVS4b+2st=QJWErz5qTpQ@mail.gmail.com>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <CANiq72=TAXwjjxFiKiiwh9m_rRK_yUVS4b+2st=QJWErz5qTpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 21:46, Miguel Ojeda wrote:
>> Using an enum would require keeping Rust's enum synced with the C side,
>> as well as implementing some simple but non-trivial checks that the
>> `type_` field is a valid enum value (and the valid range isn't
>> continuous). I think that keeping it as an integer is simpler and better
>> matches C side.
> 
> If this refers to the `ACPI_TYPE_*` constants, there seems to be a
> comment in the C docs that requires it to be kept in sync already with
> elsewhere, so perhaps it could be reasonable to add one more place to
> sync? (Though I don't see the mentioned arrays from a quick grep?)
> 
>       * NOTE: Types must be kept in sync with the global acpi_ns_properties
>       * and acpi_ns_type_names arrays.
> 
> [...snip about bindgen...]

If I understand correctly, acpi_object is something untrusted in general 
and broken hardware can provide arbitrary _type value. So ergonomics of 
enum solution would be kinda strange:

```
type_id() -> Result<Enum> // Result because it can be invalid

// ...

// '?' here makes it look like non-trivial operation
if x.type_id()? == Enum::Buffer
```

And it's unclear should ACPI_TYPE_INVALID be Ok(INVALID) or Err...

Also users of AcpiObject generally doesn't care if received object has 
valid, but unexpected type or invalid type, so this conversion int->enum 
will introduce (small but) unneeded overhead.

That's why I preferred int-style approach, matching C side. Here is 
alternative proposal from my side:

1. Enum with type values like you want
2. This Enum implements .id() method that returns underlying <int>
3. AcpiObject::type_id() still returns <int> value
4. There is method to convert int into enum (like TryFrom)

Probably you can 'newtype' <int> and implement TryFrom AcpiTypeId -> 
Enum and write something like

```
match x.type_id().try_into()? /* or as_enum() or smth */ {
   Enum::Integer => /* ... */,
   Enum::String => /* ... */
}

```


---
Sorry for my chaotic explanations...



