Return-Path: <linux-acpi+bounces-14286-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3141AD5D84
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6122C7A3E0A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8AF223DD7;
	Wed, 11 Jun 2025 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guHekeuo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC82A20C494;
	Wed, 11 Jun 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664416; cv=none; b=KAMeuniG833RlagezOzacTf/dFeD+ORziiH1Ak6uyBVDsOiR79lPN1R3RY0O59Y0heCmDwADvJkjtJu7XPcjU90JaS2dvCCNToHe5OqGZifuD51j59SpNtTESTz69s5nP42WKhBlLC9n7Qz0vEHw7GM/SzHIeDkMKIDxxErFN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664416; c=relaxed/simple;
	bh=Po1X9rUgU4wi71QhvqOh3Icg0CCiu+EgO5R5WUZNJdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ10073WIxO/nEG8Y7BWJwUOJcr1IVQlEB44tfSHi7vXIH+dHcXeXozyeyzZWpWf/i1E9gCspDG7NKa/7RvVAQEfizoa4p/5w++WhEJXtDsv2fwPx5cy0+Wz9xfIw5Gu4F8nN8MY+TnO8804/o5Rw+kP2qZ+6150MKQyLlSCtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guHekeuo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54690d369so154826f8f.3;
        Wed, 11 Jun 2025 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749664413; x=1750269213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6PUqmIbDWFmOXx3GycCUnmQ+C2eFlLVgcIz/6kRBRQ=;
        b=guHekeuoJ6+Th/UpFyROjtv6gqYn1lN+S+pf2STAZhB+5bd5K8hjgBpVAwkWK+Tmy9
         KrnNQm2dgliHARXUXN5Kclzb783Raq+vnjxCYPrNrAVmk4EsdBmOkz7kBdZDdf/lq1p6
         J+EtsqIrOvhw/1HD7SGqfiEmvAieHJfVhuuXPRJqAEnCxNM3wqstIr64VhNK7p8NyhB6
         QbVZhZkHGpQgc5da+SgxQJ/mVcpFMuWJaOjwKG1zsOGPye8rqdq1D2fn7nACrJGHedBZ
         FIxoPqxDSRxkmRGDLldl/4Yb+eHSDd4xVnI/tlI9Up3sQtMITVOSnNxRhTkPdIFqE98x
         QN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664413; x=1750269213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6PUqmIbDWFmOXx3GycCUnmQ+C2eFlLVgcIz/6kRBRQ=;
        b=enpNAsOHCg5ffHjAzXRJV70rbBAwHPMZa987eT2RvWWf3NrfjwDkjuPLvRo17BE+fI
         BgK1WMj3xasyO40VWqEQCDjNRx/VI3opqn3sYpzGlyFWVIeKMoaLULRKu5Rox4sFctfz
         1cY61dOXseVUpHvSgSDnRrztfisECDOv/prOdnRlbnR2SR1wdlA07yyGtD4a3E95MseQ
         CEdxAz3Uxwe/w9E3G8uT3Qbl85mvDLME9UR07Bzh0SyGcmx1TVBwsn23JI0w/rkK19aC
         7bJFHvNgwSpM81k2F223k8y30oikG76ANkQR7LLf/mBaWD6dhNa1fQ9Ddvis1cHe0FPZ
         E/hA==
X-Forwarded-Encrypted: i=1; AJvYcCUlN/Lz/K6Oj5DHVJ59A3UJ3qgAS5GlI/ZSfr7gj+dOhrwhUOYF40poVCJYgt/IMeCz3lhRKmu1lymBWpzfryU=@vger.kernel.org, AJvYcCW2BHqnlKojxq+23z0xnYJsxzwMOftyYOt6zA5VnLzQISyd1ZfJbqOsgwF9yCJ8222TzMCDazymz4amA8ak@vger.kernel.org, AJvYcCWwTF5mp2Db/kA/3pNLOSX+DFNV1/c0epqPHHpBf98QExvkoeNxLMgZdFl6btxv3KyUAmjvzgfjRIz1@vger.kernel.org
X-Gm-Message-State: AOJu0YypB8rcDtrUgpWmvOAc1rPxXLgHNjPy1aXZPc9z/Hgj3mxrASEz
	H7djSke7QX+on79IqDD635I2Kf/c+XUOqkQhHXtye4RbQEZWZvDcf+jL
X-Gm-Gg: ASbGncsl6z2/LHPST0SI0skY6W8r6InpEKJBYZV7HAF6YNdqwQPd1WfSMEgzq9zo9nY
	mnpoqbc4mKRQK5sCrIk2FzC5mLBBgF9vtlZfcPQpgNi67I9s9t5zcB7G1mD6hEn4vhZfjBrI8No
	KdyTeJC77UWFXqhnhbkjbAt7mtTDMoi/P5hIr+GjSdd7mDWlnKuZY7+AVofBeSvnquAKeo1ivEW
	xIRKgJEaJ41mKcm382hEXk3eyQzgphp72mgKu4a8M56bD8605YhFhJpkM2w7PKrZOuAFSs8I3Az
	mK/93PDItY3Eo11hSqkV90Xqy2JL9BpkicoQ8h83s1cc4WlxtyKjVrKZiyKPIZmHNjIESGY9IuA
	JlfYhF0anZH4NWepWm17co0N8NPREQ7n3gnDU
X-Google-Smtp-Source: AGHT+IHHI6WBJu7sDHEdtjSpBu9n0uInWMVoRmYpWTOUeUcEnqml/Fr3nnahD1USMoDsWks5VhOaCQ==
X-Received: by 2002:a05:6000:2512:b0:3a4:e502:81e1 with SMTP id ffacd0b85a97d-3a558a4238fmr3627250f8f.52.1749664412778;
        Wed, 11 Jun 2025 10:53:32 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532463905sm16203603f8f.92.2025.06.11.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:53:32 -0700 (PDT)
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
Subject: [PATCH v5 4/6] rust: platform: Add ACPI match table support to `Driver` trait
Date: Wed, 11 Jun 2025 18:51:21 +0100
Message-ID: <20250611175121.803370-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
References: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
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

In addition, set `OF_ID_TABLE` to `None` by default to match the behavior
of `ACPI_ID_TABLE` and to avoid requiring drivers that do not use OF
matching to import unnecessary dependencies or define dummy values.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/platform.rs | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5923d29a0511..62a9e4ec5c19 100644
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
+///         (acpi::DeviceId::new(c_str!("TEST4321")), ())
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
@@ -162,7 +178,10 @@ pub trait Driver: Send {
     type IdInfo: 'static;
 
     /// The table of OF device ids supported by the driver.
-    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>>;
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+
+    /// The table of ACPI device ids supported by the driver.
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 
     /// Platform driver probe.
     ///
-- 
2.43.0


