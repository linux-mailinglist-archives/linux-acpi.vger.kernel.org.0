Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CACA704200
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 02:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbjEPACP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 May 2023 20:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245404AbjEPACP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2023 20:02:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3013DC5
        for <linux-acpi@vger.kernel.org>; Mon, 15 May 2023 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684195334; x=1715731334;
  h=from:to:subject:date:message-id:mime-version;
  bh=SVfzEvIdvmQ3LoEG8iz7UgwTu9aEp6mufeLBoSNrCkw=;
  b=XgfhwQUppZj8v8z0QC/qaL7DDl3VE0I7VZch24Z9w6loZbTCkMwwSOI2
   qf+5tPY9sdSir8btlaQPFPCmpY8ObD+yck7IHNwX1seYmrxFILTr5/c2Z
   VVcYt6/NdIDVnGX8OiNlKtVcaY+sv810USw9l+sZc6ZNejNYKxp5rgdlP
   YqozGiy7x8yj/SYAzbG8OlWsOaCey893VZZveJAS53SlyzfSgbFKnk3al
   h1DrMaHUj2b/wgjmq/DONzfow5hGg3+puje/+iyQPbXdCuHkVDYtSYPLU
   6EROuxpSYWyhK9MQ8gQSm+g4jgZeq7jPyrowoWq8CVwXNLB7PiQpJB8nI
   A==;
IronPort-Data: A9a23:zpXxzKqHg/XezM8jVZBot8Bh2vleBmJEZBIvgKrLsJaIsI4StFCzt
 garIBnTbq6MZ2H3f40ga9ixoU5QupXSz9YxTwA6qyExEiNB95acVYWSI3mrAy7DdceroGCLT
 ik9hnssCOhtFie0SsKFa+C5xZVa/f/WHuKU5MnsY3guHFYMpB8J0E4lwahj6mJRqYDRKxuXv
 t/vqNHoNlag2jplWkoZ8KvrRClH5ZwegxtF+A1vDRx3lAWGzSJNUctCffvZw0bQGeG4IMbrH
 44v85nkpgs1zz91Yvu5n7DydFE9Q7K6FWBiXVINA8BOKjAbzsAD+v5T2Mg0MC+7uB3Q9zxF8
 +ihgLTrIesfFvaVxLlCCUkw/xZWZsWq8JefSZS2XFf6I0fuKxMAyN03ZK060BZxFk+azgii+
 NRBQA3hYCxviMqZ3e2fCeh91/hyMcrIINwZhHF/0WnwWKNOrZDrG80m5Pdfxiw1ickWRaiYZ
 cRfaDxzYRCGaBpKUrsVIMtm2rju3CGuNWABwL6WjfNfD2z7zgFr3b38dtHSf8SNXtlYmkKRj
 mPA42n9RBodMbRzzBLeqSr927aWxnKTtIQ6ROSGtd1rinuoz31PUDZGWVq1mNiZlRvrMz5YA
 wlOksY0loA29Uq2Xpz0VAW5iGCLswRaWNdKFeA+rgaXxcLpDx2xAXIfSzFIMIR48s04Az0sy
 lKN2djuAFSDrYGodJ5UzZ/MxRvaBMTfBTRqifMsJefd3+TenQ==
IronPort-HdrOrdr: A9a23:y02GBKy1Bw2CbLhTKn3RKrPwJb1zdoMgy1knxilNoH1uA6ulfq
 +V/MjzuSWatN9zYgBFpTnjAtjifZoNz+8R3WB5B97LMDUO01HIEGgN1+XfKnHbak/DH6lmvp
 uIdZIVZeHNMQ==
X-Talos-CUID: 9a23:45j3bG917KLiiAsRTfuVv2EJReRmc2yM8CbNIGykVmBXSKKJEXbFrQ==
X-Talos-MUID: 9a23:POJEiwu+U/fXkZgz7M2n1Ghcd+Rp6YKVAVFRyb5Wt8iKDA1QJGLI
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="330951139"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="330951139"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 17:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="678619512"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="678619512"
Received: from anubrata-mobl.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.212.82.15])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 17:02:13 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     <linux-acpi@vger.kernel.org>
Subject: ACPI: EC: Clear GPE on interrupt handling only
Date:   Mon, 15 May 2023 17:02:12 -0700
Message-ID: <87353x87p7.fsf@jcompost-mobl.amr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara, CA
        95052. USA
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On multiple devices I work on, we noticed that
/sys/firmware/acpi/interrupts/sci_not is non-zero and keeps increasing
over time.

It turns out that there is a race condition between servicing a GPE
interrupt and handling task driven transactions.

If a GPE interrupt is received at the same time ec_poll() is running,
the advance_transaction() clears the GPE flag and the interrupt is not
serviced as acpi_ev_detect_gpe() relies on the GPE flag to call the
handler. As a result, `sci_not' is increased.

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
---
 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 928899ab9502..42af09732238 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -674,7 +674,7 @@ static void advance_transaction(struct acpi_ec *ec, bool interrupt)
 	 * 2. As long as software can ensure only clearing it when it is set,
 	 *    hardware won't set it in parallel.
 	 */
-	if (ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
+	if (interrupt && ec->gpe >= 0 && acpi_ec_gpe_status_set(ec))
 		acpi_clear_gpe(NULL, ec->gpe);
 
 	status = acpi_ec_read_status(ec);
-- 
2.40.1

