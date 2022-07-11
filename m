Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59655D110
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiF0PwA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jun 2022 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbiF0Pvy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2022 11:51:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64B2193FB;
        Mon, 27 Jun 2022 08:51:51 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RCSNNL017521;
        Mon, 27 Jun 2022 10:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=zKVjs6FUp3AtesiTh6VnlwcBjsKTbJMxizo235GYlwI=;
 b=TaBQ7c1K+VqNMwl6+aPYkIIBc7bXUx9RgS0BGEfomz62nj4LDSlkcyPDLC7leqZ4BpK6
 7WXjyZJath2KNL7Gddsv/wAJAFFhazxR/TgEarVi4qvUMXU8+Q4oksZ08ayAhlSaE4U7
 2f4PqJLzk/3HjQEf6WR/wfWf+zxr27+pA59lFeBrj5e8k4yWupWnr3UzslqT4BVZup7Y
 T+uXnB1/qHAEDEPmE08mRHWbYoJqbj+9pWx2EPkhXmrQQRtWWSnKvhWQlsl2lF26gpxm
 f0WB71NJZBmdnNan8D/3wbwPnH0e01FM591xb6wSY7G8mTYnvJIxA6KOWeQgIuUVDL9N 1A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gwys2k0ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Jun 2022 10:51:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 16:51:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 27 Jun 2022 16:51:42 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.163])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 63666458;
        Mon, 27 Jun 2022 15:51:41 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 0/2] Read _SUB from ACPI to be able to identify firmware
Date:   Mon, 27 Jun 2022 16:51:36 +0100
Message-ID: <20220627155138.807420-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0ztQ70rIQ642H72ACesiiiETc-8cUU7t
X-Proofpoint-GUID: 0ztQ70rIQ642H72ACesiiiETc-8cUU7t
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CS35L41 has a DSP which is able to run firmware, as well as a tuning file.
Different systems may want to use different firmwares and tuning files, and
some firmwares/tunings may not be compatible with other systems.
To allow a system to select the correct fimware/tuning, we can read an _SUB
from the ACPI. This _SUB can then be used to uniquely identify the system
in the firmware/tuning file name.

Add a helper function which reads the _SUB, so this can be used by other
parts in the future.
Add support inside the CS35L41 ASoC driver to read this _SUB, and save it
appropriately.

Changes since v2:
- Fix error in function prototype

Changes since v1:
- Add length validation for SSID String
- Rename API
- Allocate memory inside API
- Use ACPI_HANDLE macro instead of ACPI_COMPANION
- Improve error handling

Stefan Binding (2):
  ACPI: utils: Add api to read _SUB from ACPI
  ASoC: cs35l41: Read System Name from ACPI _SUB to identify firmware

 drivers/acpi/utils.c       | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h       |  6 ++++++
 sound/soc/codecs/cs35l41.c | 24 ++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

-- 
2.25.1

