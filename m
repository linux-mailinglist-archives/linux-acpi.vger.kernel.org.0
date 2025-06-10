Return-Path: <linux-acpi+bounces-14264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFF7AD3BFA
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 16:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBED3AB5EE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD5123504A;
	Tue, 10 Jun 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvgH2+Ok"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DE225A5B;
	Tue, 10 Jun 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567563; cv=none; b=uHZ0zS1NQxKem2jvxqIw8+0SXvUwQa6JJumNxNT561gvm3o8HtPwv/3KgrdkpvU6pAym9839z6ANTtNOgs+5oyGrzZYU91vvib1b2i6i2Io1I+ZErLcmMtqnaD6duETrrK6tTlWpJ6qWMUjIwPq/V4bZvm/vjCxglQyO9EkL93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567563; c=relaxed/simple;
	bh=eAzNjFltUxiELm09w9k9dxOVmIUtcLxfxaZgakO21jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJTYcZgxMedNZPdn9ox597SnrDeDYpD3UPWXgU/D4zkEt/WJ7L41sSxjI/giIaqUF3qdohyRpFUJH7CJ9tJLlUydSzPmPSQeVneXjL0oJrc599X05nTXIhaHuOpWVG13x/eOba1aAZhy0073TZteSckX3nlnbhxUT1kK7uXEUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvgH2+Ok; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-452f9735424so14028555e9.3;
        Tue, 10 Jun 2025 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567560; x=1750172360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D4kwazpAlZo17qyn2Og7Cz+Ru1CTKqZ9TisRYwyWMCA=;
        b=YvgH2+OkxYKZ2JGhoPhtU2dkoKvKGVNbmCGkvbWl605KNf8Yro4fEDE65bBnmbvi/U
         KXuxdFhQito5I/zbQifik84OG9wvPpZLkPRhRjJ8VJ1MLCZpFmHiteLpqYBqk4k/awX0
         P7SqiyifYKBzZbAz1Vup5TJvF7CKKYCg8D4oa1iH6HBVq2K7fIzJBhDrqK1bKKj0X/7a
         aZoorTVOTsI39hUZ59aBq0zYYi6uHWYsvVFI4Swr26KeV76hs1rYlamslXh+XN/1nbBw
         4wgVhP6GvxQlfI16ZmCc1/LRj8nmCRA1zAXuiWSbkeIhgGxFEqsNk+IBODeLHEXm7AVX
         Ynlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567560; x=1750172360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4kwazpAlZo17qyn2Og7Cz+Ru1CTKqZ9TisRYwyWMCA=;
        b=QWd6pFgKK9G+o53q2dPwYKyDFpjyx7MCMTfQ5TfIb4B3rJlK0AcxhhjwLOMteEbbwu
         FmWaS+tHReoVm1GY3K03t3WBKpXhsw4Qmawd/Fr1OnEoNXVmu2JMy4TvIDSKWgZp3PA+
         WuP6JzrslyCneJtAzJ94uzIuSn0cSv6wQs1J6deM6Jkj/VT0poX9pZ5Zp0KMMFkHt4BN
         9KP+ExjIcywq5bFDiykV4zV8/msg2kLIuB0bhyaHL3LJuVJ+qZgjeCmCuyyTvjX87X6o
         qNnr35rusgo1CpiXv4NvJuFegVtIMOtJY0jWoWtnwcoCVWPRmQF3+xGiditkgLA8AEJL
         SejQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8JBbF5r3FltrJCdQqFpGwt16qKAlZWSFBC9c8F2TvVH+C+gi3+GiSHOBmGdxuQMMTxRM8COUgC6E48kBo79M=@vger.kernel.org, AJvYcCWm3/v2msG6GLk2i1fUmqbth/kxwieUUSDawOF9GSjYPJEyZ3DbZzzoOM2OaEQXXLaDZJzV+IWimT6F@vger.kernel.org, AJvYcCWmNBVcftwCelKD/UCtmxlNXqSGM1GqpEheUg5EF7dweoSa6FyYf44ufQ6m4449hjJUC1R/T+owj0P5vmyu@vger.kernel.org
X-Gm-Message-State: AOJu0YwZL7KLBQjfQ7UTc0QsoD5VM5HdSxenIfL2aMstkjUOArtGnmY1
	06b0yz/qCU/5Yg/oXsKwAZnZ1PY09g3VikKA5K3XqywQNHaHICcQg9sF
X-Gm-Gg: ASbGncsoDxiuVMKVPZJMdaYBctZ+7SYgRv2Q0B6kHSeby4tJZZHIhZRNiXQZeEEGP13
	wuZBCgESAFk65oCXGYEbdOzDmAncEa90QDPvETFJTYRRg+d3EdE5b2Vlkxmx0ltH8Hpq374a1pi
	H/WmAXNYLMSk5rigJlNW+MnHieyXGzJ97tLf/kR6FfNgRtFxmUmrAaEAO3SMJLrSeIkOjla2rm4
	+9QQFEwzL3kRhZdmAndWKjU1dDhyeJ4UZLOXlIhNrb0OxE/NQnhwp7xN4msDaIpBvBtazmbVXn1
	VOLJD4woKIFN1/0ZJ/xP2Z5nDVBpljtOV5eabqI6ekpAYhfvAFIHl0whLwHiyHOQOId7+Pb0tC9
	X2JQWOXLCInE7l+AjSbfRqggIa7/OCgQTT4iA
X-Google-Smtp-Source: AGHT+IENYHhXoQYe4kB3wXGt5TlTEHqhOFJJrxGvfo/0fGKH3HW1VUQx711wDe02QBcV90HmZxIDAA==
X-Received: by 2002:a05:600c:34ca:b0:453:1058:f8c1 with SMTP id 5b1f17b1804b1-4531058ffa6mr86597895e9.3.1749567559618;
        Tue, 10 Jun 2025 07:59:19 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209ce1afasm146136755e9.10.2025.06.10.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:59:19 -0700 (PDT)
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
Subject: [PATCH v4 0/5] rust: Add ACPI match table support for Rust drivers
Date: Tue, 10 Jun 2025 15:52:34 +0100
Message-ID: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
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

Igor Korotin (5):
  rust: acpi: add `acpi::DeviceId` abstraction
  rust: driver: Add ACPI id table support to Adapter trait
  rust: driver: Consolidate `Adapter` methods using `#[cfg]`
  rust: platform: Add ACPI match table support to `Driver` trait
  samples: rust: add ACPI match table example to platform driver

Changelog
---------
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
 rust/kernel/acpi.rs                  | 61 ++++++++++++++++++++++
 rust/kernel/driver.rs                | 77 ++++++++++++++++++++--------
 rust/kernel/lib.rs                   |  1 +
 rust/kernel/platform.rs              | 52 ++++++++++++++++++-
 samples/rust/rust_driver_platform.rs | 71 ++++++++++++++++++++++++-
 7 files changed, 241 insertions(+), 23 deletions(-)
 create mode 100644 rust/kernel/acpi.rs


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.43.0


