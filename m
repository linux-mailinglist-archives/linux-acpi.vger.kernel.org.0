Return-Path: <linux-acpi+bounces-1108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356EB7DCAFA
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 11:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA871C20AD9
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAD31A71C
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLlODXyK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7A10A33
	for <linux-acpi@vger.kernel.org>; Tue, 31 Oct 2023 09:53:26 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFC2706
	for <linux-acpi@vger.kernel.org>; Tue, 31 Oct 2023 02:53:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32db8924201so3436342f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 31 Oct 2023 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698745990; x=1699350790; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFRxwinx1cM2sVOqCV9quISEyDqLS+FaZtQfbRBK1rA=;
        b=yLlODXyKAftmOd5NF3c+z+I6Gf2qg+g3Pwv64ppyv4lcSQuLY3mPuTTvY79qn3cV4r
         a+oUYD5W0bElf9aZBj8A2osyEJmAbvwSfVRJb7zygG6u5/RSHjCK2Bk8Vmos29TP1dyl
         MnITroExuJSHn2TVkfO3OUSym0WaKM00VN2E8V29jGMVmcY0tCDUeym57TWmVTVzx6Wk
         D2VBXcc0XhDS0MEPUYVeIfiz/Cs8fTiSVr8r4sC2/8EzOStz9KehlGxpqvJAQW9pwH4l
         Jk0jhHWcmfloRd93zd2NVLDep7GbdGXCSxBrpXCRK+H39AhfARLrxFS03gKhpFEsIhdm
         hEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698745990; x=1699350790;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFRxwinx1cM2sVOqCV9quISEyDqLS+FaZtQfbRBK1rA=;
        b=tnjBglpaErKmNQd/6Z++GsMJIjRvV1JkdQwPfgAERtzxUehV1M8foALS083VSniKyv
         5tKy34ggAXfED3KRgnKiyUS+ut1QfXgMvKTmKBajeyiEaQpZy8JVm0o9HA4sUudtT9mX
         DeK8lVCkbq4N0+g2cbCze5UQyFAmdmc0plFpAD6Xteoip9O9ANkuB14hfd66P59FLrlZ
         vggKrQ9yfogevm1pmkbsqjwNoK+G5+0E3e/A1vzNAfm6SuqercLev57Ssek71rcjJNaM
         Y3xnKGSMVHamxZEF+f9gAl6AklBmfkT2L8B8pFrkUMkwwBBuPosNHTq/nQW+NfWxGh4b
         0xgA==
X-Gm-Message-State: AOJu0YxGeanzxgeKi3YsKQD0kldS05q63l55xhr1cPR+rSU859sqGc/y
	sLWBz5dAnFB38MuLkjrfI1EZ/Q==
X-Google-Smtp-Source: AGHT+IG8siE7KnFaasdwbgCjK7u76Z93oel5ja003Na7cnX3EmogDwE8acrkjpq54EA7RJ8DlL1OSA==
X-Received: by 2002:a05:6000:2aa:b0:32f:7c27:423b with SMTP id l10-20020a05600002aa00b0032f7c27423bmr7734652wry.51.1698745990224;
        Tue, 31 Oct 2023 02:53:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d694c000000b0032dde679398sm1093302wrw.8.2023.10.31.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:53:09 -0700 (PDT)
Date: Tue, 31 Oct 2023 12:53:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ACPI: thermal: Fix acpi_thermal_unregister_thermal_zone()
 cleanup
Message-ID: <45750e0c-ce53-4994-8abc-19e75377ba5f@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The acpi_thermal_unregister_thermal_zone() is paired with
acpi_thermal_register_thermal_zone() so it should mirror it.  It should
clean up all the resources that the register function allocated and
leave the stuff that was allocated elsewhere.

Unfortunately, it doesn't call thermal_zone_device_disable().  Also it
calls kfree(tz->trip_table) when it shouldn't.  That was allocated in
acpi_thermal_add().  Putting the kfree() here leads to a double free
in the acpi_thermal_add() clean up function.

Likewise, the acpi_thermal_remove() should mirror acpi_thermal_add() so
it should have an explicit kfree(tz->trip_table) as well.

Fixes: ec23c1c462de ("ACPI: thermal: Use trip point table to register thermal zones")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/acpi/thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d98ff69303b3..f74d81abdbfc 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -702,9 +702,9 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
 
 static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 {
+	thermal_zone_device_disable(tz->thermal_zone);
 	acpi_thermal_zone_sysfs_remove(tz);
 	thermal_zone_device_unregister(tz->thermal_zone);
-	kfree(tz->trip_table);
 	tz->thermal_zone = NULL;
 }
 
@@ -967,7 +967,7 @@ static void acpi_thermal_remove(struct acpi_device *device)
 
 	flush_workqueue(acpi_thermal_pm_queue);
 	acpi_thermal_unregister_thermal_zone(tz);
-
+	kfree(tz->trip_table);
 	acpi_thermal_free_thermal_zone(tz);
 }
 
-- 
2.42.0


