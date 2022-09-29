Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FD5EFA63
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 18:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiI2Q1H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 12:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiI2Q0Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 12:26:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF5413D1CD
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 09:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIP37gICbRA3ZTBQl3Amp+tUja6MU+Yqhc6V1KcCHqiO204B/vV4uzO9tU4IOwVS1Mty9QlZifEJzOMfoelkrTNPpH7xhYbUUoL92ALl6svrAN5LX6mkPQNpkFihUEyeHU4NyRwsomUb+aJZpO5yenOi+rwzZG3atz3rI6RTPDldBubWl/KpiOwZdj6FCzs66iLBLXWKQ0uIwlo23/G0z4xP0WQFaP7OwVuK6YxAzNjDdKSD7q8H8CLEvTF8d6Gbrz7EWAx806q2dQtOuxiL1oDAOwaXTdvwHTdtjMpNnOf8x6UEj9l2SrtgTjzsaqKsmYlarBzlSgs7krRiNnI8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEyVSR5d9rvIRa7WsIa724BhNMS/oqf131Q5Aczqtms=;
 b=C4yf/RV53zRF1wU41WbHbEJwg0oNTbGg3sc1ofHB35a7nAaNNujfZLWc0Ig+RpGnxg6ueckz+mrPeW12aLUAr9pMbsg6YvFca0aZjtCG6TE1NyfQrc15eH/fmBxBuXWciU74SyE7Mk8JLK5kgOQc3261LoXKLqp0J/L7n7WOjMS5t1FaVTFke0i/7mATvo6dr3kSyU6X/eH9zmXtGpJ666II46sg2wInpgSPcU3Nzmmh49IE0hdQRSvYsQkJZQTeNvB+yf88XlyVsckZLVNHTp/499NQV7BfSocBJbBu0oRukZXveOtDMyXejxc6rXPzN54OrL9xWUlniFg5okdA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEyVSR5d9rvIRa7WsIa724BhNMS/oqf131Q5Aczqtms=;
 b=Hr02wcxs2gSitAPn4UOWrIXE/2rSycADYQWYcnPIXoDpmM6pGgzMxzR+vS/qXdYKmEiGBziEduBOkMMBXLDkH+YRpJTdkjyg61Ht6SYtQBGUrsYQNs+u3JMTUrkIRwHR2g2T0Mv3E34y2p/fxrNX+VtZvjBA9AI2MCXE3KyXfp2Xa3xe+HZciHCVzBOaVJcuIbPz04Nh8vxa6MftBiakr4JkvmbWx1kmvtGOggu/CRdQlN+nJuuly8lV33+pL+CkIVfwsrSE9CNWAhsscRIJx1Uay/KA+fTukTVRC8Sh/eE2IC2n8JvBa9n5hiplxOSxpvigrSd2B05Iveb7h87fdw==
Received: from DM6PR12CA0019.namprd12.prod.outlook.com (2603:10b6:5:1c0::32)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Thu, 29 Sep
 2022 16:24:00 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::64) by DM6PR12CA0019.outlook.office365.com
 (2603:10b6:5:1c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Thu, 29 Sep 2022 16:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 16:24:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 29 Sep
 2022 09:23:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 29 Sep 2022 09:23:39 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Thu, 29 Sep 2022 09:23:38 -0700
Date:   Thu, 29 Sep 2022 09:23:37 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <lpieralisi@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Update SMMUv3 DeviceID support
Message-ID: <YzXGiULo1RXUR0l4@Asurada-Nvidia>
References: <4b3e2ead4f392d1a47a7528da119d57918e5d806.1664392886.git.robin.murphy@arm.com>
 <YzTe5AaGDauUyzDB@Asurada-Nvidia>
 <0862c961-d047-6c5d-e577-62a58b1d1bc5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0862c961-d047-6c5d-e577-62a58b1d1bc5@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 024e0c68-442d-4a89-0e85-08daa2370438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+5tiJZ7u7CxAvDKLs9my+IZk6vVii3v9W0GD1CuoIvTZjPvvXrJciVNlLzjRTdNB9FZGRuU0gzeIjHEx/97t+5rN08Gx8uaal7yR9tcwDlFbtCehVgEK09LGE+UXOqQyakhRomkDAhev7KAM2dWWccW6HFTcDUWCVFriqpNiPQEfWdkJnU55Rrp5/QIHsaUbMbl/E3YwHaSI90giOL0zI52zltoB7tSiJFM+0/QTecedj+3mCCT6I1bmNpxPIEW+0gHFzbzatiNWc7IU1sp/vcoGpPIklwsEK1PkwCByxWh8KkFz84Yp+SZ//HV6urMQ68L3LafYzVAjjESd+t/PYzdEkJY5Sl5TbiUvsGVx5QNOjr+cvpwPR/ahcjxHTKVHSCnWjuqUMYaq/OA55b5GZ4pE3EAsa9D9u95fRTxd6VYHYgYxzvaOjSIui1gb1rYamXoZhstey+KV9u8iEUg19UEegbpaN7LjIjSGBrOqEJuue1BLRhcJzNffQjcwukJu+dPCoQx7qKC8DNyrEuyh0azS0/LONQEvExAFvSbJd6NdAwLfuWgUCaMmBlm0YohLJMbMK5NytAt6XSfkC0pc1k1mGKREQOKDT3TFMp3hnG7VVEo1DC4rBGnpONUe9XyKVt+OF27VcD227xbdwsAcuvez++HCeIHsVQj3m6P0WK8FmlKeHmrdP9EgpQ52p+vxyunoktsXhzQkYQ4eZNdK2guVaUYA9mDWOYUboBQbSy5ZDQHcRukcnT9i/rrIaOJ/aQBJqwD4bUTMtsJEXREMg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(33716001)(82310400005)(478600001)(356005)(7636003)(2906002)(316002)(26005)(9686003)(55016003)(53546011)(82740400003)(6916009)(54906003)(86362001)(36860700001)(5660300002)(336012)(8676002)(8936002)(47076005)(426003)(186003)(40460700003)(41300700001)(40480700001)(4326008)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 16:24:00.2467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024e0c68-442d-4a89-0e85-08daa2370438
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 29, 2022 at 11:22:13AM +0100, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2022-09-29 00:55, Nicolin Chen wrote:
> > On Wed, Sep 28, 2022 at 08:21:26PM +0100, Robin Murphy wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > IORT E.e now allows SMMUv3 nodes to describe the DeviceID for MSIs
> > > independently of wired GSIVs, where the previous oddly-restrictive
> > > definition meant that an SMMU without PRI support had to provide a
> > > DeviceID even if it didn't support MSIs either. Support this, with
> > > the usual temporary flag definition while the real one is making
> > > its way through ACPICA.
> > > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > 
> > All the indentations in this patch are using white spaces vs. tabs,
> 
> That must be something at your end - they're definitely tabs here, and
> the copy in the lore archives looks right too.

Oh...it is something wrong on my side. The patch should be fine.

Sorry for the confusion.
