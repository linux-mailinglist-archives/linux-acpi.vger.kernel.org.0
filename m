Return-Path: <linux-acpi+bounces-14129-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD2ACDDF9
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3DA7A18EC
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB720280318;
	Wed,  4 Jun 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkAvOxw3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0E4C92;
	Wed,  4 Jun 2025 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040329; cv=none; b=gEjHodq6p+JRrL5aNBPm1Uw5VlmUMgBvSObBGQa2WSU5hghPX/A2S9dnBCdMDsGTNq0pYch56zLVxki086KF5oK1ziqTpQ4ZPofjTCgWWSlam6e67KEwlAgkTqv8YRPpo/yfyGrcWwAOwFjZT+e1Y6VcaskLYVB6PyWqYXDT6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040329; c=relaxed/simple;
	bh=PSAtI+pLo/Q2Xlq1c9GfZ74wRv6150SmJdXYrUeDBp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brdQEUVdysTx2N2HQVNtmLlNe84ih+yGcW6ncMtmqZUkC8N3sOqgbMSzWs+ZqO/VTs60xTZEpCxS5mBbZUSkkXRdHjHKlcFnmn7GWTdCF6ydsT+fWGNfHJ8jsmc7wDRPXShQki7RRpz+qszgWuloEdh1EdtOEH46EhY+CD2HR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkAvOxw3; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-442f9043f56so41733455e9.0;
        Wed, 04 Jun 2025 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749040326; x=1749645126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8kZ/aDiYOkf9h5oCh4UvH8Rt42D9SQNqq0ELvzG+vI=;
        b=OkAvOxw31Fm1Tpgm8b8hawEVTETYJtWTo6qeVa9VVujvjX4d2gpCtihp4sOL6b2fFU
         ixtv2lXPXikHc1Ys4REP0VIXWNFz8E8MdLD7g/9Kb52pkMU0KbhNJy3coF4YhQvUqEC7
         liEfq4DEVhWckKueBfjULTpLkXexeiKzk9cnTjeIJSzK2B1hae8X7d7L75ZTJ+17sUZL
         UI1Fi8h4XpKWAXqArCgU1E3P1vuHGyZJpHxTkM5UXRfS8400+4gLy14YRtnZFKo2hrI2
         ei7f7ajgoRysb2A3bq8MpTTEGzK8WdFhMOhXqFwvwMwE+5O3AZlHLVpxQDQlkN6v6+BK
         pBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749040326; x=1749645126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8kZ/aDiYOkf9h5oCh4UvH8Rt42D9SQNqq0ELvzG+vI=;
        b=E4zBgFDL6t2pFwFVup0eyVqhi7Z8r9Px9ApRlPoYz4Fx/PBWkjFc5rP9wyQMGoe2AU
         zVLUeST4vncP5118CDmZdAMi17KPkdsadQ53LLdZWr8B9kfElRK/LjR1HuUZba3boWsV
         cl24JQcd7of8dtRB86e0wMf1MwVe3ATqEnmTBu73UF0NR1K6MN3gagZ4B2c1XelbLhhA
         aij17VKHwputM6ZvcSYpjqjhrNpvAy/4MCGvIn87fp1wQp5YDRnHn5YMT4AakKxJxkmJ
         0lRcwdKo+pbAY3vZyJCfQxqC7v/HoKmkpsij8OyyZ7sR06xdx7y2ZQIHPEFGMtjGJAXn
         g5bw==
X-Forwarded-Encrypted: i=1; AJvYcCV0cZqmUGfep74hg0DC0rjfcahDMQizctHuhOXvUSYpfm1xmd5CCoC9W4iPHwNo7eTovb5WOSqQEQI3gNWasdg=@vger.kernel.org, AJvYcCVG1ittkFYFvdRSvHd4p2z/oIACkbML6NYn6BPUkzHAUuChWH21a/Cb3B+wqHF4hfUkl5ZM3kBI/muJi4B2@vger.kernel.org, AJvYcCVVyouKx/j6FiM0RylnpsT/81gJ/syHOPirJA7PtH0Y5f8VqeZdmjEuGUJM1hjEhjfYIdT9iuX2oOXSjA==@vger.kernel.org, AJvYcCVbqix9064ZNmnTbxkDDGTX3L6S7IxUtL6Lf4Rc/G6cj/y9+y70/slvYYAXvkVhEnGOti96rbRKcWPw@vger.kernel.org
X-Gm-Message-State: AOJu0YxrC9Obk49RfpHfWCkij1VjQzFn0IxMBOMjbGqLlz8JH1MNQsJq
	GnhjDXmVmxFu6dMx6DMGauL3p7hZ2VAI0g+oK6g8s7ZUVghEneAUGTeu
X-Gm-Gg: ASbGncvA+EGlyGgyfvh4nW18V9cxdEDuBnDQs23HbVkIKu05xzah9hS9jWA7W/CqZKK
	IckNY29B38FkDjs3JhbnDoinv+Ue/y2O+v+BSwv+755u5tlEYtYFsww+ob+wb1VhS8L7JjpFr6M
	L59f8Gcy2kChR+zz34qelvtO9uGqRaAdklCFjOHjGXUFLCtymMRwlRANJBF1IDUP3QuKqnA4z6r
	b1E8SHmx7WF7BchASoR4TsUUVUhrB7WLPq9G513SbH+yJE8GPaVEkECO68+X8zdbpKpwN9HYG3h
	SBIw0+gRNrlaHPBDn6pZSnFfQ05Z1ZtusIqffgDy+2YMgEdMeCjI24HpnpYXQGYpfRxeWL5zoXJ
	2QTTFO/BXUYIXqd3WdyKQ0xqucHq2
X-Google-Smtp-Source: AGHT+IGdLaFVhNtwtOVwGjagea6FvBR1QsRFelh3QuUgD4knq/vMES6atm6mlno8cGKeqS0tJEseEQ==
X-Received: by 2002:a05:600c:350b:b0:43d:17f1:2640 with SMTP id 5b1f17b1804b1-451f0b209d8mr23102975e9.26.1749040326138;
        Wed, 04 Jun 2025 05:32:06 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8006c21sm194467085e9.33.2025.06.04.05.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:32:05 -0700 (PDT)
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>
Subject: [PATCH v1 0/5] rust: Add ACPI match table support for Rust drivers
Date: Wed,  4 Jun 2025 13:29:39 +0100
Message-ID: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
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
  - A helper function `is_of_node()` for determining fwnode types.
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
  rust: helpers: Add `is_of_node` helper function
  rust: driver: Add ACPI id table support to Adapter trait
  rust: platform: Add ACPI match table support to `Driver` trait
  samples: rust: add ACPI match table example to platform driver

 MAINTAINERS                          |  2 +
 rust/bindings/bindings_helper.h      |  1 +
 rust/helpers/helpers.c               |  1 +
 rust/helpers/of.c                    |  6 +++
 rust/kernel/acpi.rs                  | 62 ++++++++++++++++++++++++++++
 rust/kernel/driver.rs                | 58 ++++++++++++++++++++++++--
 rust/kernel/lib.rs                   |  1 +
 rust/kernel/platform.rs              | 17 +++++++-
 samples/rust/rust_driver_platform.rs | 41 +++++++++++++++++-
 9 files changed, 183 insertions(+), 6 deletions(-)
 create mode 100644 rust/helpers/of.c
 create mode 100644 rust/kernel/acpi.rs

-- 
2.43.0


