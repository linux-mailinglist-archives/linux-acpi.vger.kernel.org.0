Return-Path: <linux-acpi+bounces-7371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636749498D1
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 22:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB98285161
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D514F117;
	Tue,  6 Aug 2024 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtN6Zawz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28C7E107
	for <linux-acpi@vger.kernel.org>; Tue,  6 Aug 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974943; cv=none; b=H4WZOMOUFTANmjfmiit/6/q7YMeqdgCgt48ALnjWpkrE1YOLMfq01v2mrVI2I3rprSDpuWK9u601KLb9fXZ9gDrfkxI+bQUqAvzxO8fFhxDM0BPawmpYCo5mC96OzRHGIj1Nffdb666QDq7ukYNNSIVPbFrpMG0YgVkB9ytNNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974943; c=relaxed/simple;
	bh=HA5MIyAq3K4wBmGAXx7kvjvMbEMdBSz1eDV3WE70Kl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B6hDgfOttBxkuAqwCOnEtgfckMRbQxWv11TwxD4uEOAc6KvbH3bk5Vvj48CdbS0FWf62ewpZ9FQNLEZGmDbwlrpaOM9g5rmlTLPYz4nUSWUtgeIhhjUKefuSLHz6KgTl128qJevHAA2RbRIiz7w0/cgqCweWXUeYDCFHFHwV3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gtN6Zawz; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4929540f38dso419085137.2
        for <linux-acpi@vger.kernel.org>; Tue, 06 Aug 2024 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722974939; x=1723579739; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUkvCg+RsxL9ebqULPF0t5iB+5m6NBdGn9KgAoU3S/s=;
        b=gtN6Zawza9ctKvg+NnhdNddtUaqWEkLLosr4TQ7xrkIAOfflDczAsDlanvY7d9FArr
         SOEyHaAooajef5EIyVXrts0hxKjKztc2ZTcmR1KsfIr0N/lpJDW3CUhJfH3Qi+xivUVE
         //jVnRzzBrTXfmBzi/pVcNxTkFJVvXe6o6J+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722974939; x=1723579739;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUkvCg+RsxL9ebqULPF0t5iB+5m6NBdGn9KgAoU3S/s=;
        b=Gv15kTmXxfC23jPsWySuEAwpsGQZ8ICvzRVDV/KPkYLwhcXqcnG/Ccg+03javHPaiP
         DeFYvypsYap7IGSmz6prfu+gtkLduT1Nr8Spw7SjrJ23lfwpM/0MvFqURKX55BWQZAh0
         nw8nypOC7WRYBlDOe4ia3nCU4RKrrK9lxel07D/+X1gVjdgWL3BJq7aWHpBWMONDEwFF
         u5flcXM1MUAgidyHqvXpuNqps+esnQNU67woqVAK36RzTK/pEkovynHgZQTqgJVok8Ti
         ZrWTg8Lhn8Igp6bty4pInSLIdjj5Wm6Zi/kHmN55q94UOZZTqP1CLX5nO+dl3+E4AGVI
         5pNg==
X-Gm-Message-State: AOJu0YzPkBq3zrUz4I1ttFATgB+Uo4dVgLXKAxyGoCTexEhQa+LhRMWm
	+WHPl+Hy+Ut87k6jzj2k+/sSAhMA8o328rvpl8x3gOrnn002rjWhXYhpdDwc1Q==
X-Google-Smtp-Source: AGHT+IFfSWZW6P76X9v61/mj/6S3tRRSFE21DqG896oRSD41MC2S4TF4vbAu8H9XY+BIhrwTHBOFVQ==
X-Received: by 2002:a05:6102:3049:b0:493:ddd1:d7fc with SMTP id ada2fe7eead31-4945bdf7cf9mr20304623137.11.1722974939132;
        Tue, 06 Aug 2024 13:08:59 -0700 (PDT)
Received: from spinny.c.googlers.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4945da8b74asm1830562137.7.2024.08.06.13.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 13:08:58 -0700 (PDT)
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Tue, 06 Aug 2024 20:08:47 +0000
Subject: [PATCH] acpi video: force native for Apple MacbookPro9,2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-acpi-video-quirk-v1-1-369d8f7abc59@chromium.org>
X-B4-Tracking: v=1; b=H4sIAM6CsmYC/x3MywqAIBBA0V+RWTcwSvT6lWgROtYQ9FCSIPz3p
 OVZ3PtC5CAcYVAvBE4S5dgLdKXArvO+MIorBkOmpo4anO0pmMTxgdctYUOvbe9Je2pdDyU7A3t
 5/uU45fwBlAHqomIAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Esther Shimanovich <eshimanovich@chromium.org>
X-Mailer: b4 0.13.0

It used to be that the MacbookPro9,2 used its native intel backlight
device until the following commit was introduced:
commit b1d36e73cc1c ("drm/i915: Don't register backlight when another
backlight should be used (v2)")
This commit forced this model to use its firmware acpi_video backlight
device instead.

That worked fine until an additional commit was added:
commit 92714006eb4d ("drm/i915/backlight: Do not bump min brightness
to max on enable")
That commit uncovered a bug in the MacbookPro 9,2's acpi_video
backlight firmware; the backlight does not come back up after resume.

Add DMI quirk to select the working native intel interface instead
so that the backlight successfully comes back up after resume.

Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index c11cbe5b6eaa..2d377414f873 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -547,6 +547,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Pro 9,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,

---
base-commit: d9ef02e56f0fd3668b6d7cb17f9399ea53f12edd
change-id: 20240806-acpi-video-quirk-f1c9f01f07d9

Best regards,
-- 
Esther Shimanovich <eshimanovich@chromium.org>


