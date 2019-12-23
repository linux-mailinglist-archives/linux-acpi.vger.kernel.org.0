Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B812943F
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2019 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLWKfp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Dec 2019 05:35:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfLWKfp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Dec 2019 05:35:45 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 33EC2D8FCD3267545E41;
        Mon, 23 Dec 2019 10:35:44 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Dec 2019 10:35:43 +0000
Received: from [127.0.0.1] (10.202.227.179) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Dec
 2019 10:35:43 +0000
Subject: Re: [RFC PATCH 1/2] ACPICA/IORT: Correct the comment for id_count
To:     Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Erik Schmauss" <erik.schmauss@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1577092997-9852-1-git-send-email-guohanjun@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <efd1d3fd-0e7c-64af-f226-5f263e48d88c@huawei.com>
Date:   Mon, 23 Dec 2019 10:35:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1577092997-9852-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 23/12/2019 09:23, Hanjun Guo wrote:
> In IORT spec
> (http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf),
> id_num means Number of IDs minus one, update the comment.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
> 
> This patch just for comments, needs to be upstream in ACPICA first.
> 
>   include/acpi/actbl2.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index e45ced2..382642f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -104,7 +104,7 @@ enum acpi_iort_node_type {
>   
>   struct acpi_iort_id_mapping {
>   	u32 input_base;		/* Lowest value in input range */
> -	u32 id_count;		/* Number of IDs */
> +	u32 id_count;		/* Number of IDs in the range minus one */

The IORT spec also uses the term "Length" in the examples...

>   	u32 output_base;	/* Lowest value in output range */
>   	u32 output_reference;	/* A reference to the output node */
>   	u32 flags;
> 

