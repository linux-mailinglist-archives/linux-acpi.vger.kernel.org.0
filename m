Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838A87812AF
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 20:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351507AbjHRSQI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 14:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379428AbjHRSPw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 14:15:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7D31982
        for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2023 11:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/+30svSFJRocjy7cJDD2nAdvKzvKU/7xp9TqdV0vUJMudqVAtaoCZ8K8mW+Al4aGI9o6R6Rfw4nXGYkhGw1tILSvsgXYzU2cfxxu4AwkMIpRqP9yeDD5BW2qmbZjzOjQDjpASLoCZ/JkUjpkR0ZTjpNK1/+R2E8bAG6h5Q4GqQpOsXC/WUJpEMMpM0CZ4tIZYH18L14yLitx2LSdSjNs/Yn+oifi1uwdoH+1itfcM8gYxNh4PI2ZCgYGGXcdXtgajZnywHMxmbHWB0N39+lik9lN6CrCucObQx94kGxvlODvvkmEaowWVFsuB7LcqkdQc7Y/fd5pqCN8mCH1AGPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1vxHGKTkhh3J8yHFR4SgT7fC9Cvr7Ev5U1p2CCZNeE=;
 b=N8H+cM4jYLt0MbI7I74kc8orq9avUegmKAlEPTxffi0b2Bx4NVGtrPhhx1Rt1eB1nQZtjY5cd8NRwu7BsDe5aZwEVlxttXupYMI4VqlZQyAaS0ZxGZergwknZVC85W1cdVKe5fmtWyKEZc+XUo2UU8FxmCR2xauu/SuvyPOf8h09a+L7yvao26cOJaYNLLqY3KYygCaU1y+sF86haUaEf94M5hGfgGeuO7sfEqEV3N6t5CBRHM9P6EVMaqGtcNxa1rPu9v9kmG4w4KtH4ekmXSASVOxsqQDFBfaqkMN3W1nluN2sbj7PMfD3LyCDf/udCQ5Jst/o6U9ki7akVJ8cKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1vxHGKTkhh3J8yHFR4SgT7fC9Cvr7Ev5U1p2CCZNeE=;
 b=kFE5a/ObxkfFmebQyM8G/Oer8XdzsSPpcd7tiQuJ4G3ljLhjiItRrZBcmSNWz74S/OUO8DxgiN0Ft0lYwB0QlWKVZX4IYfb+aE4ia3SpaEi+g7srsySVksWoSIO5w1UqdlliWgS7TXzrMZJQi3mB/V1fQ/EcrxApatbJAkUUOdyhv0fAu2nkQRcWRikBHaztI6jCtO5u/Omjez85DzRXcW4unzaXglxTMhkm5hQkdc5Ldn4yFOAlCi8hkzRFB/7VCEfxlEwgZRZiuOZT2saDcJA0A5IH0W2YhU/1SQuYa5D1leUi5Eu/jxSrLna3ky1iapNFbKdlR08W38V7rK79Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 18:15:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 18:15:47 +0000
Date:   Fri, 18 Aug 2023 15:15:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Message-ID: <ZN+1UktCwqTu53FI@nvidia.com>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
 <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
 <ZN5n7GnlrTS6s5Yg@nvidia.com>
 <ZN-UpDFHab0vGuXp@suse.de>
 <ZN+XE7dk04f2C3D7@nvidia.com>
 <bff750f47b326c7c0066f1debc5411a8208a128c.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff750f47b326c7c0066f1debc5411a8208a128c.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:208:236::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d8383f-0362-462d-336c-08dba017254d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uG+dNyN9Tzfx93kL4bOJSVdoageY5ARn6/YHcMl/98+yZ9PVig1X7AfW31pSywAkxzs/+m/3tXjaDa7UTR9T4X7LFPu2IQxkHEcPmDxxFT5Yk4EzF8jbV6LHj4ZjQob10mQWBZcCkojONyaMvtSGlXS6kiJW3RBiuyaA2UVe04moYmXg+gTUb3N9PN3k1V7n9DCO1k9cI0QSAobeIKtRe3YbFXisyMjciEeSfDeeb85c2Jic00+6BvVSswxo0sZzgoRKMYoQFp88KhycFI0YkeOaChGUthHxirMdqU+cJgb/OgM4+DRtLJYg8++zGlafhqMLv/LNoEB/lfNZsFrb+rBHdif+6FoUMBhIx2qaZ6KThbiCaC0rFw9+ch/q/95EMf/0gm31Mjy5qWPGw9xPERnuENru66BCiXEd5U5vB23qxdW/L5oQerG+x4FgNIKUBXXZ+TtfTz2zhD0x0ZVyl9BmQy70gEl5Bx7jv+0N3q0JjJ7anwtogb4uAlZhRg7jBzURPNC6H8XZzMq9ET9RB1ZzyJ8jkiVGbQF0a4AAdI/YQE4yWOL+2akQaT6GqkTSYXK+QnCibeCRtNHTs7uSxR9GOust+yysuRbEZODS+nI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(38100700002)(6512007)(26005)(83380400001)(36756003)(86362001)(2616005)(2906002)(66556008)(54906003)(316002)(6916009)(66476007)(66946007)(41300700001)(5660300002)(7416002)(8676002)(4326008)(8936002)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4YXsu8kQRfV/1jIncF/mQ6WtnTyEMUVhNOZdGzKIPnXyE6Vo/FcKCeNTb2o8?=
 =?us-ascii?Q?REA65aAOzaPtNN1JWSqM89FDbTqr62YHN+qvHVlUipJKq0ExbsEZI5pgy/iy?=
 =?us-ascii?Q?VnX60jI9JBSlC2VWFIJVGFXP1kX6v2aDujxwHAdEStmHlSGYsuch6ObZ3guw?=
 =?us-ascii?Q?LLo/W3z4/zlDf69oIECCKAdNJe8CoPBMtgMlQKjGimeAS4wQoIRc5LyOghCx?=
 =?us-ascii?Q?3QMEUvPzH3JxPZ7zUDKfflK1/p/B32NbXHRHw9bJThKsBmOYLf6Gwb/05tpj?=
 =?us-ascii?Q?sICH2+Hdbf7h8XcH2trDd6SsaapOLbbrxBlFETdGdODizpPhTC/IEg7CvsA8?=
 =?us-ascii?Q?lM/vcTFUOoNSgF38Q7btfcMRraxgutFojQl71uM4G+8f1lE8ZWHitcE+fkrt?=
 =?us-ascii?Q?YcBz8sXqdDtz+xSNDTj6O8mku78yDwAzrF6devmYJzc2lLneG/0vBm2gXm3I?=
 =?us-ascii?Q?xtO9F1i1MNlFbXSgEs7Pe/Ck7OqSGo414yITO/Pl90CK2ghiOLdiRJJHwQja?=
 =?us-ascii?Q?tdIP04xsRZ/+dulEiDZvlp+iThi07U7Ec8uDk5pSmdx10EhMTTmc7ydq+9lM?=
 =?us-ascii?Q?/LODNmMb9yg+ShV6nknIqP9M/Nxk1FYwNFqnb+XItLULVUMUiYaqE64MlFpB?=
 =?us-ascii?Q?yaVY+l81IU1Pbf9Usc/a0fGsmC2+jYgcT9BcM7LXsd8pw7IYuQcVbPxFU91c?=
 =?us-ascii?Q?yrZhsOCSeZSU/GSruJwtxOJUMKJL0H5ThhzB1p9ax48/jqwgCNREwS9ZhwIz?=
 =?us-ascii?Q?M7wAMaNkv0FJCg9sCs0jIbgWJYE70g49sXV1Js4TdWD3LwRkTfCpaLbSba3l?=
 =?us-ascii?Q?0WCDSxFxXeZSyRkFOfHBsrpUp0cG7aZ9UAbrfVMyxvU+Gb9h53W3SU68knIS?=
 =?us-ascii?Q?qbpSj52zGoW91Ev2pDaEfAGuKBOVpiEPoR0qOjPBVUiZrhQkMlTwvifUYE87?=
 =?us-ascii?Q?flu49SBVAhB+FHe+fUG+dAOedKlXQZPdpZE/nzEOYnl806VAg2TL1ANQHMbe?=
 =?us-ascii?Q?j/8JcQSD+nMh1fR+1QsCQgQGWY4bcSZq2ibbVVcRiFW4h+FiqpT0KhJde745?=
 =?us-ascii?Q?bLfwCvW8k8bBxHpGKxwBYb1/uFqyM10YVeLoVrJVnGV5CY4ulKB1/0MLVZFE?=
 =?us-ascii?Q?qtYDfvY8Qwk6SmjRXTagYmIjgX/1AbkeWEXccZv1HJ+3HGrtVYsKZpQgcbGQ?=
 =?us-ascii?Q?wjQ/telmu7hbXRBE+L4aY5uf8pV2F6ETpXYYZ6Q/wLuP06X8gkU2DUnhkVLl?=
 =?us-ascii?Q?wGsqrpjRwao6nz4hGaSsqHedSxqdTZU6/tRQE3kGuudIf0h+1b4KDK/35pDa?=
 =?us-ascii?Q?iE4TMHOg46zCTZtnifNBvQNRZsUb5zyO1UOM3vUmwxCLxt+hhKNwCfs8TnFR?=
 =?us-ascii?Q?S6PgU8uPbQ9rNiZLlg7F0O97A3j9/FR1M1fAoPOuyA6DIxlSNbM1iVl8i+9L?=
 =?us-ascii?Q?nE3YFxU3kAa6XsBRRdW6QwKgdTyjfYbNFXqXoiJd4F1MPGxJehnlpYVnrY26?=
 =?us-ascii?Q?WtOxk8ZyspEp2Bf9Tjgcqo7VdN/d2PzEg3nDgnrUIsoeq7H/qHXQXtWsCiuy?=
 =?us-ascii?Q?WuOTh7LoHofpKJfgOoQmQmAWMVqHrwpxS9eCv7kO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d8383f-0362-462d-336c-08dba017254d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 18:15:47.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VPJVfkHEr/yWlQqhSuL/dD+/HboaZiJd/m5MV6+lB86dIL9b7RANpaCyZ7otuNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 18, 2023 at 02:00:21PM -0400, Eric Farman wrote:

> Well, I'm trying to chase down an apparent deadlock in the mdev cases
> that is introduced with the commit [1] blamed by these fixes. Seems
> that when iommu_group_{add|remove}_device gets called out of vfio (for
> example, vfio-ap or -ccw), the device lock is already held so
> attempting to get it again isn't going to go well.

Oh, yes. Thankfully due to all the recent cleanup there is now only
one caller of iommu_group_add_device() - VFIO and only on the
vfio_register_emulated_iommu_dev() path.

All those callers are under mdev probe callbacks so they all must have
the device lock held. iommu_group_remove_device is the same. Simple
fix to just assert the device lock is held.

> I'm puzzled why lockdep isn't shouting over this for me, so I added a
> lockdep_assert_not_held() in those paths to get a proper callchain:

The driver core mostly disables lockdep on the device_lock() :(

Does this work for you?

Thanks,
Jason

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 18162049bd2294..1f58bfacb47951 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1166,12 +1166,11 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 {
 	struct group_device *gdev;
 
-	device_lock(dev);
+	device_lock_assert(dev);
+
 	gdev = iommu_group_alloc_device(group, dev);
-	if (IS_ERR(gdev)) {
-		device_unlock(dev);
+	if (IS_ERR(gdev))
 		return PTR_ERR(gdev);
-	}
 
 	iommu_group_ref_get(group);
 	dev->iommu_group = group;
@@ -1179,7 +1178,6 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_lock(&group->mutex);
 	list_add_tail(&gdev->list, &group->devices);
 	mutex_unlock(&group->mutex);
-	device_unlock(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
@@ -1195,14 +1193,13 @@ void iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group;
 
-	device_lock(dev);
+	device_lock_assert(dev);
+
 	group = dev->iommu_group;
 	if (group) {
 		dev_info(dev, "Removing from iommu group %d\n", group->id);
 		__iommu_group_remove_device(dev);
 	}
-	device_unlock(dev);
-
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
