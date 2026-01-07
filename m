Return-Path: <linux-acpi+bounces-20019-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EE4D0007A
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 21:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ECBA3065233
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 20:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54FC285CB8;
	Wed,  7 Jan 2026 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="JovUzSHT";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="ufY0KSjF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E262D063A;
	Wed,  7 Jan 2026 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818199; cv=none; b=TOs/246nSmst9YZdPQDg5b6rgZI5EIGdIOA0T9o13guYuymTRYKZTqtnMHwfnqs/7K5FgRQD2EcVwG+m3elPDOfXUShgZkeyXPMFwnSI1I+W5fDan3ZiJKuoMZJo+Zj091TY9Vjq1ijbvZb8HRb4141vj9HwKyK+txULvgd3dRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818199; c=relaxed/simple;
	bh=i8W7YKX8S0kQo5L7YSzvXf0CToGzPt6PjLFHgHRkQ0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swDhvMfeMODMg+iHAeMTT8LIX1GVfc8FcO1YtR8AIFBn/RJiKa5HXR5/w1kDwcXMEDXQuT+npP1uopCUXLm0jWovOM+fFCbxX708qX+tPFo8k/ktQnlw3VrfkNjikqVZ6tQDv+hE1mubBX+YqFnbQLtdD8RB+qIyR3SfKmwwqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=JovUzSHT; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=ufY0KSjF; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767818172; bh=7WV1mwAtbFEAdoyjirC636K
	yJEP0FvI3MsKwDZMOxUQ=; b=JovUzSHTor4A6K9fchP3H84v3bsB+YfkMqIVyxyBESFSmQFOxc
	DayNl9MUj5c1v8XTEVxRFsUR+Irl/hEXTptUbmjWwP0yfpQ9Kv0C2IjowwYzruVAxwMsppF8ojL
	3sR2no7iiAmaKUr1egEf1PPCaalR3/JMrbo5/ubLJDwAC7rbNx37huPnNyYgoUPPEn0ftfsgdGt
	lBafW+ZQc+SuTdqx7bnPvxsvgd2FYJ3gf4tDqnmalj+qtForz23xsPzKz7ax4wEGud0BKaBa1Ej
	TdnHP47ZoE5hyx6S5lpUtfNEoFtydZUgzpgRyHd3HUUXlPjbU9s+TfAZOaX+03uwJig==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767818172; bh=7WV1mwAtbFEAdoyjirC636K
	yJEP0FvI3MsKwDZMOxUQ=; b=ufY0KSjF+r38GC7lncOoHtX0dBMIkCQ8/lrE7y2g1of3r67sSm
	A28mQFchmrCa1e/Frb53YidjCILt4vO4qYBQ==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Gladyshev Ilya <foxido@foxido.dev>
Subject: [PATCH 1/3] rust: enable const_intrinsic_copy feature
Date: Wed,  7 Jan 2026 23:35:31 +0300
Message-ID: <a2c01b2d2649d48cb194e011e0643be1af151b42.1767818037.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767818037.git.foxido@foxido.dev>
References: <cover.1767818037.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Rust 1.83.0 the `const_intrinsic_copy` feature is stable.
It allows usage of `ptr::copy` and `ptr::copy_nonoverlapping` in const
context.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 rust/kernel/lib.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f812cf120042..a6eccdba50b5 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 #![feature(const_option)]
 #![feature(const_ptr_write)]
 #![feature(const_refs_to_cell)]
+#![feature(const_intrinsic_copy)]
 //
 // Expected to become stable.
 #![feature(arbitrary_self_types)]
-- 
2.52.0


