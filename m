Return-Path: <linux-acpi+bounces-14442-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA1CADE8EE
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF88C189E803
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E77528A1D3;
	Wed, 18 Jun 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQbwelzu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783C288C25;
	Wed, 18 Jun 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242400; cv=none; b=div7dbqi2MwAkQZO7G+fpgsVyKwCVPtBOMe+t1A6pH//ff/+dpoMRTuh8pSW19RF/0AF2+0vgUDAbMnmEUcmE+eeTmaILdNq4Cn1HoFsY8T4oObDIT3/A/+OtRo8n75EuDWQAXQudPXIgK2aEGxYdvDkszRLEcVpVFKtsV4BZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242400; c=relaxed/simple;
	bh=fCZg+qa6/P+Asbd0KRfxqaW80M7dwYJ1XuU8KBHp+rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVxmcoom04o7qeZbaolkr67REZ0NsV+DH2oQiBZPBQ+SizxP/07s1sMgsOTIa4sqwWY1hfrgQ8x4hIAMYYb0p4RRnm+LRUl9K5/EuOhp40ML717q9tmIwM1Jj9O5uIU+zAcib8FLzV1NOlcUsnTDVI0ppDGONK2IuHszs7jiJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQbwelzu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a5257748e1so4859615f8f.2;
        Wed, 18 Jun 2025 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750242396; x=1750847196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKJ+35t8HG4O3r9CAZlhOHv1jc/h4zjJpE9N6VOcuWY=;
        b=OQbwelzuFV6htrWm8OUkMzdTM1PH5HTFnjhH5V+Uflf1Z6Vwr7i88XOo874bO0Oeyb
         cyN2jJok7mGUHprnWFbWflDYRb8tzhl6aHU+VlAPkXk74T5nEsV+AIRwSpRpPTTQU8Yl
         xs4GF8de0zAE5+iJ8O6SxRdRGjZu/QcZPzQopwzdPWHegMSgtYB0lF+JFUzOJjioX/Ol
         1IwLirer8by/6M85I7wwxze9sA5/+OdLaaY44dgC+At8FFEdEM5Bx9eIM5OpsVLrpehd
         7B2TXID9JlSJye6oIoJ1jJuxol5JDad7HA6K8Cq6ZkpED3hZjHXxah4c7+yrxZGjQ1mU
         kQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750242396; x=1750847196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKJ+35t8HG4O3r9CAZlhOHv1jc/h4zjJpE9N6VOcuWY=;
        b=kF2dDvWFYQRZUK6kO9VnmG8H54szA4Y1UTMpo/qy5ObQ0I4sR+JwVKoblhYa+Z8vjo
         63NWR5d55MRfetEcS+/0PGSanLAIUDm0w1uIVwAnvf/MptyENWDREwKzL66sr8KoOBss
         KsYQLzLEL6DMYc2pc7cAbk90dji4oAJIpsvb6gwwLdHVlIAh3FNAXD19KmYVPxCbW+f3
         LXVYTh3sXmmuce886I1Q/QG7IzjldT0k4cLp7HhBd9WKvBep1y3BKGUPEgXJh1m87s+L
         D4HSdu70wkVhxB0iBGpXZM0bGhkqrqT+106zmqQaVepzUDbV54bt5nJkTccUbjubzHr5
         8IdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh08koQ8tFYUolQYx8w2l1kxjOg8WXd/t/7iqNncL+ETDPEY4E+g4cR2Szq1dxZHNUgA1G2oMIAa5um5N/@vger.kernel.org, AJvYcCXFLKjbe0BjHX89py/lMN4750Oz63NBAhyy4QIcNB7jgWxisoyb4Sc1DnFuOpqeRMOhQav6tkteVx2S@vger.kernel.org, AJvYcCXMsdCzrgM30stsSpYqdNeNfyZHY4+huimSeV75JVhk5kdxD8A2DMdebaZdW02F6Ta0zXoGwgY+H1R0COHrrBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4ueTMyZCBKQMx25pKS4QAZuMkixyLUJArAd4frtZy1J4lJjW
	8ZgZ/XfeYmuplNGgGg7fqgfS+FEscFKO9PpwyFrArasgKE8EkrwNgjSs
X-Gm-Gg: ASbGncsjBnw16TTO5syV0OLaWFUSbBrMOwOcBXlqtF6413n/0e9eFGXM5Z03ETezOX7
	TsRJ970eR/MpWPPTy/WSGehD4jcVEai92Nhut/Ni+MOiBxnDoO0PYoR35HVzlZ8phgyU50rCjXX
	0zumnaO5gwBqQYJfpi/brSJQ23gZlqjJS+6+HLI+f/TuNphDYr+fI5AoiU/me9bC4s1fD5A4Utr
	iiTaWZlThqBjHsKSfMwRlRPBLUakFbNMX+6TrajohOOu2RZZZIVY4RlOUF65l8uzLQgW8VXuo5/
	hCfEJ8vn0cwRmiOWrBCewiMV2ffAQhH/WOURlbKD7jMlfDYkaC5TmNTEUCnCufpBY5SH1PRKVmT
	/gwye4UNE6os50L1Vc52XCT4w7GZufvF9iK2l
X-Google-Smtp-Source: AGHT+IHb5FsVZYv2LilMOYqaP1j1L8oMI+dOxYRmokRF04f8+Qm6HB/QZ6y9DdDo5scMmE+j6mIm7Q==
X-Received: by 2002:a05:6000:4202:b0:3a4:dfaa:df8d with SMTP id ffacd0b85a97d-3a572367c45mr15194880f8f.9.1750242396332;
        Wed, 18 Jun 2025 03:26:36 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2354fbsm199608085e9.15.2025.06.18.03.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:26:36 -0700 (PDT)
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
Subject: [PATCH v7 8/9] rust: platform: Add ACPI match table support to `Driver` trait
Date: Wed, 18 Jun 2025 11:24:34 +0100
Message-ID: <20250618102434.3049816-1-igor.korotin.linux@gmail.com>
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

Extend the `platform::Driver` trait to support ACPI device matching by
adding the `ACPI_ID_TABLE` constant.

This allows Rust platform drivers to define ACPI match tables alongside
their existing OF match tables. These changes mirror the existing OF
support and allow Rust platform drivers to match devices based on ACPI
identifiers.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/platform.rs | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 2436f55b579b..0d00ab9acef7 100644
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
@@ -140,9 +146,19 @@ macro_rules! module_platform_driver {
 ///     ]
 /// );
 ///
+/// kernel::acpi_device_table!(
+///     ACPI_TABLE,
+///     MODULE_ACPI_TABLE,
+///     <MyDriver as platform::Driver>::IdInfo,
+///     [
+///         (acpi::DeviceId::new(b"TST0001"), ())
+///     ]
+/// );
+///
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
 ///     fn probe(
 ///         _pdev: &platform::Device<Core>,
@@ -164,6 +180,9 @@ pub trait Driver: Send {
     /// The table of OF device ids supported by the driver.
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 
+    /// The table of ACPI device ids supported by the driver.
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
-- 
2.43.0


