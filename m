Return-Path: <linux-acpi+bounces-14284-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A099FAD5D6A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4989E3A93C2
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E422541B;
	Wed, 11 Jun 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWzVMf6s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FB12222BF;
	Wed, 11 Jun 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664110; cv=none; b=po57G+7hhnyxO+1edlvuDN5jJfjvrQoZGESksa+/aAqKQd+YFAxFqOtEjTOYsDQ3gN3UPeW9H0EYmPCv2NYS+/vDr/AoZip5AOnpOxEuXt62b/eLFZef5yFS4jx7gfKzKq+CJfCv/D3BpoxSguWDSHfbzfAXFKjAqn0QIIZoaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664110; c=relaxed/simple;
	bh=kdiPdMh5+sRzNgtYRKj/S0sAtUte5v+zpvWVg0DO3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv4wyTSPNILOqSNPxZ1PmLgyendbjmIVa97yp0yf94erd+W9rFmgRgs8wrVuCJj0/iWplB+qRO4KOdGek1sZ7tIq/j+iuDskyAp8AXWU/NxHVp/2F/zckzSggGHVmkaVNiCeHTbumB3v2haGYPgH8LNXsVPV1xGFAT7GYaEkm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWzVMf6s; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so128832f8f.3;
        Wed, 11 Jun 2025 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749664106; x=1750268906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5X6IDTVHTHpEsUSABa7MSKK8TKkDRNQdpFJlmd5FHY=;
        b=OWzVMf6s6ieIQYLHaHb6ghg7Xx8IL2sFjoZGw798cylsvbkontJo7bpzQVrFEu4Yuq
         iTOT/c2TIUt4xopwrqKsSA/oWVFA7D/4FGth21PIq2mDpzWfjdbZatc5dda/Q+KZQ/zK
         r4kapflS0SPVyP2rn55Ki32gFjFcPAqYPnOH/Cy3LGATKlNxM+2LCU2/0Q+yQQJ/bfAm
         x8YGJ/gy+Mnm3VidenQ9BgX12kRBpkJUcb8u+Gng6KL/QpH3Q6C3w19FiOIle2/f+OfW
         PAQA2a88e/0ox4kX4XUrN84pLHq8NYxgubVDFizKWUAsbwj9iRpfbCRz9RYK6Y2O1lwO
         rZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664106; x=1750268906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5X6IDTVHTHpEsUSABa7MSKK8TKkDRNQdpFJlmd5FHY=;
        b=YyZKE8/duq5Ok8fAQSy0YXB/WkBtcpJFtV35/64JiWv2oIb/PB/J41HeqenyLf/xiF
         SpS9rs4OWHKXbRBxl2hZhsiS0mJlBJ0cv8t1W6xoFZ/YNNhNiAKQo8dzMMFWILsLBzUe
         GDTyRLYXvOCmIeColvvKuUmQX046nTlH2dMQkvV3vLWLXOttHd2ZoWFXbo3SXbziIGUe
         7FMnkq0XWGUiDJlLy5yjIT1wQyIZQQ3v2K+9TeczYLhV0KZkiAhZQcd6DT9fOIAD4WvH
         +V0mddy3eJm4zOpaOBl2/F2Ksrt7ShQAoldGMrYIPXRBtltjNXHC32/KrGRKf+jqW46C
         AKrg==
X-Forwarded-Encrypted: i=1; AJvYcCVK4+34hZQUGvJmneRwXv9FBnZiBpBoJDctJhGhFRkT5xl0AlK2a6x+b6kmzZwkPhyO8BSsQzR6y0y/@vger.kernel.org, AJvYcCWCbYsyzcbBKWh4VEKShGTNE3gxa48CMCR5HsQKU93CPBle70oWfdBG7NXW1ObG7AoV1yg/wZeEiMdOGx/5PoQ=@vger.kernel.org, AJvYcCXK6NtMT+L48jUDnWJ6UQ/ILzALnMiziVrNbHuoXn0R4G3tRD1uZ6rHNB94rFYrUm2o8FkKZz5lNq5iO9n1@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDo4yqCngu++yQKtuzL8PH8TpySugk7bX4twkvd5f3p36cyh0
	HD3eOJ0fYwPDYtbBqcca4Kg1xspxPHOHS/SL9mQvZX5Sn9f4ek56w4pv
X-Gm-Gg: ASbGncssNsoINbtMNvNRcNp0B8QZUrAafeVBXzOP6MJIHWdWlxeIU3lLtdwp0qVBk0Y
	hIp5pmcFzdNMNYo4e2rI8Fp0Jf4OH96rToCQXGQKofckH+UbxHqlFfi5X/uEnNkiW7feORHKUkt
	rSrgSFOn53w7AP7SFyBiacuX8BUdMLU0g8DLKPwq5xJtPPH8iHZAvYMT4ZNSTH+gxMfrSAVdb0f
	X+GFhWY9US2ZYjmVKd2yNbo9i90VtogdqaGOxVufF64z1bgiDI903QTmUacGMr7FJh464nDjUNQ
	InqCTGKe2FAcnZ9GGf+Vlh+aLiyoTaF+aBqbiwqylBAK0Dge6YPNjQS2ky7aaz77U0531mgvUbd
	PaBM0ExYNGHQJkkRiGEK2YcVavlaK84S//jRF
X-Google-Smtp-Source: AGHT+IEWahY4VTUQyB9OJcRC6ofG32cyzKi87gxJN/O8EUIgzlNL+d8o1qKXe//gLU6r8J4BUQxjGg==
X-Received: by 2002:a5d:5f8b:0:b0:3a4:dd16:b287 with SMTP id ffacd0b85a97d-3a5586c9e06mr3087427f8f.19.1749664106429;
        Wed, 11 Jun 2025 10:48:26 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532522a5f3sm29567945e9.38.2025.06.11.10.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:48:25 -0700 (PDT)
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
Subject: [PATCH v5 2/6] rust: driver: Consolidate `Adapter::of_id_info` methods using `#[cfg]`
Date: Wed, 11 Jun 2025 18:46:18 +0100
Message-ID: <20250611174618.802570-1-igor.korotin.linux@gmail.com>
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

Refactor the `of_id_info` methods in the `Adapter` trait to reduce
duplication. Previously, the method had two versions selected
via `#[cfg(...)]` and `#[cfg(not(...))]`. This change merges them into a
single method by using `#[cfg]` blocks within the method body.

Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/driver.rs | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ec9166cedfa7..cb62b75a0c0e 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -147,30 +147,32 @@ pub trait Adapter {
     /// Returns the driver's private data from the matching entry in the [`of::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
-    #[cfg(CONFIG_OF)]
     fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        let table = Self::of_id_table()?;
+        #[cfg(not(CONFIG_OF))]
+        {
+            let _ = dev;
+            return None;
+        }
 
-        // SAFETY:
-        // - `table` has static lifetime, hence it's valid for read,
-        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
-        let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
+        #[cfg(CONFIG_OF)]
+        {
+            let table = Self::of_id_table()?;
 
-        if raw_id.is_null() {
-            None
-        } else {
-            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
-            // does not add additional invariants, so it's safe to transmute.
-            let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
+            // SAFETY:
+            // - `table` has static lifetime, hence it's valid for read,
+            // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
+            let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
 
-            Some(table.info(<of::DeviceId as crate::device_id::RawDeviceId>::index(id)))
-        }
-    }
+            if raw_id.is_null() {
+                None
+            } else {
+                // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
+                // does not add additional invariants, so it's safe to transmute.
+                let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
 
-    #[cfg(not(CONFIG_OF))]
-    #[allow(missing_docs)]
-    fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        None
+                Some(table.info(<of::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+            }
+        }
     }
 
     /// Returns the driver's private data from the matching entry of any of the ID tables, if any.
-- 
2.43.0


