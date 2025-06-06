Return-Path: <linux-acpi+bounces-14202-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE7BAD0726
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E582E188B338
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC75E288CB7;
	Fri,  6 Jun 2025 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEhSxkZ6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3F139579;
	Fri,  6 Jun 2025 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229426; cv=none; b=lsY7fmIR0JhqIFy3g19dwU3lx1u2F+gDD24nuNlVJDZnIjspApUMuSIiNGMVKoYe3HlU83PNvjX8GCoq+Ugl+RNHuabWzVLomUew0lyCe3wrEWhoKa2jff6igubwtETG2UGRM5uGbq93RqcfH5XrJmaJQCdNHrj6mrSTbtR6KgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229426; c=relaxed/simple;
	bh=bXVAae7DKMJ0tzjoon4h0PiScmsC2Apz1l3Ep2ZFjNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWp/KSnOIQGCXaVVvH1uP3x0qXvAJoREr3vb3QUi0I8fHKgLPDos5KSRLlWDpgnVL4iuqNQB8YfhmGL6u/Wk7VzlKF6M6PL3k3ekhiK/6WB28kxrFtBbMTBCEB2b/bv/RCeYdjMqruTVgKD0qVQNbq4Xh+y6qdcVtMP6HQ98Q2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEhSxkZ6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so26580495e9.2;
        Fri, 06 Jun 2025 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749229423; x=1749834223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hJOEiywNictZFF5V1cHbMzRCVMfZP5W7l0+Ena+ZBg=;
        b=QEhSxkZ6osU+QgCO7BSSSqUvpY8adJa93BXlnx6ZsC14/mvIib+5nGrUoilyphWhGT
         8I8Ib5du/64nZrxwbO2D3UNGhS4TxNMVrSA7JKxcdsP12+wC5nZXPZWWcXui5ROBB1Y2
         90GHxZ+Vmcx8UaorDLkC9sNKM8TmGJW3PMf8rV4y94BaK7FFnOTb+oaVTrka32z4AyJI
         QzjA9pGBHPFva797iPvhjgkkzWizLA75wFAZKN32iDmKvfzbFR6XauCDjgN6VO3vRORY
         oRgmeHRE1wOvFPCDHU5WePv0PtUKe13SveMChD4Scl/anockne6QOy7z7qVXJnVkwXDB
         VWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749229423; x=1749834223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hJOEiywNictZFF5V1cHbMzRCVMfZP5W7l0+Ena+ZBg=;
        b=eOXJ5Ol4tbkew+SuxL2vVHde4sYcYFCiwfq+T4Pevhk2AR0v2Df7LoSNP/Xfv3R3yh
         z/dqB3DIeZ8khm8fmzVupxEOQjKkfmppTeZyk+lspq979SKWLmxh/qXAOQJFvBmTU/jS
         xgmFfgyFFHdJhyDxz7xu85Qq9FGVqOptwhiC7Pc2QbR/W59pM5P5Q01IVFUc+cqOJNGW
         I+j71I1ZO0AmGoAWR6vY5Wo2iy9d4IIPnQ8Zzx60iNgxzXIn00Bc1AKaWH9of5PkD2iW
         x1e5EOxN43zoAE2KO62OemkZ9grLWAhOAFCQgHRx9rMT2ZFwUW0VRMXH2S6JdXvVUZmb
         1Eog==
X-Forwarded-Encrypted: i=1; AJvYcCUjIWxvhvN9UVzqPRciBSz3XQS9Vmt9Ac7oRkUKh6B9AkNVAQvEQLAg2aMIBaDeYJnolntq7kgq95fD@vger.kernel.org, AJvYcCVTCzqQk6bTwlIQIdCJWsN2y/N8pETLD+jNxO0WRr5gyYNLx/MhziN0cOF4UbxXbnmwMBXJeqd+D7ezPN6yTeI=@vger.kernel.org, AJvYcCVlbbXcdG7dm1RUwxDRSq0cdn6aiRkNlQdcv1bCkm5bnQh6nOQMHXO5xtv4l9U7HKrxkwrEqNsCdYHPqvnC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2vX6lj2NaXud8msi5j/1Shux7oENNKmYXjXrmIAr4V6CXcFL
	OUqIL/ENi7Vv/ZTg2wtUGh2AZgdjuJN8Cvbin7DmOHYgB5hYyoOvT902
X-Gm-Gg: ASbGnctyr62Tu0iAkoISxSfWPSzH3wBLlNtNmuO7vt/teskdX2SdNWmbx5ueE5HuS1R
	5BFq3T0OcsnoN2SDmmllhbU2/2iba87Mw5cL/LsXO8dq+NGWeI3PSUkFITdXntjUz3u9OKx1+Mb
	AbwF9So0TuRBAp2fW/aQyOl+NTGsl2rb1i343wiCyAsV58dKBtlChEVUdnGQ+FilQRwke2dcaTs
	5pbPWjkZpxDag1DB70SF07Xd2ARf/pwune2UW3qJOHMIt4K2kKCzSf+AFN9jc9AiShiWP13/ox5
	aQvyyXh1kwGkzfi4e8ZkmIGz4eV5VYfUr4Q/AQ28Z+E7iHKKUF3HOhNJw5M0zyxJ2Tkol9lJllv
	L+WaF7pfS15AIOZljmFtDlqI=
X-Google-Smtp-Source: AGHT+IFhV3GFPFoA+00yt9MHy083gJVi+t2TgGm4p+nHQDI4B9+g9acm958QPZwpD82FgYPkjfw2Hw==
X-Received: by 2002:a05:600c:5305:b0:450:cfe1:a827 with SMTP id 5b1f17b1804b1-4520141b200mr46555375e9.31.1749229422688;
        Fri, 06 Jun 2025 10:03:42 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de17sm2478995f8f.18.2025.06.06.10.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:03:42 -0700 (PDT)
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
Subject: [PATCH v3 0/4] rust: Add ACPI match table support for Rust drivers
Date: Fri,  6 Jun 2025 18:03:41 +0100
Message-ID: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
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

Igor Korotin (4):
  rust: acpi: add `acpi::DeviceId` abstraction
  rust: driver: Add ACPI id table support to Adapter trait
  rust: platform: Add ACPI match table support to `Driver` trait
  samples: rust: add ACPI match table example to platform driver

Changelog
---------
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
 rust/kernel/acpi.rs                  | 61 +++++++++++++++++
 rust/kernel/driver.rs                | 39 ++++++++++-
 rust/kernel/lib.rs                   |  1 +
 rust/kernel/platform.rs              | 18 +++++-
 samples/rust/rust_driver_platform.rs | 97 +++++++++++++++++++++++++++-
 7 files changed, 214 insertions(+), 4 deletions(-)
 create mode 100644 rust/kernel/acpi.rs


base-commit: 9857af0fcff385c75433f2162c30c62eb912ef6d
-- 
2.43.0


