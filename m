Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5112292D
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 11:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfLQKsy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 05:48:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35608 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfLQKsw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2019 05:48:52 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHAmihR056883;
        Tue, 17 Dec 2019 04:48:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576579724;
        bh=T3CMfOvjx9ecvb9eaAPNLrofr0AxqpXdmnvNE+n/PCk=;
        h=From:To:CC:Subject:Date;
        b=ZdEizmhcKA80AK6pc8WJjjoNy3fSuXzf8i++I4jbHgq1HHWRXqEdxgdLfu1dtlJh4
         4KiziI+4GZldQWBj2WmDohVEKZ/oJVA3Mx4xalCh4JlnozmbfkcS5nGkx5OThfHwuG
         WbfdStAR4Zc/AdhYOEmWp10bSHfwrbOj/5Yrt8+Y=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHAmijj093336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 04:48:44 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 04:48:43 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 04:48:43 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHAmfcv016608;
        Tue, 17 Dec 2019 04:48:42 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <vkoul@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] docs: firmware-guide: acpi: Change dma_request_slave_channel to dma_request_chan
Date:   Tue, 17 Dec 2019 12:48:56 +0200
Message-ID: <20191217104856.24987-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

dma_request_chan() is the preferred API to request slave channels.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../firmware-guide/acpi/enumeration.rst          | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 0a72b6321f5f..c13fee8b02ba 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -71,8 +71,8 @@ DMA support
 DMA controllers enumerated via ACPI should be registered in the system to
 provide generic access to their resources. For example, a driver that would
 like to be accessible to slave devices via generic API call
-dma_request_slave_channel() must register itself at the end of the probe
-function like this::
+dma_request_chan() must register itself at the end of the probe function like
+this::
 
 	err = devm_acpi_dma_controller_register(dev, xlate_func, dw);
 	/* Handle the error if it's not a case of !CONFIG_ACPI */
@@ -112,15 +112,15 @@ could look like::
 	}
 	#endif
 
-dma_request_slave_channel() will call xlate_func() for each registered DMA
-controller. In the xlate function the proper channel must be chosen based on
+dma_request_chan() will call xlate_func() for each registered DMA controller.
+In the xlate function the proper channel must be chosen based on
 information in struct acpi_dma_spec and the properties of the controller
 provided by struct acpi_dma.
 
-Clients must call dma_request_slave_channel() with the string parameter that
-corresponds to a specific FixedDMA resource. By default "tx" means the first
-entry of the FixedDMA resource array, "rx" means the second entry. The table
-below shows a layout::
+Clients must call dma_request_chan() with the string parameter that corresponds
+to a specific FixedDMA resource. By default "tx" means the first entry of the
+FixedDMA resource array, "rx" means the second entry. The table below shows a
+layout::
 
 	Device (I2C0)
 	{
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

