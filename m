Return-Path: <linux-acpi+bounces-6752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D45F9255D6
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 10:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CE11F26007
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0913A884;
	Wed,  3 Jul 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWECwGZK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E2136986;
	Wed,  3 Jul 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996544; cv=none; b=LTvAv8hVfyfwLSKprITi0jC9c+pUW054i8Gyrvix8dzF1onvmilz+tyBKAQy1sK0yvtJBzRU3xzoMuF4RKX0QkCXbVdrPFeKbuP/43Iwo060BdMCf4mFDwkupOOfgEUuWf31CKZU2LlEhEmg4xEE6htFeR13S6DmDTlwVXtT5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996544; c=relaxed/simple;
	bh=g37GRHeA4FUQFNxW+0fC++R9p/fzKvH6Aw3qjaPXR2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sBBuWrKOH/CtrXCyOOSurXUbUVJj3gBJa/aP645u9OtTxxT6n6q+CCDXVJc3QOZ9Nui5tm/gMgjNPm0ADEpVRpUFXd9PNk+mAQj1S34KbbjcO4pbQrTzINcl0BxKsy3F1IuvujKpdf9n47l8a7OeMH7trdBWBDepgt61sGRRm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWECwGZK; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e72224c395so58593671fa.3;
        Wed, 03 Jul 2024 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719996541; x=1720601341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AjhbvJGW65lucbNOKyGKt16wc5zILo5usSblQaXEvc=;
        b=UWECwGZKPjJT1+8eI0oYyy75gqW7RUUl84kmfZI+DyTjFXVF1sPEUQmt0ESp2qNtps
         ZZ+CCXNiP3E6RZmRma07EmP4rCbxxaKEsNC1CsHomm9UX2t/2tGN3Oypb6GmcxgJTfqk
         JZWSVhCqKQwpb1+nNzVdG7gWn6/9VtHH8oMBjPxKzGL6QCmJixGNhmsumaIsM5J3ScMh
         RQbR0cNyrCp+w1xcKEgcRI8x+VQi0jaSkNAkrCyfEsBzrHkFPCvSK1PLjXkW8hS053Sr
         JiicFvPwxnWFHPp87Y3jgaq/KojPsHUpoQbAPZfj+BrhzyQ/V74CIcL5Sk35pkBfm3nG
         f5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719996541; x=1720601341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AjhbvJGW65lucbNOKyGKt16wc5zILo5usSblQaXEvc=;
        b=qOR/fZMFRf6cZKNNzCI6qm/Uju0z3SFWYJyRC8e9CSE0nNzZc7pYFB4OZFg4zMAEwp
         avcAjqXUf24dn59ylAP+uzkKkRsfT4G+mPPmxB6qimWp1a59rLWWN1vM66yIZPhMVgG7
         yJzMiS2JcZvUeUGvL6cAdWIu/ZXylq/mh39I6ipDdCpuyFkjnOr4ebvF6vAgbU85xdWC
         kTWXKPzzw9LFGmrF2CC9xsmvi18o0vUcziWd+mV5giMP7wb130oNyVSgqIdqTbjxPLLo
         JnNQaoA6G0F06l/Bhu5Va6AKUdYqzONcOKrAiW/IULI7q2WtwL6+DwVioV1VIyG4N65A
         oQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr8I2kqL/jceI1FuCqRFmv4dv9avfanstW5l2eeOhepHdwpIMVnr1WwtMbvgJb5z5J776b4X3bWQmfu5OkYJtIQ9g+54+gxe7o8lLNlAgfWqftuYu+jR8CBfw0TOOd4wYZLv4F1mfyGQ==
X-Gm-Message-State: AOJu0YxEIH3xEqvEDgPpo070HpAVohxHRe0hYav5TjZ4jh+N9tw4YECg
	LrIFqjY+WuqmsDlYWAiVjGFpd1SD5BCssXW38tfOZTAx9zO/WPpXgAzbgq8S
X-Google-Smtp-Source: AGHT+IGWtoPrU8lRR2/crvMe7zAwVRwVnjmZHiO2S/eMWKnrVKssX59sxbWyLLLr048lbdCvIMR7zg==
X-Received: by 2002:a2e:309:0:b0:2ec:59d8:a7e6 with SMTP id 38308e7fff4ca-2ee5e381f18mr69568041fa.30.1719996540582;
        Wed, 03 Jul 2024 01:49:00 -0700 (PDT)
Received: from qamajeed.Home ([39.45.165.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b065316sm226126115e9.26.2024.07.03.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:48:59 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v3] Updating a deprecated use of strcpy.
Date: Wed,  3 Jul 2024 13:41:25 +0500
Message-Id: <20240703084124.11530-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing strcpy with strscpy.
strcpy is a deprecated function.
It should be removed from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>

> Replacing strcpy with strscpy and memory bound the copy.

> Why?  In this particular case, it is not fundamentally necessary.

> strcpy is a deprecated function. It should be removed from the kernel source.

> If the goal is to get rid of all strcpy() calls from the kernel
> because using it is generally unsafe, just say so in the changelog and
> it will be fine.
changelog has been updated.

> So is it necessary to use the size argument here and below?
Size argument is not necessary as destination is an array of 40 bytes. Patch has been updated.

> for that to work, shouldn't the size of the *destination* buffer be
> passed, instead of the length of the string we want to copy?
Yes, size of the destination should be passed.

> Not tested, but the 3rd argument of strscpy () is optional.
> (https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/string.h#L87),
> so maybe just:

>        strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
Thank you for sharing the reference, this suggestion will do the work and accomodated in the patch.

---
	v2 -> v3: Changelog has been updated. size argument has been removed.

 drivers/acpi/acpi_video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 1fda30388297..8274a17872ed 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1128,8 +1128,8 @@ static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
 		return -ENOMEM;
 	}
 
-	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 
 	data->device_id = device_id;
 	data->video = video;
@@ -2010,8 +2010,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	}
 
 	video->device = device;
-	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
-	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
+	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 	device->driver_data = video;
 
 	acpi_video_bus_find_cap(video);
-- 
2.34.1


