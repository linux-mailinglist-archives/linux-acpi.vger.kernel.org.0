Return-Path: <linux-acpi+bounces-19364-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD256C93D80
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Nov 2025 13:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D16603465AA
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Nov 2025 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472C30EF94;
	Sat, 29 Nov 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmYkdeOU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144730E82D
	for <linux-acpi@vger.kernel.org>; Sat, 29 Nov 2025 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764419289; cv=none; b=n+2qUaH6r+E2Pv1jtsPXbWu2YHLTF0U1KghxqpKf6etGVhfcc6JFFUCn06VT8RZlegm683vx5f93JsMzuC3uXSl2NcnF4PPn1bKV+ZGPDuTlt/iAYoPzEBXvzqJAa8+iazKQvBPHr/9N5rr16NxaXJyfWQktNcIe2od7I76ZCV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764419289; c=relaxed/simple;
	bh=jMfOtC5ltGOwo2zw8E6WHyb2hwdx1JI37MEhkcm6d/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmz/jk00lffnkorAJFJfBpR7OktsZjxps11Jt7amECmMRKzloo4j81m4ow1rKKru+/aYnpEnTzKn5yZ8q+l8oe+xIoMYBL2U+ZYbchvwxNHBlSDGwugXy6tH3HzGHYDcvi0iI03XANaT2JpfIDP79b0AARWTwNFEjs/JGUyMb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmYkdeOU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso2200711a91.2
        for <linux-acpi@vger.kernel.org>; Sat, 29 Nov 2025 04:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764419286; x=1765024086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3V2gkPbQh4TVJJCmUT97AnhOY1sd61+QDFcFJfctTo=;
        b=VmYkdeOUJ10fKSocWbZ6RFrJMMTexnjIlZcmrk7bXYDxh+6kEzoMO6AsS3z3dz+yld
         2Ns4jQhJywiBEl8Rq2M5KC+kdVkvnyJD4tq69U9ba932apAFb7m/HHwJymrTUWd+Mmgj
         CD4+FjPZxt+XfADd6bzcvQZJOhejNk/UNEJNtyYYqgp5hy3Zb+cI1FwvLB2vZ+i9DFFl
         9OLxyll8+EO6NzYWZq67GgpX6Vv4UVoHmNIZ7Z5ubNlE1g0+diGzes1XNtenVqDYc9qQ
         jZrSW+9lFBkVEzrMB+aQhkDicvmHhhzwIozLnLoajlb20cW82/j5tvNtHBblFS5kYw/7
         sHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764419286; x=1765024086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3V2gkPbQh4TVJJCmUT97AnhOY1sd61+QDFcFJfctTo=;
        b=jH8fze7zrh1BZivolIESolJSqPA/7mKIpgFg4AUfZCS5FFq5V70pJd6sLgVryeQlX7
         DbVRmNfPKy+t7R001d/lDpSUIbwUc9jy8IdghnA9emNexNSjQD3lmNI1T/2Cw3w/tHgA
         hxrM4gIb0cmxNCQk6QX+6zKIjoqwK86j3e2bfhoOegmpidzPTkPwXqiMKzEMQH/2bmGR
         Da45bDzL1RG+hLi9KTKxFOoU0CYHMQQ49vqt8legqP/bgKbSej+Lp916AAdGFxeXTkQb
         qV6A2bjmwNgMDcyC3u2uvakYiIShyKwgdpoOycE1SoEnw6mAIeR3LOSgYuSSn3Vnn2Cj
         uMZA==
X-Forwarded-Encrypted: i=1; AJvYcCWpnoyBhnv5TbeK4J/PRRJ2CF9dr02f91xA3KaOtNx6yLTMRUEttTHSd3xa98MTXOorKPs61m5AvsAC@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpNfGzaWEM+1O78NF3jGmkTN0hXOpvgk7d+i2HLy5hv68H8ak
	MCICzi42kKOgWT1Hzgj/ZNotIbbctTfqvJEqsFof0hvG2W30ORADRcGt
X-Gm-Gg: ASbGncsBFzkqKGWzc1fY1WL03NIogNC9bGZPephfacNvQTHGCG4uelhOdVnsODMfarr
	nEnugNIBVRjid+z/sgKI4L8C7a18U5lqgnbbaW6fJluzZYeK5WVIA3QBhezYTBO8Oueh6ce057s
	3XUi+XDymHJ7/zea4T7O5KgIy8dzR1pqL/1tS0CmpnoHyH/6rNX3T39pxghXXF6Kpnl7IYPlczT
	GIGzbbttygDLZAszobWNpQHwtYj3brrB4Q3+h27xlEYJyRYga0DGq5YL8f/nywR6w6DXDzF4rpv
	4xzSjELgXPaIqcd2/gwZ8F1jRsT1pPCnk8PeWK+kUqhkMRJqvyoXEX2NzMcuFn9b2TXCpTVc84v
	28m2v4rGmn4BtMAYvBBIvIysjqHVL1jDOPH52eHc+oW1odsr98sXsFbqbynswzazpXNZdewhzZU
	OmBJwmjz9pqRS0FC64fqsjTqRUp254MZHlDl3Q3+kvinugm2g9E5+mvpjG8GbafqaauUzvWwiG+
	0U=
X-Google-Smtp-Source: AGHT+IHKLnLhy8FVoq7dwSlGJpH3A/bWswuLjr4boQ+kvg66h9DT70NLcNVgAxqb9q/+gSLGJHGy8A==
X-Received: by 2002:a17:90b:3848:b0:341:719b:768e with SMTP id 98e67ed59e1d1-34733e4cccfmr25699841a91.2.1764419285623;
        Sat, 29 Nov 2025 04:28:05 -0800 (PST)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fb14876sm7911260b3a.62.2025.11.29.04.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 04:28:05 -0800 (PST)
From: Atharv Dubey <atharvd440@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-acpi@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH] rust: acpi: replace manual zero-initialization with `pin_init::zeroed()`
Date: Sat, 29 Nov 2025 17:57:53 +0530
Message-ID: <20251129122753.23022-1-atharvd440@gmail.com>
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
 rust/kernel/acpi.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 37e1161c1298..9b8efa623130 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -39,9 +39,7 @@ impl DeviceId {
     pub const fn new(id: &'static CStr) -> Self {
         let src = id.to_bytes_with_nul();
         build_assert!(src.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
-        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
-        // SAFETY: FFI type is valid to be zero-initialized.
-        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
+        let mut acpi: bindings::acpi_device_id = pin_init::zeroed();
         let mut i = 0;
         while i < src.len() {
             acpi.id[i] = src[i];
-- 
2.43.0


