Return-Path: <linux-acpi+bounces-20615-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGThEbRmd2nCfQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20615-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:05:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3D288933
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2A48302D5EC
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 13:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A9337B99;
	Mon, 26 Jan 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQ89ShHJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AB337BB3
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432730; cv=none; b=CqszNVeL1ocEyYSt8QjxnLW8/oNclgC5Cj/RLOjzYfpjhHIoMZpxOPihB9MpB5ah2wQhVhls9jiRel/M34y88eDTAF5Ct77Zdv7jfuoMYoI9kLZkh70CYO37tzEUAjg17TUq6JqD68lXKbNFb9ZkCeZyIRTyDmnMINiPA33YT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432730; c=relaxed/simple;
	bh=GK1ja8KHY40OpYiu7CsA4QW7E7kCo73ow5VVlh2bhwU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gwAskcpuqORc0COcJ7SDh/n5rUBPGg5dOx/tLXmfcDl+ElnlXluYJdStjj51RmqlaQxXIn7SE1rIPRSLwM/5nYhzWw5+2oT93htK0mlVXHj1uuMK7LkHwuq9ug5FMTUEy/WyAOKIjAP9RHLmLMwJJ1EwkQ0TvSakS3MiTh2lLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQ89ShHJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-480600391a0so8914835e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 05:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769432726; x=1770037526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nDObQnK7/rlt3eIdqQ75S2Ut6SoCp4cXvTmH8r5QiGc=;
        b=cQ89ShHJKohnxj+HUYGLEohdGbqhOs9Zr3prg6f6hJsHQEKGbe2paaU2KfgC+sb+SM
         4zYxhJU+qdVXO8gi6qlQOTLUzKbXvvyPJkP5Dn+Zp3aGI/BihEWnyioMoTZa+fVkpoal
         H194H//iGX8+rfzBnnV7gG72lVSwCkikkwyKjIUf9d/XU+aRnOFlHJ4xJkVC0FnPmjiu
         bCrPFMi7DUwHYoKgLnTRdP75AA9Ut/YCQDGhKW74k3JRwkWYwATH7skIooPZynzl0GYp
         F6PSfR/9YGPYsi6+AfAOBOX0DknFIgC6T6nOx4LxBG94fqvDZAa9dMmJeYCvXnx6HBsw
         ZK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432726; x=1770037526;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDObQnK7/rlt3eIdqQ75S2Ut6SoCp4cXvTmH8r5QiGc=;
        b=i+rXiI5gLgj4fUW/AxwcWD5yGx0z7NWYe+1RPLUgtCTe+o7vMcyk8x1anCwv0z91sn
         IR+yOINaE4tFV900ZO4/tQUnmFu5LAutqt9jxv2tjiyu2tAhedy0V/OlSAUes4BHxS5o
         paEg1EhUzz/bYIsyxhxed5YUoYoej/tDZI4jG6XWFskVgXGLG0TPchHpPqbegdXorUi7
         u1wMwlFAWyaR2BB1eYa6VBiAfwEN8yn2/xe1I9WLhOkk56w4u7OSpml/EquahbEM1uNO
         3otssiiuL5H9RmQstEp0UdPSZrWdsChDSbwcEHrkaGYgiYD8UUCGpZ18nUE9r6U6jWtu
         226Q==
X-Forwarded-Encrypted: i=1; AJvYcCX69RuHNpLeLKytuYGV/zwtwEgP6wN9QqYXV7eX4p5ANYT3tf2Tegqycr83N9BE1hzNUCp4j1QpMjqr@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0gBQE0c57Lg3OkyVVukApET+IxJlq+pTIzu8c3vudO/akmRl
	nfMQUBOpBgsTZja6sXguDPlywMqGBdXvFJy2UiKhsd59BHwg5pMK8TQO9N1tdeZnKFN7Bq3E1in
	S0QHmGjeijuVp4TN4HA==
X-Received: from wmbb18.prod.google.com ([2002:a05:600c:5892:b0:477:55f8:e1ec])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1382:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4805cf66a5dmr68344985e9.17.1769432726477;
 Mon, 26 Jan 2026 05:05:26 -0800 (PST)
Date: Mon, 26 Jan 2026 13:05:13 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIpmd2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIKFblVqUn5iUk6qblpapa5SUmmRqYmRsbpZsrATUUlCUmpZZATYuOra 2FgAug+5rXgAAAA==
X-Change-Id: 20251202-zeroable-ffi-2beb542376c3
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=GK1ja8KHY40OpYiu7CsA4QW7E7kCo73ow5VVlh2bhwU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpd2aQ02h1uFN9RndAVN7fOG/7/jDGtbxpG+H8A
 b0f7XIa6BGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaXdmkAAKCRAEWL7uWMY5
 RvKlEAChro1KqzOPEgiDcDyVXAHYv6QXPuI8lZduEeYZWQzIT22LBX586Bg2T1aheLBgIjBPDIJ
 X8xB5BeAF1TbDOaBGT5zwXZOx8ana1fbAVrl9TlpSZCXstdyxba+28/JmtPVP4jq2yX7rMCKtXv
 k0CpuAfx3pkiOoSuoHp906SlX3b57lBgnSjScTaPZEatEbR5ZbeECZ7R/UhFc52GVHEgPNsCMH/
 i6cNeK3LCHnYQazcsAFfF2P2AXAqG/jxpjXUDG0MKJxGOebH2C6z5XEk61oFuT+8F5/wdt9v4Uh
 2Kj7JI1PXsNtfF4X9dZ2k7shJr/V8VtHkUvqAu6PxPxViNRksdMoxYo17aPegCUgV7HxpqGtSLz
 1x561v1QVvfy99d779o/ZeSw26UwjWeWm7fIljLOm+IWwIKt++oC9BrJcac7ZRUcM8rjbE1ZfU6
 YIci4+iqajTQgdwKCXPS9ej5eAN+xIgldeLdjQIHXmehTECvkVTBCnQapFfEshz4JfnXAynpEHX
 YWbHvoyJoimA/DGb/TkkJmqce630SAIdwSfls9O6DR2YhWqWj69toNfu2BNcuep477Ws0sou1Ah
 ETuPa3tuYbmhtQzOs7YMP2xRvAF+UiHB/2WhDWqAc+AvODtt9JQ/VDuPMvtCD27LjaKyllNJiu9 OEFfbdn/eIMyVfQ==
X-Mailer: b4 0.14.2
Message-ID: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
Subject: [PATCH 0/4] Re-export Zeroable and zeroed() from ffi module
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Len Brown <lenb@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20615-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,linaro.org,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B3D288933
X-Rspamd-Action: no action

Currently, the Zeroable trait is defined by pin-init because pin-init
happens to use the trait. However, zeroed types are useful for many
purposes other than pin-init. Also, we wish to implement Zeroable for
types generated by bindgen. For both of these reasons, re-export
Zeroable from the ffi crate, which is a already dependency of the crates
with bindgen output.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (4):
      rust: ffi: reexport Zeroable and related items
      rust: cpufreq: import pin_init::zeroed() from ffi
      rust: i2c: import pin_init::zeroed() from ffi
      rust: acpi: import pin_init::zeroed() from ffi

 rust/Makefile          | 9 ++++++---
 rust/ffi.rs            | 7 +++++++
 rust/kernel/acpi.rs    | 2 +-
 rust/kernel/cpufreq.rs | 2 +-
 rust/kernel/i2c.rs     | 4 ++--
 5 files changed, 17 insertions(+), 7 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251202-zeroable-ffi-2beb542376c3

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


