Return-Path: <linux-acpi+bounces-14398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD4ADBA4D
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBCB170419
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89669289E3D;
	Mon, 16 Jun 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWhsitIG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D42288C0E;
	Mon, 16 Jun 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750103094; cv=none; b=cIFBl8hkgIl+u4Q4Lz2tn9BVAcFMEqJfzfUNRVXfl+LbOgB62O45HNURMQ/ThnHIzZPwv9yAy0TcOWvAg7LjpgmMKtETc0ZEL+90cWot9XLwlSkuWvpLohEICPDfimTYRC+zuijpErd5D3F9TzvYFaxAHlNxcSnMMigo6fhb3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750103094; c=relaxed/simple;
	bh=zcddzq/jaoCNyvRXu3ATje4IQQGcAABOvRGRXiVVJ7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txfMFBvkjqBcWIRhyb2gUqN2xvdlPvbZk8lKeGsfNyi46CgjPvve8EWGCBOJR1im6DwZaEjHKeGGWGE1fEKNTWigWS7BPpvOJShyL7ZM5QBx6QzJHRQaFTKMtVhzjbhZNyI7XjduDzWGn48CAOtILhsbbqKfwyf8yLtUsZ+UudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWhsitIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC60C4CEEA;
	Mon, 16 Jun 2025 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750103093;
	bh=zcddzq/jaoCNyvRXu3ATje4IQQGcAABOvRGRXiVVJ7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWhsitIGa0FpU1aIx1uoIhA8t0I9PSuU0+ox924JynJCGJ6Xp9N9GG122Do3SriZy
	 oTsNS/WjEWO+ZAyf/tN+vU69sfvHVZfnX84b3IKqN+qJT2ta0rPhLsynRwxqKECDJJ
	 k2kpN7POktZLXvSf42FzGKXsQbCaiw1hboTMsIsoevrLFO5fKQrO/V8MlSkKMDktpU
	 H1Z7T18c9UJQBAilnHrHdnyCK8/KxAnJhFaoouf6o65Dko+V1xrhMCdyk/yd7Gt+dO
	 o7OVJjNuu2oKhQHwvuOy9Vm/k8b/1CB2sAvY7Fy3kBlkNRGXkU60zvtouVSuASYK7U
	 +X9JeYoFlKVTA==
From: Danilo Krummrich <dakr@kernel.org>
To: igor.korotin.linux@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/3] rust: device: implement FwNode::is_compatible()
Date: Mon, 16 Jun 2025 21:40:19 +0200
Message-ID: <20250616194439.68775-1-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613135407.1233005-1-igor.korotin.linux@gmail.com>
References: <20250613135407.1233005-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement FwNode::is_compatible() to check whether a given match string
is compatible with a FwNode.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/property.c        | 6 ++++++
 rust/kernel/device/property.rs | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/rust/helpers/property.c b/rust/helpers/property.c
index 08f68e2dac4a..177b9ffd7ba4 100644
--- a/rust/helpers/property.c
+++ b/rust/helpers/property.c
@@ -6,3 +6,9 @@ void rust_helper_fwnode_handle_put(struct fwnode_handle *fwnode)
 {
 	fwnode_handle_put(fwnode);
 }
+
+bool rust_helper_fwnode_device_is_compatible(const struct fwnode_handle *fwnode,
+					     const char *match)
+{
+	return fwnode_device_is_compatible(fwnode, match);
+}
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 838509111e57..a946bf8d5571 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -93,6 +93,15 @@ pub fn property_present(&self, name: &CStr) -> bool {
         unsafe { bindings::fwnode_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
     }
 
+    /// Return `true` if this [`FwNode`] is compatible with `match_str`, `false` otherwise.
+    pub fn is_compatible(&self, match_str: &CStr) -> bool {
+        // SAFETY:
+        // - By the invariant of `CStr`, `name.as_char_ptr()` is valid and null-terminated.
+        // - The type invariant of `Self` guarantees that `self.as_raw() is a pointer to a valid
+        //   `struct fwnode_handle`.
+        unsafe { bindings::fwnode_device_is_compatible(self.as_raw(), match_str.as_char_ptr()) }
+    }
+
     /// Returns firmware property `name` boolean value.
     pub fn property_read_bool(&self, name: &CStr) -> bool {
         // SAFETY:

base-commit: 2a1ea59de83bf367215e2a4dd9bf8bbd061349b3
-- 
2.49.0


