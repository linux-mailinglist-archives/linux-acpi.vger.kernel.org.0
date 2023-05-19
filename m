Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF352709F3C
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjESSm1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjESSmZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5550E42
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGuFTQD3KT+0cfJmW0bG7VSCacgn0g/OlTcTRuiBSghjb7ACP3iYUN3aVGY1qYmof9g+eaJnT8EnVLDI3FoaTWyNCQCCDyl4CcjT64Oqs2zVgRrML2QV1cM/9nNZaRlDhPpoBKe0rzAotUlnFnu1Gg3ix1AlrotmwiI8Gd18anOp+GxIyxdb++z6rirPAF+3zst+CWh/SLFhXnf8mIcLlhpApkzPIS+eQFhLsHKLV/MUAgxHfRpbClU6kDL4LG8URfrjg0LTgnU3PtoOsw86fpFpJ+6vVMsjuoD4HBVDz5saGZsJIANQgPWfEIVl2snqci4Y+imAyOIBUVddR1d4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5Hsf5WmlRmpquubWkA0QjrycF0ZlaAdT/eKa4hezI4=;
 b=VDrsYqrb5YWxinEPgqcXmD4MOk2hjlgD3kMLuU+SAkL8EVmLkYODwLG//b+dRe0nebnFy9Wf97YY0HVb/8FlzJaFxlNdES8wliIqlQ9EG1OhDqkUvWKh9fd2Us1kddVIxGM363QP+pQ5e7fyDSKvTa1iQXbnQkY8sd89iMhWHKPhUm8QrZmU4D2/mo+fqV3klKCDNCegPWaJ+s/nx2Wb97webMmx4gqAW/Zl3NjVFGxU32bXQHV1JUFqasB/y9mOxVD1pqRli5KwhMeUFXE9KZRJdvf4GG4tO24Nhbgzis2wwVxo6DGNZ0l7hltOVBebimlCmIXTECWGWIaarcUcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5Hsf5WmlRmpquubWkA0QjrycF0ZlaAdT/eKa4hezI4=;
 b=qs1kS5DRC1TxOtK5Q4ZcaGxSkKUlpJ6Pbc+kkS8bhdtQEVo4Vgc0L8OSLd40ZnTb9gpaAkHyVieGh5vVnY4OqNobeIijcFw09gcPOyu617nM0ClUSqNRl5sM1Gm+E4M2M73NTLHMJdHB02UPhhaWiSoAzPJ9M6nSZeADTsAjnIuH0xs1JH+wED0DP7TZ3vxvHioeIpXNB7Bsn20cR+HLJu15DXWREcGHBZIazZSmAM/Hy1m2ghhVGzOEuXZ1Ye0L2NiZM8H11KVAM5VtB6msG8mPXXPhoBtp7WbXpe5rzTB54p5aNPIQozj9eEk7NtnXPEp5xCQdml6RmV2p3wygtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 18:42:21 +0000
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
Subject: [PATCH v2 05/10] iommu: Add iommu_init/deinit_device() paired functions
Date:   Fri, 19 May 2023 15:42:14 -0300
Message-Id: <5-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
In-Reply-To: <0-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0055.prod.exchangelabs.com
 (2603:10b6:208:25::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c26d129-172c-4d1e-8afe-08db5898c705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3SzWpej6n4emt+ZUndJZrkSR0/WWiRQvzR8HOIZEOkckW+AZ+IhSpJTbO9w0+bxlHSr8pwOkcKmIFBGXtp0zNRw9OWQx/X49nYk8NAn7MBnODdDkz5459DbXzH07JVV2PDvBf0kV11MrenvApDkBN8Ry4top5e/iiv6t7zUsQJXMuMjX7XNXkCdllJCReWpxNzs9JvbmYmVTEKcMWKk4TfF0OI2uegQPPxyEf6f4f0He1xW/78F3tZq55/jTr6OxFz+4HeJHlFD3WFHhaV9i4OLwYlOjkDSF5PTmQwmfsQ7UZIo0P/Tpo99DFlZyRdtfv42+PPCzasmvnCEZQ9bAZPMzLDve8dImjhnAxiMiKncDxSpjIadGDkII48ZKpvZzE37CiqjVsryEOliiXQSIhSTp/bunzMPe9R+c/PQGBSKDLvtJMgcfdVC0J6H78nkrC6Jl3PyttLvhwLqVsOW2Nzlb27LsmNnrIRv1TvdsqJ6hB0J7ywB8qM4vn01jtOIXRVsZ0C0t/6qiDGkcppIoLTvpCkuEVAshyq5eVlYftsUmf0QRuN2ZSR8ez1pbGvS1b2HHMOcm5xg9+qWEd6094wbyBQwviaSHrmJ2dofkFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(2906002)(316002)(478600001)(41300700001)(8936002)(8676002)(4326008)(6486002)(7416002)(110136005)(54906003)(5660300002)(6666004)(66946007)(66556008)(66476007)(6512007)(26005)(107886003)(6506007)(38100700002)(186003)(83380400001)(36756003)(2616005)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VI1dB1oEwkCNs27X98dKM1i49VG3wt1B1GzTzbbmEebkttygJxBx58jHaBxB?=
 =?us-ascii?Q?6N6jlDjd0zchHphEgMq0+4Y4H5FnyE+oLMsB3SdfINit5N3oVOwAbN+TajVI?=
 =?us-ascii?Q?MEx1ohgSem8pTR+srgvRYi2wGPTIaG1+t2kPxcqJy1lkm7U2sTW7m7GaQLBO?=
 =?us-ascii?Q?EgMmAVk6Tasj0z9i8YcuPGCzdlEw9NKP+/elHzBodtKF+IC1CO2zJQGRBE7S?=
 =?us-ascii?Q?nJ03VfMwd5SWRj6AScDtD4v3URihXo53qa81OZ7OBuxkOhDwppETrVVjq3O5?=
 =?us-ascii?Q?go/kWHdJVFM12pXwFA8Fjranjuc4MJ2YOGoTYSntxa1cv/31ulm8+P+gYttu?=
 =?us-ascii?Q?HkzhrUOdkqiGBfex0HLIIoX7JP5m5C9rPjiTmzXFOTLRGoJbAgu8dw43LOmK?=
 =?us-ascii?Q?z9C535vwyQYlI/+fTaDUu0GbOmJ4zy4/jAcEQmFU4xKnaXOi7sWQENz0YOjF?=
 =?us-ascii?Q?lhXaKejUUGjH/BbSriArFSDhCR6SgZwaBDijkWF7fxTOywpxFWP5uIR/a9EQ?=
 =?us-ascii?Q?UqhvhaicJWE0/0cnXY/eIqdLMult3h4EtKsOc1mR7JUhhArFK6yAo/q6nUmR?=
 =?us-ascii?Q?oRWZX5ZguKkJCtS5TLkwXZSxD8tVr1OP8LdYklTyu+fOlVYouwhyfrbOE3qB?=
 =?us-ascii?Q?HVYbxRLcvpI84r/guIolJ8FcM0jCOuusWGuAmoCkr9sjeyZ3gHSfgl03ziw/?=
 =?us-ascii?Q?+AiVziq73PNcEWvXsS4blI5tD1QP/9Yujbm4h/ePYWeME0CD8r9pdW8tTk1z?=
 =?us-ascii?Q?yEYiZsrXGBacGGJYtUwy0cL+/3FVGrwU6q0fjAEVxHD9a8KBZdl7LmRUTi38?=
 =?us-ascii?Q?2h+UQc+53PNpTF362aK+jK9TzPH9aOf8FPebCfTVBPPlC1ndIyZgXiyQpKcc?=
 =?us-ascii?Q?7ZmQkfUjtK8HQx0PXc4SGRSOkvDwQjIapeQffJJXny2YGMNqB1tdL4S5DBUh?=
 =?us-ascii?Q?Jzv5QDRTmuv2v7L82b90PSwjbFKXzJ6kHhAnOnjfoGcHmtyr6BZC+r94vj/k?=
 =?us-ascii?Q?yRfLl/M0KJa66Uwf1EgV4P/FHlS3IwJx7nt1Ai8O4h4NWdWTBCyCd9RPFAKM?=
 =?us-ascii?Q?2MqrSdTtee/ygk0oCBBfsGFjxFvyWFEJv9yfHg6jBNdJVGW7zNp8HZBd4OdI?=
 =?us-ascii?Q?Lud20FLKh0m82+t3i8Gfyinhbj3Y0bI8ihS/MunNShVXafB5QFGQkJReS3RH?=
 =?us-ascii?Q?DjVXjtb0bWRbmrleXT8xxGGygumN09H+2rbsNCkC8AECRfHiRowpJOCYUU59?=
 =?us-ascii?Q?XH61QUYiE00P1GOmEtbXO2kkOjIw+8hQZ4P0GtF5aILcYDmyIXiH6rAkPueF?=
 =?us-ascii?Q?YWTY2ALpn/k+zsPnKn40l2FcQb/fydY7g0gV7wjtMnDwgBz2kH13Cx3UR427?=
 =?us-ascii?Q?yfqwMhl3SJEE3SkybeKERbUTOE9d0Fm5cJBqDZz9nso/SXGAuyO/7KIhSrpc?=
 =?us-ascii?Q?vuP1s2BZTplhrtl+tQhlg0GRImgkEQPGiuoSwMBX474BnL0aghW/6ncTACkm?=
 =?us-ascii?Q?aifA9dCYh+Q/CcGVeyZKNoLk+99kCn1Hr7c0FXHTpub61jOxm2H70+vFVGRG?=
 =?us-ascii?Q?p0JsfHd+VuZeRdgJaevPNlqDDBAcT7ravEBMPmU0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c26d129-172c-4d1e-8afe-08db5898c705
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:42:20.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt0bEuoHgb/QKCTMxs35MZGgQvN+B7TkfXHPOoyO9gjcjxtxvSxM2/jVVjBqNyUt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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

Move the driver init and destruction code into two logically paired
functions.

There is a subtle ordering dependency in how the group's domains are
freed, the current code does the kobject_put() on the group which will
hopefully trigger the free of the domains before the module_put() that
protects the domain->ops.

Reorganize this to be explicit and documented. The domains are cleaned up
by iommu_deinit_device() if it is the last device to be deinit'd from the
group.  This must be done in a specific order - after
ops->release_device() and before the module_put(). Make it very clear and
obvious by putting the order directly in one function.

Leave WARN_ON's in case the refcounting gets messed up somehow.

This also moves the module_put() and dev_iommu_free() under the
group->mutex to keep the code simple.

Building paired functions like this helps ensure that error cleanup flows
in __iommu_probe_device() are correct because they share the same code
that handles the normal flow. These details become relavent as following
patches add more error unwind into __iommu_probe_device(), and ultimately
a following series adds fine-grained locking to __iommu_probe_device().

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 190 +++++++++++++++++++++++++-----------------
 1 file changed, 112 insertions(+), 78 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a87e2df5ce1238..2031cb4782b9b5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -332,10 +332,99 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
 }
 
+/*
+ * Init the dev->iommu and dev->iommu_group in the struct device and get the
+ * driver probed
+ */
+static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
+{
+	struct iommu_device *iommu_dev;
+	struct iommu_group *group;
+	int ret;
+
+	if (!dev_iommu_get(dev))
+		return -ENOMEM;
+
+	if (!try_module_get(ops->owner)) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	iommu_dev = ops->probe_device(dev);
+	if (IS_ERR(iommu_dev)) {
+		ret = PTR_ERR(iommu_dev);
+		goto err_module_put;
+	}
+
+	group = ops->device_group(dev);
+	if (WARN_ON_ONCE(group == NULL))
+		group = ERR_PTR(-EINVAL);
+	if (IS_ERR(group)) {
+		ret = PTR_ERR(group);
+		goto err_release;
+	}
+	dev->iommu_group = group;
+
+	dev->iommu->iommu_dev = iommu_dev;
+	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
+	if (ops->is_attach_deferred)
+		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
+	return 0;
+
+err_release:
+	if (ops->release_device)
+		ops->release_device(dev);
+err_module_put:
+	module_put(ops->owner);
+err_free:
+	dev_iommu_free(dev);
+	return ret;
+}
+
+static void iommu_deinit_device(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	lockdep_assert_held(&group->mutex);
+
+	/*
+	 * release_device() must stop using any attached domain on the device.
+	 * If there are still other devices in the group they are not effected
+	 * by this callback.
+	 *
+	 * The IOMMU driver must set the device to either an identity or
+	 * blocking translation and stop using any domain pointer, as it is
+	 * going to be freed.
+	 */
+	if (ops->release_device)
+		ops->release_device(dev);
+
+	/*
+	 * If this is the last driver to use the group then we must free the
+	 * domains before we do the module_put().
+	 */
+	if (list_empty(&group->devices)) {
+		if (group->default_domain) {
+			iommu_domain_free(group->default_domain);
+			group->default_domain = NULL;
+		}
+		if (group->blocking_domain) {
+			iommu_domain_free(group->blocking_domain);
+			group->blocking_domain = NULL;
+		}
+		group->domain = NULL;
+	}
+
+	/* Caller must put iommu_group */
+	dev->iommu_group = NULL;
+	module_put(ops->owner);
+	dev_iommu_free(dev);
+}
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
-	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	static DEFINE_MUTEX(iommu_probe_device_lock);
 	int ret;
@@ -357,62 +446,30 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto out_unlock;
 	}
 
-	if (!dev_iommu_get(dev)) {
-		ret = -ENOMEM;
+	ret = iommu_init_device(dev, ops);
+	if (ret)
 		goto out_unlock;
-	}
-
-	if (!try_module_get(ops->owner)) {
-		ret = -EINVAL;
-		goto err_free;
-	}
-
-	iommu_dev = ops->probe_device(dev);
-	if (IS_ERR(iommu_dev)) {
-		ret = PTR_ERR(iommu_dev);
-		goto out_module_put;
-	}
-
-	dev->iommu->iommu_dev = iommu_dev;
-	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
-	if (ops->is_attach_deferred)
-		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
-
-	group = ops->device_group(dev);
-	if (WARN_ON_ONCE(group == NULL))
-		group = ERR_PTR(-EINVAL);
-	if (IS_ERR(group)) {
-		ret = PTR_ERR(group);
-		goto out_release;
-	}
 
+	group = dev->iommu_group;
 	ret = iommu_group_add_device(group, dev);
+	mutex_lock(&group->mutex);
 	if (ret)
 		goto err_put_group;
 
-	mutex_lock(&group->mutex);
 	if (group_list && !group->default_domain && list_empty(&group->entry))
 		list_add_tail(&group->entry, group_list);
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
 	mutex_unlock(&iommu_probe_device_lock);
-	iommu_device_link(iommu_dev, dev);
+	iommu_device_link(dev->iommu->iommu_dev, dev);
 
 	return 0;
 
 err_put_group:
+	iommu_deinit_device(dev);
+	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
-out_release:
-	if (ops->release_device)
-		ops->release_device(dev);
-
-out_module_put:
-	module_put(ops->owner);
-
-err_free:
-	dev_iommu_free(dev);
-
 out_unlock:
 	mutex_unlock(&iommu_probe_device_lock);
 
@@ -491,18 +548,15 @@ static void __iommu_group_free_device(struct iommu_group *group,
 
 	kfree(grp_dev->name);
 	kfree(grp_dev);
-	dev->iommu_group = NULL;
 }
 
-/*
- * Remove the iommu_group from the struct device. The attached group must be put
- * by the caller after releaseing the group->mutex.
- */
+/* Remove the iommu_group from the struct device. */
 static void __iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 
+	mutex_lock(&group->mutex);
 	lockdep_assert_held(&group->mutex);
 	for_each_group_device(group, device) {
 		if (device->dev != dev)
@@ -510,44 +564,30 @@ static void __iommu_group_remove_device(struct device *dev)
 
 		list_del(&device->list);
 		__iommu_group_free_device(group, device);
-		/* Caller must put iommu_group */
-		return;
+		if (dev->iommu && dev->iommu->iommu_dev)
+			iommu_deinit_device(dev);
+		else
+			dev->iommu_group = NULL;
+		goto out;
 	}
 	WARN(true, "Corrupted iommu_group device_list");
+out:
+	mutex_unlock(&group->mutex);
+
+	/* Pairs with the get in iommu_group_add_device() */
+	iommu_group_put(group);
 }
 
 static void iommu_release_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	const struct iommu_ops *ops;
 
 	if (!dev->iommu || !group)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
-	mutex_lock(&group->mutex);
 	__iommu_group_remove_device(dev);
-
-	/*
-	 * release_device() must stop using any attached domain on the device.
-	 * If there are still other devices in the group they are not effected
-	 * by this callback.
-	 *
-	 * The IOMMU driver must set the device to either an identity or
-	 * blocking translation and stop using any domain pointer, as it is
-	 * going to be freed.
-	 */
-	ops = dev_iommu_ops(dev);
-	if (ops->release_device)
-		ops->release_device(dev);
-	mutex_unlock(&group->mutex);
-
-	/* Pairs with the get in iommu_group_add_device() */
-	iommu_group_put(group);
-
-	module_put(ops->owner);
-	dev_iommu_free(dev);
 }
 
 static int __init iommu_set_def_domain_type(char *str)
@@ -808,10 +848,9 @@ static void iommu_group_release(struct kobject *kobj)
 
 	ida_free(&iommu_group_ida, group->id);
 
-	if (group->default_domain)
-		iommu_domain_free(group->default_domain);
-	if (group->blocking_domain)
-		iommu_domain_free(group->blocking_domain);
+	/* Domains are free'd by iommu_deinit_device() */
+	WARN_ON(group->default_domain);
+	WARN_ON(group->blocking_domain);
 
 	kfree(group->name);
 	kfree(group);
@@ -1109,12 +1148,7 @@ void iommu_group_remove_device(struct device *dev)
 
 	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
-	mutex_lock(&group->mutex);
 	__iommu_group_remove_device(dev);
-	mutex_unlock(&group->mutex);
-
-	/* Pairs with the get in iommu_group_add_device() */
-	iommu_group_put(group);
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-- 
2.40.1

