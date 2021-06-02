Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC23983F0
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFBIRl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 04:17:41 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3343 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhFBIRk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 04:17:40 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw1v61L6bz19SLV;
        Wed,  2 Jun 2021 16:11:14 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:15:56 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:15:55 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] PNP: use DEVICE_ATTR_RO macro
Date:   Wed, 2 Jun 2021 16:15:46 +0800
Message-ID: <20210602081546.11170-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/pnp/card.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index 2430c14f472d26a..d40ed8621571b0a 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -181,8 +181,8 @@ struct pnp_card *pnp_alloc_card(struct pnp_protocol *protocol, int id, char *pnp
 	return card;
 }
 
-static ssize_t pnp_show_card_name(struct device *dmdev,
-				  struct device_attribute *attr, char *buf)
+static ssize_t name_show(struct device *dmdev,
+			 struct device_attribute *attr, char *buf)
 {
 	char *str = buf;
 	struct pnp_card *card = to_pnp_card(dmdev);
@@ -191,10 +191,10 @@ static ssize_t pnp_show_card_name(struct device *dmdev,
 	return (str - buf);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, pnp_show_card_name, NULL);
+static DEVICE_ATTR_RO(name);
 
-static ssize_t pnp_show_card_ids(struct device *dmdev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t card_id_show(struct device *dmdev,
+			    struct device_attribute *attr, char *buf)
 {
 	char *str = buf;
 	struct pnp_card *card = to_pnp_card(dmdev);
@@ -207,7 +207,7 @@ static ssize_t pnp_show_card_ids(struct device *dmdev,
 	return (str - buf);
 }
 
-static DEVICE_ATTR(card_id, S_IRUGO, pnp_show_card_ids, NULL);
+static DEVICE_ATTR_RO(card_id);
 
 static int pnp_interface_attach_card(struct pnp_card *card)
 {
-- 
2.26.0.106.g9fadedd


