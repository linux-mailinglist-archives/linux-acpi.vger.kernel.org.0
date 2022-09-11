Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29095B4D0F
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Sep 2022 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIKJpk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 11 Sep 2022 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIKJpj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Sep 2022 05:45:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA82529D
        for <linux-acpi@vger.kernel.org>; Sun, 11 Sep 2022 02:45:38 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MQPtd22cczHncg;
        Sun, 11 Sep 2022 17:43:37 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 11 Sep 2022 17:45:35 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <rafael.j.wysocki@intel.com>, <bjorn.helgaas@hp.com>,
        <rene.herman@gmail.com>, <len.brown@intel.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-acpi@vger.kernel.org>
Subject: [PATCH] PNPBIOS: remove unused pnpid32_to_pnpid() declaration
Date:   Sun, 11 Sep 2022 17:45:35 +0800
Message-ID: <20220911094535.3226660-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pnpid32_to_pnpid() has been removed since
commit 25eb846189d2 ("PNP: add pnp_eisa_id_to_string()"),
so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/pnp/pnpbios/pnpbios.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
index 2ce739ff9c1a..f3302006842e 100644
--- a/drivers/pnp/pnpbios/pnpbios.h
+++ b/drivers/pnp/pnpbios/pnpbios.h
@@ -153,7 +153,6 @@ extern int  pnpbios_dont_use_current_config;
 extern int pnpbios_parse_data_stream(struct pnp_dev *dev, struct pnp_bios_node * node);
 extern int pnpbios_read_resources_from_node(struct pnp_dev *dev, struct pnp_bios_node *node);
 extern int pnpbios_write_resources_to_node(struct pnp_dev *dev, struct pnp_bios_node *node);
-extern void pnpid32_to_pnpid(u32 id, char *str);
 
 extern void pnpbios_print_status(const char * module, u16 status);
 extern void pnpbios_calls_init(union pnp_bios_install_struct * header);
-- 
2.25.1

