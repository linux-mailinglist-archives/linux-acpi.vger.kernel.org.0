Return-Path: <linux-acpi+bounces-12451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F3A71D0C
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E14B16E73C
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311421507E;
	Wed, 26 Mar 2025 17:23:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02972202F93;
	Wed, 26 Mar 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009807; cv=none; b=olvEwnyS0GIfdoHej4j+/8/hygLy++V/voCKZdABy2jkgZHDFI1BkQ813TsoaIAsij/BJ4NW8/m3c6d/zfJSCrzfOs0Uzr0Rlmg/SccTMA4GR+BWIybIh1LWbIC/7UgPQqhVWglkt1n/sjJ1rXPwZfY3nLbTaDBaVdDAeHnjY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009807; c=relaxed/simple;
	bh=rs9bOE/ilaGLGVSwM1Ef1ijs+11j18W4WaeUmdZRUUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLZ9WzrwboipooHn3uO5C4vLkKyo+6ypxwPg5T+e2SdopmJq1WGhmCIMmnnRiqfCUu/gUfM6BbmEN721ExRatk3N244PuB6wZj0+Rv7IVPVKvu87rI0uEY6JcAuEJ9dUKOSywSX+uFAoKomHddXzrRN+cTO5mQojW9uH0prakaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZND1N0Jbqz9smk;
	Wed, 26 Mar 2025 18:14:48 +0100 (CET)
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
Subject: [PATCH 02/10] rust: Add an Integer trait
Date: Wed, 26 Mar 2025 18:13:41 +0100
Message-ID: <20250326171411.590681-3-remo@buenzli.dev>
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZND1N0Jbqz9smk

From: "Rob Herring (Arm)" <robh@kernel.org>

Add an "Integer" trait similar to crate::num::Integer. This is useful
for implementing generic methods which operate on different sizes of
integers. One example is reading DT/ACPI firmware properties.

This was originally proposed by Alice Ryhl[1].

[1] https://lore.kernel.org/rust-for-linux/CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com/

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 rust/kernel/types.rs | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2bbaab83b..21647b7ba 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -3,10 +3,11 @@
 //! Kernel types.
 
 use crate::init::{self, PinInit};
+use crate::transmute::{AsBytes, FromBytes};
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
-    mem::{ManuallyDrop, MaybeUninit},
+    mem::{size_of, ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
     ptr::NonNull,
 };
@@ -553,6 +554,25 @@ pub enum Either<L, R> {
     Right(R),
 }
 
+/// Trait defined for all integer types similar to `crate::num::Integer`
+pub trait Integer: FromBytes + AsBytes + Copy {
+    /// Size of the integer in bytes
+    const SIZE: usize;
+}
+
+macro_rules! impl_int {
+    ($($typ:ty),* $(,)?) => {$(
+        impl Integer for $typ {
+            const SIZE: usize = size_of::<Self>();
+        }
+    )*};
+}
+
+impl_int! {
+    u8, u16, u32, u64, usize,
+    i8, i16, i32, i64, isize,
+}
+
 /// Zero-sized type to mark types not [`Send`].
 ///
 /// Add this type as a field to your struct if your type should not be sent to a different task.
-- 
2.49.0


