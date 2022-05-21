Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF252FAD2
	for <lists+linux-acpi@lfdr.de>; Sat, 21 May 2022 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbiEULMB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 May 2022 07:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiEULL7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 21 May 2022 07:11:59 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06F2980F;
        Sat, 21 May 2022 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D6SwVHgxTU4ivyQqfknWUgj4ctP9444wxZqjMMPa57o=;
  b=qUM+9N+5ijPFA+dMeia8QG24Ly9urjs4c+yCv2jr3dWe0TkVwdoM1i2l
   9ipL7ZgZHmwbisYJRQyw/Khzembp0EcTZFFxAGsLNyhZI7VcDZ1LuBlpd
   diSZyEnV7YyvPEYPuoJTDfpZOd7FPxpx2AcReq9RR2HFEPSrTF6fszq+N
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727889"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:52 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: CPPC: fix typo in comment
Date:   Sat, 21 May 2022 13:10:13 +0200
Message-Id: <20220521111145.81697-3-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/acpi/cppc_acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index bc1454789a06..e6c1df0b3cc4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -305,7 +305,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 		goto end;
 	}
 
-	/* wait for completion and check for PCC errro bit */
+	/* wait for completion and check for PCC error bit */
 	ret = check_pcc_chan(pcc_ss_id, true);
 
 	if (pcc_ss_data->pcc_mrtt)

