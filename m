Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185B2777DF5
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Aug 2023 18:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjHJQQL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Aug 2023 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbjHJQQK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Aug 2023 12:16:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B22112
        for <linux-acpi@vger.kernel.org>; Thu, 10 Aug 2023 09:16:09 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AEVlbK032168;
        Thu, 10 Aug 2023 16:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dsMpN15XnIE21muLE7ooraQPgiRpC1Gn/z0EoywcnfI=;
 b=CahBecJ6cUa1xX3zcF0auddztn2Sn0KCdIotPsU7Qu9vqq3QRwaMsu669mNjeuxBOi3V
 e64MzNS8ql3vHO4AxkW3KD+mZKYBixpHFQCZ+jGzKHzdck9LDVmmijMIzVPKI8ncF7Y2
 lsJmiHNmdpTuSgLrBxEYpNvnjv/1+sviMq0lJNzUiivcpkxPM2zJh0B6FtTq79Pydh0x
 9tyzpMWZ4606+SAiWhB7S3Ci8loUPBn3EmjR/LhbT4kyEMpLGqBo3v/LaHjrqfiS7hJm
 WhfIsYiJ8o39F11VuZ6EFbvZdWmfGeG9JWv1CDmhEBMpB3tkv+WjTjdpUQFbu0fpadRM kA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scqsj1nf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 16:15:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AGFMlh005855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 16:15:22 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 09:15:20 -0700
Message-ID: <7ce1110e-a462-08c5-b58a-80461041ca7f@quicinc.com>
Date:   Thu, 10 Aug 2023 10:15:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>
References: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r-aH6i_3hF0WH5po-Xy6EaD4zx_ELGMj
X-Proofpoint-GUID: r-aH6i_3hF0WH5po-Xy6EaD4zx_ELGMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100139
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/9/2023 8:43 AM, Jason Gunthorpe wrote:
> I missed two paths where __iommu_probe_device() can be called while
> already holding the device_lock() for the device that is to be probed.
> 
> This causes a deadlock because __iommu_probe_device() will attempt to
> re-acquire the lock.
> 
> Organize things so that these two paths can re-use the existing already
> held device_lock by marking the call chains based on if the lock is held
> or not.
> 
> Also the order of iommu_init_device() was not correct for
> generic_single_device_group()
> 
> v2:
>   - New patch to correct the order of setting iommu_dev during
>     iommu_init_device()
>   - Spelling fixes
>   - Simply block probing the iommu device itself instead of trying to do it
> v1: https://lore.kernel.org/r/0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com
> 
> Jason Gunthorpe (4):
>    iommu: Provide iommu_probe_device_locked()
>    iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
>    iommu: Do not attempt to re-lock the iommu device when probing
>    iommu: dev->iommu->iommu_dev must be set before ops->device_group()
> 
>   drivers/acpi/scan.c        |  5 +--
>   drivers/iommu/iommu.c      | 65 +++++++++++++++++++++++++++-----------
>   drivers/iommu/of_iommu.c   |  2 +-
>   drivers/iommu/omap-iommu.c | 12 +++++--
>   include/linux/iommu.h      |  6 +++-
>   5 files changed, 65 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 8d3740021d5d461e1ec4c17fc5625b9b4237c2f8

I found that -next broke boot on the Lenovo Miix 630 laptop (Qualcomm 
MSM8998).  Bisected to "iommu: Complete the locking for dev->iommu_group".

I applied this series and the boot hang failure shortly after iommu 
probe goes away.

Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
