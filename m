Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA47E753311
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jul 2023 09:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjGNHVw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jul 2023 03:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGNHVt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jul 2023 03:21:49 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D571E35B5
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jul 2023 00:21:29 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2NFK18GkzBR9t0
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jul 2023 15:21:25 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689319284; x=1691911285; bh=2KIgooK2dFFh+lYa+cqbbVy+s0Z
        Il/PlmgqMHKtZcZE=; b=V279nT7wwgvF2wILafN1pN7Bb2ZUvlAaiOz7WGkjcC+
        VkzGzVi6BQjBAfhgJehBBHS4u+qzEMt9XpmI+qt3nC/0AMNKKywSk8pirt57iger
        bpxTfJ068bBI1o/aclRfWVmYPo0g6m6B2klMMOvm/4LjHqT90Zo983jvdzhTW4wH
        bJWZKswB6ZysOssx/67tlHF8vnaAsrHQEN81EyHdnBY4Muy5/guY4rdsjjtJPA1o
        zhj2UPPYvPGPVwFSCpWH+B/aWoJDLEmipxesmiIc0N65tmfegLBBxFc3UD1liY30
        MbO0V80PnCY6xfTVV0ZSexgEpKGyR5G0+lILX8Sh7iA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dVc7RDmJzx9O for <linux-acpi@vger.kernel.org>;
        Fri, 14 Jul 2023 15:21:24 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2NFJ4x9bzBJFS7;
        Fri, 14 Jul 2023 15:21:24 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 15:21:24 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-acpi@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] drivers: net: slip: Add space after that ','
In-Reply-To: <tencent_DFF4CE5F22F12C5628BE86CE05E5D926750A@qq.com>
References: <tencent_DFF4CE5F22F12C5628BE86CE05E5D926750A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <489205707f078c77a9f240f4c7f4bbc9@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix Error reported by checkpatch.pl

./drivers/net/slip/slhc.c:679: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:679: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:680: ERROR: space required after that ',' 
(ctx:VxV)
./drivers/net/slip/slhc.c:680: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/acpi/acpica/rslist.c | 2 +-
  drivers/net/slip/slhc.c      | 4 ++--
  2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 164c96e..d7dcd10 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -27,7 +27,7 @@
   *
   
******************************************************************************/
  acpi_status
-acpi_rs_convert_aml_to_resources(u8 * aml,
+acpi_rs_convert_aml_to_resources(u8 *aml,
                   u32 length,
                   u32 offset, u8 resource_index, void **context)
  {
diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index ba93bab..72e64ee 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -676,8 +676,8 @@ struct slcompress *
      /* Update local state */
      cs = &comp->rstate[comp->recv_current = index];
      comp->flags &=~ SLF_TOSS;
-    memcpy(&cs->cs_ip,icp,20);
-    memcpy(&cs->cs_tcp,icp + ihl*4,20);
+    memcpy(&cs->cs_ip, icp, 20);
+    memcpy(&cs->cs_tcp, icp + ihl*4, 20);
      if (ihl > 5)
        memcpy(cs->cs_ipopt, icp + sizeof(struct iphdr), (ihl - 5) * 4);
      if (cs->cs_tcp.doff > 5)
