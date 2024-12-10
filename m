Return-Path: <linux-acpi+bounces-10039-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6AE9EB9E6
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD32B283C85
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77287214208;
	Tue, 10 Dec 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PibYboMV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090951C3F13
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858050; cv=none; b=ni1E/zfMdx/JZHMnaVfwX7hUW+VmRbfpjyc2DAjUl0aDHyGstuPhlHZShLLJcjRkm2lU23AD6ubgW5wZ1z3pAOO97wxCmP/erhA+zB8ENMfrvSsTdIzSB4DlnUU0ZCqdVGlVs3t9WwdO6Frp2zm4d1tu0onJaW2orlNVs+ypziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858050; c=relaxed/simple;
	bh=8nB9LfqUIlx893EnVEn1oyPaKNloRLzhICUSkzKGANQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=luqybZHQgqfczYKfGY7/A5W/EyAhi/lUFTchcF3/Ldjt7dsZBzUzPuXGDYq0/6lmFXSzk+AYhIWuokfVoVJUnRa8JXKHTpfQ00vv9UtJQQnjtXAioQOLtrQOc7TFuElZ8s7ujhhKzVZB4OdZ71iYuOcIMqf8NfxLRXAGaaJya/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PibYboMV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fd4998b0dbso2396431a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733858048; x=1734462848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MysYNOOOtjPxn7x1jZehpCDsgb3N3i+OrdKPB7nkcnQ=;
        b=PibYboMVU0w6jXbXBOCttKgijsfjv5A16l8vN/gCKYXQ95pQnZW0hSI13v9OkqKFuK
         8wlOe8MKJZTSTt1PPaOEcRLv9krFmhHBs3QSBV9bPcDgM7DxxZJz9BJVxpU6rKHpM+Js
         0BmQaPGMDXP5Z1IAoygaYzsSLyS7PbOl+3oQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858048; x=1734462848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MysYNOOOtjPxn7x1jZehpCDsgb3N3i+OrdKPB7nkcnQ=;
        b=qrBNidQ+lpocVPSiEs54SmiNLTJBh8u00eKJTVLqiA7b5CXiPHxw2gVSZ3Z6Q3//st
         s0bamBH5E7LFXGOkUHI0fuud8XbrobcdZcflZsE6pDGGZIvSyeZ9swUUQBcuixfdNqzQ
         BwF7npEkIwcRRA/UNU4uPa59yaR+U6zKYf98rFwjF7WA9sVc4B4KB3h7Y3ZdlE+N/uJ8
         QlA4tPGN64oeRh7yH/0DKt+tnEYVy0TXgCXf6hah9y8vTc4Y92OuakzJOZr702kAo1IN
         Pua6fUn1BbZRJgTG5AlBb8VbMwpohVhdZQa3OxZlVB4whlNMKOnpC441h+vhZADW9g+j
         G/nw==
X-Forwarded-Encrypted: i=1; AJvYcCUAAJB686/H/d/VAJRUgMgUL/ND4xjzIN+fo181u0li4I3rshnMQIYHnJ5lbRyFQZE65FLKPP7aCxGC@vger.kernel.org
X-Gm-Message-State: AOJu0YzQIPlbNdcUDypyHSKVNKmYmg5AX4N7lodT9Pl/J/0Bcz4UBmjS
	hHWVDbrYg6EIdqYItt44QHYpW0oBjkueJKTWaodTr4cRyhz5Ff3zoZlNegC/Sg==
X-Gm-Gg: ASbGncsqyRQ4jVVXSS8dyGvUX5za/qRTAnjwCFBorwD2SpLeJXVqgJAAXNnPyTmxFUI
	urn8a3dtBzusge+Zt3og6gRJCVXjZLzKdouTB5Sfzs5aq4vd8gxGRlvYIvQW6Q+yJyIBMP4ADIw
	aqAeWOYagtp5CTDdZWosQXmub1rfHcEVLkreEZ5tdqzC9wDG/lUZWcGJgpvolG6hbISAqwTom9N
	V8+OcoVt8wiSVquAtgOABfzBVUsvecRIt4dU0pjfQQXAZ7KK3JPKGot1+6mSZoagHJyQRrIHMKh
	4M3BuoSKPtw58EC0
X-Google-Smtp-Source: AGHT+IG1Y3K1qZ9CQcqUnkQEHUVS4XwePEyG43iObCbw1CEpZyvCGhCju0fkg5G3HVvnA7tqXu0KEw==
X-Received: by 2002:a05:6a20:3943:b0:1e0:ca33:8ccf with SMTP id adf61e73a8af0-1e1c1360edamr639374637.34.1733858048251;
        Tue, 10 Dec 2024 11:14:08 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cf2b:44dd:668c:5818])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd2f40dc81sm5905791a12.64.2024.12.10.11.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:14:07 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Rob Herring <robh@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-acpi@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/4] drivers: base: Don't match device with NULL of_node/fwnode/etc + tests
Date: Tue, 10 Dec 2024 11:13:29 -0800
Message-ID: <20241210191353.533801-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series:
1. makes the behavior of_find_device_by_node(),
   bus_find_device_by_of_node(), bus_find_device_by_fwnode(), etc., more
   consistent when provided with a NULL node/handle;
2. adds kunit tests to validate the new NULL-argument behavior; and
3. makes some related improvements and refactoring for the drivers/base/
   kunit tests.

This series aims to prevent problems like the ones resolved in commit
5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if one
actually exists").


Brian Norris (4):
  drivers: base: Don't match devices with NULL of_node/fwnode/etc
  drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
  drivers: base: test: Drop "devm" from platform-device-test names
  drivers: base: test: Add ...find_device_by...(... NULL) tests

 drivers/base/core.c                      |  8 ++---
 drivers/base/test/Kconfig                |  1 +
 drivers/base/test/platform-device-test.c | 42 ++++++++++++++++++++----
 3 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


