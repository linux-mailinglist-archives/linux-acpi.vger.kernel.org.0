Return-Path: <linux-acpi+bounces-6620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE2A917F57
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 13:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B61C23575
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6317E45B;
	Wed, 26 Jun 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnqDa5Zy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19016631D
	for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400515; cv=none; b=mk2WZprz64JYxuW0lK8QFZNZvgxWwWM3QNYfdz5hSYdkUZcVYcu117mzGbyqUo19sFbZoQT5fJ8r/qmwcVyvMo7AUMSYBewXU1UvSShSiRakPrc72HeyF3UEGRiJV5u3MaQ5bpWpLSp+nKybpC2WS+c6fk4UMT0leArqu3aTnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400515; c=relaxed/simple;
	bh=0GMiRghiL0posL3lrMPp5WIHVaYiKqjyKnFHan3H/Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McVieuHJd4LFP7bnFfO3kVTmA98BYi9Ynvn9Q6YrDaGmq+vlpPX9Qqrb6yELVAUZ/4GPdFq1vUlaIqUJhgR8eHlp9Xahuoei9WpBVfk/XEadfIuOgdImZaqKAa33go2GMm0MwHaVPT16X/ZZo4SKZqOi4MPZ4EdReJTIqI7GTvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnqDa5Zy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-706683e5249so3275346b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719400513; x=1720005313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FeCRNCHw66f5uF47Aw5id6R8f6m2JpOZR2R+WLXG7U=;
        b=ZnqDa5ZyhrqzkDQq6gbAau/czLvHuhAsimLrIeMsAvyVj99WnVo7Qkb9Dv1lC2jtEP
         oWG1mgEt4/NW12Mh6sHrhwukLq0WeDyTfYdim8ax6Lu1RX6qU++z0/ZNlXhw5banp/yJ
         JxJ6FeETPtwv1mNiMQH7TIKuCDDUnc2QCu9ilOLV3ARVVLM2ce3Gi8CIc2kBS0ZDsM8A
         6wxM5fHDBSo3xIsF6nBQSuc6UxytTgbyqTy33dczYVfCEe8eCVpCGj95KTaeijZoJ5aG
         ZwcztAQYGB/FKda2IdV7mfUFMgipdsm4bHFOHhcuC/ij3RW8rwnDz+FsziliohUE3/cB
         S6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719400513; x=1720005313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FeCRNCHw66f5uF47Aw5id6R8f6m2JpOZR2R+WLXG7U=;
        b=IUYQ2S3EnsbIWpggLeGwONoO+g4Xi8Md57AWyWV6xjmDWFqJcclw5JuIUiv3/CGglT
         sHqt93mlnjBSY3ZSA3ooZwVGS/zmX+9X+iL0smA6N90NHT2+9HevF6ShflAmKJnqJkZn
         UI8GK7zN0sjvFj+6dS6BVLlLYkmV653/+pOak01BP9RnW8nCQDesPVKeYQiS/3vEPqYG
         8FW7tJImKfIChIwYjF3QCUzqFt8/9WmtmQOlWbxcoKeLe9MDRPXUhlqHpywx1a8lGFy0
         9HrfsWdV1Y3od3ZfDsXuPd9RL0VsBGOAXAOjgCxP62Pvcqc/RBzTpq0YTSYVIqkcA2hZ
         pWqA==
X-Gm-Message-State: AOJu0Yx4WQbWixjCxTClJAzQRnfk6X5Rzw/VZqx93C03HLWVyoIqgJGi
	WRabv7Ie14ronBsbV8oD8gnZXPNIvf1wnQWFaw5Gj1VgLEUNXvMY5xr5Cw==
X-Google-Smtp-Source: AGHT+IEDVs6vvf60mfM6VSGvOdX60QXmye7nFMxSaJ6V2R+pIAnLaD9ovty2RPqt+2XDIFdFu2Gxqg==
X-Received: by 2002:a05:6a00:1796:b0:705:c0a1:61c5 with SMTP id d2e1a72fcca58-706745ab97cmr11489880b3a.20.1719400513082;
        Wed, 26 Jun 2024 04:15:13 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-71893794615sm6368185a12.88.2024.06.26.04.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:15:12 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH 2/2] ACPI: PM: Use max() for clearer D3 state selection in acpi_dev_pm_get_state
Date: Wed, 26 Jun 2024 07:14:46 -0400
Message-ID: <20240626111446.1445111-3-prabhakar.pujeri@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626111446.1445111-1-prabhakar.pujeri@gmail.com>
References: <20240626111446.1445111-1-prabhakar.pujeri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
---
 drivers/acpi/device_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 3b4d048c4941..a90ae059fb60 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -760,7 +760,7 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 			if (!adev->power.states[ret].flags.valid)
 				ret = ACPI_STATE_D3_COLD;
 
-			d_max = ret > d_min ? ret : d_min;
+			d_max = max(ret, d_min);
 		} else {
 			return -ENODATA;
 		}
-- 
2.45.2


