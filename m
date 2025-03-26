Return-Path: <linux-acpi+bounces-12448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA4FA71CDA
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5092F3BACA6
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC5A1F8921;
	Wed, 26 Mar 2025 17:15:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F61E1E15;
	Wed, 26 Mar 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009321; cv=none; b=KjUybphXQHWGQrZyw5PFoWt/E4TF1CHcPVGhrHYb1aqN+ZZx0jsWYNaZbVi5kMqOFB97FJoFugPT/sSmDJqyOCkgdG8yex5ueD6FMZlNHZcNPiwc/QZnIPHsIxAQvCFkXczi4iFV3enqPysePlVbHN98WyGbt0W+YkOi+sZYeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009321; c=relaxed/simple;
	bh=aIm/JGb5KR23/j5XE+CLIq3kVoApEZuw53qSIlgtvmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa0F6JLG6tagPiyBtXEdYQmhzW/whm0B5G/me54fuwvW9ipzAg16V44gZW82gJXndhbNR/sP3vSCzjTv1ISlyj/cXFifCY9ptVPkSD0twJ7DJr9yl7iaeOo8oEoA30ZUBiy4IOKIAtoLZ+ib5fD2h7n57y9/ZGidIgFMwXF1V6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZND1p2XCfz9ssD;
	Wed, 26 Mar 2025 18:15:10 +0100 (CET)
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
Subject: [PATCH 08/10] rust: property: Add property_get_reference_args
Date: Wed, 26 Mar 2025 18:13:47 +0100
Message-ID: <20250326171411.590681-9-remo@buenzli.dev>
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
 rust/kernel/property.rs | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
index dc927ad93..f1d0a33ba 100644
--- a/rust/kernel/property.rs
+++ b/rust/kernel/property.rs
@@ -8,6 +8,7 @@
 
 use crate::{
     alloc::KVec,
+    arrayvec::ArrayVec,
     bindings,
     device::Device,
     error::{to_result, Result},
@@ -64,6 +65,20 @@ pub fn get_child_by_name(&self, name: &CStr) -> Option<ARef<FwNode>> {
     pub fn children<'a>(&'a self) -> impl Iterator<Item = ARef<FwNode>> + 'a {
         self.fwnode().children()
     }
+
+    /// Finds a reference with arguments.
+    pub fn property_get_reference_args(
+        &self,
+        prop: &CStr,
+        nargs: NArgs<'_>,
+        index: u32,
+    ) -> Result<(
+        ARef<FwNode>,
+        ArrayVec<{ bindings::NR_FWNODE_REFERENCE_ARGS as usize }, u64>,
+    )> {
+        self.fwnode()
+            .property_get_reference_args(prop, nargs, index)
+    }
 }
 
 /// A reference-counted fwnode_handle.
@@ -226,6 +241,45 @@ pub fn children<'a>(&'a self) -> impl Iterator<Item = ARef<FwNode>> + 'a {
             Some(next)
         })
     }
+
+    /// Finds a reference with arguments.
+    pub fn property_get_reference_args(
+        &self,
+        prop: &CStr,
+        nargs: NArgs<'_>,
+        index: u32,
+    ) -> Result<(
+        ARef<Self>,
+        ArrayVec<{ bindings::NR_FWNODE_REFERENCE_ARGS as usize }, u64>,
+    )> {
+        let mut out_args = bindings::fwnode_reference_args::default();
+
+        let (nargs_prop, nargs) = match nargs {
+            NArgs::Prop(nargs_prop) => (nargs_prop.as_char_ptr(), 0),
+            NArgs::N(nargs) => (ptr::null(), nargs),
+        };
+
+        let ret = unsafe {
+            bindings::fwnode_property_get_reference_args(
+                self.0.get(),
+                prop.as_char_ptr(),
+                nargs_prop,
+                nargs,
+                index,
+                &mut out_args,
+            )
+        };
+        to_result(ret)?;
+
+        let node = unsafe { FwNode::from_raw(out_args.fwnode) };
+        let mut args = ArrayVec::default();
+
+        for i in 0..out_args.nargs {
+            args.push(out_args.args[i as usize]);
+        }
+
+        Ok((node, args))
+    }
 }
 
 // SAFETY: Instances of `FwNode` are always reference-counted.
@@ -302,3 +356,12 @@ fn read(fwnode: &FwNode, name: &CStr) -> Result<T> {
         Ok(val[0])
     }
 }
+
+/// The number of arguments of a reference.
+pub enum NArgs<'a> {
+    /// The name of the property of the reference indicating the number of
+    /// arguments.
+    Prop(&'a CStr),
+    /// The known number of arguments.
+    N(u32),
+}
-- 
2.49.0


