Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB3781317
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 20:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbjHRSuv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379532AbjHRSu0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 14:50:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB779421B
        for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2023 11:50:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 089ADD75;
        Fri, 18 Aug 2023 11:51:05 -0700 (PDT)
Received: from [10.57.91.158] (unknown [10.57.91.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 634923F762;
        Fri, 18 Aug 2023 11:50:22 -0700 (PDT)
Message-ID: <b31c4b66-9543-a827-9404-227d3fafe22f@arm.com>
Date:   Fri, 18 Aug 2023 19:50:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
Content-Language: en-GB
To:     Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZN-3Qfp3CyNiwJBK@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-08-18 19:24, Joerg Roedel wrote:
> On Fri, Aug 18, 2023 at 01:06:43PM -0300, Jason Gunthorpe wrote:
>> On Fri, Aug 18, 2023 at 05:56:20PM +0200, Joerg Roedel wrote:
>>> On Thu, Aug 17, 2023 at 03:33:16PM -0300, Jason Gunthorpe wrote:
>>>> Bascially.. Yikes!
>>>
>>> Hmm, that is a difficult situation. Even if the problem is a misuse of
>>> the APIs we can not just blindly break other drivers by our core
>>> changes.
>>
>> They are not broken, they just throw a lockdep warning and keep going
>> as before. This is what triggers:
>>
>> static inline void device_lock_assert(struct device *dev)
>> {
>> 	lockdep_assert_held(&dev->mutex);
>> }
>>
>> So non-debug builds won't even see anything.
> 
> But this still means that a function is called without holding the
> proper lock.
> 
>> Historically we've tolerated lockdep warnings as a way to motivate
>> people who care to fix their stuff properly. eg the Intel VT-D had a
>> lockdep warning at kernel boot for many releases before it was fixed.
> 
> There is a difference between knowingly introducing new lockdep warnings
> into upstream and letting warnings discovered upstream rot for a while.

Furthermore I'd say it's one thing to have deadlocks or warnings slip in 
as part of some functional change, but quite another when the change is 
solely reworking the locking in an attempt to make it better. This is 
clearly not better.

Thanks,
Robin.
