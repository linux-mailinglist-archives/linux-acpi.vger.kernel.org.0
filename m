Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2206751B50B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 03:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiEEBLb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 21:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiEEBLa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 21:11:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BBA49263
        for <linux-acpi@vger.kernel.org>; Wed,  4 May 2022 18:07:51 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KtwXS3dZ5zhYtd;
        Thu,  5 May 2022 09:07:20 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:07:50 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:07:49 +0800
Subject: Re: [PATCH v12 3/9] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
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
 <20220503163330.509-4-shameerali.kolothum.thodi@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <001ff5d0-09da-ec73-3b3f-d3ce9bed4dc7@huawei.com>
Date:   Thu, 5 May 2022 09:07:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220503163330.509-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
> Currently IORT provides a helper to retrieve HW MSI reserve regions.
> Change this to a generic helper to retrieve any IORT related reserve
> regions. This will be useful when we add support for RMR nodes in
> subsequent patches.
> 
> [Lorenzo: For ACPI IORT]
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
