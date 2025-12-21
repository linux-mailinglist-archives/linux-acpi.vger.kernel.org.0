Return-Path: <linux-acpi+bounces-19738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D6CD43D7
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 19:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6003A3004C8B
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A55304BB3;
	Sun, 21 Dec 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="WBFvIfQl";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="q4WyASaU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54692FE598;
	Sun, 21 Dec 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766341487; cv=none; b=ZftT4O/yo9rGghm6tF37G3sMcY+i/on9AzmfEPtVLxrxvutC9UJ/MM+uXvMpLp43O8iTzJjOgi1w5rWBgpy/hE8imqXKVy0UMawEHcZchxurbJEJcRur2G6UmlYV5mgJoDVMUqgd8LJ2ZUp2kMVZqp29oB97LhVC397H0oHEDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766341487; c=relaxed/simple;
	bh=4guQZLwLk/zxWfZ72wTJRC77JUzl36ROeuOGICzIA0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqTzHjxaRvg/qIWr0UD+QYXFxkAhyGZ3ieM7/JQmtb25Q0C1Bal8Sd6B3j1nG4Z2bamXYCh9jaSr+HAAowJD6Pwv4UC7YbMJp2uCQFKEvx57k9B8UshsEF8f9TxmROS+60onHCJUTi10cuVP+qeaeDNzcAhrat1quseBydMDca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=WBFvIfQl; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=q4WyASaU; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1766341438; bh=ZHlBPPcME7C6jnvNm+5ih+z
	OvfMMvMSU3Q8a3ToZSzc=; b=WBFvIfQl6gYIp88mgLfFolN0CiZ8m6+TlYZURzMflibIXc4pXI
	pOulkw6g8ss24HXJrj48s4lOx/u/bOqG8k+vjF0T9yWWiszLrBPwFziwdL+Nv3XJsLh6xihZVVm
	G5WZZR8y+gyEjo4r+pJPWejtbEkjSJPcDNQbTaP5mQYctKwZQbEaKDxftz5bEVET796WkQHrqUT
	05ArP4rGyv2ReVqOZ3j7NdAchoQraPj6/42RX9CI0x5+CFZ6Eqbf7BcAZrZzfIRc1ZFIVBUNxtt
	LnbrjtjkttWqSB/s8jqWOE9DqNXh2U/y0LCy4vM7W950YJIyzYzY8ywU7lo6r+Cfs3w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1766341438; bh=ZHlBPPcME7C6jnvNm+5ih+z
	OvfMMvMSU3Q8a3ToZSzc=; b=q4WyASaULkOjz5k9rhflsp/oqyfEtNW4/mtWduHqw/COdV9H7o
	bpTPkVEi9k7+HTuEhGMQ8Wp/JRUvNAX8fgAg==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
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
	linux-acpi@vger.kernel.org,
	Gladyshev Ilya <foxido@foxido.dev>
Subject: [RFC PATCH 1/3] rust: implement wrapper for acpi_object
Date: Sun, 21 Dec 2025 21:22:37 +0300
Message-ID: <a28e83201e1413091333509628274807e50ec170.1766331321.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1766331321.git.foxido@foxido.dev>
References: <cover.1766331321.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI Object is represented via union on C-side. On Rust side, it's
zero-cost type wrapper for each ACPI Type, with individual methods for
getters and other interactions.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 rust/kernel/acpi.rs | 103 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 9b8efa623130..0a164ca8cceb 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -63,3 +63,106 @@ macro_rules! acpi_device_table {
         $crate::module_device_table!("acpi", $module_table_name, $table_name);
     };
 }
+
+/// An ACPI object.
+///
+/// This structure represents the Rust abstraction for a C [`struct acpi_object`].
+/// You probably want to convert it into actual object type.
+///
+/// # Example
+/// ```
+/// # use kernel::prelude::*
+/// use kernel::acpi::{AcpiObject};
+///
+/// fn read_first_acpi_byte(obj: &AcpiObject) -> Result<u8> {
+///     if obj.type_id() != AcpiBuffer::ACPI_TYPE {
+///         return Err(EINVAL);
+///     }
+///
+///     let obj: &AcpiBuffer = obj.try_into()?;
+///
+///     Ok(obj.payload()[0])
+/// }
+/// ```
+#[repr(transparent)]
+pub struct AcpiObject(bindings::acpi_object);
+
+impl AcpiObject {
+    /// Returns object type (see `acpitypes.h`)
+    pub fn type_id(&self) -> u32 {
+        // SAFETY: `type` field is valid in all union variants
+        unsafe { self.0.type_ }
+    }
+}
+
+/// Generate AcpiObject subtype
+///
+/// For given subtype implements
+/// - `TryFrom<&AcpiObject> for &SubType` trait
+/// - unsafe try_from_unchecked() with same semantics, but without type check
+macro_rules! acpi_object_subtype {
+    ($subtype_name:ident <- ($acpi_type:ident, $field_name:ident, $union_type:ty)) => {
+        /// Wraps `acpi_object` subtype
+        #[repr(transparent)]
+        pub struct $subtype_name($union_type);
+
+        impl TryFrom<&AcpiObject> for &$subtype_name {
+            type Error = Error;
+
+            fn try_from(value: &AcpiObject) -> core::result::Result<Self, Self::Error> {
+                // SAFETY: type_ field present in all union types and is always valid
+                let real_type = unsafe { value.0.type_ };
+
+                if (real_type != $subtype_name::ACPI_TYPE) {
+                    return Err(EINVAL);
+                }
+
+                // SAFETY: We validated union subtype
+                Ok(unsafe {
+                    ::core::mem::transmute::<&$union_type, &$subtype_name>(&value.0.$field_name)
+                })
+            }
+        }
+
+        impl $subtype_name {
+            /// This ACPI type int value (see `acpitypes.h`)
+            pub const ACPI_TYPE: u32 = bindings::$acpi_type;
+
+            /// Converts AcpiObject reference into exact ACPI type wrapper
+            ///
+            /// # Safety
+            ///
+            /// Assumes that value is correct (`Self`) subtype
+            pub unsafe fn try_from_unchecked(value: &AcpiObject) -> &Self {
+                // SAFETY: Only unsafety comes from unchecked transformation and
+                // we transfered
+                unsafe {
+                    ::core::mem::transmute::<&$union_type, &$subtype_name>(&value.0.$field_name)
+                }
+            }
+        }
+    };
+}
+
+acpi_object_subtype!(AcpiInteger
+    <- (ACPI_TYPE_INTEGER, integer, bindings::acpi_object__bindgen_ty_1));
+acpi_object_subtype!(AcpiString
+    <- (ACPI_TYPE_STRING, string, bindings::acpi_object__bindgen_ty_2));
+acpi_object_subtype!(AcpiBuffer
+    <- (ACPI_TYPE_BUFFER, buffer, bindings::acpi_object__bindgen_ty_3));
+acpi_object_subtype!(AcpiPackage
+    <- (ACPI_TYPE_PACKAGE, package, bindings::acpi_object__bindgen_ty_4));
+acpi_object_subtype!(AcpiReference
+    <- (ACPI_TYPE_LOCAL_REFERENCE, reference, bindings::acpi_object__bindgen_ty_5));
+acpi_object_subtype!(AcpiProcessor
+    <- (ACPI_TYPE_PROCESSOR, processor, bindings::acpi_object__bindgen_ty_6));
+acpi_object_subtype!(AcpiPowerResource
+    <- (ACPI_TYPE_POWER, power_resource, bindings::acpi_object__bindgen_ty_7));
+
+impl AcpiBuffer {
+    /// Get Buffer's content
+    pub fn payload(&self) -> &[u8] {
+        // SAFETY: (pointer, length) indeed represents byte slice
+        unsafe { ::core::slice::from_raw_parts(self.0.pointer, self.0.length as usize) }
+    }
+}
-- 
2.51.1.dirty


