Return-Path: <linux-acpi+bounces-14483-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3045AE1ED9
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA5E165479
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7E2D191E;
	Fri, 20 Jun 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8C4J6+/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A919A297;
	Fri, 20 Jun 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433943; cv=none; b=BzmJS2E9pTuKYwaBWzb3ZCa1StIynaA3DWZrrR0ao/ChzUbRmdTGtvc5t9Lf+gRDWslTZnh1lFW0t1WWdDE+nJF2C4Yi7Nwhl6UgHj10H1RLW5CL2OpeovAPqmkCEtvFzWdmeZjs9t57on/dwYRcmOf6U3QQGw1I2j5c7gbXklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433943; c=relaxed/simple;
	bh=kdiPdMh5+sRzNgtYRKj/S0sAtUte5v+zpvWVg0DO3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch5qtOPcd0Wjabr/4wqjNFw/njH8Ieqj8OhdVuXWLOxYLkvWy21xGEyeavlxnLZUberuBkc3QPWp0S3/6K7/LvqT/6/p1n3kVqb+24Nwwg5rMR2yfXMqZILcJstCZvWYKWMC7vklqdIBwz24wjU3BJaYqamQxOqWjaGNDfT+daA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8C4J6+/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so14548045e9.1;
        Fri, 20 Jun 2025 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750433940; x=1751038740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5X6IDTVHTHpEsUSABa7MSKK8TKkDRNQdpFJlmd5FHY=;
        b=f8C4J6+/wg6QDOROSMmYbZ0GaohbAYmB1NCpq+JNCD6g5PzcOwFtYBUIzSyWZ/Wr5U
         zVaVjhS0AgsvlOebSkSK5BOR48g56bs0DWYnng4UwCXH6s7cwJFVSKreKYC2/hB8xiFd
         lrp5oTOpchNWDWv+UXs7tNXR7GHOBdnY7LZw9z7pDIDjNi8YFm2zScoIUjNY7kHKsSV4
         iaM4Lgx7YEezRGkBhozRSl9JLzbjkHN/orKXmzfG4lJPicJ2tU0zkkn5mHuR+8n3xwym
         MwH9Gcbl3t51tvO0tQah5HrH/KawqhXQHRpxewpGHrCcobwTzKvSOol6csHgXlqkwh8z
         nLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750433940; x=1751038740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5X6IDTVHTHpEsUSABa7MSKK8TKkDRNQdpFJlmd5FHY=;
        b=GJvtxk7fx3+S+adiKpz8GM/yQ8DpkBBWyooNZ0dvwPDlp0t/Pexm4pKPWpRZ0K3DgK
         G7gONSM5ggooY/BvoDkxBGsF0a7Ihlk3L3eTkkDL2xaaD0ZK/5j9qP6U5CgZ4DTmF3h7
         FwST8E5flromyBj4j4+30hanoLIN2W5KeB6+IixpPF7xWvNG3OY4VQvdLuwI4aLqq+il
         Sop875q4yrHa6JcC/Lfy6ftYMGeSHdozR9W3Q1HDl0HfK9xHZQaHZBM7GMe3uHgHnpao
         ariOXvXCihYoSz0fkNJfubgNMVdsm93mqAbUefJLyx6MUnPDs9fUIQEl6ZiM9Tcabl2N
         H50Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3YP7tRD3c3jI3ZmOywU1OLxCIhsNVM5okp7RhERaE9GQSkAB1qkaD3Pb6QkKUweHeHU3rwj1AfapK@vger.kernel.org, AJvYcCVVl73jjX6cAuFjEnoyEBMQYdMuRkAUSSTAos0Vfn4op+fBpmuwWDasCNShRjjjCdwgjAj5APJVJNn4SaPreD8=@vger.kernel.org, AJvYcCWBlJIgaSl0qMqDHknpShnN5D/CCW4taphFV70i1Tptadw3x6uF//6HGkUg/O2QDR+8YaEClKUaN/VpMQ==@vger.kernel.org, AJvYcCXqn6+8g2JSq9Qvgn6MV6DQ8MKCHWYM2jvu5VkhJJFsF+gDs5Yac2b9xsZMhOJoqRfcxrTWMUCFrBNCu9S7@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5DVI/slNwimObtWSKpeO9uFD36DGrTbQMgn21PVHUR68s5SN
	vSu1QTO7jkLxCDFx0k8NuotUAtce1b2vWFAA+IBUAHOcmIi3Ij/RPflX
X-Gm-Gg: ASbGnct66P1fiE5xef0h9U9R/fm7yrMHkAHvhDOPB8vG4LDrrAIeheSfnVqLrkZVNJg
	Mv+NQT5SfDJrEz4xmnbRl9mHegfZSGX8b/zbejrmyqaq3NRoJd4ZPqwsgSZWrwbJYp4NzuuZzGW
	g2M+V/ZJaYMir/aRnWKN0ZUkpVeyDqS5z6QLy4JlYqUgNeQ0Y6pIkqETztZGLog1/1yt1HTSrRl
	QlPO633LTpmuPigQh0MqU9fh1vmem5UXY0X0vtzGv4h1UbRto7hYBTwDj2ALsdV7KPScrkLYPPq
	WOq41ci0iluewTqymCrS7+tV/Ipi/Lh+LzVjLKw80mZOEDR/6bgwgANHYjTSqs/rfX5VUctIW+i
	NQiDjDkn4w2AvFouUhLTf3T09ymtQxyWvIGqV
X-Google-Smtp-Source: AGHT+IHBTlMifqap8Yx6rGoRjLGMK3thDNHDyszupBIkp4SOG430SYgjLtQZVOEL2dpCSM+Fq0Q+Ww==
X-Received: by 2002:a05:600c:1c02:b0:453:9b3:5b58 with SMTP id 5b1f17b1804b1-45365e4a008mr26113405e9.4.1750433939906;
        Fri, 20 Jun 2025 08:38:59 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c6b2sm2392627f8f.46.2025.06.20.08.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:38:58 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Alex Hung <alex.hung@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Remo Senekowitsch <remo@buenzli.dev>,
	Tamir Duberstein <tamird@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Len Brown <lenb@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v8 5/9] rust: driver: Consolidate `Adapter::of_id_info` methods using `#[cfg]`
Date: Fri, 20 Jun 2025 16:36:56 +0100
Message-ID: <20250620153656.294468-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
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


