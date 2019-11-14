Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38F4FC048
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 07:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfKNGmq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 01:42:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfKNGmq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 01:42:46 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 79F771C349B78791F986;
        Thu, 14 Nov 2019 14:42:41 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 14:42:32 +0800
Subject: Re: [PATCH v2 3/8] ACPI/IORT: Support PASID for platform devices
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <joro@8bytes.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lorenzo.pieralisi@arm.com>, <sudeep.holla@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <zhangfei.gao@linaro.org>,
        <eric.auger@redhat.com>, <jonathan.cameron@huawei.com>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
 <20191108152508.4039168-4-jean-philippe@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c34e37aa-af9b-5560-9c98-2cb5c55904c3@huawei.com>
Date:   Thu, 14 Nov 2019 14:42:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20191108152508.4039168-4-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/11/8 23:25, Jean-Philippe Brucker wrote:
> Named component nodes in the IORT tables describe the number of
> Substream ID bits (aka. PASID) supported by the device. Propagate this

This feature is needed for HiSilicon Ascend AI chip, thanks
for adding this.

> value to the fwspec structure in order to enable PASID for platform
> devices.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/acpi/arm64/iort.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Acked-by: Hanjun Guo <guohanjun@huawei.com>

