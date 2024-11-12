Return-Path: <linux-acpi+bounces-9520-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2D9C6463
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 23:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C671EB3FF2C
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 22:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED872219E47;
	Tue, 12 Nov 2024 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDP/DY0o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7A1531C4
	for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450343; cv=none; b=LHlRtrYmZsg6wWxjX1zbYjd+NNV8s1mNGHo8r6VvnrcyyjbU6VBooxkWa6tD0bM1XVTuVwXXQA/qyWqa0VtCUQq5IcccqupD4ocK8GlaHLLfYZ1eyFeqwUrns7zhIbxbVXDcynFOefT7aao8kMya6Uymi5aAmdehMUa9KnmmrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450343; c=relaxed/simple;
	bh=8GeByDS2uWdcqA65FmwK3WTf4oaQxq60Il3v1AwTHuc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q+cOuRtuxmDzdaq7J9uy3NMEnDT1o8fu0BZi8XbQskEMCTioLSyWPY+bVRvPMPwyzYv1MZXaut5Dp4B0BU/sdr//fr2PxzZeGVP0oYmqrEQ+fqkXUMEnj0PqO6F2qGJnDZAnAxV0hu+OJMpOb37PvjaCnxI3HZja4t6OqV8F0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDP/DY0o; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2b9f2c6559so8973800276.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731450341; x=1732055141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7FlcnUnWshiI10WLNfiJyYyEzpkvJ7Zo+urE+6Owno=;
        b=TDP/DY0oxdCMKypYDC1tn0/ZEf0bPH1sRvYYnqcsoMTmLYe0pnQodByXGegPhIsx5y
         esaT+nFcS5d7yLtsHT12Nny9PvWiYyhjnNcOOySJ56HMO9DWuwqajkorUgir797Vq9yg
         6u+7vWXE4F2Lbd97Zvk+YiOHrHnIdJAvwsFJD2+9aF/unEz7ewGIq8Z3YVcTbvKnCm50
         7/Wyv6e+ZF0dIF924X+6Mkmx7lqru9vXE0+qsyC2v5XU7YSDTKeSAl7I+eP/rkjZ+yME
         mvDtlrz6eOZ/LuC5CvNKFPwc4n7O9t9GS6mT9yg66HlRdhqTitpBPMR4xcl3C6doJvTJ
         x6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731450341; x=1732055141;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7FlcnUnWshiI10WLNfiJyYyEzpkvJ7Zo+urE+6Owno=;
        b=S5xIwZZDDvKk6oW+MQkWIEB0yX2xSbavyH4s2OamRcNHVYCwWiNNKP89pymFOh/36n
         k+hV1BimuNHCYVW+dkzmDI/cCtrg6k2a0/1WARHFfaIGYXRsJER88yho2krkxccuASN1
         zYjDvHDtndMSbdjkGp+aOLyZGcseM8T/p5qozo39kea1Jh8R8eyXbH3D5IgqTik9yRsT
         Fk4Z9EBH8Cf0oT8QKQYBG7ehffD1nkWjm91GrzPH87HdZq8qVOY1UB7yrNlSiv51Ilvs
         6Q7SXfsnyPUr+xhprFamhy4LIdm3YN9FbhxKA3tCg1BAk/2KdZllrOA7PWymfHJjOI9b
         4hnQ==
X-Gm-Message-State: AOJu0YwkMvYt3UGHOMwTkvTLDmDqCX2nQDta1XBVVwf5I9IgyYSybkv/
	CWcPTN9+cjSVMowRAyeMlsQWJypUZD9CwcR4fzMSM1YfwEG7n/kPteVB8LkHzlWCSsvpjpV2r/Z
	HnKBj8Q==
X-Google-Smtp-Source: AGHT+IEsuXSSvASgeovpBF0z8r+wVpgV2+7vhFt1qJRBztwwWEZl+9HACMovEJOSePyI6bw1Ja5nt4bz4jgE
X-Received: from dynamight.c.googlers.com ([fda3:e722:ac3:cc00:c8:f494:ac12:264])
 (user=jdenose job=sendgmr) by 2002:a05:6902:1342:b0:e2b:da82:f695 with SMTP
 id 3f1490d57ef6-e35ed2520d6mr507276.6.1731450341240; Tue, 12 Nov 2024
 14:25:41 -0800 (PST)
Date: Tue, 12 Nov 2024 22:25:17 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112222516.1.I7fa78e6acbbed56ed5677f5e2dacc098a269d955@changeid>
Subject: [PATCH] ACPI: video: force native for Apple MacbookPro11,2 and Air7,2
From: Jonathan Denose <jdenose@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org, Jonathan Denose <jdenose@google.com>, 
	Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

There is a bug in the Macbook Pro 11,2 and Air 7,2 firmware similar to
what is described in:

commit 7dc918daaf29 ("ACPI: video: force native for Apple
MacbookPro9,2")

This bug causes their backlights not to come back after resume.

This commit adds DMI quirks to select the working native intel firmware
interface such that the backlght comes back on after resume.

Signed-off-by: Jonathan Denose <jdenose@google.com>
---

 drivers/acpi/video_detect.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 015bd8e66c1cf..d507d5e084354 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -549,6 +549,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Air 7,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir7,2"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Apple MacBook Air 9,1 */
@@ -565,6 +573,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Pro 11,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro11,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-- 
2.47.0.277.g8800431eea-goog


