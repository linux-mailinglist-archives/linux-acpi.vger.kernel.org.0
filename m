Return-Path: <linux-acpi+bounces-20079-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF7CD04C2F
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 18:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FF0A3009F52
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B6B29AAF7;
	Thu,  8 Jan 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="mU80jD2T";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="3bak54Om"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901F243956;
	Thu,  8 Jan 2026 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892286; cv=none; b=Umt7B+tKwRdcb/Uz/d2RcgPGGKSomNGMcmIjLCO56ov6q0mUbUk+X4Wjbbq2EUWTa5xGxCmHXQrsp78HkIcHQWBlbcr1KAHqQ9W7Qky1Zi6vL9mxd9IBUAPXZAETkLhttkZZM9UCNMRaq1AxS6LiQSVyjUP8iO6jsNrTVmylk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892286; c=relaxed/simple;
	bh=Akv787Em/pe7IzE4s1CATqBmfi6oKnAkOOTNlpLWtBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsAIny1Ko2dAaXU/C7QaaOscytkiWTguvsi7gW87Gd/ENH0V/2w/4hgMwyF5zS89WE2kXoCLIijBlQbpQX8fO4P/Gq0ffTyAQeIHZPGSbCsUxDRJ23yjQNQjVUyD4TtznbP91Gccq3L//8Uw2kVf2z0cga6bl5uvo5fZ3JguH+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=mU80jD2T; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=3bak54Om; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767892279; bh=SE5cRd2n+bVSUXioZiMtPFw
	s1O8pgkqLqca0frq41Rg=; b=mU80jD2TaESazqllqPokk4Q9ZPJq4Nf1SOk3f6fz7g4x1Y+YXH
	y7A6GLexyvVA5dWhmUiDB54HfcKwr45HccnLFL2S4hkMG51WGUggFbfQXbFLvgwijcntzdJA+23
	OqHOiijf2bUjbg2GFUwtNRnroPbloxJ51v5mGZ/3Tc90wteqQOhYXUury2YteepGHZ2iFTVtmC/
	Z7xW706YxSIx5iEOYnnH2XpTI7GTsmW+F2xso+VL4T7dM23w/qems8++zYefPeg+yR9xHAOHsv1
	89Vx+D454omfLHEGARIwUW6goinQ/nj4BeDeUp17HIPK/mDqjHx6zx+62oUdyD0Toxw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767892279; bh=SE5cRd2n+bVSUXioZiMtPFw
	s1O8pgkqLqca0frq41Rg=; b=3bak54Om7VR6bKckKc4iHCWxCKtgKQOSoxHixRQEtealMl0ipS
	djYMZOrKLsrVlzMY7V9EqfrPWr78uyBReoAg==;
Message-ID: <7b8130de-8096-4fcb-be84-c13209638b25@foxido.dev>
Date: Thu, 8 Jan 2026 20:11:19 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: implement wrapper for acpi_object
To: Gary Guo <gary@garyguo.net>
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1767818037.git.foxido@foxido.dev>
 <05261e88ac8503e2af59d703389d94cc15f4450d.1767818037.git.foxido@foxido.dev>
 <20260108132141.6cce4827.gary@garyguo.net>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <20260108132141.6cce4827.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/26 16:21, Gary Guo wrote:
> On Wed,  7 Jan 2026 23:35:32 +0300
> Gladyshev Ilya <foxido@foxido.dev> wrote:
> 
>> ACPI Object is represented via union on C-side. On Rust side, this union
>> is transparently wrapped for each ACPI Type, with individual methods and
>> Defer implementation to represented type (integer, string, buffer, etc).
>>
>> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> 
> 
> Hi Gladyshev,
> 
> I've checked the `acpi_object` implementation on the C side and it appears
> that the buffer is not owned by the object (however managed externally,
> could either be resting in ACPI tables directly or be allocated).
Hm, I looked through ACPI_FREE() call sites and acpi_evaluate_object() 
implementation, and it seems to me that the acpi_object's lifetime is 
the same as its internal buffer. Overall, it is indeed managed 
externally, but acpi_object and acpi_object::buffer->pointer live 
together. I’m not an ACPI expert, though, so maybe I’m missing something.

Anyway, the current Rust setup seems fine for now:
0. AcpiObject validity is guaranteed by whoever constructed/passed it (C 
side for WMI abstractions, for example)
1. You can only convert &AcpiObject to &AcpiSubType (reference to 
reference), so AcpiSubType can't outlive AcpiObject
2. You can't steal the data pointer from &AcpiSubType either, because 
the Deref impl is "logically safe" and only gives you a reference to the 
inner data, which can't outlive AcpiSubType's reference -> can't outlive 
AcpiObject.

So for now until AcpiObject lives _less_ than it's inner data, 
everything is OK.

> Therefore, you might want to carry a lifetime to represent the lifetime of
> underlying buffers?
>> ---
>>   rust/kernel/acpi.rs | 91 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 91 insertions(+)
>>
>> diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
>> index 9b8efa623130..ac1a9f305f6c 100644
>> --- a/rust/kernel/acpi.rs
>> +++ b/rust/kernel/acpi.rs
>> @@ -2,6 +2,8 @@
>>   
>>   //! Advanced Configuration and Power Interface abstractions.
>>   
>> +use core::ops::Deref;
>> +
>>   use crate::{
>>       bindings,
>>       device_id::{RawDeviceId, RawDeviceIdIndex},
>> @@ -63,3 +65,92 @@ macro_rules! acpi_device_table {
>>           $crate::module_device_table!("acpi", $module_table_name, $table_name);
>>       };
>>   }
>> +
>> +/// An ACPI object.
>> +///
>> +/// This structure represents the Rust abstraction for a C [`struct acpi_object`].
>> +/// You probably want to convert it into actual object type (e.g [`AcpiBuffer`]).
>> +///
>> +/// # Example
>> +/// ```
>> +/// # use kernel::prelude::*;
>> +/// use kernel::acpi::{AcpiObject, AcpiBuffer};
>> +///
>> +/// fn read_first_acpi_byte(obj: &AcpiObject) -> Result<u8> {
>> +///     let buf: &AcpiBuffer = obj.try_into()?;
>> +///
>> +///     Ok(buf[0])
>> +/// }
>> +/// ```
>> +///
>> +/// [`struct acpi_object`]: srctree/include/acpi/actypes.h
>> +#[repr(transparent)]
>> +pub struct AcpiObject(bindings::acpi_object);
>> +
>> +impl AcpiObject {
>> +    /// Returns object type id (see [`actypes.h`](srctree/include/acpi/actypes.h)).
>> +    pub fn type_id(&self) -> u32 {
>> +        // SAFETY: `type` field is valid in all union variants.
>> +        unsafe { self.0.type_ }
>> +    }
> 
> This should probably be an enum instead of just integer.

Using an enum would require keeping Rust's enum synced with the C side, 
as well as implementing some simple but non-trivial checks that the 
`type_` field is a valid enum value (and the valid range isn't 
continuous). I think that keeping it as an integer is simpler and better 
matches C side.

>> +}
>> +
>> +/// Generate wrapper type for AcpiObject subtype.
>> +///
>> +/// For given subtype implements
>> +/// - `#[repr(transparent)]` type wrapper,
>> +/// - `TryFrom<&AcpiObject> for &SubType` trait,
>> +/// - unsafe from_unchecked() for 'trusted' conversion.
>> +macro_rules! acpi_object_subtype {
>> +    ($subtype_name:ident <- ($acpi_type:ident, $field_name:ident, $union_type:ty)) => {
>> +        /// Wraps `acpi_object` subtype.
>> +        #[repr(transparent)]
>> +        pub struct $subtype_name($union_type);
> 
> Instead of wrapping the bindgen-generated subtypes, I would rather this to
> be a transparent wrapper of `acpi_object`, with an invariant that the
> specific union field is active.
> 
> This way you do not have to name the bindgen-generated names.

Sounds reasonable, thanks!

>> +
>> +        impl<'a> TryFrom<&'a AcpiObject> for &'a $subtype_name {
>> +            type Error = Error;
>> +
>> +            fn try_from(value: &'a AcpiObject) -> core::result::Result<Self, Self::Error> {
>> +                if (value.type_id() != $subtype_name::ACPI_TYPE) {
>> +                    return Err(EINVAL);
>> +                }
>> +
>> +                // SAFETY: Requested cast is valid because we validated type_id
>> +                Ok(unsafe { $subtype_name::from_unchecked(&value) })
>> +            }
>> +        }
> 
> It feels like this can be better implemented by having a sealed trait for
> all possible ACPI object types?

I don’t see any particular benefit except moving the `impl TryFrom` out 
of macro-generated code, but you’re probably right -- I’ll try 
implementing it this way.

(will rustdoc show TryFrom on the AcpiSubType's page if it's implemented 
via sealed trait?)

>> +
>> +        impl $subtype_name {
>> +            /// Int value, representing this ACPI type (see [`acpitypes.h`]).
>> +            ///
>> +            /// [`acpitypes.h`]: srctree/include/linux/acpitypes.h
>> +            pub const ACPI_TYPE: u32 = bindings::$acpi_type;
>> +
>> +            /// Converts opaque AcpiObject reference into exact ACPI type reference.
>> +            ///
>> +            /// # Safety
>> +            ///
>> +            /// - Requested cast should be valid (value.type_id() is `Self::ACPI_TYPE`).
>> +            pub unsafe fn from_unchecked(value: &AcpiObject) -> &Self {
>> +                // SAFETY:
>> +                // - $field_name is currently active union's field due to external safety contract,
>> +                // - Transmuting to `repr(transparent)` wrapper is safe.
>> +                unsafe {
>> +                    ::core::mem::transmute::<&$union_type, &$subtype_name>(&value.0.$field_name)
>> +                }
>> +            }
>> +        }
>> +    };
>> +}
>> +
>> +acpi_object_subtype!(AcpiBuffer
>> +    <- (ACPI_TYPE_BUFFER, buffer, bindings::acpi_object__bindgen_ty_3));
>> +
>> +impl Deref for AcpiBuffer {
>> +    type Target = [u8];
>> +
>> +    fn deref(&self) -> &Self::Target {
>> +        // SAFETY: (pointer, length) indeed represents byte slice.
>> +        unsafe { ::core::slice::from_raw_parts(self.0.pointer, self.0.length as usize) }
>> +    }
>> +}
> 


