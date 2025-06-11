Return-Path: <linux-acpi+bounces-14282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F6AAD5D5E
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 19:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069007A9B58
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC67080E;
	Wed, 11 Jun 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBFBvLJD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24420C463;
	Wed, 11 Jun 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663761; cv=none; b=B1hbeHQwmM2QJqw9j4v+CBQ9z7NANFCQ77UVSLEyYhqrY9Ewrp1EWM2NQ3vrOzIDZL/kpASp5DVj7eUf9XOwT7wNaSEaQixk1D1L9tNKfqpoQTQHhWU6bdoggAjs8PAQBGFlGN/EpqDYp1xe3J4IG1IdaXmVOi2Db+gQrnYT3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663761; c=relaxed/simple;
	bh=+7hlOHTGyzfkz6jFtb3mrOj0g8LJ223bjIPqkP9k6eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHC51MTVzzrzbvgCDIzrXD4TAlD6jf5230UyL1+lUgc83Yr6Ev+/T+b5uN+5xKMKVzuTuE6K7CkCVHnX4NM60x9hkLMq7GNwjS6bPxGGdTo6J0Vooo7X5Z5HzgfUgq1ICycs+8FJeB2O14pFlm1yPSJQROAGy0lHXEo2u2N0Cg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBFBvLJD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so327945e9.1;
        Wed, 11 Jun 2025 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749663758; x=1750268558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bcxpZFPwbSvixcgtkq37B2t3qfcJWLChmp+3p260Tmc=;
        b=BBFBvLJD1tMVCQzsikPij3LnQteTTJXv8c55BsV9Ar2PxxjedAs3zkYnHmQmIEcinB
         hIpaT62KAQ7ir3CVUlkaH1FzlvsiR8g0a6yNtrPBXKgRJheOz9ouKUtTOJ2KnAJnm5S7
         zWqSk3qj5sM479QHYgV1noOE5LJTYBvhQ298tJG02W+Z+YVl2ALGPlV0dxtvbMc38EFP
         dcLZBVzLSPPLGA9OwNYElbiPaUtqK8m8pEJoeQihxES/lew1ch76a0nssBfJ/jLvs7bK
         13vIv10/zPrTRF07hz+p63eRmcFRvXgfxmGp93SWaKl3/+57zPi1u9CpVxCD/SiVcBYp
         uGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749663758; x=1750268558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcxpZFPwbSvixcgtkq37B2t3qfcJWLChmp+3p260Tmc=;
        b=ONGt3iAAcYSbVpAI632cSrXAuNj5BEGX4RNx0ZFSPArmboIAi+nrRn4fALakE3aDQZ
         avSTKfHTzcYoIUv0Ls5H4jF4cKgMtuUJ4ZYm0A7hu7bT86s/eXXXimGLWmFYZ3YTN4OI
         uKs//E84FiREbPWbOeQ3U6PcEYHH+YZ7nq5JoehP8o72w307n2eodfWaxUeFNAKJq0BB
         1+qJkMqsvBMD6t15zCFDUDsNd5LbQTSa8g+wq4rGRU0n6Ae78D1/cBMnElj9UGOkkbdj
         LT9tOB0df63DUGZLDsaOyrcSHc0uBjV70qqE34QDyTm+NMNfpYMp08jK2CNXz8iyEqfY
         J3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUF/UOIcmBRukTmM8uOcY956EhLfJZP265yNvM6M9TxoUk8i36p6PQiAEpjYhUSTpyYf+xCbazguciBQGOd@vger.kernel.org, AJvYcCUaVX1kIlQKpmDinnrkeyc3JM1VYfQIHZw42GD/efQjiLy3pdJ5F9So5Mp3wPmxHuIMLjKh2s0glyCu@vger.kernel.org, AJvYcCWjTmr1vgdVLCWx6qLUpDjJVc8Y/Io2/k+wsAtOOO0taEpf8mGLi0ygKdEyiFksa+JLmj1hfCv5vcL96tLcqwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrJrJchEs7jwaT0pOHZpnyQvUgy3aBywumNABlKSajGWcta6O
	VJ9VNjIDXTBDkKuVAO4+Ix63cyc8KyeaSK/wE6ajqPkT0a+29sO88Eto
X-Gm-Gg: ASbGncuFykCc2zplqJ8ZsGBaQ0Dnkc92AqjYVewNPURbVHUaJW9s9b7JEWIwbfMqbXc
	8Cmn171UO7ZYvlwzuqQqgXqCcZEJQ0QhAwlFrlCVOEMkQiplOCpQUJIuqoKtBKGNjTjyO9FPfly
	lE93YbpVDz/inv+dbT33uMh/6m7Kndg9jNIV4N9SWjI6qMgJmywwcmsmkBv+BSATPaY0XgG9Dqd
	CdtLqVtC0DSQyqEppCEg9oATYYTFBWI5wuGkPKmxlzqinUcOqRZOhHbePKS1sYhR+sZV67PPH5m
	vKHc4lLx9lUomVHPv1vbDtoY91Mz2vUP7GOC80H5SHhNgli4EpOKkz+a2Dp9AzZq9wORXSatsJ3
	mC8W4gYTimJ1PUR3IdHXoyQ7B36fUS32n9T8d
X-Google-Smtp-Source: AGHT+IGqXKmrevR7joOVP5V2a+fTB0jNzy8eGMG+UQ0h+Xt8qIsJsAcR1SRGcesVEkYOMOAQuDf0AA==
X-Received: by 2002:a05:600c:3496:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-453248f984cmr41545315e9.17.1749663757317;
        Wed, 11 Jun 2025 10:42:37 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45325205053sm28137415e9.23.2025.06.11.10.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:42:36 -0700 (PDT)
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
Subject: [PATCH v5 0/6] rust: Add ACPI match table support for Rust drivers
Date: Wed, 11 Jun 2025 18:40:33 +0100
Message-ID: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for ACPI match tables in Rust 
drivers.

Currently, Rust abstractions support only Open Firmware (OF) device 
matching. This series extends the driver model to support ACPI-based 
matching, enabling Rust drivers to bind to ACPI-described devices.

Changes include:
  - A new `acpi::DeviceId` abstraction for working with 
   `struct acpi_device_id`.
  - Updates to the core `Adapter` trait and `platform::Driver` to support
    optional ACPI ID tables.
  - A sample implementation in the Rust platform driver, demonstrating 
    multi-bus matching.

This is especially useful for writing drivers that work across platforms 
using both OF and ACPI.

Tested using QEMU with a custom SSDT that creates an ACPI device matching
the sample Rust platform driver.

Igor Korotin (6):
  rust: acpi: add `acpi::DeviceId` abstraction
  rust: driver: Consolidate `Adapter::of_id_info` methods using `#[cfg]`
  rust: driver: Add ACPI id table support to Adapter trait
  rust: platform: Add ACPI match table support to `Driver` trait
  rust: cpufreq: Remove unnecessary `of` dependency in cpufreq example
  samples: rust: add ACPI match table example to platform driver

Changelog
---------
v5:
 - Got rid of unnecessary consolidation of `Adapter::acpi_id_info` methods.
   Instead, firstly made consolidation of `Adapter::of_id_info`, then
   `Adapter::acpi_id_info` is added using the same pattern. 
 - Set `Adapter::OF_ID_TABLE` and `Adapter::ACPI_ID_TABLE` as None by 
   default. 
 - Removed `Adapter::OF_ID_TABLE`/`Adapter::ACPI_ID_TABLE` initialization
   example due to irrelevance.
 - Removed extra `of` dependency and `Adapter::OF_ID_TABLE` initialization 
   in cpufreq driver.
 - Link to v4: https://lore.kernel.org/rust-for-linux/20250610145234.235005-1-igor.korotin.linux@gmail.com/
v4:
 - Fixed code example for `trait Adapter` in platform.rs 
 - Fixed driver implementation example in rust_driver_platform.rs and moved
   it to `trait Adapter` in platform.rs per Danilo Krummrich's suggestion.
 - Consolidated `Adapter::of_id_info` and `Adapter::acpi_id_info` methods using
   `#[cfg]` per Benno Lossin's suggestion.
 - Link to v3: https://lore.kernel.org/rust-for-linux/20250606170341.3880941-1-igor.korotin.linux@gmail.com/
v3:
 - Removed fwnode type check in `Adapter::id_info` per Greg's and Danilo's
   comments
 - Removed `is_of_node` rust helper, due to unnecessity. 
 - Fixed example code in `rust_driver_platform.rs` per Danilo's comment
 - Added an instruction of testing ACPI using QEMU with a custom SSDT
 - Fixed minor code formatting issues.
 - Link to v2: https://lore.kernel.org/rust-for-linux/20250605161956.3658374-1-igor.korotin.linux@gmail.com/
v2:
 - Removed misleading comment in `acpi::DeviceID` implementation. 
 - Removed unnecessary casting in `acpi::DeviceID::new`.
 - Moved `pub mod acpi` to correct alphabetical position in `rust/kernel/lib.rs`.
 - Link to v1: https://lore.kernel.org/rust-for-linux/20250530123815.1766726-1-igor.korotin.linux@gmail.com/

 MAINTAINERS                          |  1 +
 rust/bindings/bindings_helper.h      |  1 +
 rust/kernel/acpi.rs                  | 61 +++++++++++++++++++++
 rust/kernel/cpufreq.rs               |  3 +-
 rust/kernel/driver.rs                | 81 +++++++++++++++++++++-------
 rust/kernel/lib.rs                   |  1 +
 rust/kernel/platform.rs              | 29 ++++++++--
 samples/rust/rust_driver_platform.rs | 71 +++++++++++++++++++++++-
 8 files changed, 222 insertions(+), 26 deletions(-)
 create mode 100644 rust/kernel/acpi.rs


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.43.0


