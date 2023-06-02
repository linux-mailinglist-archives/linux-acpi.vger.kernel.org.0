Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4B72083E
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 19:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbjFBRSB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjFBRSA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 13:18:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0D81A2
        for <linux-acpi@vger.kernel.org>; Fri,  2 Jun 2023 10:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocwyg9U6Mt9X12mxQrk5iRXL2dF2BM6tm3Mqr6WR8RCgptQEZeZ3W/vE2o07Q46KuD8ArLe8vfKHK7elXbl09M1ZOIwbBexXfj8jDUMqPWabHit1nrDkyopx7Y18LXiZzK1B42Fb9bloA8aZ7PH90rXsS37z9FoBQC21faHWUr2l3d4d+IQXIOElTf67VRZKfUvjYDj8iLuko6jPKu7K8mqptzrI5B9ntlP7vmYpis65xV/XcVfqc3MlTvAILpdFROPFwUZROrC/n/rEB65u6TZUd9DatXf+xRGWznGYgb4c4WXS0kYAGhbHRLIqpm2MPUa0uHpdx8L/+ePcXDKh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp4CvA6VEyKbLKotziq+mvgP1YMokQ/M1DUzE38Tjck=;
 b=jH/B/0YGhz2BhldieKiuPeykiz/aIhW7bpwE09J1ZNRFtLltj+/ZvJpdb04XgrK0+ftJhaD6oBqn79OmMLEeoV0GjNlpYPPgS7+4ys4N9qAOYEv0bg4BtqGfVyqp87O524992riHpIsyFVRV3aZIpQ7p4bjrolIVPsec6c+buOBNM2LA6B6OlcU8fWqCp9mMx5R0rZdL8LQjj3fNZWy7GglKqIJBdpxVfeW3ZJOqNGHa4cJWqkI1zN2qaJwW/F3nhfpzt+N5P6iPEm1ZjI7xUZtKxjGIiiw6z4DbUOFmdN9emoMB6WDLT99cAaLtm87raR3yoaSkR4mJWiO57vmjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp4CvA6VEyKbLKotziq+mvgP1YMokQ/M1DUzE38Tjck=;
 b=pXFroJGaRdYmKHYB2pOklbJAUaPbdAOD5ZkNBvb8NpVx4Z9RtsQiq9Y8fhdhPsthTcRpH0dP+ZgiHwvRhyG4n6tFDcnWBsR0Ye9jRazsILVGBJ+yQcxVxjDLfUXzI5iLJIxgWtxmJsQlXvaNdSkmCXWF8AlLZF6AMk3HUGlE1jbBHgjM8y3Tr5PMcxYU60Pw3Ge6+v0ETlVKYu7IPF+eKOlz5FmgVnZ3tcb4uGdvlP6Oriay22ZTu3106TWK5vKrCePvwC7K8M84A0ybMb/Jk9YrtXaWivnG8/8YcHQZuVzIJVmTGACcMBhPWXcGmbYTi3cTMSO78JLDg720qoVDMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 17:17:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 17:17:57 +0000
Date:   Fri, 2 Jun 2023 14:17:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 03/10] iommu: Inline iommu_group_get_for_dev() into
 __iommu_probe_device()
Message-ID: <ZHokQkog30XkravM@nvidia.com>
References: <3-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
 <6676d850-f633-bacd-445b-44cf045a699c@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6676d850-f633-bacd-445b-44cf045a699c@linux.intel.com>
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 5adcb3c7-989f-4024-dd69-08db638d4f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOib5VIeEsbx1GGI4Va+i9g+PohDHpt1muswnRCCLjJx7b9L0Ej5ilMUlhoZgcEhn8yWb5NR+JRGZETPZg6n+BTDFwfv8g+DOxMvh8j2dYtvedImClOE04HrkTN15H8qbt7woMpyB1OSs1QExjsL9C3dr6+8pK4idD65YtwaRPwmUnT79sla5zP/OpcKUzcXr9bL8rY7ftdv35K7urKoElGs4NlBSeYH/SFbgeyOVnAJVnfqGX7W/Lyl7lPKuirfGZgnam/RNAwBwqdEVYgYfqz+WFiPIZrRjGz0+XSOI0UhIja+WjnqZclt4J8V7wFEEfh78JGY9ZyCv313zowkIX9Atv02ArRKgaCklXufwHNcVSHv3wjPuEEqZ4YdRObg3+NL0b/ny+fYlRUk8u9djwSzx3V/N6mclKTSr0G+6cjS8KRccG1YeIfQVzvbnf4s2GPa8GLlEC0x42UeAqtKXTWX9dRsswoQa8Uo7KWc3+PmYHy4TNRNFAEXjcaXHV+UpZd5sdl+pS+xZCbz8UXVMczzrVVDo0azSZ49eDvJ66TAZDftygMFtWPxQnXy/h/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(107886003)(7416002)(54906003)(478600001)(41300700001)(316002)(6666004)(5660300002)(4326008)(66476007)(66556008)(6916009)(66946007)(26005)(6512007)(6506007)(53546011)(6486002)(8936002)(8676002)(186003)(2906002)(2616005)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nLdiI7gZBz8lfxUDW5tftERIo+WVasWw4l/6pSP9BMoxnztNrxl2rKONJihQ?=
 =?us-ascii?Q?SYj1s4HPYCwEE3jg/iFmIVp4ztP+EoVn2i7gl0ENbyGNbmNzQuYymDztPsC8?=
 =?us-ascii?Q?CBx/OD0jweS9QcU0IMqHMxZBSLjhEZVV740y19wrVcze15V7o4YR0RCkgdJ8?=
 =?us-ascii?Q?S262qlfl/oaPcIxr0c9mk5X4UGLgmWqnAjRaOhAdRNeAb4TsndYnJXeK6+wv?=
 =?us-ascii?Q?ub2UaYXdQFkpOREEwPQ/XR0Yv24dT1mJ5D5kgpgBCWHpL+o/5/bL++K0Kd+N?=
 =?us-ascii?Q?qUbLMX6OIVvhPv6+Is+eQY52z8MkfA+wBYZOS5u28TWg+XOZuA9S9LeI9n/o?=
 =?us-ascii?Q?ak7yDdyfDKHvZjtjYr3Io/s3q/OXPwSeZVccG50jCRAaAMfHm2+UfI4L3Knp?=
 =?us-ascii?Q?/9wh1NfVDGOFQyrl4yRCQs1Df0O3abElg60KDVcl9F3N6SAqo3v6Xoyt2cbL?=
 =?us-ascii?Q?Cl446j6UUL4xEjM2XFGDLZwngulMXslt2zWd8/i4OM8C8Wod6e00c64P6qA9?=
 =?us-ascii?Q?7jjjvjqlKBAkrSxB5//DNt1NoLTIlHARy1q3LRxNuUs+CtGod54KfZH2/E5i?=
 =?us-ascii?Q?9b3HEpowpI+CEYzEng2V2XZK8FJN72+/kdbVglZxu9C0G4yELaZbf+76Jyql?=
 =?us-ascii?Q?RQYzeh/rMoU9sF9665fJNz0CiSSvdNZWG0ljtFgMkN+XCSOJtPoMRbjR46Oz?=
 =?us-ascii?Q?hnoxFM35nH8QGAznGFon1zTjYmG0qJwT7+sk/3Qyo4WZd9XeqgLATGccyxSI?=
 =?us-ascii?Q?i3bRD3GnxA1wfg29xE3K+rW147+ARSneWeltWdVuFuSB64SgL60TfqqI22WA?=
 =?us-ascii?Q?FrdzfURhwtk7cLHy0dxw0I2UuXXBpsTt7nXVSeBSKL2ssDRPexKir0K6u4jp?=
 =?us-ascii?Q?P2j/BA/7HNqOqry3eyXzhK/dTxNdoFSwEJ14sarSeQkif4jR91beN9t1/TTr?=
 =?us-ascii?Q?CPTtCtsjMcIjKGA11gV76g1noGkKauKDQ0fzLGIeN5NqXEe9c35DLtgpkw4n?=
 =?us-ascii?Q?dDGauAAl6YglOsYfb6BrRwiHEy0gw/TbO9+Z8I2g9tCm3Qyej29E5yRUMxzL?=
 =?us-ascii?Q?1dcFehlBt9qgC0kgLeCXb+VFyL3W4dZr+XvUwuZiIrH/T8M/FRX90HyrPNUk?=
 =?us-ascii?Q?WfcV741zU9yHC/EZgQ1Zuv0K+H+vbI3SbhuqQKQwD9eB8onJju6cJuE6y+sf?=
 =?us-ascii?Q?shy7hch9gbrmkUIyVu/AabWnb8IcrvlupIlirWhYe9vKvVpdCwrdK1NXJFNb?=
 =?us-ascii?Q?LTcXVY35hU59K/BaWiv2RvVIYrlqPgY9oxqmeht5CtGC1KaTk49NVd4AKdik?=
 =?us-ascii?Q?xXpqDC0Wx/OyK/6P4pSUBm9Zun/Nl/YTZA0RAkfdlggDs2YOUfKFsUNYt+4O?=
 =?us-ascii?Q?9Z2UgoCBf9zEdlT+EtM69m33c/AMRlu0Kf86ytZNrH/YfOUtutWmo/UEOF9C?=
 =?us-ascii?Q?IuBomOAnxPRNgT6SoqcifwyxSCA0y9sgIGXxVLRpVWjpVBQwF0JYDDjSx5Xn?=
 =?us-ascii?Q?IsD+HJ/U87BphgQ8tvPweYM/wJkmdvqFGxqi5VUkOGvP1gOLfuD3npDtRgfy?=
 =?us-ascii?Q?0jkYo5CTN29AUoZDWYytW/Im6au5+CWl0wSV/UWk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adcb3c7-989f-4024-dd69-08db638d4f07
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:17:57.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EilCoXjR5AbHKpEmxuy14K5eZ7v4oJWYEiSNTdZxTndtwiV1VAWe/DOLROYK7Uf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, May 21, 2023 at 04:19:34PM +0800, Baolu Lu wrote:
> On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> > This is the only caller, and it doesn't need the generality of the
> > function. We already know there is no iommu_group, so it is simply two
> > function calls.
> > 
> > Moving it here allows the following patches to split the logic in these
> > functions.
> > 
> > Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> > ---
> >   drivers/iommu/iommu.c | 50 ++++++++-----------------------------------
> >   1 file changed, 9 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 35dadcc9999f8b..6177e01ced67ab 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -127,7 +127,6 @@ static int iommu_setup_default_domain(struct iommu_group *group,
> >   				      int target_type);
> >   static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
> >   					       struct device *dev);
> > -static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> >   static ssize_t iommu_group_store_type(struct iommu_group *group,
> >   				      const char *buf, size_t count);
> > @@ -379,12 +378,18 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
> >   	if (ops->is_attach_deferred)
> >   		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
> > -	group = iommu_group_get_for_dev(dev);
> > +	group = ops->device_group(dev);
> > +	if (WARN_ON_ONCE(group == NULL))
> > +		group = ERR_PTR(-EINVAL);
> >   	if (IS_ERR(group)) {
> >   		ret = PTR_ERR(group);
> >   		goto out_release;
> >   	}
> > +	ret = iommu_group_add_device(group, dev);
> > +	if (ret)
> > +		goto err_put_group;
> > +
> >   	mutex_lock(&group->mutex);
> >   	if (group_list && !group->default_domain && list_empty(&group->entry))
> >   		list_add_tail(&group->entry, group_list);
> > @@ -396,6 +401,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
> >   	return 0;
> > +err_put_group:
> 
> nit: perhaps out_put_group?

err_ is the right label, this is not a success path.. Most of the
labels are err_ except for out_unlock which is sometimes a success and
out_module_put which has always been mislabeled..

Jason
