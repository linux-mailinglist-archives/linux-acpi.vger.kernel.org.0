Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C336A4292B2
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhJKPC5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 11:02:57 -0400
Received: from foss.arm.com ([217.140.110.172]:60808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhJKPC5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 11:02:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EB10101E;
        Mon, 11 Oct 2021 08:00:57 -0700 (PDT)
Received: from [10.57.95.157] (unknown [10.57.95.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1E353F694;
        Mon, 11 Oct 2021 08:00:54 -0700 (PDT)
Subject: Re: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated with
 a dev
To:     Jon Nettleton <jon@solid-run.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        yangyicong <yangyicong@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
 <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
 <CABdtJHv+SZ15RcBaFt0w4iTsMMbAjGB2Wm4GST3cNw+2Q=OeVw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <706e2dc8-37af-2344-0d99-6da1f27ba0fb@arm.com>
Date:   Mon, 11 Oct 2021 16:00:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABdtJHv+SZ15RcBaFt0w4iTsMMbAjGB2Wm4GST3cNw+2Q=OeVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-10-09 08:07, Jon Nettleton wrote:
> On Fri, Oct 8, 2021 at 3:10 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-08-05 09:07, Shameer Kolothum wrote:
>>> Get ACPI IORT RMR regions associated with a dev reserved
>>> so that there is a unity mapping for them in SMMU.
>>
>> This feels like most of it belongs in the IORT code rather than
>> iommu-dma (which should save the temporary list copy as well).
> 
> See previous comment.  The original intent was for device-tree to also
> be able to use these mechanisms to create RMR's and support them
> in the SMMU.

Can you clarify how code behind an "if (!is_of_node(...))" check 
alongside other IORT-specific code is expected to be useful for DT?

Yes, iommu_dma_get_resv_regions() itself wants to end up serving as an 
abstraction layer, but that still doesn't mean it has to do much more 
than dispatch into firmware-specific backends as appropriate.

Robin.
