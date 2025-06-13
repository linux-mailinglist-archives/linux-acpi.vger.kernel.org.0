Return-Path: <linux-acpi+bounces-14354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F655AD8EAE
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 16:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179801BC65BF
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9BD18DB24;
	Fri, 13 Jun 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACaFf16e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFFB2E11D8;
	Fri, 13 Jun 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822709; cv=none; b=iA/CeqMOjjozha1w/lsOB9Js4o0KTdZ96t5oAxHxjdBtBF4mImFXoZKdb2YRo9a4oVJZMZkO+8htsKyYeSHkUaCSAczZ20jvOR/YlKUkQf+HVgtxXQqi2v1V6eAErtUmJe31wvkyqMt8QQlkkHOz2TiRvjA662GrxOV2AKKoX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822709; c=relaxed/simple;
	bh=qrwoSmZh1uvAMGuc0OD8LaGxAk4MN2XVSm5XQa5DvhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nazL7Ov8WZT4CrG/0YaV0ZqkKzYG7ix5xG07D2TvK17VuxQewqnJ/UE1boDGudyeO6ahr97+TVMxII+L4CurTR8O5ovfStfEQ08LekdxxiHzHJjkvX+sOVm53I/ueCubv/v24GNsrMu6wikII7TNIQBYUBG/Z+1ZWOtDU4FmvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACaFf16e; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so1314037f8f.1;
        Fri, 13 Jun 2025 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822706; x=1750427506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xp6TNa4qUBX4uNwGZpN4h1HBng/ZXNtRsGZbvmQNhiQ=;
        b=ACaFf16e0MaWOwO/MBRkB4qrRKM9lLqr8j74FCQlSrXFE/bpdUBAan29e9UZMKs4i7
         PdQXhw4Tq8ME1eXnJvafw5xPrqUbO6+SFHk7V5vfw4hVrcpIA/bL52wqTJFhKEj34kFz
         KVR/poYbJcx95j1nUVfpBxW4FBjsPDnxzVUjPVncfW+n+dy0bmi4ovhDGajFEt9vqOy3
         57J5arwH/pOMBY1XduXwIlRJ6wJk+M6fLtbowBB5gD7Sc2TB8R4qhyaiRNkdiOvHltU3
         Qg9Iu3K1vyq3nKDItkrlC8IejEOelVVqANuPFib01tO8GJdSPhgh2FGjwcEBLiJPHsDy
         TpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822706; x=1750427506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xp6TNa4qUBX4uNwGZpN4h1HBng/ZXNtRsGZbvmQNhiQ=;
        b=LKImXttKVE2rsPpJ6lUSLta47DnkrgaaPgXu7pLkqoEijK/Dh8TR1SOBO08LlhvfKP
         +RtA7bNf1K477jLC82j+sXkYCcxmfjUcfzsStp6Br8mtHbXKwem2v4F8jeeTthzNtF27
         i5xnYLg/yKaNwxaEsUnGgXV1sRfEO0BrBDRBTb3/g+enUu/PYhSpnptgmvbwPlIxk/Ey
         EVFSGEzFWSE7tcteP/75PEspy0Fzyv2sUU/huYqB7YXe8Xrlemt+BvruX9WW3llOy+xS
         aNWOsNGQoZ+FupPFBNIChuLizHyhCR0mbfhatJkBca4OJ2KPqdZo91mvmROJlM3XcLGK
         2eiw==
X-Forwarded-Encrypted: i=1; AJvYcCUNk4p0go5+id+12BPhn1Kd2dq+xy8GUp6x2FLnVpGPgBgf9pD0ixgej9XPi8sz5/17Kni6OfKyvjF2@vger.kernel.org, AJvYcCUYFyUKmY2h8xSqaF7adJH/4JKKQS4FRMq5m1iQEZxDIUgqvmNoge7AUHJDwjnqFaS4mYXbfEBozDqG/SYe@vger.kernel.org, AJvYcCX/vBuTcpABgzcb8A36Qt30kHeilgPkQKc2Pb7pNCftj9US4/7uCS4b+iB5L3Cu3d1tcoFu2NshDcRt5ybSo2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+pTN+TiIM5IdczZ65PD3/UWH0fk5DGgSudFxSN5iNlkrQj10
	JXz0L/hZsCllIvyeEqi08tSKoQQAXrY5NEdJolHKO68RZ49iTqLpUIA2O8N08L/yVDY=
X-Gm-Gg: ASbGncuWZ41mP9VuG1kXciy8mOOcLP2fwgon8JphgqC7AxBx8CBYcXV/WL/3TmoGmRj
	/kZuBrq2+8uHm7v//51ITDxa29bI9BMzuIrSXQY6hnkizEImrY5YEjNTjbInz/+A1Lcvjj5hRFm
	kNVimHntE9ZTcm6slqq0mH2j+XVOs9ULUVKUN7y0MyJCoQj1/YuaHqFJ8HL2tiq4IiY7N+VWMwh
	Ezcxp4DE1r/r6XiSH1v8+yYR3WYXt69xbo0Iw0L7XMbBqtNJYu+qP4PBHmNZKogubg1D8HAzV72
	gv0qcHnSrhgGmtAjPuZB1qrtsLTUxvhh3cM4lMbF0LJVmusIivuMmhHQwJC0PpiX9Ifcku8Ls9d
	Gx0k52Ggfb0eMt1eGJPXUroJdL3H6eKrr+ak+
X-Google-Smtp-Source: AGHT+IGgi31tXooyEV3h/llbbLtPIOyeOEKKAWW17esYDZOUzx0JrD+WJRAVNUDlqd/B7dfjeISPGw==
X-Received: by 2002:a5d:584b:0:b0:3a4:eeb6:3b6b with SMTP id ffacd0b85a97d-3a56876da63mr3590191f8f.43.1749822705452;
        Fri, 13 Jun 2025 06:51:45 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08c99sm2445560f8f.63.2025.06.13.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:51:45 -0700 (PDT)
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
Subject: [PATCH v6 5/6] rust: platform: Add ACPI match table support to `Driver` trait
Date: Fri, 13 Jun 2025 14:49:43 +0100
Message-ID: <20250613134943.1232287-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
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
index 2436f55b579b..62a9e4ec5c19 100644
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


