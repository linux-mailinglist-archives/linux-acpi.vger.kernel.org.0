Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E22F3038
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 14:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhALNE1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 08:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405338AbhALM6f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 07:58:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0F30235FF;
        Tue, 12 Jan 2021 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610456287;
        bh=rsPGDI3Ps/iaNx5jPpDFUH88u5fQVROzQcmT8n4Co5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4oSip51F6t2M3oe6NNYWU1iSfuEnYfpDN7s3q8jmLFNNukXQTjwNJoQjuPl3QoM5
         +IKgha64XNjJkW/BHJbZCHdfiU0GE1jVGl3H5VWkkMkP0zTRfaifN+JbMxcZhYvUN5
         TLm3qNkNDlZ8y1Mbff28qbiXDuoWZfPLl5dJgNo+FV/aPbZav91Ll+DKyoR6jex8Vz
         lw77GKsITadektgRb5lCqQz9S0ZqvsToXBnMdrPce9ljWUFhJ4Q6d13v3Hg5cxeh4K
         YRG+7mPM5LmY3uM0EoDvPEoPdGqpHLBN0ympISixM8ns8/vez88WUnAzR6JyJttEQP
         zZkBU1FlUoVZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 12/13] ACPI: scan: add stub acpi_create_platform_device() for !CONFIG_ACPI
Date:   Tue, 12 Jan 2021 07:57:48 -0500
Message-Id: <20210112125749.71193-12-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125749.71193-1-sashal@kernel.org>
References: <20210112125749.71193-1-sashal@kernel.org>
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
index 4bb3bca75004d..37f0b8515c1cf 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -787,6 +787,13 @@ static inline int acpi_device_modalias(struct device *dev,
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

