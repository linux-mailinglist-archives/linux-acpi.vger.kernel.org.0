Return-Path: <linux-acpi+bounces-20155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2879D0F92F
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87F17304A9B8
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B4534F48A;
	Sun, 11 Jan 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="TLqQOnHP";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="Ws2sGOfg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528B34F486;
	Sun, 11 Jan 2026 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156322; cv=none; b=igZMy/j224SLYZuZYAdQLVfXyMgkmpz1StKsuGtZbrPGEN1ea1NwVJRbiHNBVhHqk9B9FWQW836u/yZdvuUc4Kxi2TotElVOrJdAJF8QY92oJCIKwC55tdG96C/Utq0GmUmXyyT8rn22VfeLutIjtfihU2XAxQ1dTdYTKWgpfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156322; c=relaxed/simple;
	bh=bV4EWz/BTK+Xq0GJsnKA8hk4RPz8zyxpx91FWog7v0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBqwkLjdN3Ghta+P57F47cJ4GMVF8kFkRU8elU4er3qA13KNLVfdnet7dfF7+ED++bw9EaVS3BRuACPLa+DxGz1tOIUH0aZc5ZU5sN6JkDAlOxJ7rR+uDKb65qEflT2qyKEbyWSEuKH1vsNwIc6qtKZ03R+nAOAfDsPWmRmNkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=TLqQOnHP; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=Ws2sGOfg; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768156306; bh=Xf4l59yTGNgTpiVOoO0eqv6
	lrW07UkUBCfzLt473RJc=; b=TLqQOnHPpgfksRyq6fV8azxq+Oy9ChJMM6u8nbBjgkZagorXmb
	uCvmBdWLNPfOaRPgsAu9ZwjuI8e7XMFFH+AkFwU5sFGWw/06q/ArXGvfKtAHfJpspaozYzuYL1G
	2a+sQnhZYKzw7fceP9dtykVi5gtXW7DfpSMr3Hbaux3QA7xh+RGgZ0u3skzUq+KF5CpjT0hgx09
	HR/xQttrul6toSNbkGT0J51dNsynS5R8Z3RK7pUU/KVcfLC6vfnBhRptCy642XdueMn1kHmtGBK
	h5mPfNCTkgm/3xp3TrVJXD3kmRslPtrL+tRM7Qmf9kTorsDqjAVcihhH5DKX2FvjnCA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768156306; bh=Xf4l59yTGNgTpiVOoO0eqv6
	lrW07UkUBCfzLt473RJc=; b=Ws2sGOfgJNNoSD2DwsIKX2saC+h+mXtm8t5lgE1vOKIp+i52jz
	UNLBRTQs3ZLBKculqX4XX/j3Lpic1emjjxCQ==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/2] rust: implement wrapper for acpi_object
Date: Sun, 11 Jan 2026 21:31:25 +0300
Message-ID: <a4bf01ed94406605e12df6b6d1676ea0bd6cd17e.1768153572.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768153572.git.foxido@foxido.dev>
References: <cover.1768153572.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI Object is represented via union on C-side. On Rust side, this union
is transparently wrapped for each ACPI Type, with individual methods and
Defer implementation to represented type (integer, string, buffer, etc).

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 rust/kernel/acpi.rs | 97 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 9b8efa623130..c730c12d3979 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -2,6 +2,11 @@
 
 //! Advanced Configuration and Power Interface abstractions.
 
+use core::{
+    marker::PhantomData,
+    ops::Deref, //
+};
+
 use crate::{
     bindings,
     device_id::{RawDeviceId, RawDeviceIdIndex},
@@ -63,3 +68,95 @@ macro_rules! acpi_device_table {
         $crate::module_device_table!("acpi", $module_table_name, $table_name);
     };
 }
+
+/// An ACPI object.
+///
+/// This structure represents the Rust abstraction for a C [`struct acpi_object`].
+/// You probably want to convert it into actual object type (e.g [`AcpiBuffer`]).
+///
+/// # Example
+/// ```
+/// # use kernel::prelude::*;
+/// use kernel::acpi::{AcpiObject, AcpiBuffer};
+///
+/// fn read_first_acpi_byte(obj: &AcpiObject) -> Result<u8> {
+///     let buf: &AcpiBuffer = obj.try_into()?;
+///
+///     Ok(buf[0])
+/// }
+/// ```
+///
+/// [`struct acpi_object`]: srctree/include/acpi/actypes.h
+#[repr(transparent)]
+pub struct AcpiObject<'a> {
+    inner: bindings::acpi_object,
+    _p: PhantomData<&'a bindings::acpi_object>,
+}
+
+impl AcpiObject<'_> {
+    /// Returns object type id (see [`actypes.h`](srctree/include/acpi/actypes.h)).
+    pub fn type_id(&self) -> u32 {
+        // SAFETY: `type` field is valid in all union variants.
+        unsafe { self.inner.type_ }
+    }
+}
+
+/// Generate wrapper type for AcpiObject subtype.
+///
+/// For given subtype implements
+/// - `#[repr(transparent)]` type wrapper,
+/// - `TryFrom<&AcpiObject> for &SubType` trait,
+/// - unsafe from_unchecked() for 'trusted' conversion.
+macro_rules! acpi_object_subtype {
+    ($subtype_name:ident <- ($acpi_type:ident, $field_name:ident, $union_type:ty)) => {
+        /// Wraps `acpi_object` subtype.
+        #[repr(transparent)]
+        pub struct $subtype_name($union_type);
+
+        impl<'a> TryFrom<&'a AcpiObject<'a>> for &'a $subtype_name {
+            type Error = Error;
+
+            fn try_from(value: &'a AcpiObject<'a>) -> core::result::Result<Self, Self::Error> {
+                if (value.type_id() != $subtype_name::ACPI_TYPE) {
+                    return Err(EINVAL);
+                }
+
+                // SAFETY: Requested cast is valid because we validated type_id
+                Ok(unsafe { $subtype_name::from_unchecked(&value) })
+            }
+        }
+
+        impl $subtype_name {
+            /// Int value, representing this ACPI type (see [`acpitypes.h`]).
+            ///
+            /// [`acpitypes.h`]: srctree/include/linux/acpitypes.h
+            pub const ACPI_TYPE: u32 = bindings::$acpi_type;
+
+            /// Converts opaque AcpiObject reference into exact ACPI type reference.
+            ///
+            /// # Safety
+            ///
+            /// - Requested cast should be valid (value.type_id() is `Self::ACPI_TYPE`).
+            pub unsafe fn from_unchecked<'a>(value: &'a AcpiObject<'a>) -> &'a Self {
+                // SAFETY:
+                // - $field_name is currently active union's field due to external safety contract,
+                // - Transmuting to `repr(transparent)` wrapper is safe.
+                unsafe {
+                    ::core::mem::transmute::<&$union_type, &$subtype_name>(&value.inner.$field_name)
+                }
+            }
+        }
+    };
+}
+
+acpi_object_subtype!(AcpiBuffer
+    <- (ACPI_TYPE_BUFFER, buffer, bindings::acpi_object__bindgen_ty_3));
+
+impl Deref for AcpiBuffer {
+    type Target = [u8];
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: (pointer, length) indeed represents byte slice.
+        unsafe { ::core::slice::from_raw_parts(self.0.pointer, self.0.length as usize) }
+    }
+}
-- 
2.52.0


