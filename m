Return-Path: <linux-acpi+bounces-14888-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B51AF022A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C52447546
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE51F27EFE2;
	Tue,  1 Jul 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Xw5mgx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054627C172;
	Tue,  1 Jul 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751392088; cv=none; b=fqdBfabquo3cIQhkWgGkxuBHZStj9+yaa8QlfYPO3s1Y/HhqDAv7Cbi4zSyO4Xjp2GZ34d5ucHcaDxcR+5KHRslYEbL/qXu0EVZHRgs22eSaJuErJDbWZ3paYeHDzYMUcLAesGsx9lKrGfuIxw8g6YUF0ecHrGCwOFFxYL+bKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751392088; c=relaxed/simple;
	bh=XNRBviar2/vlgVZz7XPdVTDJlqoNYCm5E8gMgmgCnso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJIZdFNkqBP57JC4UUnduY6JuAvI3UHM1+oJhqqliWOpDOUVTMAscw804DxwJWQdwIxGrmd37YBB57nXteRMcrGT7tKD7Ojgqb9CB6EYHhMBxTCgzN/fbgxPiHi6rfUK4MoKaGQYZ7BrhikZhpaoTYkbD16iLifH/gV6RQhER6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Xw5mgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41273C4CEEB;
	Tue,  1 Jul 2025 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751392088;
	bh=XNRBviar2/vlgVZz7XPdVTDJlqoNYCm5E8gMgmgCnso=;
	h=From:To:Cc:Subject:Date:From;
	b=R7Xw5mgxepuR8cjgfT3YEDJbBa1fMdwlyiP2F5OqBPxlJi1Ak/Tut0XaBIKNv+Tbf
	 KnY4JQlnWomg1SwSNkT1wuwMCIr/JHoJPECRw+p4QYX6rDC+mmmJaoDrsrk1Uqis2i
	 kCc5pljZ98yX1UqKwFSacboWw9J7iGssAIcQ2Zb0y90/UpYF2GJ35TncycraFrNRug
	 42LXCTOjJupq0+8RR5HHq9X2L0u7glxQgBL4I3QVjWR37eKsL3+DVf+WZVee5N+Pjt
	 l+RPwhjSPqgPGIgiUQOw+c02x4wc93SpzN3qmBFOXHPaNRwWvwtATFVOnUUqax2c2l
	 zs9RvzzTeC+Qw==
From: Miguel Ojeda <ojeda@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] rust: acpi: remove unneeded cast to clean future Clippy warning
Date: Tue,  1 Jul 2025 19:46:56 +0200
Message-ID: <20250701174656.62205-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A future Clippy warning, `clippy::as_underscore`, is getting enabled in
parallel in the rust-next tree:

    error: using `as _` conversion
      --> rust/kernel/acpi.rs:25:9
       |
    25 |         self.0.driver_data as _
       |         ^^^^^^^^^^^^^^^^^^^^^^-
       |                               |
       |                               help: consider giving the type explicitly: `usize`

The type is already `ulong`, which nowadays is always `usize`, so the
cast is unneeded. Thus remove it, which in turn will avoid the warning
in the future.

Other abstractions of device tables do not use a cast here either.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
I noticed this in -next -- please feel free to rebase if preferred.

 rust/kernel/acpi.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index eaae3bc8e54c..2af4d4f92924 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::acpi_device_id, driver_data);

     fn index(&self) -> usize {
-        self.0.driver_data as _
+        self.0.driver_data
     }
 }


base-commit: f5d3ef25d238901a76fe0277787afa44f7714739
--
2.50.0

