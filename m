Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765E755CE63
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiF0Lxh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jun 2022 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiF0Lw3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2022 07:52:29 -0400
X-Greylist: delayed 404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 04:45:08 PDT
Received: from mx1.sbone.de (cross.sbone.de [195.201.62.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287AA474
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2022 04:45:08 -0700 (PDT)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id 179AF8D4A162;
        Mon, 27 Jun 2022 11:38:18 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id D9724E70810;
        Mon, 27 Jun 2022 11:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id hpfsF3TvzMS2; Mon, 27 Jun 2022 11:38:15 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id C8185E7080F;
        Mon, 27 Jun 2022 11:38:13 +0000 (UTC)
Date:   Mon, 27 Jun 2022 11:38:12 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
cc:     Steven Price <steven.price@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "lorenzo.pieralisi@gmail.com" <lorenzo.pieralisi@gmail.com>
Subject: RE: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
In-Reply-To: <44338c87254d4d439d29694de8f19435@huawei.com>
Message-ID: <alpine.BSF.2.00.2206271005580.68830@ai.fobar.qr>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com> <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com> <44338c87254d4d439d29694de8f19435@huawei.com>
X-OpenPGP-Key-Id: 0x14003F198FEFA3E77207EE8D2B58B8F83CCF1842
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 24 Jun 2022, Shameerali Kolothum Thodi wrote:

Hi,

>> -----Original Message-----
>> From: Steven Price [mailto:steven.price@arm.com]
>> Sent: 17 June 2022 13:42
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; Sami.Mujawar@arm.com; jon@solid-run.com;
>> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
>> Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> On 15/06/2022 11:10, Shameer Kolothum wrote:
>>> Hi
>>>
>>> v12 --> v13
>>>   -No changes. Rebased to 5.19-rc1.
>>>   -Picked up tags received from Laurentiu, Hanjun and Will. Thanks!.
>>
>> You've already got my Tested-by tags, but just to confirm I gave this a
>> spin and it works fine.
>
> Thanks Steve.
>
> I think the series is now in a good shape to be merged.
>
> Hi Will/Robin,
>
> Appreciate, if you could please take a look at the remaining SMMU related
> patches(7-9) and provide your approval?
>
> Thanks,
> Shameer

First of all thanks to all of you for keeping this going.

I've read through most of this patch series and it doesn't read
like the best sunny days.

I do understand that there are incentives to get things right; sometimes
first make it work, then make it better? Running code often seems a
better alternative than wrong words on paper as users don't care about
the paper.  They only care if their hardware becomes a paperweight
because it's not working.

I was trying to find diplomatic words but the general problem has become
so much bigger than just this change as I am faced with the fact that
vendors are talking to give up maintaining Arm/ACPI and go back to FDT
exclusively, which I believe would be the wrong but an understandable
exit out of a roundabout.

For me this Arm/Linux/ACPI problem becomes double-impact, as I am not
even a Linux person.  And part of what Arm/ACPI was solving was the
any OS can just works on Arm hardware; for a while people were hoping
it could make FDT the next Flash; it just seems it'll not be because
people cannot get fixes or workarounds for real world problems into
Linux timely?

So a very polite but firm prod towards Cambridge from here as well in
the hope that you can make a big change to this world by helping not
to miss the next merge window/release leading to way bigger impact.
It would be rather sad to close the Arm/ACPI chapter for good but it
seems that we may be standing on the verge of it if things do not move
quick now and different in the future.  It'll certainly need change from
all sides but the good things is that at the end of the day we all want
to make the world a better place.

As I mentioned, I have no stakes in this Linux change.
I just care about Arm and ACPI because I saw light and a chance in it
and I would love to see it stay.
Let's all work together in one direction and make it a brighter future
for everyone.  Can we?  Are you in?


May God bless you and your work,
Bjoern
