Return-Path: <linux-acpi+bounces-14443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0FAADE90F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BF83A9C11
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440982857CF;
	Wed, 18 Jun 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmLgEDOc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9821578F;
	Wed, 18 Jun 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242540; cv=none; b=HUpHLQ3AoxKUCeY8rXOO/Jj4LHXtIy8/imfJy1mWWDOXuei4z2dil5T2W91MdJGVpE6xteGx1Nk0AVD6bmg4uLV2XgDZXPcrstJFzgfnebs4gnIqRUTlaFVIPzCS3iOzZBAEm98l++KamM3fvpTg5dLYJ/iZ1Xx+YQoRO0UIJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242540; c=relaxed/simple;
	bh=T0SJPHJhwVKORNMLpZJcWv8mbwrStmXpFFZ9WfsgFkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGAndAMVCE3Lfr3LmZ0p5RQsLIIA320bBo7rRCFmfy0H+2XmE77VnccXM5/Um7qsdY84xKeNAnMypa2/ewRCLluxEE//9ET/j91SaPhnXMzyYL9IbPdOjdLqX0OlcIcNcD/8qypaf5PHyPd/4Pxspeh4trSHdF6t/qMotuNBvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmLgEDOc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d7b50815so56795045e9.2;
        Wed, 18 Jun 2025 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750242537; x=1750847337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAsGZRd53w+Z7fyD/JC6KZq84tLoTkjPM83MNjJS0NE=;
        b=ZmLgEDOcqQq0o5zezDOuNDl1q1Xodbt/ACjR8+M+ALhwcnG6nPln3nP03o4Z28dido
         ChQZKXGy0K6QY/qIsv5bfbBWktAxN6pcYKLPUQRSp5MoLbgDSmCNtZUDeXrXsAD7iavK
         WLUQN/MM43dp+52gHnCB71wt/cJF8MLTX1xX42mSqm3EloPPLuGbTKE+8pTwc0ZNSWnw
         vUNRI1WrFm6sAr31T+J36AzaPaVJD/9l6yQi/TDkqBF8pB2g4bU9d/Ix/z4THnpnrFU0
         9LCGyiGexb845KMa1rL60Upk1ZeuRn87jolJCIt0FDk7zJ+oSICqFqXjb4lwey2/YjSA
         pK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750242537; x=1750847337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAsGZRd53w+Z7fyD/JC6KZq84tLoTkjPM83MNjJS0NE=;
        b=OO4oE20SWe10EmLqpTDiz9eSM1BomRgTanNKU9a7KRmPExSxifJTsxxMGRRtzHVnIy
         3OfdkAN9fntSQ7/i3NIg4knBzdvOxqXoKABXwA2D3/DZlN6SUSDLE7AMotYuI2Juctti
         kDSL6C2l3EVOlCohb9kd79kBHTfUjDsdYGoXw4jo54vMnUtFE0Pg30DdpWJLmlhg4715
         Dj8Fh1cVjxpLwDKP6l2LazW+4VyDyz/Mq/BtRYrdaItW8NJUF+C5Q1u8WA/AatLmBzOq
         2480KzERhLy0iwY9+J0hDtY/NRzdLUHlmLALYR9LmQdDbIVHDGHeN1IR2VHmTD/vjujK
         QK5A==
X-Forwarded-Encrypted: i=1; AJvYcCUgVour87XifuktOU0/4eYynM0yAr3Gturm4V4KC82vnW0JH5e+L1m62AMj3kl4EEpwrInBaEApdR6Gu+tMkz4=@vger.kernel.org, AJvYcCUwTIjry3Cg4LgMHUVXFV7GYFPNyiU4rdrKp4T2SM1dvftGgTtDPYpfvVneS17r8zBtgrq7XAlit3a9NkeG@vger.kernel.org, AJvYcCWmKxHi4pD9+iqMRLKMf2Y7mc7QKvs7NYLk9Oi6ZPl9SlcDNosFGvit/TowLeVWVs2l0Lsedk0Sb6tH@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2J6Dh5nGxyJK0qB9oMZVG5YGLDblQIZQOVuf6VJ41Yo45ceH
	4gIz3ihsEmny2NU/KdWQLEqoa1v3P1mtFPW8slrhh76/V/auLpyqP+sx
X-Gm-Gg: ASbGncvcsbLrSCNUGLQ9/4cEg+5rH0Ks/eVEKg9Vp+qBQl3nuVbJ1Km8PmkR78ytxEw
	w7RQh1nmp7wDVGSo7XHZlJ7Bx416af9UA8W5tYXJjmUupkXTB+haU3cE5GSWul2wWEEK8PU/UiZ
	4YaJ68AMtZKLX8QUJrYj5F7+wI4LUckAvCfDc/Kw1NNnEUeOJNKLqnt6ohOofKXtc8OA3I+UgSJ
	fIHr9AFhkR58wH3jDQUno7LIEZucvWAZmn7ZVlSUhLCPpdh6OH5rvg/dK1S7FTTv/SMuDmdLQlM
	GQdRrZiNADotZ0kPwvbaG/FQkQb0XOgde9mu7ECiJYMYrvLD+pDOd3SFW4OuIBF/fGa83dlauEZ
	EY/hHcq9j9gVP6nFDs9dbjgq/FuHlEcwImQ1DDvY=
X-Google-Smtp-Source: AGHT+IG4qgyrL1HA5S/KZPAkJ4SBAyNYbQB2c36HChaEOrLssPGD5XPO47yPsV1kRMOz16sqHr2WfA==
X-Received: by 2002:a05:600c:8012:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-4533cae684fmr168876995e9.11.1750242536280;
        Wed, 18 Jun 2025 03:28:56 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535971b18esm10060145e9.2.2025.06.18.03.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:28:55 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	lenb@kernel.org,
	wedsonaf@gmail.com,
	viresh.kumar@linaro.org,
	alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: [PATCH v7 9/9] samples: rust: add ACPI match table example to platform driver
Date: Wed, 18 Jun 2025 11:26:54 +0100
Message-ID: <20250618102654.3050345-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
References: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the Rust sample platform driver to probe using device/driver name
matching, OF ID table matching, or ACPI ID table matching.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 samples/rust/rust_driver_platform.rs | 70 +++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 036dd0b899b0..57e3ac77ef54 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,8 +2,68 @@
 
 //! Rust Platform driver sample.
 
+//! ACPI match table test
+//!
+//! This demonstrates how to test an ACPI-based Rust platform driver using QEMU
+//! with a custom SSDT.
+//!
+//! Steps:
+//!
+//! 1. **Create an SSDT source file** (`ssdt.dsl`) with the following content:
+//!
+//!     ```asl
+//!     DefinitionBlock ("", "SSDT", 2, "TEST", "VIRTACPI", 0x00000001)
+//!     {
+//!         Scope (\_SB)
+//!         {
+//!             Device (T432)
+//!             {
+//!                 Name (_HID, "TST0001")  // ACPI hardware ID to match
+//!                 Name (_UID, 1)
+//!                 Name (_STA, 0x0F)        // Device present, enabled
+//!                 Name (_CRS, ResourceTemplate ()
+//!                 {
+//!                     Memory32Fixed (ReadWrite, 0xFED00000, 0x1000)
+//!                 })
+//!             }
+//!         }
+//!     }
+//!     ```
+//!
+//! 2. **Compile the table**:
+//!
+//!     ```sh
+//!     iasl -tc ssdt.dsl
+//!     ```
+//!
+//!     This generates `ssdt.aml`
+//!
+//! 3. **Run QEMU** with the compiled AML file:
+//!
+//!     ```sh
+//!     qemu-system-x86_64 -m 512M \
+//!         -enable-kvm \
+//!         -kernel path/to/bzImage \
+//!         -append "root=/dev/sda console=ttyS0" \
+//!         -hda rootfs.img \
+//!         -serial stdio \
+//!         -acpitable file=ssdt.aml
+//!     ```
+//!
+//!     Requirements:
+//!     - The `rust_driver_platform` must be present either:
+//!         - built directly into the kernel (`bzImage`), or
+//!         - available as a `.ko` file and loadable from `rootfs.img`
+//!
+//! 4. **Verify it worked** by checking `dmesg`:
+//!
+//!     ```
+//!     rust_driver_platform TST0001:00: Probed with info: '0'.
+//!     ```
+//!
+
 use kernel::{
-    c_str,
+    acpi, c_str,
     device::{self, Core},
     of, platform,
     prelude::*,
@@ -24,9 +84,17 @@ struct SampleDriver {
     [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
 );
 
+kernel::acpi_device_table!(
+    ACPI_TABLE,
+    MODULE_ACPI_TABLE,
+    <SampleDriver as platform::Driver>::IdInfo,
+    [(acpi::DeviceId::new(b"TST0001"), Info(0))]
+);
+
 impl platform::Driver for SampleDriver {
     type IdInfo = Info;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
         pdev: &platform::Device<Core>,
-- 
2.43.0


