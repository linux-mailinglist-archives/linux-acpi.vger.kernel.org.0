Return-Path: <linux-acpi+bounces-12445-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EF9A71CD4
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB6517451B
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9F1FC100;
	Wed, 26 Mar 2025 17:15:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691B1FBC89;
	Wed, 26 Mar 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009306; cv=none; b=QD9f88Vt6iS7VFUH2eAuRYTYYCCC1XmGaDajl1nwmRe7mVJPWLLBBf1sXuVF5BZJ9nKg/3k7k6Rx9D7XB8aX/grHCUlZu0uBXxhkB7pferjUms1g5eavX0nDr9tOU7FAayvbLA0GwnJxPhUT4ws55R/pFnxjkGQfmso1K7ZQvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009306; c=relaxed/simple;
	bh=g8jiBgUmirygyBk4J0uJSx25wPYIMJmKBYqNb9X1hIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7q1Elgn7V48Wn4s5AGgN50BIQ7Pzfy0Sp8jfsgpfZuNKOL2Yk7CO6iRxckmDZ0NodhUMrAEMbK/sTolkW3pA457I/23ge3JmQ1UebaQDSwwpi+YPngGQCDN7B/shQ+gW8qbMlyhd0vkvd5h7V9YTPcpdeYjHqKOveHLYO+c2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZND1W4jmjz9thB;
	Wed, 26 Mar 2025 18:14:55 +0100 (CET)
From: Remo Senekowitsch <remo@buenzli.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Rob Herring <robh@kernel.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Remo Senekowitsch <remo@buenzli.dev>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 04/10] rust: Add bindings for reading device properties
Date: Wed, 26 Mar 2025 18:13:43 +0100
Message-ID: <20250326171411.590681-5-remo@buenzli.dev>
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device property API is a firmware agnostic API for reading
properties from firmware (DT/ACPI) devices nodes and swnodes.

While the C API takes a pointer to a caller allocated variable/buffer,
the rust API is designed to return a value and can be used in struct
initialization. Rust generics are also utilized to support different
sizes of properties (e.g. u8, u16, u32).

Co-developed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 rust/kernel/property.rs | 153 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
index b0a4bb63a..4756ea766 100644
--- a/rust/kernel/property.rs
+++ b/rust/kernel/property.rs
@@ -4,9 +4,17 @@
 //!
 //! C header: [`include/linux/property.h`](srctree/include/linux/property.h)
 
-use core::ptr;
+use core::{ffi::c_void, mem::MaybeUninit, ptr};
 
-use crate::{bindings, device::Device, str::CStr, types::Opaque};
+use crate::{
+    alloc::KVec,
+    bindings,
+    device::Device,
+    error::{to_result, Result},
+    prelude::*,
+    str::{CStr, CString},
+    types::{Integer, Opaque},
+};
 
 impl Device {
     /// Obtain the fwnode corresponding to the device.
@@ -26,6 +34,41 @@ fn fwnode(&self) -> &FwNode {
     pub fn property_present(&self, name: &CStr) -> bool {
         self.fwnode().property_present(name)
     }
+
+    /// Returns if a firmware property `name` is true or false
+    pub fn property_read_bool(&self, name: &CStr) -> bool {
+        self.fwnode().property_read_bool(name)
+    }
+
+    /// Returns the index of matching string `match_str` for firmware string property `name`
+    pub fn property_read_string(&self, name: &CStr) -> Result<CString> {
+        self.fwnode().property_read_string(name)
+    }
+
+    /// Returns the index of matching string `match_str` for firmware string property `name`
+    pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usize> {
+        self.fwnode().property_match_string(name, match_str)
+    }
+
+    /// Returns firmware property `name` integer scalar value
+    pub fn property_read<T: Integer>(&self, name: &CStr) -> Result<T> {
+        self.fwnode().property_read(name)
+    }
+
+    /// Returns firmware property `name` integer array values
+    pub fn property_read_array<T: Integer, const N: usize>(&self, name: &CStr) -> Result<[T; N]> {
+        self.fwnode().property_read_array(name)
+    }
+
+    /// Returns firmware property `name` integer array values in a KVec
+    pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
+        self.fwnode().property_read_array_vec(name, len)
+    }
+
+    /// Returns integer array length for firmware property `name`
+    pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
+        self.fwnode().property_count_elem::<T>(name)
+    }
 }
 
 /// A reference-counted fwnode_handle.
@@ -57,6 +100,112 @@ pub fn property_present(&self, name: &CStr) -> bool {
         // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
         unsafe { bindings::fwnode_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
     }
+
+    /// Returns if a firmware property `name` is true or false
+    pub fn property_read_bool(&self, name: &CStr) -> bool {
+        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is valid
+        // because `self` is valid.
+        unsafe { bindings::fwnode_property_read_bool(self.as_raw(), name.as_char_ptr()) }
+    }
+
+    /// Returns the index of matching string `match_str` for firmware string property `name`
+    pub fn property_read_string(&self, name: &CStr) -> Result<CString> {
+        let mut str = core::ptr::null_mut();
+        let pstr: *mut _ = &mut str;
+
+        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is
+        // valid because `self` is valid.
+        let ret = unsafe {
+            bindings::fwnode_property_read_string(self.as_raw(), name.as_char_ptr(), pstr as _)
+        };
+        to_result(ret)?;
+
+        // SAFETY: `pstr` contains a non-null ptr on success
+        let str = unsafe { CStr::from_char_ptr(*pstr) };
+        Ok(str.try_into()?)
+    }
+
+    /// Returns the index of matching string `match_str` for firmware string property `name`
+    pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usize> {
+        // SAFETY: `name` and `match_str` are non-null and null-terminated. `self.as_raw` is
+        // valid because `self` is valid.
+        let ret = unsafe {
+            bindings::fwnode_property_match_string(
+                self.as_raw(),
+                name.as_char_ptr(),
+                match_str.as_char_ptr(),
+            )
+        };
+        to_result(ret)?;
+        Ok(ret as usize)
+    }
+
+    /// Returns firmware property `name` integer scalar value
+    pub fn property_read<T: Integer>(&self, name: &CStr) -> Result<T> {
+        let val: [_; 1] = Self::property_read_array(self, name)?;
+        Ok(val[0])
+    }
+
+    /// Returns firmware property `name` integer array values
+    pub fn property_read_array<T: Integer, const N: usize>(&self, name: &CStr) -> Result<[T; N]> {
+        let val: [MaybeUninit<T>; N] = [const { MaybeUninit::uninit() }; N];
+
+        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is valid
+        // because `self` is valid. `val.as_ptr` is valid because `val` is valid.
+        let ret = unsafe {
+            bindings::fwnode_property_read_int_array(
+                self.as_raw(),
+                name.as_char_ptr(),
+                T::SIZE as u32,
+                val.as_ptr() as *mut c_void,
+                val.len(),
+            )
+        };
+        to_result(ret)?;
+
+        // SAFETY: `val` is always initialized when
+        // fwnode_property_read_int_array is successful.
+        Ok(val.map(|v| unsafe { v.assume_init() }))
+    }
+
+    /// Returns firmware property `name` integer array values in a KVec
+    pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
+        let mut val: KVec<T> = KVec::with_capacity(len, GFP_KERNEL)?;
+
+        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is valid
+        // because `self` is valid. `val.as_ptr` is valid because `val` is valid.
+        to_result(unsafe {
+            bindings::fwnode_property_read_int_array(
+                self.as_raw(),
+                name.as_char_ptr(),
+                T::SIZE as u32,
+                val.as_ptr() as *mut c_void,
+                len,
+            )
+        })?;
+
+        // SAFETY: fwnode_property_read_int_array() writes exactly `len` entries on success
+        unsafe { val.set_len(len) }
+        Ok(val)
+    }
+
+    /// Returns integer array length for firmware property `name`
+    pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
+        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is valid
+        // because `self` is valid. Passing null pointer buffer is valid to obtain
+        // the number of elements in the property array.
+        let ret = unsafe {
+            bindings::fwnode_property_read_int_array(
+                self.as_raw(),
+                name.as_char_ptr(),
+                T::SIZE as u32,
+                ptr::null_mut(),
+                0,
+            )
+        };
+        to_result(ret)?;
+        Ok(ret as usize)
+    }
 }
 
 // SAFETY: Instances of `FwNode` are always reference-counted.
-- 
2.49.0


