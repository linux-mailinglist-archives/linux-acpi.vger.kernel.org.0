Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871B816EB34
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgBYQUg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 11:20:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50466 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYQUg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Feb 2020 11:20:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01PGCgHA116331;
        Tue, 25 Feb 2020 16:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=rpgiRVAOEOCL2DLZ9a7NU85Bt5tQQW0VuUiPQYjaQH0=;
 b=T42H0185vhu4pks02QydslX17erLfw6LgG5OTy6BwUZ7OYTydJSC4nhLMbmdmBDVEhFt
 j8j7bgCCqBZ7H9j7Hu8HHVSYGDncVSMsU+anYKNie3q9wwy4fd6Puo7sSl4Lor4zSLKr
 C/wk4zz4PKVRsbcCuIXTgZRaKiYv3gghh8CfnBaSJOVi1Z7TBzow4r2kJw7VIhPS50ZX
 4DSmLGWzTKgnPbGwpSuyiJogzqdlYsMZW+1PshvwHFpU2ckW+8uYD3SA9Ym20gwCOOHS
 jmovymbM1Pci/IMpLp4/TFoSz8zgVjd3fiV/CSm+4yHmw2hQZT4DS1HDxNiWRd4VoPxM oQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yd0m1tgmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 16:20:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01PGEPC0059561;
        Tue, 25 Feb 2020 16:20:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2yd09awhvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 16:20:24 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01PGKMja005134;
        Tue, 25 Feb 2020 16:20:22 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Feb 2020 08:20:21 -0800
Date:   Tue, 25 Feb 2020 19:20:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] acpi/nfit: improve bounds checking for 'func'
Message-ID: <20200225161927.hvftuq7kjn547fyj@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250124
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The 'func' variable can come from the user in the __nd_ioctl().  If it's
too high then the (1 << func) shift in acpi_nfit_clear_to_send() is
undefined.  In acpi_nfit_ctl() we pass 'func' to test_bit(func, &dsm_mask)
which could result in an out of bounds access.

To fix these issues, I introduced the NVDIMM_CMD_MAX (31) define and
updated nfit_dsm_revid() to use that define as well instead of magic
numbers.

Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/acpi/nfit/core.c | 10 ++++++----
 drivers/acpi/nfit/nfit.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 24241941181c..b317f4043705 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -34,6 +34,7 @@
 		| ACPI_NFIT_MEM_NOT_ARMED | ACPI_NFIT_MEM_MAP_FAILED)
 
 #define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_HYPERV
+#define NVDIMM_CMD_MAX 31
 
 #define NVDIMM_STANDARD_CMDMASK \
 (1 << ND_CMD_SMART | 1 << ND_CMD_SMART_THRESHOLD | 1 << ND_CMD_DIMM_FLAGS \
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a3320f93616d..d0090f71585c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -360,7 +360,7 @@ static union acpi_object *acpi_label_info(acpi_handle handle)
 
 static u8 nfit_dsm_revid(unsigned family, unsigned func)
 {
-	static const u8 revid_table[NVDIMM_FAMILY_MAX+1][32] = {
+	static const u8 revid_table[NVDIMM_FAMILY_MAX+1][NVDIMM_CMD_MAX+1] = {
 		[NVDIMM_FAMILY_INTEL] = {
 			[NVDIMM_INTEL_GET_MODES] = 2,
 			[NVDIMM_INTEL_GET_FWINFO] = 2,
@@ -386,7 +386,7 @@ static u8 nfit_dsm_revid(unsigned family, unsigned func)
 
 	if (family > NVDIMM_FAMILY_MAX)
 		return 0;
-	if (func > 31)
+	if (func > NVDIMM_CMD_MAX)
 		return 0;
 	id = revid_table[family][func];
 	if (id == 0)
@@ -492,7 +492,8 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	 * Check for a valid command.  For ND_CMD_CALL, we also have to
 	 * make sure that the DSM function is supported.
 	 */
-	if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
+	if (cmd == ND_CMD_CALL &&
+	    (func > NVDIMM_CMD_MAX || !test_bit(func, &dsm_mask)))
 		return -ENOTTY;
 	else if (!test_bit(cmd, &cmd_mask))
 		return -ENOTTY;
@@ -3492,7 +3493,8 @@ static int acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
 	if (nvdimm && cmd == ND_CMD_CALL &&
 			call_pkg->nd_family == NVDIMM_FAMILY_INTEL) {
 		func = call_pkg->nd_command;
-		if ((1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
+		if (func > NVDIMM_CMD_MAX ||
+		    (1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
 			return -EOPNOTSUPP;
 	}
 
-- 
2.11.0

