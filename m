Return-Path: <linux-acpi+bounces-14399-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1BAADBA4F
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 21:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE973A33D5
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F2A28A416;
	Mon, 16 Jun 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWf70akD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDA28A40E;
	Mon, 16 Jun 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750103098; cv=none; b=W8acqCGOgz0KQKdSH2iWZz4fUwbiURyxNTqYXvBZEOFd8rrIUa6iLxHoHk9UoAJa6M39T0gIw+eJl5UUp3U5BXRejCCwn3mR6CU9s6OnALGBkJEDIvaN66d6lQTrJfgd6UIOhhFfgskF46sfp/qSRqTack/9iNva9KYYo3ulS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750103098; c=relaxed/simple;
	bh=Xe0INp48LTcwqCr5InqN8S+WZL2OaJHjHcHJ15QthgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKUyfsP4K1JtOv0mus8i9elAE71PmKZ425iw+STJdbPuBp2mzAjLHqzxLD+bHWlBOrjO+OaOZ0c57WMBFpz3UN6Vtm0sQ1NsGE9cCivYjfJWK+WQuqkbaXDeUqTQ7A0DL4zlfKuzaM8MHL5Or1krxyZVBp32kSdLLMaRewnednk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWf70akD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50833C4CEEE;
	Mon, 16 Jun 2025 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750103097;
	bh=Xe0INp48LTcwqCr5InqN8S+WZL2OaJHjHcHJ15QthgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWf70akD3FiLgaus9rVzHNqJvLHkKmGPZ54ZLk71AJt2u6mKI4sdDMAzinmk9t3cg
	 0H+POci6AzXW1CQTuU+iED5fjpeU/5/B3aKYfTwbsyHuHOiV0OrM/5bH2DFfUNxHl6
	 Qqkc6fJA+OAWJI4Ol/JbjE6qNoT8aT8rk3LmPwTfQzSCH8LnY6aPpivcA4zW5PA/z4
	 uR9usic1/JvCnD3huDcS80OnErQEhPHlyUGY3kgt2uHu+BWnoK1xlVJKYjphT563JB
	 zbnNWz7WcU7KGolGHqn1j4Nx2jjKNT6v62RpQSDZTXxxuN+6jz6uZkaXAvjYMZrtCl
	 nwlIhz13njghg==
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
Subject: [PATCH 2/3] samples: rust: platform: don't call as_ref() repeatedly
Date: Mon, 16 Jun 2025 21:40:20 +0200
Message-ID: <20250616194439.68775-2-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616194439.68775-1-dakr@kernel.org>
References: <20250613135407.1233005-1-igor.korotin.linux@gmail.com>
 <20250616194439.68775-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In SampleDriver::probe() don't call pdev.as_ref() repeatedly, instead
introduce a dedicated &Device.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_platform.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index c0abf78d0683..000bb915af60 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -32,13 +32,15 @@ fn probe(
         pdev: &platform::Device<Core>,
         info: Option<&Self::IdInfo>,
     ) -> Result<Pin<KBox<Self>>> {
-        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
+        let dev = pdev.as_ref();
+
+        dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
 
         if let Some(info) = info {
-            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
+            dev_info!(dev, "Probed with info: '{}'.\n", info.0);
         }
 
-        Self::properties_parse(pdev.as_ref())?;
+        Self::properties_parse(dev)?;
 
         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
 
-- 
2.49.0


