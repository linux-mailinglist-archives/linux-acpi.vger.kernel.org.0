Return-Path: <linux-acpi+bounces-10152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664029F3A80
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEB1161933
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 20:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D91D47BB;
	Mon, 16 Dec 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CyxHrd6Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA731D434F
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379923; cv=none; b=Y7yecPaJ3PYQX7EJsTy7Exwod89VQ4FG58vtdMgLlrL5St1IVt9gdh8i/cZKiEWDQWjV3kangx7LUXyYAZ44fIQYCkJUD/quaOw8PLhiXoSwDvsBkckXdrC0bamWqzZrgFsCeXQaNj20YX1csXluQ0zf6sGjjf7Ira4qUfPg7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379923; c=relaxed/simple;
	bh=wcShxfPbnClrISO1dAhdVjYKxC3gZhQzGp9ty+s6tng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heF5oXSV8ad15AsicuSN1cfsJem07HD4ZC9CNOYHFG/GxtPz9Kee83Zj6tx6KlSMQ9dstWx7D79p97cDfGjaUd8w3TdlzpYj8ukJ8e+SCfUPlHmzy8XJCeQRZW3NYCt+dfsC4nytIHDqo1LAQWO3Ae5slhgj0sWUsLvXDmpq18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CyxHrd6Y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216426b0865so39560275ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 12:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734379921; x=1734984721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBk1B/iGfmqWsVYAcS6S50yqQBfz2Y6wZFszhj2EhmQ=;
        b=CyxHrd6YQF7GWWJ2k+SbX9xh/haSR7y2Ih/2Mi4+Xv/ldkmYPGVqY0UUGK0Qys90lB
         HRhKFYcYEKnMdMV1aCFGCj2x0xOZwJb6vYkTy95JQo/ArvScjPor5GVmQEyTaoR8pgCn
         DgRWUHzdCeEptJR2TRwOt6EzatwUofbxcxqyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379921; x=1734984721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBk1B/iGfmqWsVYAcS6S50yqQBfz2Y6wZFszhj2EhmQ=;
        b=hVx3vDirQkGPMJAhCz6dVXh8wuEHeWihBPys1xPS9EeNTCupYCdXZ/1Y8pluLBK+ig
         3QUDg7HtoodPvKh7oOylamLlShs78PlXR9aXd4xPEOrrBxMr4ih00YmpUO8NZEjjePO6
         BVXcnRnLJrksFdN93fs27LzJ2z0M+xIqI8+FKfXQ1sFfVxUdRJ0z6aB3b2ZYe7OIS15J
         rJwY55FeUVsUfgsD1H43itVdFRlSrh/z9PkPN0evDOtiNEtg7KskuP20eQeStQrwSWNT
         V40MpRU0KmARIuocCQkwtS6xpFClXKDfMHQHj6bIxTnwbdWy+qtuIcoHxC8jEBi5qywm
         cRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE77XGHpbBhLhuAIHG8Ij3ZbxjQFbw8XiLPUsJMSmrpGaSXtmzfDvnBJZWMAahbJMvq2dbddrsR/Mi@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVBmkkEtePv2kXeTQ/IY4MxfqyaJ+WotYOusa3qXC4eYjI/pT
	wlhyBE5eK3UZkUCpX6DFN412k6Avmsom6to47hgfBhMY7rmc6jk0uDd6aWG+RQ==
X-Gm-Gg: ASbGncu5WPBExh1aJek03Ha1R3S/72UbS+eub8GsA0W4aZS3oX/K7nSAkBWeVEBgF+e
	ssLibbgEkF8WSE41a+4SEKs0iazwpD8dg6RAC/sQExx5M8Rwx1mO2bEH/rRWRVUDY1Ze/woOMcn
	flMpeqZ3H67NFVB2TZNz/n8qlaUsj/Eju8dp5PH7xdNWXJOjqqP4E4L0kjfthOl8hU5sTiIY72a
	VLYjRUgft+h7MzSN4TwHELsae23oz5Zt/gj9aHzIgoJg7R6G4BJGFofRwkrJXQokLanbvyTcgn7
	eE1RZDg+0mf+Xo0BvA==
X-Google-Smtp-Source: AGHT+IF2iv9Je95U9OGbHT2oN5GIgDqe2UtAMFx/DSAMFSH7IN0Tter2gRXLrFhHCS1ZV+etVrE7DQ==
X-Received: by 2002:a17:903:3256:b0:215:7faa:ece2 with SMTP id d9443c01a7336-21892a4177emr159121845ad.35.1734379921239;
        Mon, 16 Dec 2024 12:12:01 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:953:5b91:a52c:e817])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1db5883sm46591995ad.41.2024.12.16.12.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:12:00 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	linux-acpi@vger.kernel.org,
	Rae Moar <rmoar@google.com>,
	Rob Herring <robh@kernel.org>,
	David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 2/3] drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
Date: Mon, 16 Dec 2024 12:11:43 -0800
Message-ID: <20241216201148.535115-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241216201148.535115-1-briannorris@chromium.org>
References: <20241216201148.535115-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per commit bebe94b53eb7 ("drivers: base: default KUNIT_* fragments to
KUNIT_ALL_TESTS"), it seems like we should default to KUNIT_ALL_TESTS.

This enables these platform_device tests for common configurations, such
as with:
  ./tools/testing/kunit/kunit.py run

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/base/test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 5c7fac80611c..2756870615cc 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -12,6 +12,7 @@ config TEST_ASYNC_DRIVER_PROBE
 config DM_KUNIT_TEST
 	tristate "KUnit Tests for the device model" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 
 config DRIVER_PE_KUNIT_TEST
 	tristate "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
-- 
2.47.1.613.gc27f4b7a9f-goog


