Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56D43AB9DB
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFQQow (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 12:44:52 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:6999
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230459AbhFQQov (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 12:44:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGDKY+Ept1I+9BpxMjLKaOBxDZ5w8QKESfWM/TeUt/SRMrC7Y8giiZkn+ZhFGxPWq+c+xGYWITdxrw6XpRR4H254UF7Qh3sVoxzZi20vvqMhG2naJS2ud69sygjYg61pNZWOLEZUwUKyWQWx8kdAH3yhCQuHg0B+2uWusY66sRMRJ3YJcsdhesVSSeQShPeHM7uSGvBYj6UMRl9d9uaLinzJY6NPVvoNFUQ5PSlgc0hj3UG5JHN6VBKULINl0HnW/5Y1QCMZ/qYkauU12RgsZ4z/aVrbi08tJ+27B8GP79YkKiNJ/rcQfa4KMQDI98q5KSqKeLhQx2aJ/5GUD92dMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAwdQeXEeOgNYbcYlQdfLP3BHgaHkSBCzzjryyZxLfM=;
 b=mbI/3sigjAig2/aoYRh8MdHu2Xgv9VwQuFH77plseoDrs5T1WfYSrdo6ZwmtqzLHSYiQH8VzAgG2gl7ZKAkBBvJ0IsE1hn7VWTDBlzEHy8NKue+/KPuSOvQ9Pgz84ilFdx3ZVJClDMsoXfrp/nTEEY43EczYLLal48AzbVXwDWNCSLSD7KMyKuBz0tjok5WZJo2KuJ7AeEsBgTr+QMQpf1zvlLGd5Gt3PcVXHn2oIr4sMM5o1mb2V92VoEZkKgVGjR4wdnwZZ8Ps1FViYuVoxHchXTDcaqrAM6rp/5RccjR27QOpKCObKMQq0jSOtpmd/w0LRDOg8OQmJy5tuUWImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAwdQeXEeOgNYbcYlQdfLP3BHgaHkSBCzzjryyZxLfM=;
 b=eIbnPzI4mA9sxiUxpo1F2RjKuY9RX0HjL9coy5FlXXvVyvM0p1kn2CN64RR0rN5B73GRRoO4FfeGpYTkmNXOomYWnHlGOa7DkaNwsGziAhzG66cO0GLwHya5hxVS1IPvkHn7JEy9Nof69cCbe7nqp02inw54/2qPAVaPFAhu4lk=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:42:38 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:42:38 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Julian Sikorski <belegdol@gmail.com>, teohhanhui@gmail.com,
        Shyam-sundar.S-k@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5/5] ACPI: PM: Adjust behavior for field problems on AMD systems
Date:   Thu, 17 Jun 2021 11:42:12 -0500
Message-Id: <20210617164212.584-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617164212.584-1-mario.limonciello@amd.com>
References: <20210617164212.584-1-mario.limonciello@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN6PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:805:de::19) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN6PR05CA0006.namprd05.prod.outlook.com (2603:10b6:805:de::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 16:42:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb89219-6bd5-4aa3-f637-08d931aeea4b
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4671D21CFDD8A0ADC75C3060E20E9@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtkLpdan4nlFbnee7aupm/yHOvOFMSTL+BsBXCIPuDQAz3HBDfPi5TkERmgXF78HPSOy85y1rjk+1LS/LONQgmFG7D2gltYcHO3c/Pk1U67z0bcd7Fr38tj95qHgMNWex2mbPvR5Lb11BrhT5DKGtBWrAuy/eSsf1DrkGN+BtHx5uCgpOJBS5XuIAwPgt/kV2noc0hSjmHQk0nRJzmPjgf+lCfl/oAJucRPLq/hSkIVGmD098LqPNwBrbUyv8b/hfIhRwIfl2nxec5Y/XdCnIRgfi96vNO+mhmLQ7YwQml+ejH3l6sJy0+YXaJUjn3kwKDsle46JnOFiG58mSnKLxGSlyji2Cn5ejZJJYw1G6bnKDRQClNbLDA8GwmvxLVMIkc6kLtQKQ0XCKrlxMk1OAQT7HSjkXomi6r1iYCPUoicZjCWg2yeIHrMpbY0aNeWwqmRLnxr9PGeiFprMc2JSxiLie1No95taRo1bSuLbC8s5j+ZMZjU+/BJcFlmZSvCcQfWuejw0L3+CRXlNU9cA8a0HYKnPczFOLc4ueEkCkGi6BmvsPAjlMvlcoxQf5ScGDAPqKWopcYMoNHvx5Af3Vp/Dvr72KasPrfXaiRaMGo7NjGR1+tqJa1OkMXsItygvbzbNeLRr15Vh0Nojt6iwM6k3C0kezraDV+b1J3bGwWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(316002)(45080400002)(8676002)(86362001)(44832011)(6666004)(110136005)(38350700002)(1076003)(38100700002)(4326008)(83380400001)(52116002)(2616005)(2906002)(5660300002)(7696005)(956004)(8936002)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sn7AT9d8a1IuRzFSsGW9gjagCNKE8lDj/TntaKyMqGSVCPDlBL1z/M56uR0n?=
 =?us-ascii?Q?PME1weaFjRgdyvqFu1micWZypGcXbLDMH1bTu8MnIubMC5wYCoVdrAbHUP7f?=
 =?us-ascii?Q?3RbAiFNukeIW2zF3fWRWaJ0C+RzBO3VtP1numxmLTOF38R1of8i0kooOfADU?=
 =?us-ascii?Q?nil0BQpOUZvKTYzcMIKwJP7JdBY4VPGHBbknHeYbpa261LZHKbThg1hN0Hxg?=
 =?us-ascii?Q?Gic9K/1nSi4dlLZ+ziGC2L87CM2Qkzu39HCxvM0XOBfsOzoYcq3JYs0nNPG3?=
 =?us-ascii?Q?7kkktEdVnuvo/MAmKolgQFRldG/Chl+FWNnDvNyW7LBf4fLhKIQziaej5u2H?=
 =?us-ascii?Q?crtV5eEwS3CX4PtFzN0HYEExh4DHWAMpG6TQEtbACiHyvPYaJxvIeEpTGb5U?=
 =?us-ascii?Q?h2YgXzSUFR4LZt/WZYWBkbbAo7IR+LHEJCRUH1ljDGfuCu45al5WOzFpP5ZV?=
 =?us-ascii?Q?rqabKDZRuWIBS2vpkSZyXAOjdsRd61dSIjTXKi+dHDCrGIKDJBpm2hV/3ohA?=
 =?us-ascii?Q?E5bINpiBDe6D5SNxO2be0P8WCe0f+45N+DMWGX5c+1VyUCMQ19rTVSm4tHFd?=
 =?us-ascii?Q?hDHznUiG6ocinwMuxHlYGp8+KhRpnvsM8H+z6CPWHuqMfaxO6HinRpsw1pgi?=
 =?us-ascii?Q?bnacJTv58nFs6fur9bKTu0VrWappkfajGWowkKdnPm9pjOEbHs1t0N1iOzfx?=
 =?us-ascii?Q?OYacQf1M0M3QS+zs5zSROr2uqVKLkY6r9Ek+HTMeU4VhGh/jEoNFdkv96pz5?=
 =?us-ascii?Q?vOBU8v/fxQXmXH7Nn9mE06Ogej7ILGjOkJXj+aXDUtDI8vD2HY7ZJ/aM9PD+?=
 =?us-ascii?Q?GxWdFyNOESGEr/yZ3D6Lana4aKsDX/GCzhJXmBY3sgMZkf9qkQr33Xna9Xeb?=
 =?us-ascii?Q?lQLOZ3rVL4jCybSd3j7aoc0h4MzaifVC4Xn9i3vryPiusLx0ycq7+3bih1WF?=
 =?us-ascii?Q?hQn6TFRLbtBHqD84w7lIP+uE9tiJ4koW9p9Ny0PqAgcCtyHcdVT/Ey+2xHLF?=
 =?us-ascii?Q?A1jqdeKe1qB6Gh9o/oS6/It2lB0V12XztQCLOiU6iYRto2aOdtHsCXybeQhu?=
 =?us-ascii?Q?R584E3WiW61xPbsus1YsrFCY15fjGTbWGdp2yF8s6b3rqFq5afiHt1ijqYqw?=
 =?us-ascii?Q?Z4nfLiwK0RP3mUyD7RiM4LDDylK1FoeoSC5vK/nKm20rHGBzxqh0hpXV+sTc?=
 =?us-ascii?Q?A2q7mazijm+nktOyc2U8mn6BdYqDWu67PTpm611LW3DSac6GXv1kxN/L0CJE?=
 =?us-ascii?Q?EvMlcI8aODbxFHYzn1vURooJ824E7tKcglgFKgB6biQY35tR90hTYYYvlJcl?=
 =?us-ascii?Q?52Ff72BMFHf29srhXKpL6hpp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb89219-6bd5-4aa3-f637-08d931aeea4b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:42:37.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdQb2IgeWWNbZ0rqSxO2wd1S4wnfL5Tq4Zwf6QlJ2BMCCFr0FCsXeQR2P/Wz64yMyEvc7GlLvMimI278KacNgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some AMD Systems with uPEP _HID AMD004/AMDI005 have an off by one bug
in their function mask return.  This means that they will call entrance
but not exit for matching functions.

Other AMD systems with this HID should use the Microsoft generic UUID.

AMD systems with uPEP HID AMDI006 should be using the Microsoft method.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 3f2a90648ec9..816bf2c34b7a 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -371,12 +371,27 @@ static int lps0_device_attach(struct acpi_device *adev,
 		return 0;
 
 	if (acpi_s2idle_vendor_amd()) {
+		/* AMD0004, AMDI0005:
+		 * - Should use rev_id 0x0
+		 * - function mask > 0x3: Should use AMD method, but has off by one bug
+		 * - function mask = 0x3: Should use Microsoft method
+		 * AMDI0006:
+		 * - should use rev_id 0x0
+		 * - function mask = 0x3: Should use Microsoft method
+		 */
+		const char *hid = acpi_device_hid(adev);
 		rev_id = 0;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
 		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_MICROSOFT, rev_id,
 					&lps0_dsm_guid_microsoft);
+		if (lps0_dsm_func_mask > 0x3 && (!strcmp(hid, "AMD0004") ||
+						 !strcmp(hid, "AMDI0005"))) {
+			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
+			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
+					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
+		}
 	} else {
 		rev_id = 1;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
-- 
2.25.1

