Return-Path: <linux-acpi+bounces-12447-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39EA71CD6
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F48B3B7FD7
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4004B1F8BA6;
	Wed, 26 Mar 2025 17:15:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680981F891C;
	Wed, 26 Mar 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009312; cv=none; b=Z7z1Yultm3TycINNOVF/kpkU1N+gn3AqIxFctUk3LytdRoiVZ2+Tsgs+uFKSFoP432DyQnRQMTrnb4hSopG2hfBUdyZMbQgk4SPHhLgeZ8kLcN+BaL2zvj3e+fkZyfHTIVHk2BAwP4PqBzTdXKd2YsspSvOWo6XahBbTQrIyLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009312; c=relaxed/simple;
	bh=g3w3UNJdidUDKl+iR6KhiWQ5a6E0oggHsoN9a3L+pGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uV8nyO1P2clAZpibhdsCFYYOYWZEtalxms7peD/6fdOloSQtWczjCg40FRVh0gHeX97WJtGL0Dkl6wydrym1A9tCRHnDL2VkiBRR0OMwmICvjrUmYelFCaMM32T5mPrs0r1aUdnplFsQ+MU4tfnJj9eiUyXYBNNO+fMF7+NpOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZND1k25Crz9sc4;
	Wed, 26 Mar 2025 18:15:06 +0100 (CET)
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
Subject: [PATCH 07/10] rust: Add arrayvec
Date: Wed, 26 Mar 2025 18:13:46 +0100
Message-ID: <20250326171411.590681-8-remo@buenzli.dev>
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is basically a proof of concept intendend to gather feedback
about how to do this properly. Normally I would want to use the crate
from crates.io[1], but that's not an option in the kernel. We could also
vendor the entire source code of arrayvec. I'm not sure if people will
be happy with that.

[1] https://crates.io/crates/arrayvec

Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 rust/kernel/arrayvec.rs | 81 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs      |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 rust/kernel/arrayvec.rs

diff --git a/rust/kernel/arrayvec.rs b/rust/kernel/arrayvec.rs
new file mode 100644
index 000000000..041e7dcce
--- /dev/null
+++ b/rust/kernel/arrayvec.rs
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Provides [ArrayVec], a stack-allocated vector with static capacity.
+
+use core::mem::MaybeUninit;
+
+/// A stack-allocated vector with statically fixed capacity.
+///
+/// This can be useful to avoid heap allocation and still ensure safety where a
+/// small but dynamic number of elements is needed.
+///
+/// For example, consider a function that returns a variable number of values,
+/// but no more than 8. In C, one might achieve this by passing a pointer to
+/// a stack-allocated array as an out-parameter and making the function return
+/// the actual number of elements. This is not safe, because nothing prevents
+/// the caller from reading elements from the array that weren't actually
+/// initialized by the function. `ArrayVec` solves this problem, users are
+/// prevented from accessing uninitialized elements.
+///
+/// This basically exists already (in a much more mature form) on crates.io:
+/// <https://crates.io/crates/arrayvec>
+#[derive(Debug)]
+pub struct ArrayVec<const N: usize, T> {
+    array: [core::mem::MaybeUninit<T>; N],
+    len: usize,
+}
+
+impl<const N: usize, T> ArrayVec<N, T> {
+    /// Adds a new element to the end of the vector.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the vector is already full.
+    pub fn push(&mut self, elem: T) {
+        if self.len == N {
+            panic!("OOM")
+        }
+        self.array[self.len] = MaybeUninit::new(elem);
+        self.len += 1;
+    }
+
+    /// Returns the length of the vector.
+    pub fn len(&self) -> usize {
+        self.len
+    }
+}
+
+impl<const N: usize, T> Default for ArrayVec<N, T> {
+    fn default() -> Self {
+        Self {
+            array: [const { MaybeUninit::uninit() }; N],
+            len: 0,
+        }
+    }
+}
+
+impl<const N: usize, T> AsRef<[T]> for ArrayVec<N, T> {
+    fn as_ref(&self) -> &[T] {
+        // SAFETY: As per the type invariant, all elements at index < self.len
+        // are initialized.
+        unsafe { core::mem::transmute(&self.array[..self.len]) }
+    }
+}
+
+impl<const N: usize, T> AsMut<[T]> for ArrayVec<N, T> {
+    fn as_mut(&mut self) -> &mut [T] {
+        // SAFETY: As per the type invariant, all elements at index < self.len
+        // are initialized.
+        unsafe { core::mem::transmute(&mut self.array[..self.len]) }
+    }
+}
+
+impl<const N: usize, T> Drop for ArrayVec<N, T> {
+    fn drop(&mut self) {
+        unsafe {
+            let slice: &mut [T] =
+                core::slice::from_raw_parts_mut(self.array.as_mut_ptr().cast(), self.len);
+            core::ptr::drop_in_place(slice);
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ca233fd20..0777f7a42 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub use ffi;
 
 pub mod alloc;
+pub mod arrayvec;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 #[doc(hidden)]
-- 
2.49.0


