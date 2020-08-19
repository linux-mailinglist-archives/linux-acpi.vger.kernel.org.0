Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477AB24A4C0
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Aug 2020 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHSRRP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Aug 2020 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgHSRRD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Aug 2020 13:17:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990D9C061383
        for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2020 10:17:03 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h185so15836274qke.21
        for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2020 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Dql59iVUZIXkMIIjRDDc9cryY7AhHQUktCiD/CtP8/0=;
        b=SaDIMZS2ii5M5hBvS/wwp02CsyM2WPoW3RqEkAntGwgxTc4fVo7Hx68pRr+AOLnMrR
         UPMgRPyCsKDOPkRe5OKLNS4CI8pXI48uTBAWd5kMgZh9TUGqG+xq+ZKk+ufGc2nxez2v
         qM5hV+1DJlqIs2S7mkDklsgr1aszYcG+di4pl68Ichj98sn24wIe5MX/OedzuTsLDsk9
         SQ9AdgEncaUMdDgNBdwuHSqBZ0tbYSqoCC1GYXp4rK63q/3ls3eFhJ7glbLrIKsZonE1
         aE68EPmxKxdI2FE2q2ElWOgDcKvDcg4YidizaXSbXSz+qJabPAnGnjihSoLDAXf3SR+M
         pWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Dql59iVUZIXkMIIjRDDc9cryY7AhHQUktCiD/CtP8/0=;
        b=F3Lbvmf8XTTTInWFtc9ZTLien1c1MXYvnwswYhTxtm+mVO96vQ9eXAR2VnRU/do/rr
         qTUbAgA9CldwCTp7e4rx5PVzWTvZEMn4eR+XcRCACeLlHRRbCIPAU+ylurWeNVgJgK2Q
         xF5R875IdgnBKVC3WceSSL3i7ksFJTkCBQUVu8DpPu4IOBzPUzvVOjQH9N6xCBJL5r8W
         YHGqT7oGAXScgkrqzD6MIMr80wZyLualPpCcsdWRfsnpi1kaZNHtlnmyXjdlqTd2Uab4
         w+mDRNgyAEFyM/vxEYSqD5esZ842HZSwWu5tAtCZf0MkymcpvCWjrHFJLR0QnFcrMWWI
         THhw==
X-Gm-Message-State: AOAM532wC1m78ukwUbAaw8+xe4v2q47JAVLO969kESvTUvZg8ehiUNH/
        f5ZgOmjYwLYFrkEm/SXybeUstYSqkiSr
X-Google-Smtp-Source: ABdhPJxtxagNEX1cAwExC+2CTX+K29Gd2P21QvxBb0PdzYKFclarlAwZULABq4oqzi5/58pbOaAB1YwWaySr
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr25123931qvv.88.1597857420860;
 Wed, 19 Aug 2020 10:17:00 -0700 (PDT)
Date:   Wed, 19 Aug 2020 10:16:56 -0700
Message-Id: <20200819171656.2650926-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] drivers: acpi: apd: Check return value of acpi_dev_get_property
From:   Furquan Shaikh <furquan@google.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     adurbin@google.com, akshu.agrawal@amd.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Furquan Shaikh <furquan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

`fch_misc_setup()` uses `acpi_dev_get_property()` to read the value of
"is-rv" passed in by BIOS in ACPI tables. However, not all BIOSes
might pass in this property and hence it is important to first check
the return value of `acpi_dev_get_property()` before referencing the
object filled by it.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/acpi/acpi_apd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 4c348377a39d..806b8ce05624 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -99,8 +99,8 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (ret < 0)
 		return -ENOENT;
 
-	acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj);
-	clk_data->is_rv = obj->integer.value;
+	if (!acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj))
+		clk_data->is_rv = obj->integer.value;
 
 	list_for_each_entry(rentry, &resource_list, node) {
 		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
-- 
2.28.0.220.ged08abb693-goog

