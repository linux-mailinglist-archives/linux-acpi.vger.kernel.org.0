Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54FA2F3011
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 14:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbhALNCU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 08:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405508AbhALM6s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 07:58:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D2B22310F;
        Tue, 12 Jan 2021 12:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610456301;
        bh=wSiP5Yy3ak9NSXoHC+m4cI2NMDPxDip38q1+sFbQ5dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JdLSztHkqSrpFdvRDFG1VGtJFwufZOmj2lkjuJrucuW0YiQpdcBRU4pm0PWH2IKQG
         NtSuPuEW3WgyPi7v2z76dKu/aQKMbQ+JtU1cvL4c4LmeSbUe/JzZE1LA+3fjp7nmD1
         FWb79el7iAzatcKVF8/BIvCU+xVdLl84exSPqcmnr8BsX/ZpcJfZOZqtQp+cGV40ii
         p2Y9WRPC3WkjNsGubBsOOhHJ3BseuqDFQ71CJqsmUoBkm9QcBCQvR4RKmAJ4CTl5J+
         PiBFRD705qA6+pWknmbT31aUT7YG6gDmz0FZV5kOV7GzwqyFxlkO9hrNg1MlWfmq/2
         KRFbRhDkt/GGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 7/8] ACPI: scan: add stub acpi_create_platform_device() for !CONFIG_ACPI
Date:   Tue, 12 Jan 2021 07:58:08 -0500
Message-Id: <20210112125810.71348-7-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125810.71348-1-sashal@kernel.org>
References: <20210112125810.71348-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Shawn Guo <shawn.guo@linaro.org>

[ Upstream commit ee61cfd955a64a58ed35cbcfc54068fcbd486945 ]

It adds a stub acpi_create_platform_device() for !CONFIG_ACPI build, so
that caller doesn't have to deal with !CONFIG_ACPI build issue.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/acpi.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5670bb9788bb4..192b045cc56ec 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -734,6 +734,13 @@ static inline int acpi_device_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static inline struct platform_device *
+acpi_create_platform_device(struct acpi_device *adev,
+			    struct property_entry *properties)
+{
+	return NULL;
+}
+
 static inline bool acpi_dma_supported(struct acpi_device *adev)
 {
 	return false;
-- 
2.27.0

