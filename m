Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5172343E
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 03:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjFFBAX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 21:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjFFBAC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 21:00:02 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19923109
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 18:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etnIfPFnquGKXMiZLHKsnDrNh4gyz0ELPVvKwDzN3QBIXFAzASNR6GjxZd9Cx2jelC2lymePu6QY7rtcTBz0+jcl6ziFhh4wUXokktHlPCtaIMMpyghuCNEJun8Shfm3MTwBzWg00Iwl/BM5t5OUyMFQlI044AnXqMo/V7XCix4Ugpj8838nhqCktpoFSIgxHshhdFIuSb+FUHoktFR9gHENsA+R346BhyYJyIfaZcq1+ezUPJzF/9esRGpFROGJCVghb2sGBV3mFSkSulYpuOr6MWYWIGwVR9JfuKe+5M2gAd1K5cLUIFmHW4mJwWi/VjNrfLp68y1Te2QOMT9oNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmoDPoU3V6R7hplC/i33578VGjjaJ0snSYhYFvlP2/s=;
 b=Ca/vUiAdJefiSEs+e1Px29D04yMGH/EZ6PL/d2OSp9BsySeaDhdFlSgZw5VadYpo1L/VwkCjy1GpHU4AM90eJDqbGfLE6gSN3HK/yeUwbaJdeft1kmCtW+k01ykZBV3SUDH0CLxXDuajwMDaPUEC7/12Iuv9D6V8uY30cFMMQbnU5zBGdk332bCfLHukgJG37nWvzuVuxCjQRbAutN+qlrYDWhuHYqX3WLXYi4yye/xiBNSq/UwJ2bwAtpJsI1lHElt7xdXLnxBgmpzz9iCReoQvg08ugvVnnQv77i1VwcorZ38wF15yQ8Y/diQ/1euN8SbLImWog7fhm+kx0Gmong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmoDPoU3V6R7hplC/i33578VGjjaJ0snSYhYFvlP2/s=;
 b=Ssn2jf/MtoGpMlzg7CJvNIJyjhV+iyDq7nXHAkSXBQ/Llx5UJMnA5BVV3K9vhXaZFCJczf8kqrsqoh9uqY70rA0DfV+hIebZNFvDJ47sMa+SfbfyjNSoLCI9NxMoaxzwnKwPxkcMJQEQrEs9TPsEVgax4GqwWNxaCxFzqBjS/rzKEPPAOj11Gw+LExwDBPQpjiw5JcmrS0U8svagfJPuWF0L3t2vp6wVvqlVg473TRaH5mLkRAjsMnwugGMk5MRYbpHOcsL63XJq6fiTfJV+sCY2gl31wZOCSUusWxrcyrfu1wDmV/R3mQASdoM3D8Ur729e3u6yIwSV+ByXKvoJ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 00:59:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 00:59:57 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 07/10] iommu: Do not export iommu_device_link/unlink()
Date:   Mon,  5 Jun 2023 21:59:45 -0300
Message-Id: <7-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a03:505::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: a556a0d2-d384-443d-84cc-08db6629555f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k30RIXPiasdfH00EQXmlpKPfEan0UbPZsWKJfn25ubYdQJTFkcKCYZwBkfbbsxGuSRv+LcNCu1psbL5gOBndylNAk98zgw/6xYCCjIKDQWSoT8AAA95s6F1PJ+pODyCNFmtJBS1XmRL7c13hB+NPft9R6ST2JZ0PLuWNqdQceik4DcmhaPdZ9SP1KhZIfZ2Iv+bhYibmxxvgqcFwgpxMK1iVKNdzz8HAle8CRIP5LOLXWDeTvHkCYlIGhBiZx6H0IvGz//SRw9REfnIa/rSTLpuqJ9vguw7Jr3Wdil/0WtBf8b6A7X7UB6mN1StARANkG8HKLepVAsdBhizwhgYmbDxLmga+SkWiD1bko2UTxnpuFvDgHufmiBNJUX2a69AU0wSbAa+fvX77E418ZlV5EzTjyqq/CHpZLrc8dVjjty76hx1TqZVGNeAe/Bxn0yELKqz1yJx/NuTfHv8vpsz5reXN8Ms6kUJv4uHjfWzGaYrWlgNlwA2KVqtnJ+HelW+yFRQcil5rFqcbGXHKEOGlrANQIQFn38ZY3lYVcagN/vs2wWUSY+A9PipiqOy/3hNmB88WaK3vs8QuXtTl1iDToumo2qyEeHu1P/3DPv+vJl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(36756003)(110136005)(54906003)(4744005)(2906002)(478600001)(86362001)(38100700002)(7416002)(41300700001)(8936002)(8676002)(5660300002)(316002)(4326008)(66556008)(66946007)(66476007)(83380400001)(6506007)(2616005)(6512007)(26005)(186003)(6486002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d4avrx/KHWkYmD/HTAuL3EF9JIjrY4C3dqUh9pBt/Ad7R59VYaZpz6q9eJG/?=
 =?us-ascii?Q?QMZW7BdAXE687420SZdAmX/AsQasZD2MzrkZ4iEsz4jOvlmHt1xhq7qNIdOD?=
 =?us-ascii?Q?fNM56YKcmLeImVf/2Iucq9vSP7pABIQ8DaA0c7+j9iO6+MfsdRWblzucN1iW?=
 =?us-ascii?Q?ayPzkrTJdEaXC174ClSesKY8jmiidHZ1n+0WWEN9IgMmf+3BTvssTuTNV5s8?=
 =?us-ascii?Q?T4kIChhfMPIUpcFCqfRzBHNgMfPNvC6UgzOgOdgogexGVfE7P9vCqoZZ6gO0?=
 =?us-ascii?Q?HTQ1xn1CiL1VGSsJ3brNLE1XNfiPvKHwppOGSwQDelqiItERpnYnYcBtAY5r?=
 =?us-ascii?Q?MXy6RCSYJXib9lqnwLAzWI+5DFM6+2RqrYZo9WdzDGWTWql7hNcEuAwclXc2?=
 =?us-ascii?Q?gwmeW37r1HzQInkm5MiNimW7lPH62LoZeWlbl8UqpaKLQYHqUjT5XUcH2zpL?=
 =?us-ascii?Q?tLCpfvwW2Rgdc79Quedld1J9sRFjX7lR5yRo0UHHiH6WmzFhHxOrAT6Hqpye?=
 =?us-ascii?Q?Rgb26sZW/z9e6ANSq+kXZE81paZe4P/mZmceTbMnZB8AaUqlmWJGYNV0XwmV?=
 =?us-ascii?Q?zxw1SQd2DLMvNUAkgQNEXNhqmFkhkVHi8PZJGkMSr3jWHWBtiS7VN7t0xGwz?=
 =?us-ascii?Q?AfjNHwZenzUrbkT/U83aA9o9RPT4Z+Ds6QnZ66rOTYGp+yjLqzItEySD1sy2?=
 =?us-ascii?Q?If3uoqaY8wIxWERoCGICPC48L+thNB+1s0pmr8f3HhN24Ls8tkSK1WVhGiKv?=
 =?us-ascii?Q?FysBAvAjDoxFlI0vX51SwgdIo+dzZMuV1NoDIxS8cH7l8i7aUZH29423wPTg?=
 =?us-ascii?Q?gQpu1daWorY0qAxJmQghJw25ImjtznIlCX1V7MGHe2w5vgcoDHPSDi9NLZjr?=
 =?us-ascii?Q?j20diy1wKoyu2EOhHp0cDVXqD1RMGYO3dOS/mUzktAArlWPFqctCTZWQ0IO5?=
 =?us-ascii?Q?RidESMTBk6Ojq+RYnXEwc8ck7wg330xnDOlQ2bTmCbAsmuhkC+rAJw5phm9D?=
 =?us-ascii?Q?CDBxNIyNl0JappfoysZvQP0XGGv5n0XoW/eojzdyHPbfNlOe7i66TXnlnF+q?=
 =?us-ascii?Q?acp8MfxitXvL+Kt5w2sY1hKWdhxRoAqX08X+kWbmLdxseoZsIwwzdj+JkRl2?=
 =?us-ascii?Q?aUNsEvboeWrtPyBCcxQq+sjWJi0N7px56W6GK/gdICQVEMcd8ZkpenHKqqAo?=
 =?us-ascii?Q?7gLeMoUeMwYpa3F77lsO0LOmxwCXf8cbPchgRLSA0TM/oxBzA3vdtiyGZC5k?=
 =?us-ascii?Q?LsQ+5fJG+lP5tn2zUkE4E77uUF1eANBsLMhkJsrlPGHm77sqCXnJeQjnppal?=
 =?us-ascii?Q?jf0iWCH85/DUgbxj0HxFiQHY0+2LGzt445Ar5HdqV/9/gs8c1W19o6tNoC74?=
 =?us-ascii?Q?M5dn3GaveUqC4o1sMKUQSf+a1VPOsfHVC0mhgFgTiKdOcOuJ8ww26slD3jTZ?=
 =?us-ascii?Q?ooY6eHRROFYx+oJeHvc8hz74QIGDYUEq3IC5C0/O4Y+xVrP6ciFcrDPiujO5?=
 =?us-ascii?Q?xuIc0dvJBLjJsCwkpkVxP4q6QPgxFzc7hz9SL1zuCGabl0/lwhCxKQRyYaoU?=
 =?us-ascii?Q?DBikYcZwhs+2d25W2SZvqwRRyjcOsKgXywPHgcp6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a556a0d2-d384-443d-84cc-08db6629555f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 00:59:51.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR+Sxd+G2jWABlPaa4jWyqrtp7sW9ywC/3g0MP7Ve2EoUYxEmBnMNQGz4wxTkRTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

These are not used outside iommu.c, they should not be available to
modular code.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu-sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index c8aba0e2a30d70..cbe378c34ba3eb 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -119,11 +119,9 @@ int iommu_device_link(struct iommu_device *iommu, struct device *link)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iommu_device_link);
 
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 {
 	sysfs_remove_link(&link->kobj, "iommu");
 	sysfs_remove_link_from_group(&iommu->dev->kobj, "devices", dev_name(link));
 }
-EXPORT_SYMBOL_GPL(iommu_device_unlink);
-- 
2.40.1

