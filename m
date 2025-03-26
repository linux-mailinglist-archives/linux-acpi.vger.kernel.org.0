Return-Path: <linux-acpi+bounces-12444-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E819A71CD3
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EAE173936
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64EF1FBCAF;
	Wed, 26 Mar 2025 17:15:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30AA191461;
	Wed, 26 Mar 2025 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009304; cv=none; b=QNyoc2DTwMcUhWNDVwjMF2htPIxZk+n5jfg56Kdcg9GlLBjfRxbI0Xss3WZxelVU3gbxs/EPdIBZp3+6BBEUCuFhtwjUHvzw3mZ7A/1UND/HXa95wCJclyTEAaBFkeitnjZUFsIyi+5QXxz554pltPmougN1uCYEvw158/IKv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009304; c=relaxed/simple;
	bh=JKX2V1B64mbQVg8EwAHLfQBMzztwg14JNlI2w/Y5OSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yg0hE1x2TyqlrvUEQF8QklykPuCb0JYbVTG/CzGtv5Rj33XewfQPo+n1A51TnxGpMu8g9ny5aIXi4uYvYtZdj+xCpLK/oRyXS2uokoCcdyCKkoD8at9A0sHrfrRMNboYhNA3sKA6Ha5otSyz7IAciflHuB2Y0JZRvNBYfIV1vKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZND1Z6Jd4z9v5v;
	Wed, 26 Mar 2025 18:14:58 +0100 (CET)
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
Subject: [PATCH 05/10] rust: Read properties via single generic method
Date: Wed, 26 Mar 2025 18:13:44 +0100
Message-ID: <20250326171411.590681-6-remo@buenzli.dev>
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This can probably be squashed into its parent. I haven't done that
yet in case there is something wrong with the generic approach and the
previous one is preferred.

Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 rust/kernel/property.rs | 171 +++++++++++++++++++++++-----------------
 1 file changed, 99 insertions(+), 72 deletions(-)

diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
index 4756ea766..4a03008ce 100644
--- a/rust/kernel/property.rs
+++ b/rust/kernel/property.rs
@@ -35,31 +35,11 @@ pub fn property_present(&self, name: &CStr) -> bool {
         self.fwnode().property_present(name)
     }
 
-    /// Returns if a firmware property `name` is true or false
-    pub fn property_read_bool(&self, name: &CStr) -> bool {
-        self.fwnode().property_read_bool(name)
-    }
-
-    /// Returns the index of matching string `match_str` for firmware string property `name`
-    pub fn property_read_string(&self, name: &CStr) -> Result<CString> {
-        self.fwnode().property_read_string(name)
-    }
-
     /// Returns the index of matching string `match_str` for firmware string property `name`
     pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usize> {
         self.fwnode().property_match_string(name, match_str)
     }
 
-    /// Returns firmware property `name` integer scalar value
-    pub fn property_read<T: Integer>(&self, name: &CStr) -> Result<T> {
-        self.fwnode().property_read(name)
-    }
-
-    /// Returns firmware property `name` integer array values
-    pub fn property_read_array<T: Integer, const N: usize>(&self, name: &CStr) -> Result<[T; N]> {
-        self.fwnode().property_read_array(name)
-    }
-
     /// Returns firmware property `name` integer array values in a KVec
     pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
         self.fwnode().property_read_array_vec(name, len)
@@ -69,6 +49,11 @@ pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Re
     pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
         self.fwnode().property_count_elem::<T>(name)
     }
+
+    /// Returns firmware property `name` integer scalar value
+    pub fn property_read<T: Property>(&self, name: &CStr) -> Result<T> {
+        self.fwnode().property_read(name)
+    }
 }
 
 /// A reference-counted fwnode_handle.
@@ -101,30 +86,6 @@ pub fn property_present(&self, name: &CStr) -> bool {
         unsafe { bindings::fwnode_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
     }
 
-    /// Returns if a firmware property `name` is true or false
-    pub fn property_read_bool(&self, name: &CStr) -> bool {
-        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is valid
-        // because `self` is valid.
-        unsafe { bindings::fwnode_property_read_bool(self.as_raw(), name.as_char_ptr()) }
-    }
-
-    /// Returns the index of matching string `match_str` for firmware string property `name`
-    pub fn property_read_string(&self, name: &CStr) -> Result<CString> {
-        let mut str = core::ptr::null_mut();
-        let pstr: *mut _ = &mut str;
-
-        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is
-        // valid because `self` is valid.
-        let ret = unsafe {
-            bindings::fwnode_property_read_string(self.as_raw(), name.as_char_ptr(), pstr as _)
-        };
-        to_result(ret)?;
-
-        // SAFETY: `pstr` contains a non-null ptr on success
-        let str = unsafe { CStr::from_char_ptr(*pstr) };
-        Ok(str.try_into()?)
-    }
-
     /// Returns the index of matching string `match_str` for firmware string property `name`
     pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usize> {
         // SAFETY: `name` and `match_str` are non-null and null-terminated. `self.as_raw` is
@@ -140,34 +101,6 @@ pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usi
         Ok(ret as usize)
     }
 
-    /// Returns firmware property `name` integer scalar value
-    pub fn property_read<T: Integer>(&self, name: &CStr) -> Result<T> {
-        let val: [_; 1] = Self::property_read_array(self, name)?;
-        Ok(val[0])
-    }
-
-    /// Returns firmware property `name` integer array values
-    pub fn property_read_array<T: Integer, const N: usize>(&self, name: &CStr) -> Result<[T; N]> {
-        let val: [MaybeUninit<T>; N] = [const { MaybeUninit::uninit() }; N];
-
-        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is valid
-        // because `self` is valid. `val.as_ptr` is valid because `val` is valid.
-        let ret = unsafe {
-            bindings::fwnode_property_read_int_array(
-                self.as_raw(),
-                name.as_char_ptr(),
-                T::SIZE as u32,
-                val.as_ptr() as *mut c_void,
-                val.len(),
-            )
-        };
-        to_result(ret)?;
-
-        // SAFETY: `val` is always initialized when
-        // fwnode_property_read_int_array is successful.
-        Ok(val.map(|v| unsafe { v.assume_init() }))
-    }
-
     /// Returns firmware property `name` integer array values in a KVec
     pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
         let mut val: KVec<T> = KVec::with_capacity(len, GFP_KERNEL)?;
@@ -206,6 +139,38 @@ pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
         to_result(ret)?;
         Ok(ret as usize)
     }
+
+    /// Returns the value of firmware property `name`.
+    ///
+    /// This method is generic over the type of value to read. Informally,
+    /// the types that can be read are booleans, strings, integers and arrays
+    /// of integers.
+    ///
+    /// Reading a `KVec` of integers is done with the
+    /// separate method [Self::property_read_array_vec], because it takes an
+    /// additional `len` argument.
+    ///
+    /// When reading a boolean, this method never fails. A missing property
+    /// is interpreted as `false`, whereas a present property is interpreted
+    /// as `true`.
+    ///
+    /// For more precise documentation about what types can be read, see
+    /// the [implementors of Property][Property#implementors] and [its
+    /// implementations on foreign types][Property#foreign-impls].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use crate::{device::Device, types::CString};
+    /// fn examples(dev: &Device) -> Result {
+    ///     let fwnode = dev.fwnode();
+    ///     let b: bool = fwnode.property_read("some-bool")?;
+    ///     let s: CString = fwnode.property_read("some-str")?;
+    /// }
+    /// ```
+    pub fn property_read<T: Property>(&self, name: &CStr) -> Result<T> {
+        T::read(&self, name)
+    }
 }
 
 // SAFETY: Instances of `FwNode` are always reference-counted.
@@ -220,3 +185,65 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         unsafe { bindings::fwnode_handle_put(obj.cast().as_ptr()) }
     }
 }
+
+/// Implemented for all types that can be read as properties.
+///
+/// This is used to make [FwNode::property_read] generic over the type of
+/// property being read.
+pub trait Property: Sized {
+    /// Used to make [FwNode::property_read] generic.
+    fn read(fwnode: &FwNode, name: &CStr) -> Result<Self>;
+}
+
+impl Property for bool {
+    fn read(fwnode: &FwNode, name: &CStr) -> Result<Self> {
+        // SAFETY: `name` is non-null and null-terminated. `fwnode.as_raw` is valid
+        // because `fwnode` is valid.
+        Ok(unsafe { bindings::fwnode_property_read_bool(fwnode.as_raw(), name.as_char_ptr()) })
+    }
+}
+impl Property for CString {
+    fn read(fwnode: &FwNode, name: &CStr) -> Result<Self> {
+        let mut str: *mut u8 = ptr::null_mut();
+        let pstr: *mut _ = &mut str;
+
+        // SAFETY: `name` is non-null and null-terminated. `fwnode.as_raw` is
+        // valid because `fwnode` is valid.
+        let ret = unsafe {
+            bindings::fwnode_property_read_string(fwnode.as_raw(), name.as_char_ptr(), pstr.cast())
+        };
+        to_result(ret)?;
+
+        // SAFETY: `pstr` contains a non-null ptr on success
+        let str = unsafe { CStr::from_char_ptr(*pstr) };
+        Ok(str.try_into()?)
+    }
+}
+impl<T: Integer, const N: usize> Property for [T; N] {
+    fn read(fwnode: &FwNode, name: &CStr) -> Result<Self> {
+        let mut val: [MaybeUninit<T>; N] = [const { MaybeUninit::uninit() }; N];
+
+        // SAFETY: `name` is non-null and null-terminated. `fwnode.as_raw` is valid
+        // because `fwnode` is valid. `val.as_ptr` is valid because `val` is valid.
+        let ret = unsafe {
+            bindings::fwnode_property_read_int_array(
+                fwnode.as_raw(),
+                name.as_char_ptr(),
+                T::SIZE as u32,
+                val.as_mut_ptr().cast(),
+                val.len(),
+            )
+        };
+        to_result(ret)?;
+
+        // SAFETY: `val` is always initialized when
+        // fwnode_property_read_int_array is successful.
+        Ok(val.map(|v| unsafe { v.assume_init() }))
+    }
+}
+impl<T: Integer> Property for T {
+    fn read(fwnode: &FwNode, name: &CStr) -> Result<T> {
+        let val: [_; 1] = <[T; 1] as Property>::read(fwnode, name)?;
+        Ok(val[0])
+    }
+}
-- 
2.49.0


