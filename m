Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443DD782806
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Aug 2023 13:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjHULfb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Aug 2023 07:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjHULfa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2023 07:35:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFEA4E6
        for <linux-acpi@vger.kernel.org>; Mon, 21 Aug 2023 04:35:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627D62F4;
        Mon, 21 Aug 2023 04:36:08 -0700 (PDT)
Received: from [10.57.3.137] (unknown [10.57.3.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E03E43F762;
        Mon, 21 Aug 2023 04:35:25 -0700 (PDT)
Message-ID: <5e3e8bae-12ba-f445-29a8-65e48065a000@arm.com>
Date:   Mon, 21 Aug 2023 12:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
 <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
 <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
 <ZN5n7GnlrTS6s5Yg@nvidia.com> <ZN-UpDFHab0vGuXp@suse.de>
 <ZN+XE7dk04f2C3D7@nvidia.com> <ZN-3Qfp3CyNiwJBK@suse.de>
 <b31c4b66-9543-a827-9404-227d3fafe22f@arm.com> <ZN/ESR+3pchFRB9g@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZN/ESR+3pchFRB9g@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-08-18 20:19, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 07:50:18PM +0100, Robin Murphy wrote:
> 
>>> There is a difference between knowingly introducing new lockdep warnings
>>> into upstream and letting warnings discovered upstream rot for a while.
>>
>> Furthermore I'd say it's one thing to have deadlocks or warnings slip in as
>> part of some functional change, but quite another when the change is solely
>> reworking the locking in an attempt to make it better. This is clearly not
>> better.
> 
> Exactly what isn't better? We now print a warning when pre-existing
> locking rules are violated. That is the only issue here.

What locking rules? 9 years ago when of_iommu_configure() was introduced 
(97890ba9289c), of_dma_configure() ran at device creation time, and that 
remains the case in some places, so cannot necessarily be called wrong. 
Subsequently making it run off driver probe in the general case was a 
bit of a hack, but at the time probe deferral was the only tool we had 
available to easily enforce the ordering of IOMMU drivers relative to 
client drivers. In hindsight there are subtleties which weren't really 
apparent at the time, but what *was* clear was that the benefit of 
letting IOMMU drivers be normal drivers without any special 
OF_IOMMU_DECLARE£() weirdness was significant, and thus today's mess was 
unwittingly born.

The existing locking rules are that there aren't any locking rules 
(other than the probe_device_lock bodge), which obviously could be 
better, but does rather disprove the assertion that they could be 
violated. A robust locking scheme would be great, but designing one 
based on something which already violates *other* IOMMU API assumptions, 
such that a) it can't ever really work, and b) it makes those underlying 
issues even harder to fix, is not productive.

Thanks,
Robin.
