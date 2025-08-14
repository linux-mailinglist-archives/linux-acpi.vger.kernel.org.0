Return-Path: <linux-acpi+bounces-15672-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E1B2613F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDE95802A5
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC3303CB0;
	Thu, 14 Aug 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClexRkY9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3E303CAB;
	Thu, 14 Aug 2025 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163907; cv=none; b=UsrDN4bIDxuX7hhhNRkL1k9UL7Yk7BJeFp2ZzQm1RLpBMA+fomvauppm5/6ACNr9tpczinMxZAe/H9f/NMj+oM2bUIsRFgUP+pbLIYej0Zqji4iIACDeozXii6FUkC3DFoLvkibDOSP8yXiVy1w6jXAyGQ/I2vMjF9EuMmx1T04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163907; c=relaxed/simple;
	bh=KU8iCPwOBksDO7Sd3iDRD2on8k7W4YiXdZipzP3STXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jU0uFq4+LUp4zPYiovgKeoSGeCeuqZe+GTc+wvWYHQ0H9+BKk2ItfnqPXYtflck6J+uySRb72fgb/uRoZpHkP4fdQwB13yTbtA6B/WWWQlXfsgc/IllaSK49MuujUKF3jKNJCuKF00x00NGHK18HpY58Oo2jUyPlBAnZUja5RS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClexRkY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06397C4CEF1;
	Thu, 14 Aug 2025 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163907;
	bh=KU8iCPwOBksDO7Sd3iDRD2on8k7W4YiXdZipzP3STXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClexRkY9V6MGiVefVjvEicea1kMdZiPoA5yMywBPlX3UHH2B+SP6rUWndbLKJyKYb
	 ZzXqK9yG0gVw79md48fk4zSskDhpsKLdHSf5sEwmSz2AClWY9PzLovxxNRnoRdC7Bg
	 OGaqqcKdcTb/2VzuMfc9AuvW3m/p45dgot1fLnq/U5MdZItWJVHhJ4CdcD+AJy0q4p
	 Z3krhLk0tJF0vPRDH0v5yYuEW4scpANbwxd8as86ODgqQPN5Lt377VdiVx9yBfJNjU
	 fGtmNNiWeTV3RmlVAPCKoRgv9DMB2rLyNKrBD9mkivH3bJw9/wOGan5tejGI46k9ES
	 k76D8aoTzyQWg==
From: Benno Lossin <lossin@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] rust: acpi: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Thu, 14 Aug 2025 11:30:37 +0200
Message-ID: <20250814093046.2071971-11-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814093046.2071971-1-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/acpi.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 7ae317368b00..f9488be9249c 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -42,9 +42,7 @@ pub const fn new(id: &'static CStr) -> Self {
             "ID exceeds 16 bytes"
         );
         let src = id.as_bytes_with_nul();
-        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
-        // SAFETY: FFI type is valid to be zero-initialized.
-        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
+        let mut acpi: bindings::acpi_device_id = pin_init::zeroed();
         let mut i = 0;
         while i < src.len() {
             acpi.id[i] = src[i];
-- 
2.50.1


