Return-Path: <linux-acpi+bounces-10043-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D499EB9E7
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7993A283D0F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83221422C;
	Tue, 10 Dec 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlMqwKrf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDE2046BE
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858058; cv=none; b=LzNsygQRIGzAtWOw/5s9UwkBjOadQtfSj/JATleMOjtIQzlsQ3e54Ir9qBUFjElwxSvBnb9RGtsEH6S6qqy4TABFF47VuOLQKLw+Z7SiPl/XWnL4T7p3amwOghWWSHhVHHm6s9lEeEPNjvu7qOkVwOi8ZKkVL4TZohaBE6JJ8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858058; c=relaxed/simple;
	bh=P4g5rM5+vT8QGYunnxWP/KgERAFX3h+8woBAFgIYFAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0mc/Bg7nQDDVo9H7SjvM7Ob4j+oaYMmlzMNV4ctmtGGHDhD7u9m1iSkzj2eosT82bUlxmMWHEx6qf0Av4uTWxnX/AWfk3TD3G29Lnjqw9hM404IGaEaEyMwwd9nG/eBIfVz7p3/8UKICVelVyk2jyC95nhA+hyvBK95dwTigN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WlMqwKrf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21654fdd5daso22921335ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733858054; x=1734462854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5b9XYsu4O+lmiHBc5HtDX/VKh9pMQ/nh/9V8laOoEk=;
        b=WlMqwKrfeIwp0P41CrA+Zj9t45RW8SEmlQ/tdqAF0JdsgY6Sr3lgLPTwnPLFJmKIcV
         qGMPm6K+eXnRPlgFj1+Ml61thPxxzyr/NJ45maIE2JxRY9Zo7pqpQw3QlKZe+4w6aZ+y
         WZ/1iFwKtXHJi8xQfXL8Jrrm0y3vo57Cei6bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858054; x=1734462854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5b9XYsu4O+lmiHBc5HtDX/VKh9pMQ/nh/9V8laOoEk=;
        b=FIro1/3xsk7tKh56l51M/cZoQpH8BfVOrR8Hv5n06ADM7VsUlTTWD6eMwAHg6Jhkdg
         m6ZYmX/jJmEBPjQ2ljY2UMxqLmJJdVfBcciyCA3DkWTvfev3LbMaZUjyp5xoSv6LTx6h
         j/qVGZwjIXTrobK/55eByBHbBt731xZ4gjhXxQKHidaeVo5tJyBq+vD7RjkMtaN4K94D
         mxLp/4dNSFKlnUJwKwswwL1YG7Qte7uP7NYTLE6yVrbNg7u5IFvp35YgLV1FC98RnSdB
         ZmUqv8u9Jow9Rxb3cpQqTaO/RC7WnuSTFWqNutaTgTh2UN7Sczjs8PylusCtzM9gL/+G
         QfAg==
X-Forwarded-Encrypted: i=1; AJvYcCWqHYLYJknsgy3TIQee/FrkYVY8kZeP53VkHk1atvnJDz+GaP+K7V2Y3GqXowmz/Dsfh6p1GmzL8kOm@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJZWL/WKpEXilCxn1SLsR2mXD8n4b83XOCOEhRtdPmKk2J1f2
	dG39I25ff3o/Clt7LA8FaVxayZNc3bKiQDtQwCGn5CTp6D5R8/3svHUDDxTRrg==
X-Gm-Gg: ASbGnctqZgO1XtdxZWCBiELS/fqpkUFyWofcN5zfaVXbThkv04pzmrT6XVLAkPzLC/g
	cQ44MYpOodejq1hBVqEZ+lmnyzv5FcVyHHolC9sXMAkqFxDa8NXEwoOwWFoauoYKXdDb6N9ZvnU
	ezUAi9brZTRVie+6vxRZOgEZcJspFmodS36adAipnpEXMoQA6mPqyjdW8XlwsdXbIQKh2hvEqzb
	JKzcw+tmNyvpRGnD6WTezQixynneDspw8pSMaIxTbSO/poHUgnRiGK6pe9c9NZI5Z0wmVgVVdjv
	3tlgreF4nC3PYY7R
X-Google-Smtp-Source: AGHT+IEXiv8Ym3Q4nPBKFIlRwqhDrPPK9Ud52JE4zWYY3RQI+KC6JJeue0TzMBRAN1JYYwitRq9xzQ==
X-Received: by 2002:a17:902:fc86:b0:215:94e0:17 with SMTP id d9443c01a7336-217783b776amr4525505ad.23.1733858053991;
        Tue, 10 Dec 2024 11:14:13 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cf2b:44dd:668c:5818])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd3af6ef9csm5920470a12.62.2024.12.10.11.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:14:13 -0800 (PST)
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
Subject: [PATCH 3/4] drivers: base: test: Drop "devm" from platform-device-test names
Date: Tue, 10 Dec 2024 11:13:32 -0800
Message-ID: <20241210191353.533801-4-briannorris@chromium.org>
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

This is a reasonably-helpful base for generic platform_device tests, and
I'd like to add more tests that aren't specifically about "devm"
functions. Drop the devm namings for the suite, for clarity.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/test/platform-device-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index ea05b8785743..fd871bb9e143 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -15,7 +15,7 @@ struct test_priv {
 	struct device *dev;
 };
 
-static int platform_device_devm_init(struct kunit *test)
+static int platform_device_init(struct kunit *test)
 {
 	struct test_priv *priv;
 
@@ -203,7 +203,7 @@ static void probed_platform_device_devm_register_get_unregister_with_devm_test(s
 	platform_driver_unregister(&fake_driver);
 }
 
-static struct kunit_case platform_device_devm_tests[] = {
+static struct kunit_case platform_device_tests[] = {
 	KUNIT_CASE(platform_device_devm_register_unregister_test),
 	KUNIT_CASE(platform_device_devm_register_get_unregister_with_devm_test),
 	KUNIT_CASE(probed_platform_device_devm_register_unregister_test),
@@ -211,13 +211,13 @@ static struct kunit_case platform_device_devm_tests[] = {
 	{}
 };
 
-static struct kunit_suite platform_device_devm_test_suite = {
-	.name = "platform-device-devm",
-	.init = platform_device_devm_init,
-	.test_cases = platform_device_devm_tests,
+static struct kunit_suite platform_device_test_suite = {
+	.name = "platform-device",
+	.init = platform_device_init,
+	.test_cases = platform_device_tests,
 };
 
-kunit_test_suite(platform_device_devm_test_suite);
+kunit_test_suite(platform_device_test_suite);
 
 MODULE_DESCRIPTION("Test module for platform devices");
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
-- 
2.47.0.338.g60cca15819-goog


