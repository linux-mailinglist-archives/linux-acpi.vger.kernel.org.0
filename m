Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669B151B527
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiEEBVB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 21:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiEEBVB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 21:21:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03E454F8C
        for <linux-acpi@vger.kernel.org>; Wed,  4 May 2022 18:17:23 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ktwfd1qMpzCsXW;
        Thu,  5 May 2022 09:12:41 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:17:22 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:17:21 +0800
Subject: Re: [PATCH v12 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <steven.price@arm.com>,
        <Sami.Mujawar@arm.com>, <jon@solid-run.com>,
        <eric.auger@redhat.com>, <laurentiu.tudor@nxp.com>,
        <hch@infradead.org>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <20220503163330.509-5-shameerali.kolothum.thodi@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9e8307a6-5169-d3c2-2d87-9bbe98b04f97@huawei.com>
Date:   Thu, 5 May 2022 09:17:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220503163330.509-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022/5/4 0:33, Shameer Kolothum wrote:
> Parse through the IORT RMR nodes and populate the reserve region list
> corresponding to a given IOMMU and device(optional). Also, go through
> the ID mappings of the RMR node and retrieve all the SIDs associated
> with it.
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
