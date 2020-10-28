Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDED29E213
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 03:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgJ2CFo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 22:05:44 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:47552
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbgJ1ViJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 17:38:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLaWTNQpW/YqjRZEkJ8OB+LyZvnGzY+yxT1sfdsSjCzyRlFtNCYqYWeUobRZl/06S1t1y7wIljTDKWxWHkatBXOnRb5fCeXNunfHNkud+t2Y0zuZMeyoL/ZSXxfyYsK5xCAuZUhcS2FeCFpNZ05L3GShVqpNcaZ1vgS1H6z8k2UQQ0RDiP+cmpA/4wIMzurg0DNtL1pXulNiNUQeT+XIfH8iALKuCIciwqOOxWn0ucXRDutvY6g1BxWWFixajxrLcSsxtXyIXSAaUfrNU2hDII+GuEK8xKplGHjMFs/r69/KG+FDxeBLlSXp1/pdWUgTr8Q3cwBpw6rq5ChxpARkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJXzbbLVoWEXngm/TFSMemPhqJOABsPdwuAreARsr1w=;
 b=K/oh9Gcloa5UwELNT3ogbK91SRfRheB43I2J8JtDFqYKxuiejUVHBrl6xc3hrkYTrvvI7cEVq+09TfSjxGMPrMSC60Ff1xi0Zpcnbfk2kWB3prtOwAw3ySFjuc14MKSndwIZieFfAVv7nYE2PaODIRSkCMLwvs/i2q4YCeCou4h3W1euLOxRPIVng8y0eSS0bndLxAVFmtOWhOo9l4lC5fX8wOPbZIb/M9ukikLYbBa9CtUEoafAJtpgTlW+54llBZLyUOvgyoiBiB5sfh/R7PhMx5/+weyzqmvJUY+rrZWFuiU3/r3r3jgLYc7Cgqtu1H4sFsc9gd/wtwY84j7qQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJXzbbLVoWEXngm/TFSMemPhqJOABsPdwuAreARsr1w=;
 b=gIIezjNIiIq7e7G+otLhN/y+AXnNVIMMVH3yfn1frZV0vvyorxyLQuNEmKvuhP/YGt4y5+EoO1uZjslUfFOpir8T6THOhfw/Y1p14Zp/S7hJ2F75Jx2o7uSvCsreTm54bfR6fPdogQWm4wPA/ii5w8N37ERTWzuq4BH0et808HM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Wed, 28 Oct
 2020 20:05:34 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::a18a:3898:84d8:1209]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::a18a:3898:84d8:1209%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 20:05:34 +0000
From:   Mark Asselstine <mark.asselstine@windriver.com>
To:     linux-acpi@vger.kernel.org
Subject: [PATCH] ACPICA: avoid double free when object already has a zero reference count
Date:   Wed, 28 Oct 2020 13:05:23 -0700
Message-Id: <20201028200523.111028-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [147.11.105.123]
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ala-lpggp2.wrs.com (147.11.105.123) by BYAPR08CA0009.namprd08.prod.outlook.com (2603:10b6:a03:100::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 20:05:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 345abd57-95f8-48a7-112d-08d87b7cd454
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:
X-Microsoft-Antispam-PRVS: <MW3PR11MB46844B53F2E103811DC79620ED170@MW3PR11MB4684.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0xzVpObx0ZaiAXqfTClWOD8OgDBmCPKDrQ+eZZ0bpktMINXk8/JV19YdXCggrpWdftPHqZCVIbQaTt3VLbx6OkfPHMLbqIGkef7zNBDzdMxv0QG7S+zSUgGNgId6AkhRUOIGdsrFeEs0yufY9m+rubehWPH8m5xS8Dv5Oi54sLOijKVbYlR5mlnOKZZeUGAWXJMfBaSeENfpTK5rVRbwN92JbhuwGmHWzKwaQO799DvBbHG6l4ZVUwxUhgXS8fj8ID467VzvuT0BndJ2JCGkkNxsLKgoGYt5DvJsZzDNCuh9LKSqAgo13ISMzd4KuVsg/OcEYuMuc1fFHiWPRfKBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(366004)(136003)(6916009)(16526019)(1076003)(26005)(8676002)(316002)(86362001)(36756003)(186003)(5660300002)(6666004)(8936002)(2906002)(83380400001)(6506007)(52116002)(6486002)(478600001)(956004)(2616005)(44832011)(66556008)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sWbxtF+OzZuxTiUbMJV7wqF1/7AxKbKk+IULPvvm+5v2eJ1dLRKU2yxZtt9nCxiBqUbO/mxYRIbKzy0rzhjS1+FsP04qFlLXe5WB2Ht2eO4FmQ4E/WNltJnXHXEHfLXYwVJnPUzFS5Ne/vUAQTjJBIAqVzXfSjK1ZjlwTvnaHXa769CgpMYFu7kefTNUEJZSruXp0Jqy8ry385p/q2qwJeGbLzc5DXzxuM1ayE7AFUireFZx0i7hVMyb4aqeMBHFrlFoOR7tNbfDeDF+AcziJfEvtwEdWjo+yl7id5bWCdzHcTCIXwZ6D8eT6FDQ5D6vrQFbolJb41hRHCO01WVEoWsfZC1AkLkME3Cuzs42aVaRKzsuTGfOOHEAA9K+grdKm1zCRwEaZK2Nd+ccd8WtBzIVdREmHA4Z0sWQMK/5OAKtAkdZ1UKy3h+yr8o6/Y1BI/Sab2VxCzlx0QECt68d5E51hD4caX+vx198wCAh0Y0htsp6tF/CDFxIPjvm3t7eyvyW2J7z2FUCI12NIqcZWu6/D62vroDFxBVZQtR0snRTxY5HdnNEOivdrR/vdP/zqjv9wzU8ru3oaAy4Hrk6C+7Rc5uxzKx3XmcyYpTmbpauQq36rjjHBPCs6RaeeDkIZtuIY1shW4z16Vg+5er38A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345abd57-95f8-48a7-112d-08d87b7cd454
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 20:05:34.2012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGLVJa1Py2gAr2gg1vhtND9YZ46xA9W6MKSyskZbnhITtk5OD6M5E5iwOop5SUUPlsae6QJam6tptLj5GAh6/FftwMb+czYYh8LHtpA+V5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The first trip into acpi_ut_update_ref_count() for an object where
'object->common.reference_count' is 1 and we are performing a
REF_DECREMENT will result in 'new_count' being 0 and thus the object
is deleted via acpi_ut_delete_internal_obj().

If for some reason we make a subsequent trip into
acpi_ut_update_ref_count() with the same object,
object->common.reference_count' will be 0 and performing a
REF_DECREMENT will produce a warning msg "Reference Count is already
zero, cannot decrement", 'new_count' will again be 0 and the already
deleted object will be attempted to be deleted again via
acpi_ut_delete_internal_obj().

Since the object deletion doesn't NULL the object the calls to
acpi_ut_delete_internal_obj(), acpi_ut_delete_object_desc(),
acpi_os_release_object(), kmem_cache_free() will operate on the object
as if it hasn't been deleted. In many cases this can result in no
issues, but if you are using the slab and a new object has been
created with the same address this can be the cause slab corruption.

Adding a check if we are decrementing to 0 for the first time and only
calling acpi_ut_delete_internal_obj() in this case will prevent
another attempt at deleting the object.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 drivers/acpi/acpica/utdelete.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 4c0d4e434196..c6b860fd9eb5 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -421,9 +421,9 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 				      ACPI_GET_FUNCTION_NAME, object,
 				      object->common.type, new_count));
 
-		/* Actually delete the object on a reference count of zero */
+		/* If we haven't already, actually delete the object on a reference count of zero */
 
-		if (new_count == 0) {
+		if (new_count == 0 && original_count != 0) {
 			acpi_ut_delete_internal_obj(object);
 		}
 		message = "Decrement";
-- 
2.17.1

