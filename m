Return-Path: <linux-acpi+bounces-12450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D317A71CE2
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B763BDAB3
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE01FF1AD;
	Wed, 26 Mar 2025 17:15:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7321FECC2;
	Wed, 26 Mar 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009325; cv=none; b=p0IRSoqBVz4QacW+WXVLuh6HJK/f2n/ymwR995PvB0iZQsleSdHVdsVfC6vg+Sx0fxwfkvopKcHS2tk+iQ2E0zZTx5SOjeUBW+01jJE79EIFYdZRmjlWpQAus9nKrPCmARbp6S+JJd9aXhqw42l4obGV2ihQl3yLmr38VH4+suw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009325; c=relaxed/simple;
	bh=s56M1HA3ha2K/OQmzA+ilqI8odqNZ9uJMiyFYK8oGPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpnIlmwthZgwYdTYUGQ+rXNOIzQJJiUcTjaSKt7zGAiI5HRnF4DMmCvyTRSXgGfNOkcEE/30pggeik1O2u5eNxFQhJGu7FfSuYMcoQJYrbY1q0YqAmTa7mBqlPhVkdXsBR9p/ggV3jLUWp9cJmenxOiAueKjf8sKDhWbzwvr7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZND1s6nVHz9tFH;
	Wed, 26 Mar 2025 18:15:13 +0100 (CET)
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
Subject: [PATCH 09/10] rust: property: Add PropertyGuard
Date: Wed, 26 Mar 2025 18:13:48 +0100
Message-ID: <20250326171411.590681-10-remo@buenzli.dev>
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZND1s6nVHz9tFH

Forcing users to specify whether a property is supposed to be required
or not allows us to move error logging of missing required properties
into core, preventing a lot of boilerplate in drivers.

Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 rust/kernel/property.rs | 146 ++++++++++++++++++++++++++++++++++------
 1 file changed, 127 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
index f1d0a33ba..e4f0e5f97 100644
--- a/rust/kernel/property.rs
+++ b/rust/kernel/property.rs
@@ -42,7 +42,11 @@ pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usi
     }
 
     /// Returns firmware property `name` integer array values in a KVec
-    pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
+    pub fn property_read_array_vec<'fwnode, 'name, T: Integer>(
+        &'fwnode self,
+        name: &'name CStr,
+        len: usize,
+    ) -> Result<PropertyGuard<'fwnode, 'name, KVec<T>>> {
         self.fwnode().property_read_array_vec(name, len)
     }
 
@@ -52,12 +56,18 @@ pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
     }
 
     /// Returns firmware property `name` integer scalar value
-    pub fn property_read<T: Property>(&self, name: &CStr) -> Result<T> {
+    pub fn property_read<'fwnode, 'name, T: Property>(
+        &'fwnode self,
+        name: &'name CStr,
+    ) -> PropertyGuard<'fwnode, 'name, T> {
         self.fwnode().property_read(name)
     }
 
     /// Returns first matching named child node handle.
-    pub fn get_child_by_name(&self, name: &CStr) -> Option<ARef<FwNode>> {
+    pub fn get_child_by_name<'fwnode, 'name>(
+        &'fwnode self,
+        name: &'name CStr,
+    ) -> PropertyGuard<'fwnode, 'name, ARef<FwNode>> {
         self.fwnode().get_child_by_name(name)
     }
 
@@ -132,12 +142,16 @@ pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usi
     }
 
     /// Returns firmware property `name` integer array values in a KVec
-    pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
+    pub fn property_read_array_vec<'fwnode, 'name, T: Integer>(
+        &'fwnode self,
+        name: &'name CStr,
+        len: usize,
+    ) -> Result<PropertyGuard<'fwnode, 'name, KVec<T>>> {
         let mut val: KVec<T> = KVec::with_capacity(len, GFP_KERNEL)?;
 
         // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is valid
         // because `self` is valid. `val.as_ptr` is valid because `val` is valid.
-        to_result(unsafe {
+        let err = unsafe {
             bindings::fwnode_property_read_int_array(
                 self.as_raw(),
                 name.as_char_ptr(),
@@ -145,11 +159,19 @@ pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Re
                 val.as_ptr() as *mut c_void,
                 len,
             )
-        })?;
-
-        // SAFETY: fwnode_property_read_int_array() writes exactly `len` entries on success
-        unsafe { val.set_len(len) }
-        Ok(val)
+        };
+        let res = if err < 0 {
+            Err(Error::from_errno(err))
+        } else {
+            // SAFETY: fwnode_property_read_int_array() writes exactly `len` entries on success
+            unsafe { val.set_len(len) }
+            Ok(val)
+        };
+        Ok(PropertyGuard {
+            inner: res,
+            fwnode: self,
+            name,
+        })
     }
 
     /// Returns integer array length for firmware property `name`
@@ -194,24 +216,42 @@ pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
     /// # use crate::{device::Device, types::CString};
     /// fn examples(dev: &Device) -> Result {
     ///     let fwnode = dev.fwnode();
-    ///     let b: bool = fwnode.property_read("some-bool")?;
-    ///     let s: CString = fwnode.property_read("some-str")?;
+    ///     let b: bool = fwnode.property_read("some-bool").required()?;
+    ///     if let Some(s) = fwnode.property_read::<CString>("some-str").optional() {
+    ///         // ...
+    ///     }
     /// }
     /// ```
-    pub fn property_read<T: Property>(&self, name: &CStr) -> Result<T> {
-        T::read(&self, name)
+    pub fn property_read<'fwnode, 'name, T: Property>(
+        &'fwnode self,
+        name: &'name CStr,
+    ) -> PropertyGuard<'fwnode, 'name, T> {
+        PropertyGuard {
+            inner: T::read(&self, name),
+            fwnode: self,
+            name,
+        }
     }
 
     /// Returns first matching named child node handle.
-    pub fn get_child_by_name(&self, name: &CStr) -> Option<ARef<Self>> {
+    pub fn get_child_by_name<'fwnode, 'name>(
+        &'fwnode self,
+        name: &'name CStr,
+    ) -> PropertyGuard<'fwnode, 'name, ARef<Self>> {
         // SAFETY: `self` and `name` are valid.
         let child =
             unsafe { bindings::fwnode_get_named_child_node(self.as_raw(), name.as_char_ptr()) };
-        if child.is_null() {
-            return None;
+        let res = if child.is_null() {
+            Err(ENOENT)
+        } else {
+            // SAFETY: `fwnode_get_named_child_node` returns a pointer with refcount incremented.
+            Ok(unsafe { Self::from_raw(child) })
+        };
+        PropertyGuard {
+            inner: res,
+            fwnode: self,
+            name,
         }
-        // SAFETY: `fwnode_get_named_child_node` returns a pointer with refcount incremented.
-        Some(unsafe { Self::from_raw(child) })
     }
 
     /// Returns an iterator over a node's children.
@@ -365,3 +405,71 @@ pub enum NArgs<'a> {
     /// The known number of arguments.
     N(u32),
 }
+
+/// A helper for reading device properties.
+///
+/// Use [Self::required] if a missing property is considered a bug and
+/// [Self::optional] otherwise.
+///
+/// For convenience, [Self::or] and [Self::or_default] are provided.
+pub struct PropertyGuard<'fwnode, 'name, T> {
+    /// The result of reading the property.
+    inner: Result<T>,
+    /// The fwnode of the property, used for logging in the "required" case.
+    fwnode: &'fwnode FwNode,
+    /// The name of the property, used for logging in the "required" case.
+    name: &'name CStr,
+}
+
+impl<T> PropertyGuard<'_, '_, T> {
+    /// Access the property, indicating it is required.
+    ///
+    /// If the property is not present, the error is automatically logged. If a
+    /// missing property is not an error, use [Self::optional] instead.
+    pub fn required(self) -> Result<T> {
+        if self.inner.is_err() {
+            // Get the device associated with the fwnode for device-associated
+            // logging.
+            // TODO: Are we allowed to do this? The field `fwnode_handle.dev`
+            // has a somewhat vague comment, which could mean we're not
+            // supposed to access it:
+            // https://elixir.bootlin.com/linux/v6.13.6/source/include/linux/fwnode.h#L51
+            // SAFETY: According to the invariant of FwNode, it is valid.
+            let dev = unsafe { (*self.fwnode.as_raw()).dev };
+
+            if dev.is_null() {
+                pr_err!("property '{}' is missing\n", self.name);
+            } else {
+                // SAFETY: If dev is not null, it points to a valid device.
+                let dev: &Device = unsafe { &*dev.cast() };
+                dev_err!(dev, "property '{}' is missing\n", self.name);
+            };
+        }
+        self.inner
+    }
+
+    /// Access the property, indicating it is optional.
+    ///
+    /// In contrast to [Self::required], no error message is logged if the
+    /// property is not present.
+    pub fn optional(self) -> Option<T> {
+        self.inner.ok()
+    }
+
+    /// Access the property or the specified default value.
+    ///
+    /// Do not pass a sentinel value as default to detect a missing property.
+    /// Use [Self::required] or [Self::optional] instead.
+    pub fn or(self, default: T) -> T {
+        self.inner.unwrap_or(default)
+    }
+}
+
+impl<T: Default> PropertyGuard<'_, '_, T> {
+    /// Access the property or a default value.
+    ///
+    /// Use [Self::or] to specify a custom default value.
+    pub fn or_default(self) -> T {
+        self.inner.unwrap_or_default()
+    }
+}
-- 
2.49.0


