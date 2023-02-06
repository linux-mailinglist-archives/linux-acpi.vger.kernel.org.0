Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7768C818
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 21:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBFUyH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 15:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFUyG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 15:54:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C751421B;
        Mon,  6 Feb 2023 12:54:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYyINrFuVdq1qM5FSOBd9XIOTME0fsB5jPp6dHoeigYm/ERsBRFBDuE8saCBRZmEyzUqKnzEhM42C+/byUQPCpmeN+jzKzUHaHysGbc3XqtYwieFdpMG/nsHW196tyMbCeQCqCUC3k9+gFSwgQqMYq14VW25u7a1SIUMnaBV2e1zxPwiPZQo1iwrh1NQIG4gEh7S0by/Ojl+pnq6Q08A0mQnFjEd/Q4FjoW/Lcq+qlK7S3sT0xgWd3ZPu5PL1XkRoZ1uDXWYZbm4amA20oo9VHYaukyBIzkuWTxs+icQn32hcho3SasRa4J/c6SjqkUwZyxESQVU/u8ktobhBQTf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtBogBfa5hzttJa4tvHetnIZkXYyIfbANuO1aSlDqls=;
 b=eGzCxtnU1xGgltgkF28FFRVVthxtPNmN53PLlg6ZvP3xwGvyp/PwkdSjW9/op8dy7iJYAKUvIQgjcIAh4hQosF+gGInV9KilcnvSCYegFIHKakqsp7fLrod5dyRofTvm+bf7JvODPi5W/G75AdWL/rFFjmXhG35eANnUKP7US9xPOM+dj7bRM9euuuwrBY3b41enAWEgqI3bhJnqj3WqOHT4mJXmudoLp6C6goS+ofhTtzP/YIvwBrY0x0ZzZsygAdS9FcvioLG/o8QbB4KLp2hwyJ1NY0LNSj/oscZNDQRKSgYeCWNguG1303xb0sHU2VWM3UeqVm0L2o9fIvfAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtBogBfa5hzttJa4tvHetnIZkXYyIfbANuO1aSlDqls=;
 b=Y5GpfhQpSIN+NwcrMAkW6zFJnB7tXHiov7fg+N9f5hEJENAXks33wqH6bEmCSTPBKm1KlYR2xO0vbeXRF5+YtLIKdjyTKofjkiwwXg4WLYAb+4qgnPfW0gj+XJtf3Ikq5dyi9cmAjmBe3mX0Bp7mH9V0Pa9CHHpz4f2E7BdhQME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB4926.namprd17.prod.outlook.com (2603:10b6:a03:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 20:54:02 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 20:54:02 +0000
Date:   Mon, 6 Feb 2023 11:55:30 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 05/18] cxl/region: Add volatile region creation support
Message-ID: <Y+ExAllpl9OIyvl7@memverge.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f22a310-abd7-4a3d-b1fc-08db088446a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwagtFM//MWXPUTAvJKkin3oSlcMMsgaCqOz+QKQkWKPRVK6NntYyqPSz7G3gZV+5wi1G0Q0fFJS61kf9qV4d7WMEV2FpVIoJoaXs3mkFq3bTw5Zgmpel0aRfdxVQjJ9dvLYWGBYGDf2gvRorIvHgUjJowqKtW3MtdF0AmnGs90tfnK2Gviue96cDWrNLcYr4uyQBYA6ZCXOoG/8R2M3fQ4Svozva32CDHs94/GqOcsFZ/g82CkNyxH/D2fG1HOSHikEQz/w/Hg4f6yX1cXNCdswFAvMnZe3eslm0cnlkFi2O3bjD7w2iYk2M14SxxF37vZbHdVuTnCD2NOKl5AzdmDxPC8Em+/b374DNaL7Rf9Uqe44+IxMkYauYXQZWa2n2mUsi5O+YiX2WEmUic35QzuMjOz3n/MtWRrGZQpzIkhATQ5Je2jnMQXMCRrKOHL7rj4Ltpp+FygQviDUbjrBOrrjKcMH7zYyXYWhjiUYyN/ZiWcvdg6a+JXx+5q7NvzEsZ7Kf6D8rbg+3yd6xnRJWaZN5SGXPS26qia1cO1Kmqq4ZG8eRJgcaXdacs7XCypxjaoBA3cOsMI8Ss0jegllr7KG2LCHQ2A0UoQUoL9mXmTFQdSuPFlBeK4lolXBZy54zIbTgkG1+qiLqqhThDP8BCy/UbjbhI61tWwkvARK6rE9sz5wfOX/E1c43zTKzS2P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(396003)(39840400004)(136003)(451199018)(36756003)(186003)(5660300002)(4326008)(38100700002)(66556008)(66476007)(66946007)(6916009)(8676002)(316002)(6486002)(6666004)(6512007)(26005)(6506007)(44832011)(86362001)(478600001)(41300700001)(2616005)(8936002)(83380400001)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IO4FNa93bugUzRPNzr67cz4UJjPtxu6Or98I+MW5s4lLdBFEvxM9qzYHTFbh?=
 =?us-ascii?Q?yv/QBNnj3EMALGOaBNRaeoy43swEFds8qif+k2d1b3zkTRMoJdTCA3ygbdgn?=
 =?us-ascii?Q?U8sSFV0DwUu7kWWtrsh6b2WVY6Wsw+6pNXimSEaLcSmwuKpf+G/3Hhv7XhJt?=
 =?us-ascii?Q?YlvC1kOCstVf/3q2Bg0HlM9Zq/Nh8NwMYlSrKjG6xhKp6q20LWPejiClhyd3?=
 =?us-ascii?Q?MvystuSMc/oqDamI8aisVhENzLIAe3UKXV6nWxaasqnVpHKJkhJBBkYYWY1I?=
 =?us-ascii?Q?FDt/xMWcGNqT0jw2LKS5QKIiNpR1lMLIgs7MKa5CGGipLTrEBPPW6Ds/PczV?=
 =?us-ascii?Q?Pnu+T17HouT1+IXeZTnuTwHVUtmdvEPuVQmd9VnPfJTZxao6bfdhPpEPvoq5?=
 =?us-ascii?Q?4oDQxVLajD2jRPLWNQ0qCV/vPMZFTrPx3yIE3yQ028Sc6F0woYqiiUfo2VU6?=
 =?us-ascii?Q?lqqyEpzWgkzxSnsZhr2FMDi6AdRKtSEOl5tqdy2HVlYU9URv2liDXch/rM6t?=
 =?us-ascii?Q?+ikQwvNs419s0y5PutkzzL52cPdg73h+ltd/pvrc68rBVyWErXjBp85vTrAB?=
 =?us-ascii?Q?O50u9Id6bUANUdILOlkGdJdWDMK3x950Kzr2gUhG9D/JfBKtGI+PB1iy+5/k?=
 =?us-ascii?Q?CoQLFW6Vynuvvr62tnB29o6NoCaDXd/f+KYDiGeFh6m7u4/qWZhGwOmo7/hg?=
 =?us-ascii?Q?68YiCauvjRjUn4AtbZkg3kVFqIARIY6ircNPIiCxXszpIudujCA/nBEZcEMY?=
 =?us-ascii?Q?iuf6Eikxy8AR/vb0/IP+mkhlq6A7UHFzHwwWrKQrqnfcITmaiJW3LoOnMQ3/?=
 =?us-ascii?Q?nkuDEKZROWvGF3uE6fpU25DMjUu6IrQGXfd7NZle0MYYAO3CGeMM7pcyj40O?=
 =?us-ascii?Q?N/WtTZNkMk2eI7V8wgCAoLAKZzWVMSpgwRDdLJqqGc1uuNiQ9aNMkdE7zYMu?=
 =?us-ascii?Q?X2Dy2jydOKAjBANjGpTBPoYurum9rsKjKK6+aazoWWLb7TPEKUUCFoJMb2o2?=
 =?us-ascii?Q?YcpBMQW5NUuE8XfahNw+s6zmwKqswqZH2iJZ0+2TCf6FYGr7pqts+kFNhecf?=
 =?us-ascii?Q?cwaXlmtq5HrTdbD8Y9bfH0gAp8yfW+4frR4PfBc+eosz43BRAT8Zvp5ywcoi?=
 =?us-ascii?Q?lWMII2EKwtKL0QBEh9JomVgx0Soqzo94zCoVKFom41A9tpHo2Y3ZbkHYrkJY?=
 =?us-ascii?Q?fv+8n3zNBr6gq58Xjop2zJkhIlNOuuSiqEETYoz+K9Xb0Pw30aWxfYU3Xanm?=
 =?us-ascii?Q?c7PlmJn0vK8SzgGlT5yqxOOIe0I7HCFUwJbsX2sjn9GAKC5RaXYZtxxgJRnQ?=
 =?us-ascii?Q?zAynpACPEBzMmbEE5Cey7czEENPichvYqyrAt3rXhkw+VBYBPxwPM0DmwG4n?=
 =?us-ascii?Q?L2jQXD7sYtsZIL7h9Mb93oXpzJs3fViH6DS/oa25KnWAYhA3YJ0rCAnoxa6i?=
 =?us-ascii?Q?ciVprHXa4f9pPcgWQNHw4WJr6Un69ow9xgszYQ+LhrMDerc3+86oVpT81pz+?=
 =?us-ascii?Q?bdFfZ7+X93PLupUbhx6BpBOPmYZ12fPa4rt6N/acEOl2mVJBHgrF4MXreTje?=
 =?us-ascii?Q?EkoCZY49yuQxHVgC4DbzAArwhnHBYeTysuvzoryXjHUGBGvmnzoqKxhv/H71?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f22a310-abd7-4a3d-b1fc-08db088446a7
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 20:54:01.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49Z5bH8NpWcZirPT+vqwqhd5AZ42zvAuCcjhIZrl1M039Ih6vDJHSDfU/sTAZTYo9uxQvP2fI8Zcr0RItbR03zEUGXYGT8SAN0Z8TWYRG1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4926
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 05, 2023 at 05:02:56PM -0800, Dan Williams wrote:
> Expand the region creation infrastructure to enable 'ram'
> (volatile-memory) regions. The internals of create_pmem_region_store()
> and create_pmem_region_show() are factored out into helpers
> __create_region() and __create_region_show() for the 'ram' case to
> reuse.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  
[...]
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8566451cb22f..47e450c3a5a9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -294,6 +294,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_type3.attr,
>  	&dev_attr_target_list.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
> +	SET_CXL_REGION_ATTR(create_ram_region)
>  	SET_CXL_REGION_ATTR(delete_region)
>  	NULL,
>  };
> @@ -305,6 +306,13 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>  }
>  
> +static bool can_create_ram(struct cxl_root_decoder *cxlrd)
> +{
> +	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +
> +	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +}
> +

does this collide with either CXL_DECODE_F_ENABLE or CXL_DECODER_F_AUTO?

I think obviously if it's already enabled creating new regions in a
decoder doesn't make sense, but if F_AUTO is set, does that imply
the region settings cannot be changed?
