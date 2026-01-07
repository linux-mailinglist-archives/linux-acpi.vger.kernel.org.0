Return-Path: <linux-acpi+bounces-20021-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E64B7D00113
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 21:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B273F3005B9D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EBA318EF6;
	Wed,  7 Jan 2026 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="rYkZVxEh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="Rc+44m0p";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="dQtkPqkt";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="Fq/3aGKs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender6.mail.selcloud.ru (sender6.mail.selcloud.ru [5.8.75.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9BF23C8A0;
	Wed,  7 Jan 2026 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819249; cv=none; b=MkjYSDQaQAyyYYsd3QjWvodgGdE1Mpx4ySTbvq/0aUkPNnrVM7PxfJdLDunW9jIvWGbEOKaVr6lE7LqAnt0/C7BNrpL+InWNzvhPNkwk1KwO66v9D5yw2MUBlrNabwNI8VYLxMs1dBA6eO2DMzmaJh0j+GvPwpT/ScUIF74IXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819249; c=relaxed/simple;
	bh=+DCHUUSyyM1kANcD3QYs0ElAq8Y2r0xCGWcdKoADy1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfh5P+wh6VWW2bwLl27yCt85IwMPF8chbh4ntmT6SZA6TiGpCG0V7KCTBdxau1No6dCyLmde8Bf46oxUFbolPUaUxRMqVCIqOqIFSIGrpljaGls/1/V8yacFbM+10Hpb0zr+GVS2Qn+gXBpvvgNXIWyXpke8CkyEjXg71LURh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=rYkZVxEh; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=Rc+44m0p; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=dQtkPqkt; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=Fq/3aGKs; arc=none smtp.client-ip=5.8.75.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EoPPcByryAWO+tKsOanY3nkf4rGppMtkx5HzY6lwzZ8=; t=1767819245; x=1767992045;
	 b=rYkZVxEhRTp18W65V9T0YH15W0AzPPqIhgnvLMtibdMKU5pt9ntZmnP5OKgIjcFeS31jhkplCx
	W5g4Yj95edHBRh+CXa/BKnpS6Z+9qWEjH6JhK86czDtrs52rmXLhQ5n+atRA3UFB9+pS10JKleUC9
	26EdskskmSVbPtHLdbrI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EoPPcByryAWO+tKsOanY3nkf4rGppMtkx5HzY6lwzZ8=; t=1767819245; x=1767992045;
	 b=Rc+44m0p9zZgp7vItlgqZkHfNwHfDEIkg0XQpxAQ65gifJdaDmDMBTh0r1QHC3U9yhH9KxISqD
	wD0C3Q8SXqT3aLWZf4LyDSfWewbc8B17qkPIv6nGR6mbRr8dz6dhscX9JLKTi0LVCMR7eA7P+RZhw
	IhVwSjHf89BrXuJupAAw=;
Precedence: bulk
X-Issuen: 1539712
X-User: 335779833
X-Postmaster-Msgtype: 3849
Feedback-ID: 1539712:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251225.193711
X-SMTPUID: mlgnr60
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767818172; bh=EoPPcByryAWO+tKsOanY3nk
	f4rGppMtkx5HzY6lwzZ8=; b=dQtkPqktYNVkdp8Rb+VqoXQr/2NM/cjzk1+FfhskV7jwo4tkmG
	sgTz6EmcDYTeQnVf5aOUrGHbgVtJl9g/hDQTEj6NFYldAJOaep5n/z5IpZRy8EtAOfz6eYgtfIp
	0a0XYMe9VxGv48aItAzpgJ/JXidABghXr6ysD4pMnHkHxJYnsvln21PWtbNsrWFourTqUvKSJvb
	G/UXAHo3bSwKeWb3hjyOK0YNnQZqMJnZBpucyig8u7yWk+s0siwKUSTicJcEkTQbE3+UcAglCSi
	pfncw8p5Q92DJiNfQVB3yiCrkgNfanmK+CMJhP70+YXOYAn4Ni/OKLscQabRGesXUwA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767818172; bh=EoPPcByryAWO+tKsOanY3nk
	f4rGppMtkx5HzY6lwzZ8=; b=Fq/3aGKsvGdB/erd0E0YJyzBhZcdkxbSOEqTOfv45c+eLNEvEO
	jRn8g6Yls80XnIVFs9jIQEFcHG7EvTuV69Bw==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
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
	linux-acpi@vger.kernel.org,
	Gladyshev Ilya <foxido@foxido.dev>
Subject: [PATCH 2/3] rust: implement wrapper for acpi_object
Date: Wed,  7 Jan 2026 23:35:32 +0300
Message-ID: <05261e88ac8503e2af59d703389d94cc15f4450d.1767818037.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767818037.git.foxido@foxido.dev>
References: <cover.1767818037.git.foxido@foxido.dev>
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
 rust/kernel/acpi.rs | 91 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 9b8efa623130..ac1a9f305f6c 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -2,6 +2,8 @@
 
 //! Advanced Configuration and Power Interface abstractions.
 
+use core::ops::Deref;
+
 use crate::{
     bindings,
     device_id::{RawDeviceId, RawDeviceIdIndex},
@@ -63,3 +65,92 @@ macro_rules! acpi_device_table {
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
+pub struct AcpiObject(bindings::acpi_object);
+
+impl AcpiObject {
+    /// Returns object type id (see [`actypes.h`](srctree/include/acpi/actypes.h)).
+    pub fn type_id(&self) -> u32 {
+        // SAFETY: `type` field is valid in all union variants.
+        unsafe { self.0.type_ }
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
+        impl<'a> TryFrom<&'a AcpiObject> for &'a $subtype_name {
+            type Error = Error;
+
+            fn try_from(value: &'a AcpiObject) -> core::result::Result<Self, Self::Error> {
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
+            pub unsafe fn from_unchecked(value: &AcpiObject) -> &Self {
+                // SAFETY:
+                // - $field_name is currently active union's field due to external safety contract,
+                // - Transmuting to `repr(transparent)` wrapper is safe.
+                unsafe {
+                    ::core::mem::transmute::<&$union_type, &$subtype_name>(&value.0.$field_name)
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


