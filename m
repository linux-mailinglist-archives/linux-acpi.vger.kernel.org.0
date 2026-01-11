Return-Path: <linux-acpi+bounces-20156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 763A7D0F938
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 19:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19C31301E208
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E3350281;
	Sun, 11 Jan 2026 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="Q4pQC5dO";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="VyBeX9Ng"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494A3491E8;
	Sun, 11 Jan 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156326; cv=none; b=CXGSd2iJ6XZNt141by1+kei8zFUkjTgPeW9ohYchSBiK12u+Ewx2KmY5Am4JsFQNmHuubQQOr43w2G9Oml67vm60zNAmxK6XVDwrGios5UinLhKuTizb/N2SrlXMe50OxcZ5e9cNwNgnsxBKuBadDnnlXP+EpHMkLWUzG4Hi6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156326; c=relaxed/simple;
	bh=mGKfS8RVtSig7BhkvMsSWhuP4/P9aMyp9SBdwy4NVeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEryApt4wkAQ8Ve1D54mLJUe8C+JDrSIPQVmNyYvk6A+B+NRgqoupaoQdW+wDpV2Wbl3PeuZJP4hleKbxjZp8gdAMFJMj0m781n3eWOEhkaUC1kAzpwUWAA27vqvSHyilHdoFPabz6zTi397o0tNlN7YH6sZ7ZxxFJOlXlP0/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=Q4pQC5dO; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=VyBeX9Ng; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768156306; bh=ZYnE0ZP81q42WS37VMVO9lq
	ZG3qDAnUFH+JIxSEFMf8=; b=Q4pQC5dOnXVUq3XeNWoHYOjSyzwekdUSWz5NkcrrQS/6McG2xG
	iummasr/0hC+ki+SOmrtihxDW60XFVjlgxA/mpvbebatX88X8iYukwUJmm15PE/vrtyKL696vYZ
	8PP0HH919swKhOi5RVC3PJu+eR9uyiDOD3twkPf+Jv2+IMV6COVJu3quJTRiDxC6+gTmLQfG+1Z
	VzwgT8xqahs87ZPlBTvS5m6HfHxqx+flQ/PPyGoFFrtzzbxlwxJym6cN6w2vEsIkQ/Zr8DHcIj1
	ajvO0LN2G2FCkbw8g/qV+NwfuHm+HkcdH4EaSCmT6SuN2mbCHwmTx81C+NCbLJYlodg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768156306; bh=ZYnE0ZP81q42WS37VMVO9lq
	ZG3qDAnUFH+JIxSEFMf8=; b=VyBeX9NgAjnbQlTX1ytqhGC3goi8ob1HydPB5myHhxUFqLj/gS
	eHYDOGFgcGNGQAUEJPOMmRb756hP32JQj2Ag==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
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
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/2] rust: WMI abstractions
Date: Sun, 11 Jan 2026 21:31:24 +0300
Message-ID: <cover.1768153572.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overview
========
This patchset implements WMI abstractions for Rust drivers. It is the successor
of the previous RFC posting [0]. These abstractions allow most WMI drivers to be
implemented in Rust (provided other dependencies are abstracted as well).

Currently, the only driver in existance is a reference driver (rewrite of redmi-wmi,
Armin is OK with that [1]). While being fully functional, it depends on sparse-keyboard
abstractions, which I am still polishing. You can view WIP abstractions & driver at [2].

Notes
=====
I do not know how these abstractions should be handled in MAINTAINERS, so for now I have
simply added them to the original WMI entry. I would be happy to be added as a reviewer
to keep the Rust version 'synced'/valid though.

[0]: https://lore.kernel.org/rust-for-linux/cover.1766331321.git.foxido@foxido.dev/
[1]: https://lore.kernel.org/rust-for-linux/c7384f13-e286-45a4-95c6-24d389217185@gmx.de/
[2]: https://git.foxido.dev/foxido/linux/-/commits/rust_wmi?ref_type=heads

---
Changes since v1:
- Add lifetime to AcpiObject
- Add forgotten `Sync` requirement to the WMI driver trait
- Drop unsafe in DeviceId::new() (so no need for the const_intrinsic_copy feature)
- Device<Core> -> Device<Bound> in notify
- Small fixes (styling, missing safety comment)
- Add link to the WIP reference driver

I didn't touch AcpiObject::type_id() in v2 because it does its job for now. It's currently
small (only one subtype, whereas both enum options would introduce a larger integration
surface), and it would be an easy change if someone needs a more powerful solution.

I've also played around with some other suggestions, but:
- Suggested wrapping acpi_object instead of bindgen union subtypes will only introduce
    unneeded unsafety in each subtype's operation. I decided it's better to expose the bindgen
    type once than to validate a safety invariant each time.
- Suggested implementation via a sealed trait didn't really provide any benefits; it just
    raised code complexity a bit. Maybe I did it wrong, though...

Link to v1: https://lore.kernel.org/rust-for-linux/cover.1767818037.git.foxido@foxido.dev/
---

Gladyshev Ilya (2):
  rust: implement wrapper for acpi_object
  rust: add WMI abstractions

 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/acpi.rs             |  97 +++++++++++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/wmi.rs              | 286 ++++++++++++++++++++++++++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 rust/kernel/wmi.rs


base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
-- 
2.52.0


