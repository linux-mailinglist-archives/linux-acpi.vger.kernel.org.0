Return-Path: <linux-acpi+bounces-19770-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C2DCD5D26
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 12:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43C5330021DC
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E5531961E;
	Mon, 22 Dec 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4MTqpYf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA9313E24;
	Mon, 22 Dec 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766403314; cv=none; b=PYhQSLWi6GzyKf2Eso7jdo3R0vBlHHei/RJYWuIsvSB2s9Sp5j4K9NxduA/I0veQNuVhJoLjWOKc3hcG9aIOA6AjRfkFuK66GtyUibzWVI5VEPk55NjtF2lapQO/DsCw0t3Tj1UmfWMxFOJHcCqN+OuoLi7fj+INE5oCoSKFHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766403314; c=relaxed/simple;
	bh=BofS04asxFICi56vUDiVBEg4qyYf90vaa4Ld2Hab65I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Qf85TkvvTUVpOAY6byPrTlLA0+pH70xo9ccnmd1zkHrCdYrPilmT/LqV0OdA5TgX/2liaf3IW1U/QhIjNCzLkK718LuRLCvCQgsxogmRGItYDlGYHKAkY9YHu+i3em3egwUPPZBiJ8SJIc2hQHSELaWkXXQjvRIVbGhMRBzcqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4MTqpYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4840C4CEF1;
	Mon, 22 Dec 2025 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766403313;
	bh=BofS04asxFICi56vUDiVBEg4qyYf90vaa4Ld2Hab65I=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=p4MTqpYfLYrV41B2H7R8TP1GCquSJjiBNHONStnG494lkxiwgfTGZW+mEZ6AdLhbo
	 Ze+U9USO4FE5R9vqxyrBev74V+veq2DbI9Jlg1mGwyw+gd2iYyHwLr02r8u6fPLT3+
	 dreYMVykdtBowaEDE+qn0zhG6XtMEXooHssmOGFwTrOLY+Aaz4GwIoCgU0gFIL7h64
	 fMWznhVmIOLHo2Z5KGxYfpVEKJlVpiNceJKKkY0uXAClOTJv5FJRVZwVzfML+QtziO
	 2e1+vj+MOsh32F2tnBw1lYxGVd4SKxal/SkI6Um3SkD3AP21lajpnHElmJvK1b4mne
	 J8d88ArYC49Jw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Dec 2025 12:35:08 +0100
Message-Id: <DF4PPPGQBPNA.13TJNSRSRUW0A@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH 1/3] rust: implement wrapper for acpi_object
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@gmail.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-acpi@vger.kernel.org>
To: "Gladyshev Ilya" <foxido@foxido.dev>
References: <cover.1766331321.git.foxido@foxido.dev>
 <a28e83201e1413091333509628274807e50ec170.1766331321.git.foxido@foxido.dev>
In-Reply-To: <a28e83201e1413091333509628274807e50ec170.1766331321.git.foxido@foxido.dev>

On Sun Dec 21, 2025 at 7:22 PM CET, Gladyshev Ilya wrote:
> +/// An ACPI object.
> +///
> +/// This structure represents the Rust abstraction for a C [`struct acpi=
_object`].
> +/// You probably want to convert it into actual object type.

I think this is a good place to link the corresponding types.

> +///
> +/// # Example
> +/// ```
> +/// # use kernel::prelude::*
> +/// use kernel::acpi::{AcpiObject};

Braces not needed.

> +///
> +/// fn read_first_acpi_byte(obj: &AcpiObject) -> Result<u8> {
> +///     if obj.type_id() !=3D AcpiBuffer::ACPI_TYPE {
> +///         return Err(EINVAL);
> +///     }

Given the try_into() conversion below this check is unnecessary.

> +///     let obj: &AcpiBuffer =3D obj.try_into()?;
> +///
> +///     Ok(obj.payload()[0])
> +/// }
> +/// ```
> +#[repr(transparent)]
> +pub struct AcpiObject(bindings::acpi_object);
> +
> +impl AcpiObject {
> +    /// Returns object type (see `acpitypes.h`)
> +    pub fn type_id(&self) -> u32 {
> +        // SAFETY: `type` field is valid in all union variants

Here and in a lot of other places, please end with a period.

> +        unsafe { self.0.type_ }
> +    }
> +}
> +
> +/// Generate AcpiObject subtype
> +///
> +/// For given subtype implements
> +/// - `TryFrom<&AcpiObject> for &SubType` trait
> +/// - unsafe try_from_unchecked() with same semantics, but without type =
check
> +macro_rules! acpi_object_subtype {
> +    ($subtype_name:ident <- ($acpi_type:ident, $field_name:ident, $union=
_type:ty)) =3D> {
> +        /// Wraps `acpi_object` subtype
> +        #[repr(transparent)]
> +        pub struct $subtype_name($union_type);
> +
> +        impl TryFrom<&AcpiObject> for &$subtype_name {
> +            type Error =3D Error;
> +
> +            fn try_from(value: &AcpiObject) -> core::result::Result<Self=
, Self::Error> {
> +                // SAFETY: type_ field present in all union types and is=
 always valid
> +                let real_type =3D unsafe { value.0.type_ };
> +
> +                if (real_type !=3D $subtype_name::ACPI_TYPE) {
> +                    return Err(EINVAL);
> +                }

This should just be

	if (value.type_id() !=3D $subtype_name::ACPI_TYPE) {
	    return Err(EINVAL);
	}

> +
> +                // SAFETY: We validated union subtype

When writing safety comments, please read the safety documentation of the
corresponding function and try to cover all requirements listed as bullet
points.

> +                Ok(unsafe {
> +                    ::core::mem::transmute::<&$union_type, &$subtype_nam=
e>(&value.0.$field_name)
> +                })
> +            }
> +        }
> +
> +        impl $subtype_name {
> +            /// This ACPI type int value (see `acpitypes.h`)
> +            pub const ACPI_TYPE: u32 =3D bindings::$acpi_type;
> +
> +            /// Converts AcpiObject reference into exact ACPI type wrapp=
er
> +            ///
> +            /// # Safety
> +            ///
> +            /// Assumes that value is correct (`Self`) subtype
> +            pub unsafe fn try_from_unchecked(value: &AcpiObject) -> &Sel=
f {

The name try_from_unchecked() implies that the function is fallible, but it
isn't. I suggest calling it something along the lines of cast_unchecked().

> +                // SAFETY: Only unsafety comes from unchecked transforma=
tion and
> +                // we transfered
> +                unsafe {
> +                    ::core::mem::transmute::<&$union_type, &$subtype_nam=
e>(&value.0.$field_name)
> +                }
> +            }
> +        }
> +    };
> +}
> +
> +acpi_object_subtype!(AcpiInteger
> +    <- (ACPI_TYPE_INTEGER, integer, bindings::acpi_object__bindgen_ty_1)=
);
> +acpi_object_subtype!(AcpiString
> +    <- (ACPI_TYPE_STRING, string, bindings::acpi_object__bindgen_ty_2));
> +acpi_object_subtype!(AcpiBuffer
> +    <- (ACPI_TYPE_BUFFER, buffer, bindings::acpi_object__bindgen_ty_3));
> +acpi_object_subtype!(AcpiPackage
> +    <- (ACPI_TYPE_PACKAGE, package, bindings::acpi_object__bindgen_ty_4)=
);
> +acpi_object_subtype!(AcpiReference
> +    <- (ACPI_TYPE_LOCAL_REFERENCE, reference, bindings::acpi_object__bin=
dgen_ty_5));
> +acpi_object_subtype!(AcpiProcessor
> +    <- (ACPI_TYPE_PROCESSOR, processor, bindings::acpi_object__bindgen_t=
y_6));
> +acpi_object_subtype!(AcpiPowerResource
> +    <- (ACPI_TYPE_POWER, power_resource, bindings::acpi_object__bindgen_=
ty_7));
> +
> +impl AcpiBuffer {
> +    /// Get Buffer's content
> +    pub fn payload(&self) -> &[u8] {
> +        // SAFETY: (pointer, length) indeed represents byte slice
> +        unsafe { ::core::slice::from_raw_parts(self.0.pointer, self.0.le=
ngth as usize) }
> +    }
> +}

What about the values of the other types? How are they accessed?

Also, I think it would be better to use a Deref impl rather than a method.

