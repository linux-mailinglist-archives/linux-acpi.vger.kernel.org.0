Return-Path: <linux-acpi+bounces-14269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A94BAD3C62
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 17:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272F23A975B
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F423506D;
	Tue, 10 Jun 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5jLLVN8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77074D8D1;
	Tue, 10 Jun 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568199; cv=none; b=d/OiGcZctIsz2mwJ+ShmxRYSH3Mrf+l3oMu+wXc8rUuljlIuYSugpitRWoO9VFpRstbbs/vuMXMOCK3ldSOEn5EGyqaY4cqkrrlffHYl+65VkTNi+JI3dD+kzGhEYbNDl0YXm7oaeCd4aHUQ5o4fmZck7bx5eaHqFERglyW7pXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568199; c=relaxed/simple;
	bh=7bkZleI4BH17Oy/akeL6W3YsLvC+6yz5vzfe0WCU0cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiDZUJpcLIlc7OYZcZnELiN0dP8t6F5yOAzXTizZbKS1Y0IYyKoIgiJhzuNf5rAARgZ3ImTZTFdC8b3iANrhvKdhLQgHuwfg6Ru3TJAmXC8KzqqeHfKU7ff1CBXB3x+VrClOQZx1a3wv3SBSR1E6YnR5EZtm96FQP2cnhYOvlBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5jLLVN8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so43816615e9.1;
        Tue, 10 Jun 2025 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568195; x=1750172995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALK8x8rgzEp18DzbemRF0ze+qv0C7P5MIc0avCWsR7g=;
        b=g5jLLVN898VjkanqBBpRg9ar4CcVYgNTXBSD71beq9kjEtkce42L6m0MkH4BOmyB72
         70zZaY0qhABgYj7xBwdcNV+m61rMMOpVoyxCjfkA/xkRhOpq0pGprEi3yp4vbICknO7e
         VLsJJk5xatgHR/E35OM4nfOg3CYnnCyJcWdhRjEJssTZtzpRftPrx8FX0oJ8vxuUGNFP
         d9HDapDIOpRSsawUApdZet//tR5H5Mu/x+KZ/tSZhrmlkT5bdo7yo1nrxIUbNHyLPNdn
         yvmiYW1H/m4u03FfnfmmVyfagdoy3a4Sj0CpAa9LC9ZPZA28q3VulO7mF+aU7up/An+2
         8M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568195; x=1750172995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALK8x8rgzEp18DzbemRF0ze+qv0C7P5MIc0avCWsR7g=;
        b=tJa5byP4rcsL2ZtTvGk67ynRyDhiWI8VNLB/XS1H6ekCvt5CpUkao4TSnfSk9e8enx
         xQjgvjyeVxEm67I1t2Nn9BOlvJGwnHsPTQBHhyX1XFHDcRuyn7wv/OQPDotjA91JSoV+
         Z34iZykNcwFR6GiGjb2edHNMI9O+hBXLOnCuDrW06iyZGWi19/WHj5FNWNwnSsGNTRve
         2DolYNNLeUOPp+nrSekt2suc7Xf6TKP6pDRa9Jzawn8KvTuAfDUytaW9ii2ICjtDvCsH
         73RPfY0YAzGpy9z7i/XAwUpU3DPNMOx9Joj1oG5Yg52Jcyu414axUj2+++U+6ZtZMWCV
         v1RA==
X-Forwarded-Encrypted: i=1; AJvYcCVKuyw7jDfxQ2ZGzMj7lQpHgf2fbRv7fffICzJAT9+42Abzcxf0oNfS6uddbd6cTABLiV/c6VAgYhRaKHTsbJY=@vger.kernel.org, AJvYcCX5J5WTdzv/OXXFbXN3jAxOPJbLBKSep60FKTSSyGTuG3cnI7rZzRVSSlI+MQU6wPb5tru0OtFT2jQYbNEz@vger.kernel.org, AJvYcCXfelJIj7DgrxfJt7LMpO8740Wl3fNZ1vBltchrKjWFgTUa8hdaUxydHZkRjGKzPOqHa5bpnipswDg9@vger.kernel.org
X-Gm-Message-State: AOJu0YwUS/nKtxoUpKOFSX8DNkzrXga2FveseA7je1tIhrarRogHeMHJ
	kH0+6OC6hYslgGr/097SbcpZFM6UcDV3vRoJt8T3Yo75BQKL1xcIgE6e
X-Gm-Gg: ASbGncs9phg76KK1RLQ3dWMYa1b1SrQQv77NVoZVpw9vlL9rLr0bKw2o+5OnNEr20/6
	Ml1oozQljROZHGpJftY6TekJykqPveK3MiZXFg4WOg0NEHMf4U2IT08Sn/tmV8HXB9g9fIGRPWJ
	PSC49/2pCTJJkSK+cXEUp+Xzji9p822kCA1uQNDkrV48k8a7LBkMdsQGryxlQsWFPugCFNmVDP+
	A+GGVj0yAXrcr4BkVnaZ1AvLCtuFdkQ8k76emZ1wYWhdLJ6yvvPODEnDOn5sg+y7KzYksXPZ7Rt
	05uNq6P/mRRXP4/ldKEVrQBpivDWGypVO2kNDcASgX4nIXO76dYh1lgEBFkel3hUEtzdeD/nCzH
	E+Rraqm947+HQjT07oadabqXmMY2iRaAabBIGKmR5jDg6PU8=
X-Google-Smtp-Source: AGHT+IGitqY+8Fi4phqzF5RpNzwTKpl9TkN87YxaAxk4dfH2LxdJNCATFugI5nL1SEOnctKAqGjUeg==
X-Received: by 2002:a05:600c:4f88:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-4531cffd001mr39725185e9.14.1749568195028;
        Tue, 10 Jun 2025 08:09:55 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213726c44sm147571765e9.28.2025.06.10.08.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:09:54 -0700 (PDT)
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
Subject: [PATCH v4 4/5] rust: platform: Add ACPI match table support to `Driver` trait
Date: Tue, 10 Jun 2025 16:07:52 +0100
Message-ID: <20250610150752.238391-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
References: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the `platform::Driver` trait to support ACPI device matching by
adding the `ACPI_ID_TABLE` constant.

This allows Rust platform drivers to define ACPI match tables alongside
their existing OF match tables.

These changes mirror the existing OF support and allow Rust platform
drivers to match devices based on ACPI identifiers.

To avoid breaking compilation, a stub ACPI match table definition is
added to the Rust sample platform driver. Functional support for ACPI
matching in the sample driver will be provided in a follow-up patch.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/platform.rs              | 48 ++++++++++++++++++++++++++--
 samples/rust/rust_driver_platform.rs |  3 +-
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5923d29a0511..893b4189a10b 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -37,12 +37,18 @@ unsafe fn register(
             None => core::ptr::null(),
         };
 
+        let acpi_table = match T::ACPI_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
         // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
         unsafe {
             (*pdrv.get()).driver.name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
+            (*pdrv.get()).driver.acpi_match_table = acpi_table;
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
@@ -96,7 +102,7 @@ fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
     }
 
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
-        None
+        T::ACPI_ID_TABLE
     }
 }
 
@@ -127,7 +133,7 @@ macro_rules! module_platform_driver {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, c_str, device::Core, of, platform};
+/// # use kernel::{acpi, bindings, c_str, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -140,9 +146,44 @@ macro_rules! module_platform_driver {
 ///     ]
 /// );
 ///
+/// kernel::acpi_device_table!(
+///     ACPI_TABLE,
+///     MODULE_ACPI_TABLE,
+///     <MyDriver as platform::Driver>::IdInfo,
+///     [
+///         (acpi::DeviceId::new(c_str!("TEST4321")), ())
+///     ]
+/// );
+///
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+///
+///     fn probe(
+///         _pdev: &platform::Device<Core>,
+///         _id_info: Option<&Self::IdInfo>,
+///     ) -> Result<Pin<KBox<Self>>> {
+///         Err(ENODEV)
+///     }
+/// }
+///```
+///
+/// The platform::Driver requires declaration of both OF_ID_TABLE and
+/// ACPI_ID_TABLE, but if driver is not going to use either of them
+/// it can implement one of them or both as None.
+///
+/// # Example:
+///
+///```
+/// # use kernel::{acpi, device::Core, of, platform};
+///
+/// struct MyDriver;
+///
+/// impl platform::Driver for MyDriver {
+///     type IdInfo = ();
+///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 ///
 ///     fn probe(
 ///         _pdev: &platform::Device<Core>,
@@ -164,6 +205,9 @@ pub trait Driver: Send {
     /// The table of OF device ids supported by the driver.
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>>;
 
+    /// The table of ACPI device ids supported by the driver.
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>>;
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8b42b3cfb363..e3992e7a71e9 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
+use kernel::{acpi, c_str, device::Core, of, platform, prelude::*, types::ARef};
 
 struct SampleDriver {
     pdev: ARef<platform::Device>,
@@ -20,6 +20,7 @@ struct SampleDriver {
 impl platform::Driver for SampleDriver {
     type IdInfo = Info;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 
     fn probe(
         pdev: &platform::Device<Core>,
-- 
2.43.0


