Return-Path: <linux-acpi+bounces-19371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2AFC981F4
	for <lists+linux-acpi@lfdr.de>; Mon, 01 Dec 2025 16:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CDE64E1E1F
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Dec 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C19333457;
	Mon,  1 Dec 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImMRwE8b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946A332ED9
	for <linux-acpi@vger.kernel.org>; Mon,  1 Dec 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604346; cv=none; b=Ve5wtOE2hxTb1hy7RNcfiT9CCr3efAzdSPPVXad+R9lCngUVune5qaZbuz1wMxBJVhVxg6gCrAS2YHdXKjm5R+CO3oLAUZFjeVjb5BueONz39nxv9NEuEDP0lamEtfyv1pjEQ/pDdllUDo0oZgXXBLtna6LLwhnhFPE8wRt949o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604346; c=relaxed/simple;
	bh=XGyeeigAK9L746tngnKMOCKOk5BQ+hWN4+EJTlSpqSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjiaAyx+UDGbIB8eMbDEGk5+zdCu2BXmFl0qP1K65pPSPT4rYaT/EZFvuKv96dIYiq+PpxfdL/d6BxEfpkV4BC+qrSSXRpS6Uz9jH+wX2S1T4nypmENcpsrY05V96Gr6+YZOgcq7dGXFYW93YWIYX1AX2ijmc17jKgf9WtPqrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImMRwE8b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297e982506fso56944365ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 01 Dec 2025 07:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764604345; x=1765209145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVKsqLAjHiedCsMTkQj6KU9uWiG9cI4IM21lpckerh0=;
        b=ImMRwE8b/Fjc5hCvvFAs4/MtNwNQvIsehrcYoQ34UMRmy88hdHkudaz7hVav3ODsF0
         +g4Bwwgn8XF0hCzld0EGWArZ3iqa1lsew9wgUzez6dRoFp4z/8BNBv0MAd0vLJ4BvAsH
         /o5/8ChQ6MPoYk+/b57KvLOMxJKHLUq4cEygNReIukWJOoHUQoqpmWzRx3GPy3MMrrdu
         OqhhpXUemzCDpYHlGAVjJCHyUzIXi1nNBXgKmeuEHcHMx2VhRZZwrChRUqlGNoT2GdeP
         SM1HM+C7Tmxw76LMztzqmx5uZKIqX5ZtFNiohpc+Mw/AHos0s8VOn3ds4VarKXEzR2Ym
         hwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764604345; x=1765209145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVKsqLAjHiedCsMTkQj6KU9uWiG9cI4IM21lpckerh0=;
        b=vINlGNOGSNsHvvVJsTnHlifzvpEwZhuvywoUoevawb4v+vbPL9hl/fbcwZ3szI2qUr
         rrPh38DdcrkXfSNVnJfa2FBehL00RspKDuWIhU1B2KcYXSqqkzEQXy8ImaNqvd8tXcic
         0f2lu7WErLeXoZ+M9aOKQ/X/w35EeTI9TrZRIrEuNbILBCOl4GM9Z3vmPsicNXtjeYsU
         CUckvzN6/RKZjq9btxBUXYQyimZkr8gK7kOdBGxR6JxWO91z3/R6wjaalayPjkuOOJa5
         jLOnDICap+lK4dAP1MQxJCZLNQ8/YMXvvmkZ/NdmLmGuYquH6qx9gUVAJ7FzaH6TURm4
         3iKA==
X-Forwarded-Encrypted: i=1; AJvYcCXW68Cwe40UkTex+ukjnfEhSk4T7PRITw8CDsZ0ipVDltx5bhnqD6+83Ii5qwCpeqTYZHxjY5zk40yM@vger.kernel.org
X-Gm-Message-State: AOJu0YwdK5Fmx2g+2lYndga0IhVI/LPoqhUc0pslsRtRvfIsH9kheRfk
	/Ge9eXElM0iBQPjG1nBJ943F9Bc4Q9NRoAXOEzuXJoHfVkP5V1TpCumL
X-Gm-Gg: ASbGncthazpgCV4LWlQnUBZ0ukJaTm+71wSg56csJJlu24uHQhrLWy3RRXFih1G39xc
	mRwxdGBPfFFP+dR1T4e4TlHNU5fGnpRaAjW/fr0e7Eq6RstyIEQT6IP8A4prCR4zeCXHYJtR/6W
	OT8iM8nmoVhgoDgJ4+2bhVKFNEqQfFvQX6cesVmj1Hnx4ZlbTEm2QvrnuZ9E7+TDVAaatVlEYjt
	0iUWGMxX5oE+EKs11plI2c56nDLD8UUHL8TGYCga8aQXeyya47A5NO4nm2Y1Oktut3VJDltVNY8
	EsbZkyU1GoOlkpUiU5YImmeCfCIEwIlz7TC3cyq6tjzvK8nh+Q8znnkxJALaBM91DWdsx7dV5qy
	aEMxoUYvxWNG0yXPymAZnqYciTyQavvr2tLlobBjHDmvvlWZ42sz5Xf/W/xQntFJwSuudf1WTlx
	zym9jn7L0GSmB7Pc06UOK69ZDcN4TbNK16BLkB41poe8/kioDaDlns1vje4uBxpzoS
X-Google-Smtp-Source: AGHT+IGat4VhF83+oMq7CNZLZBFhrHJD09jfouaostnsMQaYHnfRxI2M9f052yuItSKVu6dT7hxfmw==
X-Received: by 2002:a17:902:f641:b0:295:395c:ebf9 with SMTP id d9443c01a7336-29b6bf80942mr448394395ad.55.1764604344552;
        Mon, 01 Dec 2025 07:52:24 -0800 (PST)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5442csm125777105ad.85.2025.12.01.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 07:52:24 -0800 (PST)
From: Atharv Dubey <atharvd440@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-acpi@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH v2] rust: acpi: replace manual zero-initialization with `pin_init::zeroed()`
Date: Mon,  1 Dec 2025 21:22:10 +0530
Message-ID: <20251201155210.22710-1-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `pin_init::zeroed()` instead of `core::mem::zeroed()` for initializing
`acpi_device_id`. This removes an explicit unsafe block and aligns ACPI
initialization with the pin-init conversion used across the Rust tree.

Link: https://github.com/Rust-for-Linux/linux/issues/1189
Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 rust/kernel/acpi.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 37e1161c1298..cc98b36b90a0 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -40,8 +40,7 @@ pub const fn new(id: &'static CStr) -> Self {
         let src = id.to_bytes_with_nul();
         build_assert!(src.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
         // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
-        // SAFETY: FFI type is valid to be zero-initialized.
-        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
+        let mut acpi: bindings::acpi_device_id = pin_init::zeroed();
         let mut i = 0;
         while i < src.len() {
             acpi.id[i] = src[i];
-- 
2.43.0


