Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEE0525F5F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 May 2022 12:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379146AbiEMJtx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 May 2022 05:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379143AbiEMJtt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 May 2022 05:49:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 709B0200F71
        for <linux-acpi@vger.kernel.org>; Fri, 13 May 2022 02:49:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A66E143D;
        Fri, 13 May 2022 02:49:48 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.2.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AD983F73D;
        Fri, 13 May 2022 02:49:45 -0700 (PDT)
Date:   Fri, 13 May 2022 10:49:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, rafael@kernel.org,
        joro@8bytes.org
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Message-ID: <20220513094940.GA23371@lpieralisi>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <2234ad60-c49f-8c72-616c-dfa5300354ef@huawei.com>
 <8e4f012717e34195a53cb73f8ce28627@huawei.com>
 <5c8ae673-f8e3-0ed3-e62d-d445913b012c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c8ae673-f8e3-0ed3-e62d-d445913b012c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[with Christoph's correct email address]

On Tue, May 10, 2022 at 09:07:00AM +0100, Robin Murphy wrote:
> On 2022-05-10 08:23, Shameerali Kolothum Thodi wrote:
> > Hi Joerg/Robin,
> > 
> > I think this series is now ready to be merged. Could you please let
> > me know if there is anything missing.
> 
> Fine by me - these patches have had enough review and testing now that
> even if anything else did come up, I think it would be better done as
> follow-up work on the merged code.

Given the ACPICA dependency I believe it is best for this series
to go via the ACPI tree, right ?

I assume there are all the required ACKs for that to happen.

Thanks,
Lorenzo

> Cheers,
> Robin.
> 
> > 
> > Thanks,
> > Shameer
> > 
> > > -----Original Message-----
> > > From: Guohanjun (Hanjun Guo)
> > > Sent: 05 May 2022 02:24
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > > linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> > > iommu@lists.linux-foundation.org
> > > Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> > > joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
> > > <wanghuiqiang@huawei.com>; steven.price@arm.com;
> > > Sami.Mujawar@arm.com; jon@solid-run.com; eric.auger@redhat.com;
> > > laurentiu.tudor@nxp.com; hch@infradead.org
> > > Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
> > > 
> > > On 2022/5/4 0:33, Shameer Kolothum wrote:
> > > > Hi
> > > > 
> > > > v11 --> v12
> > > >     -Minor fix in patch #4 to address the issue reported by the kernel test
> > > robot.
> > > >     -Added R-by tags by Christoph(patch #1) and Lorenzo(patch #4).
> > > >     -Added T-by from Steve to all relevant patches. Many thanks!.
> > > > 
> > > > Please note, this series has a dependency on the ACPICA header patch
> > > > here[1].
> > > 
> > > Tested on a Kunpeng920 server machine with SMMUv3, the 3408iMR RAID
> > > controller card works as expected,
> > > 
> > > Tested-by: Hanjun Guo <guohanjun@huawei.com>
> > > 
> > > Thanks
> > > Hanjun
