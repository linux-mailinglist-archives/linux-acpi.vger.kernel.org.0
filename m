Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066DA3CC754
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Jul 2021 06:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhGREOo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 18 Jul 2021 00:14:44 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:31201
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229571AbhGREOn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 18 Jul 2021 00:14:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+NKQJ3Gyc0NXBlspxU0OFSmbdFA3LZnu/cANMOuSHubgYwAdDryfCnp2CP928bOAJirPvwuAIRa/PU9v7LXf1B++ByvIn1vJ3QQC7AWDJttz1HNcvxDMJU8V68HKURzmVvoYMAslGyQj6UGIvXqnSiIqSUSA4NiqK96KGi4bQGDg8Eu8Hwb8/pN0ioexM3HBBRIYvAn612mXn71LRXl7c+wSfN4wC0n4l9Q6GGg33lq3o/mvzYFHeQe9OZZY2e//0L8bVxscnmZ5GU8LVwplaODSEyHM9Q6RF4nOajcBqQ0pTkm4c5AANEdkVmHMj3qE5HkD5HNt+KJbw89hjts1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0BP/cURlQbXE3h9TOfkuaovt+cGv2+oi2W7AeYndsA=;
 b=QRwLWy7eGq3k7XSqjM6jfuvSk5hqTtnT7qKsJ+UJksTe/SV7WVWV9a8oISgGBEmRRxn7Odun6m+33Wa7SQ+dZ4VsErlK12adanESCf5GfwrkB62eSODvUPjYdQ6kd5i7nP3GWbfcoWBA+cI+/zr6ehSNIcCSUpPOJ12ZCNhdrwK6pbFhAc8Zh7jIcQzpXwMHKViGhdfApzLO2AtyPzcVn464tfbQt23bWfFQKvrfrYhejlryIn4VqvatLZquBnF28L+i7t0B9TuZBCaDgTPKoblspzvsdJc+3PpWDRtW32VZsOZy/+uigwOi/fhvVjuTnRpkbEFMyB2zeUswmgrfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0BP/cURlQbXE3h9TOfkuaovt+cGv2+oi2W7AeYndsA=;
 b=C4IfkFkitQ1FbfFnBBkGaOOijpu1Ytc36+mUycsze/LJbXNd9X7YfXp+4oXuc0x/Qnz6iC/JQL2CzQbfIgFOvx5O61qNtSXZYdpYxdOWtOPPbfl3TvytVquJWI/UelxjuWhuFdylAjSYJTh/CehDT3Bf7xaAbbD4sNtNb2VJ5Jw=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Sun, 18 Jul
 2021 04:11:43 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4331.031; Sun, 18 Jul 2021
 04:11:43 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        stable@kernel.org
Subject: [PATCH] ACPI: PM: Add support for upcoming AMD uPEP HID AMDI007
Date:   Sat, 17 Jul 2021 23:11:38 -0500
Message-Id: <20210718041138.4739-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::18) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 04:11:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67f2b57f-137b-45c2-3e6e-08d949a226ad
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24168D31CA72CAC224285747E2E09@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11gaMWikABfdlaIP2Ryj3k106FHaV76qkkgSOfUvwSSuQpdikmZtqj8NzXvQTvLYM3JFBzJKCErdsR4dvNXWR4Cxgv+HyaXs6U0/AsrhOhQvXxzoaQA0/GlDIeLj0OQ00CS18FpbAszxVRshD6SifaFCWK0FxDRdR9uL/5qw3StjHv+qMtuorIJqzq9uEfz5k0/XC7kty1Jjq+jBtz4Q7Q+oXT7IuM6ag9n7d/VMhn0SQDR0U1EP5eC1MZFpyXGBB/bj7/EGlGvIslZwuyqxT72iUbzAYK21hFfr2CURJLIDKaHl2YyfQcrXabz8FqGeQm1DYSkzCRImEOsKTNrMz/dAIqvyakJNDCVBwg0KtMId8GcthVKyy0Dsmg7cHvzy1Z2qxoIvZb+YCbe/mbIDV/jnHbvmKvIekIXC3u9yoFghxrH0b2Yn5+NcowFTAe9L7wU9FfAnD/gvuEYRpMYAQA/11o4JbjDHE1eTdbGtyrNqWkRZs3SsTVRh7a976nQBhp6RgMtlxnEWJfrExV//YoKlMBS9akCgrLriRhhrY9V1wJH9y4bAFvAH/ysDKquD2k1crLKseZHLGXTJ1xKNJColkntYoeWx9nyD42dhYWaewff0cp8DrePqF6rUDDXP7iCk9DC9riLLJZQQwqdWw1piTzBWW17FkewV8t+GsHr9AID4HWHPb1VVCgjjplsmFRwf7Su42JK0ZHNw2OQ6BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(66476007)(508600001)(8936002)(1076003)(45080400002)(66556008)(38100700002)(66946007)(8676002)(2906002)(44832011)(6486002)(5660300002)(38350700002)(4326008)(7696005)(26005)(86362001)(52116002)(956004)(83380400001)(36756003)(186003)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G5PbLwc1dms1822UL2NdxcQ1HiS0eh5/wjKr/6BcPWGmEFaC2yzTWYamo7wi?=
 =?us-ascii?Q?ce51MGTgFKBvo0ojMbBKOvrBBbYDuusuWq6UIxoC0DOZfGqAdFEznTG5B7LP?=
 =?us-ascii?Q?jkrUqWPddHdZXbwThDW5yCOSy6Y5lWBS9OYDxnCsr+6kgO7PPiljhRiPAHpE?=
 =?us-ascii?Q?HekimlxV0CSnYnzcKhPEbbB42WilGAoARHhOxYkhAElAzzN5Wio+ZBqD9Juj?=
 =?us-ascii?Q?nT1jO3Ta9FWR8mOBGJzxDGjah81QfcDs/XnN47oRSFiZ/mv3fcjPJnot+QcC?=
 =?us-ascii?Q?ZN40bryFur0afRcQ0WQ5xACLVd5yUrls131OT9ZXALUnnJRa7ApYrP9N5EnY?=
 =?us-ascii?Q?uhgQFDdq4jBusNVf8CVRsyKLJ8MoRnjUWdhvUE96aR32W0+INbeV1r78JD7n?=
 =?us-ascii?Q?f+vrVyIpFrdBTQqtvvnMMab6npIDsaDW1ySVnYRZNn9j5FSdDLb6TTAeRu9/?=
 =?us-ascii?Q?N9h4eO7k+MIv1YUhFFW1shhQL1vNrFj0hkggc6ZW2CF0tUOJ8V2hKHqItmgu?=
 =?us-ascii?Q?VfjmNDFR5X4sG8NZhlaQitogQyfs37ubdf4oGRFP8iLaZJW6Q18MJ5k1Ju0u?=
 =?us-ascii?Q?DbJkoFkglWymjU3nMytfCVN1O68AaLZkZNXYhap/+oydnqpoDaZ92s/uU+nj?=
 =?us-ascii?Q?6BfBa7zz3/VmIg36SpffITO3IvSdE7Y+ZKEUhf5D2uu32LooMlHHbm+IyggV?=
 =?us-ascii?Q?xky3onVbh46qBTciVUU2o/EVdK2sV4SFpM4qzSe8YtLxpzSJvCPG3aYZMAlq?=
 =?us-ascii?Q?SvWzOYFv+OevXQvZS04pgjuYJCYhbGQKlXJ5TktIDjrekYE5cobN9uLBOncT?=
 =?us-ascii?Q?AJU9ghynqxGAEwYHdRZfYv/cr1HeAfqMvhI6/KPuEYmPjOMPCII9h4aDEpUu?=
 =?us-ascii?Q?6gaKZyxKxfOC5vqcYf7Ea44GQUSTQuEX0DtvHcZYnvbgtKBgiXtIDxlY/ycZ?=
 =?us-ascii?Q?yhwk7IFc0Y9jmj/6eqN6JDmV36ENc1hJTc/DLX9Bn4kvozrdp0Jk7E+JpFey?=
 =?us-ascii?Q?a1g5DSxP4k9w4URTMq8wLFYPa7C+iOYH03ST3zxzCdmVpwh6GA+ozDt0vgmZ?=
 =?us-ascii?Q?o6wdmbMEYNGeRAgRI9UUtzT03mSGnLN+6u5q5vrarHSvycomQmv3YaU8Ga6O?=
 =?us-ascii?Q?WDSIzZZ9yiNLUbMbivZrkOFQgR6oDY3o+xaKUTPaFHfBfGRhgT4fWR4zGe80?=
 =?us-ascii?Q?GPKMXoXtXdHhIJh6gwGawAGS2lSXj/wak9OVGx0Y3wAt3RrL4XogVFbhf2BP?=
 =?us-ascii?Q?ylgHnGGvfEEXT/VVdiuRqboz0vR97yIj+uvylEW7+mdAKM+bF+aEpKLLuYbJ?=
 =?us-ascii?Q?hJuc+aGn6u+FRuqXrf6KTAOM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f2b57f-137b-45c2-3e6e-08d949a226ad
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 04:11:43.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vh11B/jOBxBdEbGpX1yfDZ4BDq7ZaFr8yXFzVVyjhD+BwDaeh8OZM0VM9udbvWIY8JRyH39rbXQe1Lv8IDdaug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

AMD systems with uPEP HID AMDI007 should be using revision 2 and
the AMD method.

CC: stable@kernel.org # v5.14
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 1c507804fb10..fbdbef0ab552 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -378,19 +378,25 @@ static int lps0_device_attach(struct acpi_device *adev,
 		 * AMDI0006:
 		 * - should use rev_id 0x0
 		 * - function mask = 0x3: Should use Microsoft method
+		 * AMDI0007:
+		 * - Should use rev_id 0x2
+		 * - Should only use AMD method
 		 */
 		const char *hid = acpi_device_hid(adev);
-		rev_id = 0;
+		rev_id = strcmp(hid, "AMDI0007") ? 0 : 2;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
 		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
-					ACPI_LPS0_DSM_UUID_MICROSOFT, rev_id,
+					ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
 					&lps0_dsm_guid_microsoft);
 		if (lps0_dsm_func_mask > 0x3 && (!strcmp(hid, "AMD0004") ||
 						 !strcmp(hid, "AMDI0005"))) {
 			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
 			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
 					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
+		} else if (lps0_dsm_func_mask_microsoft > 0 && !strcmp(hid, "AMDI0007")) {
+			lps0_dsm_func_mask_microsoft = -EINVAL;
+			acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
 		}
 	} else {
 		rev_id = 1;
-- 
2.25.1

