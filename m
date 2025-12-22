Return-Path: <linux-acpi+bounces-19788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9FCD6FA5
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 20:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B64F3003FCA
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1005308F28;
	Mon, 22 Dec 2025 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3VNGzT/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5A2D0292
	for <linux-acpi@vger.kernel.org>; Mon, 22 Dec 2025 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431978; cv=none; b=Wr1WO6O3DQ+8V8rVTHBrzR8oGpcLocOPgn+8O3oxn68Ze4Kk+l0Trc+uIT2uTaukcRH5jC/f3lpZPGwvuJuBkfEDirS+b5Rt0yw3/OZ7spSLTzDwiQWzGb4fCZGIvkjPFMd6GlMs2MlL/NkWUtogECRZsYtNJOzV51n5xJV9zZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431978; c=relaxed/simple;
	bh=2YLmqYLXG8cvuDMIXMSVNeC2qAgNhbNu2d7uOd4IqIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBY+/+2xlXF30MrG0FAWu4gTz+su75rvZWLBUJMz1Uqm0ybpyVeJGl5zhwFRItxt44w92AYCe5J3Oz+Fzm+hQsn9U04xVIDYw/aH8LsUIFsMIjgBl25PmhnMgFBsd5ctjZZebos7t5bdV4hfwh/Gcim+3rN8pHl5ORtKvjZJNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3VNGzT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBE7C2BCB0
	for <linux-acpi@vger.kernel.org>; Mon, 22 Dec 2025 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431978;
	bh=2YLmqYLXG8cvuDMIXMSVNeC2qAgNhbNu2d7uOd4IqIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F3VNGzT/CsTfe3DWl7QcMrwTXVtn7t6zeoXDfhEPGhZ8KJPJl2uXQ02WkMORvq++0
	 M3Y/0Ooo3Rys3UNO1LLKOclnu1WitUhxezbdiE4ztqcbtZhpKm5b7QM3ViSsfuDP6W
	 CM0la+t4L6g6BR+A06W2p6Hfervi3uga6tfq3TLLd0v1HFL2cWx+3fsEm3GmHmgp/t
	 6qrIGJQYFcEBhxhVJnMpLsENK6GqCyDEl19o7QmxW2f/RZ3t299FdiPUNlrP9VCQxm
	 lDElXiiAAb+e/R7IOH4m1JsLj8pRXDvt0tFJWB6GzaO10akhoqOUgfhvK4F0aNBoI9
	 vD7IEJCcpb+9g==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65e943048afso305918eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 22 Dec 2025 11:32:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWR+zcwDDSuiDkyZZPiKGGF8PgXBKAfCPxqcaBQPv4NjpxMIRFgTh1JlxsiLz6BSLBQlBvWb9FYkvIt@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYpLIEnvGCfpgrRwxVMI9g0b7qEkEQhy48ZMKplRZZcVBrKq7
	kXch4KyJNaHo3SjTfnz3TqDmor5eoOb62SXFiFZwYDG10+3ncNkwW/aUHHxt1VISZvCMLQy6xrZ
	uFnNN5qEsdEbq0/d0dcUFr9dvOKJcPa0=
X-Google-Smtp-Source: AGHT+IH9Oh5ISckXWZDzO/JklOW5Tf/iJ8QC33F5miP3LQxw43hjKyPUfvzG4hyaummAbxFPPPUyE01caboS86H4kxc=
X-Received: by 2002:a05:6820:827:b0:659:9a49:8dd0 with SMTP id
 006d021491bc7-65d0ea2a39emr4539336eaf.18.1766431977292; Mon, 22 Dec 2025
 11:32:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1766331321.git.foxido@foxido.dev> <a28e83201e1413091333509628274807e50ec170.1766331321.git.foxido@foxido.dev>
In-Reply-To: <a28e83201e1413091333509628274807e50ec170.1766331321.git.foxido@foxido.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Dec 2025 20:32:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hQwopbJox0QpT5tmZ0Eobgpfii47cDP8OWEON+iT4Qxg@mail.gmail.com>
X-Gm-Features: AQt7F2pLyfssaq8QK0jeDWulf5Uchu82OKpzC-ivQuaspV6Nq4x_CDAxy2F83U4
Message-ID: <CAJZ5v0hQwopbJox0QpT5tmZ0Eobgpfii47cDP8OWEON+iT4Qxg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] rust: implement wrapper for acpi_object
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 7:24=E2=80=AFPM Gladyshev Ilya <foxido@foxido.dev> =
wrote:
>
> ACPI Object is represented via union on C-side. On Rust side, it's
> zero-cost type wrapper for each ACPI Type, with individual methods for
> getters and other interactions.

This is ACPICA stuff though and switching over ACPICA to Rust any time
soon is rather unlikely.

Is this really needed on the Rust side?

> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>  rust/kernel/acpi.rs | 103 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>
> diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
> index 9b8efa623130..0a164ca8cceb 100644
> --- a/rust/kernel/acpi.rs
> +++ b/rust/kernel/acpi.rs
> @@ -63,3 +63,106 @@ macro_rules! acpi_device_table {
>          $crate::module_device_table!("acpi", $module_table_name, $table_=
name);
>      };
>  }
> +
> +/// An ACPI object.
> +///
> +/// This structure represents the Rust abstraction for a C [`struct acpi=
_object`].
> +/// You probably want to convert it into actual object type.
> +///
> +/// # Example
> +/// ```
> +/// # use kernel::prelude::*
> +/// use kernel::acpi::{AcpiObject};
> +///
> +/// fn read_first_acpi_byte(obj: &AcpiObject) -> Result<u8> {
> +///     if obj.type_id() !=3D AcpiBuffer::ACPI_TYPE {
> +///         return Err(EINVAL);
> +///     }
> +///
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
> +
> +                // SAFETY: We validated union subtype
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
> --

