Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033092D582B
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 11:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgLJK07 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 05:26:59 -0500
Received: from foss.arm.com ([217.140.110.172]:33624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgLJK05 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Dec 2020 05:26:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D0BB31B;
        Thu, 10 Dec 2020 02:26:07 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DB713F718;
        Thu, 10 Dec 2020 02:26:05 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, devel@acpica.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, jonathan.cameron@huawei.com,
        Sami.Mujawar@arm.com
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com>
Date:   Thu, 10 Dec 2020 10:25:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 19/11/2020 12:11, Shameer Kolothum wrote:
> RFC v1 --> v2:
>   - Added a generic interface for IOMMU drivers to retrieve all the
>     RMR info associated with a given IOMMU.
>   - SMMUv3 driver gets the RMR list during probe() and installs
>     bypass STEs for all the SIDs in the RMR list. This is to keep
>     the ongoing traffic alive(if any) during SMMUv3 reset. This is
>     based on the suggestions received for v1 to take care of the
>     EFI framebuffer use case. Only sanity tested for now.

Hi Shameer,

Sorry for not looking at this before.

Do you have any plans to implement support in the SMMUv2 driver? The 
platform I've been testing the EFI framebuffer support on has the 
display controller behind SMMUv2, so as it stands this series doesn't 
work. I did hack something up for SMMUv2 so I was able to test the first 
4 patches.

>   - During the probe/attach device, SMMUv3 driver reserves any
>     RMR region associated with the device such that there is a unity
>     mapping for them in SMMU.

For the EFI framebuffer use case there is no device to attach so I 
believe we are left with just the stream ID in bypass mode - which is 
definitely an improvement (the display works!) but not actually a unity 
mapping of the RMR range. I'm not sure whether it's worth fixing this or 
not, but I just wanted to point out there's still a need for a driver 
for the device before the bypass mode is replaced with the unity mapping.

Thanks,

Steve
