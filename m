Return-Path: <linux-acpi+bounces-9894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0449E11BE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 04:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C8728316D
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 03:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2EE126C16;
	Tue,  3 Dec 2024 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="I0GqnjHp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F1936AEC
	for <linux-acpi@vger.kernel.org>; Tue,  3 Dec 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196639; cv=none; b=IQqU+Bno9iAK9H8tx/vMObDmEGifyMD3Iu1wTokrdiPcHwGaiDC/mVno/lljAYT5SBaVxE7LO1UhCv9MbgCGOjZ/BHS3CXoWyb8P4k4a03gz3fHad3lijjggS+d9CwqrcD/mOiM/kpAqH8SyBgOc/Oz9yYUT8opOzyqYRoWHeZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196639; c=relaxed/simple;
	bh=bD/3apAuf952VVtwXLkI7UBCN06xt1Z89RhtBXZLpu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fWyb7TVAvKujbt70VqBvNWk657F+dhfotC21cYWOqMD80EKh6WTV//HATO8nbgRNIOjfQYcg+f3Ed2c8TM6ywL2KbYt8GimLjpYK+ilQst9y2HHShrpxG+WmCmOqV9deH58CsoQ9JoxREYriAuydzN2iccSOdxu4ncUKYCdRIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=I0GqnjHp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215a0390925so15604885ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Dec 2024 19:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733196637; x=1733801437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74YDRypx4znInvVqSzM57OPzHortpnE7cILebpOpdas=;
        b=I0GqnjHpJI6VkRD+VdIue3s/TYozEmhHSlmUvxR+TyUgwuqnww/urVCia7CyLCqnnu
         u7BGu7lVD4M8SBzigoZDjb2HwiYn49ES//3L7TBlOxm43QNSEnC61hKLCAjxGDQw83vb
         wXwu8/e6ywDDMK1NHWYJ9Nb4ubjJI9gI4K/45ksPfRKCWyNKOeBTOmIamkBV97wckSCN
         dnE9yd0lBDXXjRzd4QUz2gGg03o2w96f2c8KdJITDvpVwOxvJfH2Kd+eFalMUNd8WuEc
         /6Z+yfTzyKBlzYXsv1Ig9zuXfFIni2UeW8BegHdQyfDKX+NrUA/C0IXPiRbd9lO1wM18
         llZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196637; x=1733801437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74YDRypx4znInvVqSzM57OPzHortpnE7cILebpOpdas=;
        b=qvzU/FxES8z0KO0No97j8sw2WOHjMz6qNShGG2G17ycNve+vxUSfzZ2C9nR19ug4Lx
         uY4OvHjqhCY/BXKxe/mwRI4Sd7BPLx2UUBHQDb3iNY3fay2RuGfMyTT/L4LbN0Dw0afw
         nVIuchU9h8Ny9gqW4XEJhKDRqzewK/dnCQkZLaBk/4GA3srO4mul2DwNkm4hz0OcslNj
         I9fZaHCUkGS95O95qzx37UQfWcOsaKgq68eBpMiRt5EyT07vzWkosOnkpwtfdx2W7+ci
         yh/HUW5QXU40EA6QcJILOlzbIAVrGbv8IBKDLccWtbdC783g04lcdw+Hqp7JCc4XpFpg
         uXRw==
X-Gm-Message-State: AOJu0Yw0pIsI3A1SqvfHnFtIrufMkd2E9lSbZooPAWJ8JynFVm+9Ngpc
	YKqjg79awyJZJzO20M3TA1DCCo6c0L1hVEM12PDg80eAPh7b9IbGWtWn3tOmliM=
X-Gm-Gg: ASbGnct2c8/kpXn22w9tE65/skmBpmtJP7RO4HnrHWLF6ptxtEfFSisoWMKCT2YwWVg
	0zkLo+hyINupnvMV91MMpin0fcTAk/VNSlgzjUAsiD0xf/RLNERBJzc610HVL95FPO2J5whDkWW
	rCfOq++/dZxH2xozqJyoMPgPFlkrpXjz/kzjQZMQtACVDiHUa9nQ/wuyI0wO7Z0U8n51GyMXp4l
	tuxvFD64aWOFxqA7ZkIII43F9iB1RG8m8XUL8OZWKpQTXjjSO+8qoaJZT+vHgIC0P7RO3qywWpN
	2GPv9RMWdp8uGhzY4JfT4VzThN0KQJ0SgUqP
X-Google-Smtp-Source: AGHT+IG+dHv1z6NUbtxuUBhEuVfJ0/a1nq1g00Ke7EV+ke3oeNNyhhmHEjfMytnEQVVW2lbmkCXJTQ==
X-Received: by 2002:a17:902:ea07:b0:215:75a5:f72b with SMTP id d9443c01a7336-215bd266391mr13077795ad.53.1733196636870;
        Mon, 02 Dec 2024 19:30:36 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2153a1e3e7bsm71405605ad.25.2024.12.02.19.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:30:36 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] ACPI: fan: cleanup resources in the error path of .probe()
Date: Tue,  3 Dec 2024 12:30:18 +0900
Message-Id: <20241203033018.1023827-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call thermal_cooling_device_unregister() and sysfs_remove_link() in the
error path of acpi_fan_probe() to fix possible memory leak.

Fixes: 05a83d972293 ("ACPI: register ACPI Fan as generic thermal cooling device")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/acpi/fan_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 3ea9cfcff46e..8e3f62a3745e 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -379,11 +379,14 @@ static int acpi_fan_probe(struct platform_device *pdev)
 				   "device");
 	if (result) {
 		dev_err(&pdev->dev, "Failed to create sysfs link 'device'\n");
-		goto err_end;
+		goto err_unregister;
 	}
 
 	return 0;
 
+err_unregister:
+	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
+	thermal_cooling_device_unregister(cdev);
 err_end:
 	if (fan->acpi4)
 		acpi_fan_delete_attributes(device);
-- 
2.34.1


