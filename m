Return-Path: <linux-acpi+bounces-17503-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1771EBB3C55
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 13:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966B017A4C4
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09D1310628;
	Thu,  2 Oct 2025 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AP2/bhB3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890530FF30
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404854; cv=none; b=fIJAyVwi/ZCIixEudTYVlQC8tliJZBnWCKtdHlk+oLLMEkD2CneKjv81WucsHanHdRrXDN4wuvwrUhEKm9zkNPzenppnTreT9U5fn64+iDZKWtwi5pWXHQQwyRdsc3Ur1Asqy5B1Sw9urz2YoogZdCO9nuoMVD3Jrace8sH5+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404854; c=relaxed/simple;
	bh=joJFsmLC0ahfMOA1xiYAki0VFQaETHltvy6RAJznUm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fH3s1Pg264+BP4U2lbyjPBD4ZXsFV5z6M2D/3Iu7Mk7G5dj3p181Fbrp5/ILYl8IDRS4mAB74x2DOlt1a7F6K+eRtpXNput2opAcvk5j8IeJf7fE60phnG8KGtA9YFrujwgvJotEyVS8oXOQAFEo7ZyLsHJAYwjik8Eh5K4PsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AP2/bhB3; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62f9cfb8075so939216a12.2
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 04:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759404851; x=1760009651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NE2gdnRWmdJaMiCXgFNZvZRGrqhmc689a8INpdeTYqY=;
        b=AP2/bhB3lfByuFHV3N1Q37yM0KeF3t1eDI2jm37FU4kncOL2xx9i/xlP17bEmMlljM
         t9LnD5kxizrY6xv2PftiAwcckPA+1AlTtzeplwwCP4nQzhpEnugREwhr86RsfBrF/DQz
         xWcHodcigTXCKscQPhJtb4ogrqO53mkZz3KlZSi0/oppXHHI6APB1vxiA2OFQqT/0KxU
         3cLzlGVGQpI/OOXfCGjG9uDoIJCVCrqdBdV7YtSqvbgGiLsC7+VALse5i3URXxNNQcuv
         WDt565QUtP+m8SXRUdMroJUuIqbpr3dUaudPN4iQy30cD8wQCqdkbd5dzfs9YAmY66ob
         38cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404851; x=1760009651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NE2gdnRWmdJaMiCXgFNZvZRGrqhmc689a8INpdeTYqY=;
        b=G6f0MWtK6geoPVBKzuOSw7glP0OQt335XIWofWCFwyB0q5EB95I7lTTsfBf4p/cTid
         R6jGc58gbTqcNPg0/EoyxRmyPs/+7MeEkygSbrr1Nz6e/eEtntseFX0uCsQinGnpWFh9
         yV4fr3oWz4Js4FtFuAgMnwZyTSeBmIMmumwQGj+13cYKKEMly+zqzeWPmLI4PD7gkLbf
         HEdcr9tsk5GppUokq1s6iVj5wGXnqZteV8vUYk7/hGGRmBAsh2LzojNN6yyMe2kxnG47
         XrAXl45g0MUeqescCluwWGl3Jmq1JozSttzvew6XHXp5dl7THBhU6qf9gcphFpTMNaLq
         yhgw==
X-Forwarded-Encrypted: i=1; AJvYcCUfAdk6/sgOcsJB4NofjabJYlXo0Awna3XRLY4i8Xln5u4QIi6pCFvkoNLkG9OpURcewKt3IJ3b7dK4@vger.kernel.org
X-Gm-Message-State: AOJu0YymuqRPZlVijWX0jt0xsnUbOy0XZDgrXn7XA9JsWOKjO/lG8cuR
	MD6qzhcZAkoM1wtYWSKSf09S1TdDPQcf59WvE/Ha99vQs7I3SDOjJwMjQ428a9Wtsd+6ouLtWj3
	2NpesjQ==
X-Google-Smtp-Source: AGHT+IFnNGWeUW+2QiI2DEf6id556ZD0ID7jFmIizNY5EI0PMeiFKJnPQbdWshUAr7O6MaAV/CyVGfRtTZo=
X-Received: from edqu5.prod.google.com ([2002:aa7:d885:0:b0:634:b46f:19de])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3489:b0:634:e004:76fd
 with SMTP id 4fb4d7f45d1cf-63678a9a613mr6778480a12.0.1759404850841; Thu, 02
 Oct 2025 04:34:10 -0700 (PDT)
Date: Thu,  2 Oct 2025 11:34:02 +0000
In-Reply-To: <20251002113404.3117429-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002113404.3117429-5-srosek@google.com>
Subject: [PATCH v3 4/6] ACPI: DPTF: Remove not supported INT340X IDs
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove not supported INT340X and Wildcat Lake ACPI device IDs
from scan handler.

Fixes: 3230bbfce8a9 ("ACPI: introduce ACPI int340x thermal scan handler")
Fixes: 9cf45756a4b9 ("ACPI: DPTF: Support for Wildcat Lake")
Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 26522ddfcbaa..7d1308b1f513 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -21,12 +21,6 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3406_DEVICE_IDS,
 	ACPI_INT3407_DEVICE_IDS,
 	ACPI_PCH_FIVR_DEVICE_IDS,
-	{"INT3408"},
-	{"INT3409"},
-	{"INT340A"},
-	{"INT340B"},
-	{"INTC10FF"},
-	{"INTC1102"},
 	{""},
 };
 
-- 
2.51.0.618.g983fd99d29-goog


