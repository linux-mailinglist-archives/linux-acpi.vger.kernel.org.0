Return-Path: <linux-acpi+bounces-10041-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171749EB9E8
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59821678FA
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D3214224;
	Tue, 10 Dec 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XB/+Kbto"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7F1C3F13
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858054; cv=none; b=hky/wHbWIMsFBAnGp2Xxwaxxp9CEPXQ6LExgm+vwlsgF4rZMScZbJX/4bVyDKJaXHIJzSquedxOFHlyIrgIt3C4KZZHMigoPTGfRJpxpWmNNJPBLfkKz4lb4Aaa22ii5yOEO/pFqzV4ZgHSkEGzE9zDWizkUkSIqes+/Lpm6bW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858054; c=relaxed/simple;
	bh=Ktozs3TxtIvoiWuLqIp07E08Wer0m0MdC4yIE4HkHSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGCkzQh49tB/9D+WYXV8L4WmhpZxeH16dMq28q2oZaLUyFAfLRWPUQyV0obN2kJViQxb/TvxA14g7IqOWVnwGKSo9diJLTqfJkCmPktRFIayQs82I6+OzMxomMrX1s+Tm+SMxsTprySPcnMHp3ZrlgeJP0+o0eRn8IJvol/8uLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XB/+Kbto; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163b0c09afso28852945ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733858052; x=1734462852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGZYGe93XYnwpPCetlELRil+jhnZS6KVmyET+MljDnQ=;
        b=XB/+KbtoK485fcPDblLVqiGT6DX1xihh1Ve5l7HEkMPSkewF80yzVGt6fPxfug8uyP
         EJ9Oi9fdwbmBg1mg4V3h6HTdXqltcSiSmuA8+4PRwTFLEGz98iT9DOzO3aUMiBQuOrYk
         57R9ODayhgz6A9n3Ie8qfHD01jUY7cKYfpjzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858052; x=1734462852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGZYGe93XYnwpPCetlELRil+jhnZS6KVmyET+MljDnQ=;
        b=IoXbx6fhg6+wTUMPDwk1r3B3/agjBx4kfksMZDnzN9YUSlZ5D5obPu7xZ4obr6vlpv
         +bAkL2UGFOJmL6FRXL3qCSxaQ0pNhccW34jza6vZHjHIFUKG/xIjBFeU57JiWZrQMgMV
         A+LnGsnWC9hXi3R5u6mm/u3KIhkH94hTr/L8WShmrx2dOvZHGkYLtjDds12fOv/DYcKh
         ZlGoaknQDeDwlN3m2dqLAgMf50eaCdLxFls2XRiJjpWX/TNDDQS2Y04FAiV6gOERSwEQ
         EDjvvyPAUV5S+3P2p1Ei9vDUXtZU30N/EULx+5wEXPYqTb1OMZRN/UJcbg60K7t1/hAb
         vQOw==
X-Forwarded-Encrypted: i=1; AJvYcCWt/s22pi0UfbevRnsfDwisY02RXMAbaBHzO8iOV8zCHMPTuqDpDNsrlnI+PrevkWPDwWPl8D0TJAHw@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGZwvUSdcpcAcZPkiSQOIEKOPe9Fh71kLTVFu/TjR42dcgBae
	TzT6FS868SVcrEGJrCc3r/9AxS+dba1ocKRbWLNCIA5mz9TFnUKnnrIdcnkzjg==
X-Gm-Gg: ASbGncsHSejFwVBnG4LrOKnvqWd/CM0FBXgtPqUW6FDg/8nlmVdBSlUs4UpsAR/o4vm
	5OPuj5UkVdr2nWY8fo59g9syhHNW/zlIeueCZHc/ZhhkbTiI9VgFko1bn1CE+tTJlsAO5TCnb5f
	DJVgG85A4KHN+XI7hhEAS02+o9fZ3CEvamvAltjeno7QDWMK5L244rYCOzB04kNvy1seYqdEol+
	CAi55TB0JzSUjayWrzCZCFpdoolzmEGsT/U957tkqeGQUt5RtQE4Tga4J2sDMIMGcUB7HHxQ+N8
	34r+Yu7vJauYiJL1
X-Google-Smtp-Source: AGHT+IERXAaqqiMd5mOzuFLvZrQd9StHnBG8/hIZg4z03BXT5k24eR9dZkYbgceUnjEuaFJTxHifoQ==
X-Received: by 2002:a17:903:18f:b0:216:7761:cc4d with SMTP id d9443c01a7336-2177869bfe5mr3528915ad.55.1733858052118;
        Tue, 10 Dec 2024 11:14:12 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cf2b:44dd:668c:5818])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd37745f99sm6188134a12.10.2024.12.10.11.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:14:11 -0800 (PST)
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
Subject: [PATCH 2/4] drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
Date: Tue, 10 Dec 2024 11:13:31 -0800
Message-ID: <20241210191353.533801-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241210191353.533801-1-briannorris@chromium.org>
References: <20241210191353.533801-1-briannorris@chromium.org>
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
2.47.0.338.g60cca15819-goog


