Return-Path: <linux-acpi+bounces-12446-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C791A71CE1
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90D7189BAD3
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA951FCFC2;
	Wed, 26 Mar 2025 17:15:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D61F91C7;
	Wed, 26 Mar 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009307; cv=none; b=OTFyzo56dmtg1T9Io4UPYZLigFCVC2yMMcG/2z9EVZwbSkhhPPKgj4mNzUwQsRTPZ1Yvgkevnbao96xKQisq3glPgI0/ucjO+s1XaVxR1jOyofrf6+oEgCn6uSplwVRSESw7T/cwgjWZy4N+xnLrpbCQ7iitRZ4C5WSmrNGPocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009307; c=relaxed/simple;
	bh=8ycTyKAu8Ysd62/+z/c9faBury4UhlNST+28a4jGdGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9Cq8EsYtivW5oPc9FEaYRROLtp6Cgv0rrr/LJBnU+kA7z5cQCJV/xWpM2vBMzkJ5nHurwwZq6BJcCDOP1pehd2nxF89GZsUrsV7vPR1R2nnOhYbiH0wrU3AXCGudpg3TExZdFmBnP86wtkpPN2dWEe0tvWHdoAfl42z7b2O0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZND1f4Mnjz9tct;
	Wed, 26 Mar 2025 18:15:02 +0100 (CET)
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
Subject: [PATCH 06/10] rust: property: Add child accessor and iterator
Date: Wed, 26 Mar 2025 18:13:45 +0100
Message-ID: <20250326171411.590681-7-remo@buenzli.dev>
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 rust/kernel/property.rs | 57 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
index 4a03008ce..dc927ad93 100644
--- a/rust/kernel/property.rs
+++ b/rust/kernel/property.rs
@@ -13,7 +13,7 @@
     error::{to_result, Result},
     prelude::*,
     str::{CStr, CString},
-    types::{Integer, Opaque},
+    types::{ARef, Integer, Opaque},
 };
 
 impl Device {
@@ -54,6 +54,16 @@ pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
     pub fn property_read<T: Property>(&self, name: &CStr) -> Result<T> {
         self.fwnode().property_read(name)
     }
+
+    /// Returns first matching named child node handle.
+    pub fn get_child_by_name(&self, name: &CStr) -> Option<ARef<FwNode>> {
+        self.fwnode().get_child_by_name(name)
+    }
+
+    /// Returns an iterator over a node's children.
+    pub fn children<'a>(&'a self) -> impl Iterator<Item = ARef<FwNode>> + 'a {
+        self.fwnode().children()
+    }
 }
 
 /// A reference-counted fwnode_handle.
@@ -75,6 +85,11 @@ pub fn property_read<T: Property>(&self, name: &CStr) -> Result<T> {
 pub struct FwNode(Opaque<bindings::fwnode_handle>);
 
 impl FwNode {
+    // SAFETY: `raw` must have its refcount incremented.
+    unsafe fn from_raw(raw: *mut bindings::fwnode_handle) -> ARef<Self> {
+        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(raw.cast())) }
+    }
+
     /// Obtain the raw `struct fwnode_handle *`.
     pub(crate) fn as_raw(&self) -> *mut bindings::fwnode_handle {
         self.0.get()
@@ -171,6 +186,46 @@ pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
     pub fn property_read<T: Property>(&self, name: &CStr) -> Result<T> {
         T::read(&self, name)
     }
+
+    /// Returns first matching named child node handle.
+    pub fn get_child_by_name(&self, name: &CStr) -> Option<ARef<Self>> {
+        // SAFETY: `self` and `name` are valid.
+        let child =
+            unsafe { bindings::fwnode_get_named_child_node(self.as_raw(), name.as_char_ptr()) };
+        if child.is_null() {
+            return None;
+        }
+        // SAFETY: `fwnode_get_named_child_node` returns a pointer with refcount incremented.
+        Some(unsafe { Self::from_raw(child) })
+    }
+
+    /// Returns an iterator over a node's children.
+    pub fn children<'a>(&'a self) -> impl Iterator<Item = ARef<FwNode>> + 'a {
+        let mut prev: Option<ARef<FwNode>> = None;
+
+        core::iter::from_fn(move || {
+            let prev_ptr = match prev.take() {
+                None => ptr::null_mut(),
+                Some(prev) => {
+                    // We will pass `prev` to `fwnode_get_next_child_node`,
+                    // which decrements its refcount, so we use
+                    // `ARef::into_raw` to avoid decrementing the refcount
+                    // twice.
+                    let prev = ARef::into_raw(prev);
+                    prev.as_ptr().cast()
+                }
+            };
+            let next = unsafe { bindings::fwnode_get_next_child_node(self.as_raw(), prev_ptr) };
+            if next.is_null() {
+                return None;
+            }
+            // SAFETY: `fwnode_get_next_child_node` returns a pointer with
+            // refcount incremented.
+            let next = unsafe { FwNode::from_raw(next) };
+            prev = Some(next.clone());
+            Some(next)
+        })
+    }
 }
 
 // SAFETY: Instances of `FwNode` are always reference-counted.
-- 
2.49.0


