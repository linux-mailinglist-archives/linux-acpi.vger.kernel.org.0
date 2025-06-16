Return-Path: <linux-acpi+bounces-14400-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95243ADBA51
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 21:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07401725BB
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCE28AAFD;
	Mon, 16 Jun 2025 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB+wNGJd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC128A1D6;
	Mon, 16 Jun 2025 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750103101; cv=none; b=tEYfYZUY4RtcybaGsXSgRMUNddlI7/wguACpo0OgoLQ66hSUadadqn6U6q1UlwAYZk257ZaAfci7lzZlpwZ93KUIPfyeALUFdRZt3kSrDUIda3Y/IqCEgEVGNv6KRSAViDiPyX5/zR8dcWwrxVaLKyiJEx6fbXoQD9pAxcx2yFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750103101; c=relaxed/simple;
	bh=Xr330VJZ59GqasSbBRpzL/AsW35MswJhQCbz4Ie7Ip8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L84jtbRIkOEXP6GwKb1d0KBdLIhwX9Qs9QTHTkyvUydMcCGX4gOJT03IGb9No1OC6I8qfJPfqrK/U2hY3qi3c4FtekRC5qVBElpZdZgHUmVXJ1Djh4kIxI0cGX+5WtdHtzngfUnvlgBuu06gmWHXZ9zCbuktuZreENg429bcihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB+wNGJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2462C4CEEA;
	Mon, 16 Jun 2025 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750103101;
	bh=Xr330VJZ59GqasSbBRpzL/AsW35MswJhQCbz4Ie7Ip8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vB+wNGJdTskadDBPNPnJJS5U7SJuMNFtITj7ZFtVUlQeB3weIaCLuCbjI7zg9asK3
	 lg6y6HZHiNfOOi9olpoCGntfywbOwHcV1wPz03hu6ncuCpn4X7hLsrVTsdiSmk31XL
	 Wy1HU1NJpDWATyeyPuG7MLxI9ckItv0h/9HXTsq+qvG06XhQlLlWtczT5DsBoZ8kx8
	 3U/3SQhBvJg4bhhAOyitoHmrtqb8ZF8mDBClYsT3Hsy/pH0wonmUm06fGvr0+Spkkn
	 SHwveQ865QwWNTlnaOiKnajNs9rf5+j/4NzZwvHx0SNWVR5S8K5D7A68jGCdhGUBRZ
	 QHKz5J5bVYOPg==
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
Subject: [PATCH 3/3] samples: rust: platform: conditionally call Self::properties_parse()
Date: Mon, 16 Jun 2025 21:40:21 +0200
Message-ID: <20250616194439.68775-3-dakr@kernel.org>
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

Only call Self::properties_parse() when the device is compatible with
"test,rust-device".

Once we add ACPI support, we don't want the ACPI device to fail probing
in Self::properties_parse().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_platform.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 000bb915af60..036dd0b899b0 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -40,7 +40,12 @@ fn probe(
             dev_info!(dev, "Probed with info: '{}'.\n", info.0);
         }
 
-        Self::properties_parse(dev)?;
+        if dev
+            .fwnode()
+            .is_some_and(|node| node.is_compatible(c_str!("test,rust-device")))
+        {
+            Self::properties_parse(dev)?;
+        }
 
         let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;
 
-- 
2.49.0


