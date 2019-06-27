Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7212457952
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 04:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfF0CLA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jun 2019 22:11:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbfF0CLA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jun 2019 22:11:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7A5856FB3196203F8FEE;
        Thu, 27 Jun 2019 10:10:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 27 Jun 2019
 10:10:55 +0800
Subject: Re: [PATCH v5 1/4] ACPI/PPTT: Modify node flag detection to find last
 IDENTICAL
To:     Jeremy Linton <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <mark.rutland@arm.com>,
        <lorenzo.pieralisi@arm.com>, <sudeep.holla@arm.com>,
        Hanjun Gou <gouhanjun@huawei.com>
References: <20190626213718.39423-1-jeremy.linton@arm.com>
 <20190626213718.39423-2-jeremy.linton@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c36d197b-9f85-4681-69b6-a573451b5ed6@huawei.com>
Date:   Thu, 27 Jun 2019 10:10:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190626213718.39423-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/6/27 5:37, Jeremy Linton wrote:
> The ACPI specification implies that the IDENTICAL flag should be
> set on all non leaf nodes where the children are identical.
> This means that we need to be searching for the last node with
> the identical flag set rather than the first one.
> 
> Since this flag is also dependent on the table revision, we
> need to add a bit of extra code to verify the table revision,
> and the next node's state in the traversal. Since we want to
> avoid function pointers here, lets just special case
> the IDENTICAL flag.
> 
> Tested-by: Hanjun Gou <gouhanjun@huawei.com>

This is wrong, my family name is Guo, and please correct my
email address as well (for all the 4 patches).

Thanks
Hanjun


