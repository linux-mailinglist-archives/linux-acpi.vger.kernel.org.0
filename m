Return-Path: <linux-acpi+bounces-12442-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD613A71CD2
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE65189C1F3
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E921F91F4;
	Wed, 26 Mar 2025 17:14:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB9191461;
	Wed, 26 Mar 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009290; cv=none; b=RpWNkoKWA7IR5NrlFqbiPVXmMf14i53Ob+C3cz1XBGieKtZRg2XMCkfN+nEvMnK4DRE56r8GItdpIuy7eqw4SbLFxvDu/YNBGeIkZA8v0lG3gZ1Z1MTx4ZIPrxYPY3W41K0e1Gu49NnaCk+E7qtR0WSf4y0F5EEYa+Uu92u6db8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009290; c=relaxed/simple;
	bh=Tw/2+nSVi9h/5nQCeDcX0MAEOnDWfwqXhh3Hxy0trxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXyr3RN1y2C3XPaR/yGVNdUSVvPKWbdQeHG6098Vx40jeZADEuqzQUSSti9aOYYXXyaEC21pbXK3Z7B5DPKopRt0ekRXO9dMjwW4/sGZx+kjnSPww5SPSTQlB2iTEzmZ4GmeC1gYY+djVnWxhsmsIqWRHB+YyQm0L0Nfe39TDuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZND1J2ls7z9sc4;
	Wed, 26 Mar 2025 18:14:44 +0100 (CET)
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
Subject: [PATCH 01/10] rust: Move property_present to property.rs
Date: Wed, 26 Mar 2025 18:13:40 +0100
Message-ID: <20250326171411.590681-2-remo@buenzli.dev>
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZND1J2ls7z9sc4

Not all property-related APIs can be exposed directly on a device.
For example, iterating over child nodes of a device will yield
fwnode_handle. Thus, in order to access properties on these child nodes,
the APIs has to be duplicated on a fwnode as they are in C.

A related discussion can be found on the R4L Zulip[1].

[1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/DS90UB954.20driver.20done.2C.20ready.20to.20upstream.3F/near/505415697

Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 rust/helpers/helpers.c  |  1 +
 rust/helpers/property.c | 13 ++++++++
 rust/kernel/device.rs   |  7 ----
 rust/kernel/lib.rs      |  1 +
 rust/kernel/property.rs | 73 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 7 deletions(-)
 create mode 100644 rust/helpers/property.c
 create mode 100644 rust/kernel/property.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e11..b4eec5bf2 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -23,6 +23,7 @@
 #include "platform.c"
 #include "pci.c"
 #include "pid_namespace.c"
+#include "property.c"
 #include "rbtree.c"
 #include "rcu.c"
 #include "refcount.c"
diff --git a/rust/helpers/property.c b/rust/helpers/property.c
new file mode 100644
index 000000000..c37c74488
--- /dev/null
+++ b/rust/helpers/property.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/property.h>
+
+struct fwnode_handle *rust_helper_dev_fwnode(struct device *dev)
+{
+	return dev_fwnode(dev);
+}
+
+void rust_helper_fwnode_handle_put(struct fwnode_handle *fwnode)
+{
+	fwnode_handle_put(fwnode);
+}
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index db2d9658b..d5e6a19ff 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,7 +6,6 @@
 
 use crate::{
     bindings,
-    str::CStr,
     types::{ARef, Opaque},
 };
 use core::{fmt, ptr};
@@ -181,12 +180,6 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             )
         };
     }
-
-    /// Checks if property is present or not.
-    pub fn property_present(&self, name: &CStr) -> bool {
-        // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
-        unsafe { bindings::device_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
-    }
 }
 
 // SAFETY: Instances of `Device` are always reference-counted.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0..ca233fd20 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -67,6 +67,7 @@
 pub mod platform;
 pub mod prelude;
 pub mod print;
+pub mod property;
 pub mod rbtree;
 pub mod revocable;
 pub mod security;
diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
new file mode 100644
index 000000000..b0a4bb63a
--- /dev/null
+++ b/rust/kernel/property.rs
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Unified device property interface.
+//!
+//! C header: [`include/linux/property.h`](srctree/include/linux/property.h)
+
+use core::ptr;
+
+use crate::{bindings, device::Device, str::CStr, types::Opaque};
+
+impl Device {
+    /// Obtain the fwnode corresponding to the device.
+    fn fwnode(&self) -> &FwNode {
+        // SAFETY: `self` is valid.
+        let fwnode_handle = unsafe { bindings::dev_fwnode(self.as_raw()) };
+        if fwnode_handle.is_null() {
+            panic!("fwnode_handle cannot be null");
+        }
+        // SAFETY: `fwnode_handle` is valid. Its lifetime is tied to `&self`. We
+        // return a reference instead of an `ARef<FwNode>` because `dev_fwnode()`
+        // doesn't increment the refcount.
+        unsafe { &*fwnode_handle.cast() }
+    }
+
+    /// Checks if property is present or not.
+    pub fn property_present(&self, name: &CStr) -> bool {
+        self.fwnode().property_present(name)
+    }
+}
+
+/// A reference-counted fwnode_handle.
+///
+/// This structure represents the Rust abstraction for a
+/// C `struct fwnode_handle`. This implementation abstracts the usage of an
+/// already existing C `struct fwnode_handle` within Rust code that we get
+/// passed from the C side.
+///
+/// # Invariants
+///
+/// A `FwNode` instance represents a valid `struct fwnode_handle` created by the
+/// C portion of the kernel.
+///
+/// Instances of this type are always reference-counted, that is, a call to
+/// `fwnode_handle_get` ensures that the allocation remains valid at least until
+/// the matching call to `fwnode_handle_put`.
+#[repr(transparent)]
+pub struct FwNode(Opaque<bindings::fwnode_handle>);
+
+impl FwNode {
+    /// Obtain the raw `struct fwnode_handle *`.
+    pub(crate) fn as_raw(&self) -> *mut bindings::fwnode_handle {
+        self.0.get()
+    }
+
+    /// Checks if property is present or not.
+    pub fn property_present(&self, name: &CStr) -> bool {
+        // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
+        unsafe { bindings::fwnode_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
+    }
+}
+
+// SAFETY: Instances of `FwNode` are always reference-counted.
+unsafe impl crate::types::AlwaysRefCounted for FwNode {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::fwnode_handle_get(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::fwnode_handle_put(obj.cast().as_ptr()) }
+    }
+}
-- 
2.49.0


