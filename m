Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2051D709F3A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjESSmZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjESSmY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:24 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60BA1A8
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3rhMeZ59PPlLfbj0zidQxwAZ8EwAkAmQVv+K/ToltWBaoRnWk9QHfdS4vDhaw5eTMmvAePciTXqURfIED48YiVfDAM0q23hI/E2V/OkTrOEUY0CtM/5wO296ykJFzx7D+GZCWl/NkXh2Et3hKc0+q1dO9aop/b/40nWx6UnXXNANAAyYx68jxoBSIL6cvVXVORXi5RhoWkkLj8tHARpmM//MjQBPe6HKTslIqBe2c3288DctXP+sTdK0t/3k8LNN44JOfNhshu5TxKVS/2Ah/46c2Ch6zTVkbpEpW2HUMExh9f/ckIT05od0lFjpV7zVWxQwiIAs3kBz+BtCpD+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKZN4z1vpGNiEpyjDYvozAQgaDB03JAE18GciEB5yOk=;
 b=L7o91UUA0j/TBMZCyucoaqf02ixfjG+8zJYZHcFQpiuV94wt5NYAmsMNXxJo9qyxHwxsupbxeC1JSRJ/+pp5KYYe2RVW6U6T9k3AEFKI5ba1sFIRzI/AvCKbn7lJFUF3m3nsrUZCsEULbL3kQmfCQwCKPCqknO+flHsSNTEClzND6tfmXq9Gy9nSXYeVweKaXUhuUKzMAtYMCYWAgiXkazrX3La8R8o8cV3iKCcUAy9u3G7f0URwQJPK9MRnOQzKpXUwSxQPVpv5YPrwaDoHNQh7zEH/TwIhwjr5TVPF4DLyRxjTvPTDAKHIaN9SFH6Tc3nirwQ6rwdftJHt+aLEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKZN4z1vpGNiEpyjDYvozAQgaDB03JAE18GciEB5yOk=;
 b=fg9SGBISXTET5qrUgOOHyf4/RRWYGCA+0IOdNlVEbl1F4PU3Fr4cNXV31kJe/p5nkl6LPI4xV6+LkRfgrIO8r9GOZK/gz8Ut4n2/LJNM4toUr0sVHCVRz4f6k1qrsN2v3hYWCYAmlNmgdEFb7vSusoj+aHTK5p2umdeYW83GJaEiDu6LldcxHHKRqoXbP7TqqfBlxh7H21cgA8ul6PFH9VKapyl5mSPzuv9+jqMu/uBunDUonnT/AMcyc39TKB+vaTg3iApsr4ipEKmZ6m9hdIwqU3dYK21KGlXXOfLRhKGjCUM+Q6ur1PogOkozeRkIZ0M8u3EA28N1iGgkkkM9tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 18:42:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 18:42:20 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 07/10] iommu: Do not export iommu_device_link/unlink()
Date:   Fri, 19 May 2023 15:42:16 -0300
Message-Id: <7-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0050.prod.exchangelabs.com
 (2603:10b6:208:25::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: f37f23bb-e0c4-4376-792b-08db5898c6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTjZPOUCEXGqN7OARQRN9KfdSQk0Gxf5apM8jR3BdoKXvtflixvQ3P+D1WzV+1P3pRv/wu+k9rIPaQo/1mpvwr4mejLRzT0wTwIVg9W30vIBGkqISMGj3PPnmMg5WASnkpwSjTtRBheFXLAb6bS25gLMrla7o/jqP/7ISjLkJRsxg/fxR27hOM2YE3MlTa/nBs38xwHlpCy7hplaLgpE4eg8QCBmaJDHQZ5nTz93UAVb9DTf4WI5RTFQUZExLjFL2C+YgKDeFvUBhIlFBLEEmGg7RcLJRwE7xenEYjfymGXdTOXoGSgf4cTan3AwdMWyx/8gJuEM6FwCLX4DdpJKNEWfhDMWaOWB7Y0AA+TRrBs+tLQSQUW0hwkq4cAU1FzFwePUoslrhBkDT7KTKYytwqsHZIwdIyT9raS6sGg2bXRQna4S2/ltYCMrYOcGoRU5+8pBRfWgcOAgrvyO5/esW9DzLpIZtFrKebqIIhkZAzpR7v2jF7W83NspC0eseFBHpGCftrODgreq56q2tLjV0lPqSGryxp5maHEdr3WZIfkPJjElDaGewZHsUUSOUyViksayW3ZB2jSVmkjHSoz5ocTVCTQPWy/RWyg7YoOIUkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(6506007)(2906002)(186003)(4744005)(107886003)(26005)(86362001)(83380400001)(2616005)(36756003)(38100700002)(316002)(41300700001)(6666004)(4326008)(6486002)(66556008)(66476007)(66946007)(110136005)(54906003)(7416002)(5660300002)(478600001)(8676002)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?027WqbhUAic9c8kzAclO2gX8iqHOVL+ewNtwVQlfuAThiVYiE1NlRigcHI0l?=
 =?us-ascii?Q?rK648J7LdTIv91cZXaAOXHHxTpvUzfSDggGoRdB4TXVm26Wv91EOUBAyOXUF?=
 =?us-ascii?Q?89Q+2l/XFHtskQ51avDOcbgizS5ZcSne4DiwVkJTofpR0T9l+eOcuLU2s3Zm?=
 =?us-ascii?Q?gUWvWCCp3XttC3UT0I9Ut083aY5f42JDHbO/N8KTbTcDWbiEsicK4yhcvZOS?=
 =?us-ascii?Q?/WqmNbMpRUr6dqyrC4AawkmBTEAh3781tsd9zLLlPGyVNCvU2qzOUXCoNiAV?=
 =?us-ascii?Q?80XgNTJVjGsay/71u5fzGbuPId9T4ykVU6qe90LkcLyXubomA7JtJ15ryw6+?=
 =?us-ascii?Q?gz0BR+JikT38ZC1n1HymtoOPA8ogYV+wixv6/YY4iH7Jv/4EtAXILMy/gKYx?=
 =?us-ascii?Q?Ju7KIdksNS4WTxMRdVgWeRQ3EqVymeCiQMr3o2z0kEqIDe8q4EHnOwY2+ZDH?=
 =?us-ascii?Q?NdW5Qof09iJX6d5vpRgTKosnOGL25YJpkSlh/x7zpFCFhjhH0c92/cyPyvgL?=
 =?us-ascii?Q?0l83ICQwQX3hvGGqrvDsHVl8RzzPEkNrR3rtFcUL7fFujS0d/RiOYzs7srsS?=
 =?us-ascii?Q?sl8d1X0OVAzx6SRwb/pETWjPK9iVrLDX8NWMDKYuwXTXaIjW3NgrLGLf5b/A?=
 =?us-ascii?Q?3eePo1bMILIUEK1gBwahYgsow0ndlRYrVOBMdMSbAM12UodKMfcIpfG3EEEx?=
 =?us-ascii?Q?Hxz5AwmDkZ0aKZnvVmT0q6TYS4XGUSIXsi2DwYNHWHTgDSF6+rZ6EW60hgO0?=
 =?us-ascii?Q?+3BffQieO6nBUiC/rexwUUSzKaLMkbSM57ld45lGJgrdPyuYnaG7tj0m0DXf?=
 =?us-ascii?Q?IYgsiiihEl2Vh2sPSnMfLk4yvIzks6sg372IXeAmjG6cI9NbC4XDs7by75H6?=
 =?us-ascii?Q?3TcwKYToF+0QNrw1bg0wAsPcYjCq8TUTfa+7+i+VqaMCGRMdpCru3LULezeX?=
 =?us-ascii?Q?T2j0MHug7c970tifu3HiBEmo8Mg3Z5i4Ad3l2XYW9SPT6kdA3PRUWzYJnFrt?=
 =?us-ascii?Q?RFF5+E9oGlGkQAQJ4cqXxGRFOzx3PXgTy9X2OdV35iyLQNf/rT4vVuQvMIhG?=
 =?us-ascii?Q?LjEg2uBsiDIr0w0dZUwQI8abUFo+XWtgRjNHoINrtuKkcRc1t00eodyLQLlS?=
 =?us-ascii?Q?rXCNE/MkyBxFBPpkjURIbJ0dQD5JGrEMnS01Vt5X2iQLP9S7Vni+mEdosxw7?=
 =?us-ascii?Q?xAUTmpIqNSSWxqNHdYarAAqzLq3i4QLEdqP60bVpsdAGgmnERjhQfKQMgUI+?=
 =?us-ascii?Q?/j3/L/kNxNp6UCZ0rExP9S7VZmNWuLzSCRI743FTkHTsftWcbIandE1A9LBe?=
 =?us-ascii?Q?S3dSEidxyBhOJcdK6AzGtJ78nOuZyWUqjALfhv4XM0VAgm2GPLmV945HncE0?=
 =?us-ascii?Q?60et1BZxsT5oO7ZkYSgjBh4YI5yat5N1sj9T64g/yoVgX98m/0OImYJyt5nv?=
 =?us-ascii?Q?tGjzyxFCG4NpY+4RjFMJC4e6KGGQrYgDpUqrAmkLgLLSnMwJhVcOrVs4K2Y2?=
 =?us-ascii?Q?61b1KtYVMDHkqRg9Q1T7WWAgFBJ6aGWguWl+4v2mfpgu+A9m7gExfDY+Ngcj?=
 =?us-ascii?Q?X9T/xSaDRXuzdSmuL6v/HSO97rj6aMcsgtz0pV+l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37f23bb-e0c4-4376-792b-08db5898c6f2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:20.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJI8A6V220LihiUiQ2HRXEs7i/jz3tkhYCs8tCiOfYrid3JuvZhQsU/HkJumoDjo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

