Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709BA775EA6
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 14:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHIMQA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 08:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHIMP7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 08:15:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37D81982
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 05:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYS+MHjPVGs9dXJlzgdVfNAfsjwYEx8w20Z6lNDILKcnRkgnlOAsl75o9DoXbkUB9iSUi7cm9O7zgl0kqBbyF6lo1RoXorZmFfleTfC70VA85b5qC1cGtvKeRdvu2rr/sfAXXLZeR8gWHltMFV/dgjFhobiZCXUZESy9q000Ck1K43p04STEKvnM9zLa8buKOSHGU2JaQOXa/MACGZ03B1j78Ely9U25LirBqaQfY9iM4jaD5Aw79RIDI8cg9UKxYfdSEdmZrIgvOzwB2mM0V8anFE7ra8JISj2nbf1DwyQ4EiAx5zzW/kpneALthMDQ99wSbhIN8MzucR09puqxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IVpcM66TUlaG7FWdDnYQn4dm856Ig/UMV90YPte90E=;
 b=ZQYgH6HijzICYxLbNnCGGhD16g3JFwpr+JAkyfbS4MkN2OuHBH+SAREKgk8x3f3gUkOPmQy65SGETtYES3jSjFTTYq108scrl8hI71oNdDlUzhgBLJZ4ldqL9g6TpRWt1tWA4tlMDaB5JRW2KbJJH+ABO1tIbDryteLzaDEzrSqV/xBmUPfz2jtGgqMvnXqq2zOYcIRMiKscS0SuZp2fTxJS4eOmdcOxq+yVNjQF29KdeZr3fi7z0j/1qkjgKcwBo8w4CxDukVNOBZ8yeSMzq4ki7zS7jxj8Hhi9L82HfBzX0eOxONMqbKy3kKm+AuK24MKwBh0+pzjI5MYwQjb00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IVpcM66TUlaG7FWdDnYQn4dm856Ig/UMV90YPte90E=;
 b=dBSXvQ3CnQ1WPm/m+7I/bRwxxW3g8NbKtB0gZSl22ME2vHkTGbSeVYAwFcJ+z+tGlkp2MVMUzPdzf9xgkeM/gp/Fx0nzMgxlP1Qk/Cic6Sa4J+5F0zs8z27614hXaQ7eG45zrg6YgZ+/Y7znglnymG+ovrCfJZkRcVmCeSLgz3d39et/boOm8br0yaQWps4cFok8Bom/CI0Owan40t/osPzbWhnlwJMRyF5PR/9ac7Xjx8nRgeIhb9kUhOYJBOzPP0uY8VeEx8IeWjgpMaEqeyrNODv9KMvZFQcCEWWaH3j598qGcjciGWoOnzI8ZwNJ4iuem7YXihA2xNV4SEbA6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 12:15:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 12:15:55 +0000
Date:   Wed, 9 Aug 2023 09:15:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 3/3] iommu: Do not attempt to re-lock the iommu device
 when probing
Message-ID: <ZNODeRzC+Rtkta1U@nvidia.com>
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
 <3-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
 <BN9PR11MB5276EA0632C6E65C83397B1A8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EA0632C6E65C83397B1A8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:208:32f::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 749aea48-7c5c-403c-de5c-08db98d2617e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QR0BXwjjdBnHeiwqCEe9V5OWjhidYzCIY58b7/q1RbtxoDarR9Qgu3fLdqWM4911+Ge7G4iW8ItfI4Wi8+s3j040wGM86vHFBNs0Plfl1guzDtAZlEk8bgvLyVIEhzxgYQebnEO/YuBSmGk9iyOUKLi92XouEb9mgTNdU1g4CUzeZL9zKfYUskjPxUq/o1OgI7iDiAKlhYp07dusxN9rOdrehNlDCCyTwJBcsD6EVyd5Z/UNH26h69H2swsWgNsOTNoD23Ur8UlJ1BvtqOMMZFIbZwtHUU8RuQ65ICMpCrEqyew2YLRvKT+iZv99NoT5IP7RgT010gOMhhBimOnodMAl0fVDyePe9ZXkp5hR/dHESYYV7ii2VdEL+XDpJpQJfGP7DG63bUI1nPzTdVC1O2bBYHxjkDXkpB8bOQBPDauGUEkrh0Ib9SWUIpi2Nnj1HEB29xUgE+iEeCf/YmlCiYFnP2fWzC5q5wiEjLDYbYoxIHyMez0k9VHxJqIRikAKztmDm5lCrL6ogFmdmVxANPJQkeo4S6/pTmVuK9b7qu9ZeFST55P/Ma5+SRsFIINAr2zpNkoeuLFwrZr1lnSuIiT0YdAq7vqwkE608eBL8iI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(1800799006)(451199021)(186006)(478600001)(38100700002)(54906003)(2616005)(86362001)(6512007)(6506007)(26005)(36756003)(6486002)(66476007)(66946007)(2906002)(6916009)(4326008)(7416002)(316002)(8676002)(8936002)(66556008)(5660300002)(41300700001)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TP4iG4K2OZ77vNcN1HFCsmIoKEq8I5N+IEFPzIfMn5YQaeubbpw1aIlDdaYG?=
 =?us-ascii?Q?/iN1FErRUQk4u7dPWoNz7RbUWfFIFx/8AzIIl9L6HCRAYKl9baV2XioDNyUk?=
 =?us-ascii?Q?yDxkd462MVeQYWaM+4iKEo16Y3ZUX0K+VETi0mie8oC2zBneFU/4PY1sOgdo?=
 =?us-ascii?Q?IdhxBJvrPA4WRIhyaNytwXuQjeRHI9AOE6eVSMnl5cCmbTOhCiNEBx0mG7SO?=
 =?us-ascii?Q?ShcViP/T8oUmFgwNThrnCMA6RUXeLSpj9Jf9kvCAzyWQt/sb9k9SWklaoHfw?=
 =?us-ascii?Q?0Wo2kTBIbIXKh2qJlOTnstqiTXwmjkfMsrV5IdfqYo1yA4WR8vQ1sKyHBHyc?=
 =?us-ascii?Q?aqshyQd/D9GVksD12IoIZYRYG/Qyj7HC9pRIMns7Q3FO2Gt1Egl30+3/FKZn?=
 =?us-ascii?Q?7Y9Pc43OFH+Eumk23AlcZX+j720zadh+2iGM8De5MDMPBMHSBGqKT4SIoIun?=
 =?us-ascii?Q?OFpru6FA626CjCYqz4PWmnitdFi1yzsTinHYdeaIF1ZQ7ubOWLcoOC8TxJmu?=
 =?us-ascii?Q?L8sZHsGazXgXVZE5kgVReqmicTKkuyDQp6orVre/52EqZtF5jRe7mLDI1s7p?=
 =?us-ascii?Q?gRqy333bXMyk7+KcO9ur3xxSTIyV37NJccXOfTOIHU4zAhqMhdaUgbBUTeRs?=
 =?us-ascii?Q?jVEbIhTaVPR1KKx0p1fkepVrGgF3B2FIdn8BXC3GEbZNNDMWPwkak8m+rJlW?=
 =?us-ascii?Q?uAdmi3vCP6XAKX2PocbDYKl2Tz2wkuLPuN/HAC1veySOLt0MEltyABPpNHuD?=
 =?us-ascii?Q?WTxGypCxanB4M0p1QBmW2RRJk7Ufd/MzVsgFlVfE1JWRtJ4QD267pYkcZPj1?=
 =?us-ascii?Q?qpY6VdZXV7VoUbl0Lc5X+8EgTOU4MOpAzIJCE6qMyOPA8XZzortRpBm5fW3h?=
 =?us-ascii?Q?k7ScvQ2gPFNED4p6gAu3Rt1KK1n+QiRr1Av5cf2/wcLthLUFuh/8Uli9Jm8c?=
 =?us-ascii?Q?plql+FxUqOkBM6luepWRw8tRRWY8osh59FEaTgSUuWpGPV9Yw6LpNoAYYOgP?=
 =?us-ascii?Q?H2IcSOANd8Wibqmvug7Zr4O0VCLjFpMqjgCWw/edTXm2CLWl7hUZUw9ucVVJ?=
 =?us-ascii?Q?+NHKubkEQmTQbOP3YhyGpQJITEKLmwE4dE0ASKwF2HsDJx3VmIBwFtxBqYTL?=
 =?us-ascii?Q?yHsf5797A4zqwIuEA7tyqYFL77BOHb6RVEMk5Pms4MRsTqhdkr5LNhlbQJep?=
 =?us-ascii?Q?FCIXPO6QZTPAOGgZwMut0SJmL0S3d7IQXHNubvAW/iI4YD2xga99FeZS3J5h?=
 =?us-ascii?Q?yhUZ5nJOJxOs371S4/sDdxW3jpQ1GaCiVUe996QO0V7aETwgLEhB6K3dzgGm?=
 =?us-ascii?Q?yGYYo3oUi9cCMKAiLoM73yX7y0LRK9ZDa903aeIKDgQGqvRitcFTvMHs2XyP?=
 =?us-ascii?Q?F4R69uw3uF2zNyQxCFdVqlesQviHHH87jtyvsqyx5OdG7eLal/FNg/AOivdE?=
 =?us-ascii?Q?0iAGRTmBV/qZPV4MQwR1z+oZW0y5fAUsqrclWnvC9UKU//l59+uGgApZUlzZ?=
 =?us-ascii?Q?+Q7ILVut6OiSVaPd/azxPnt5gf/Us4oPe3p2rWULczltuPh1PF1L9XKEdmf6?=
 =?us-ascii?Q?4ZR4tDN/Dilr9SoVPuDFPd3Fnvlw2TJaY/YbSaDH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749aea48-7c5c-403c-de5c-08db98d2617e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 12:15:55.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3y2BkRf0MrF84r2TzYrZhhidlL3CJ1Bni2G34y3wCw5dS1u/XI9igLZVAPxDvPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 09, 2023 at 04:01:42AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, August 9, 2023 1:27 AM
> > 
> > @@ -1800,11 +1801,18 @@ struct probe_iommu_args {
> >  static int probe_iommu_group(struct device *dev, void *data)
> >  {
> >  	struct probe_iommu_args *args = data;
> > +	bool need_lock;
> >  	int ret;
> > 
> > -	device_lock(dev);
> > +	/* Probing the iommu itself is always done under the device_lock */
> > +	need_lock = !args->iommu || args->iommu->hwdev != dev;
> > +
> 
> is !args->iommu a valid case?

Hmm, not any more, it used to happen in an earlier version
 
> btw probably a dumb question. Why do we continue to probe the
> iommu device itself instead of skipping it? The group is a concept
> for devices which require DMA protection from iommu instead of
> for the iommu device itself...

Yeah, that is how I originally did it, but since the locking appeared
here I thought it would be safer to just continue to invoke probe as
we have always done. I don't know for sure that there isn't some
driver that relies on this for some reason.

eg it might change the group layouts or something.

Thanks,
Jason
