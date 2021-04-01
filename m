Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83F351A03
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhDAR5g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 13:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236641AbhDARzA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D9EF613BC;
        Thu,  1 Apr 2021 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617297309;
        bh=Ph9+lnZtIzSHhSU0K6hxMEjAX5FATLhumPexdh/21YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ri+XLAtbo6oc/14qf6Nc6kPi+TD8uNByUFcX9gAWNIrqfgTCdfJl62m0qAureFoaL
         vQsb20+HbosVH32lv0CWBjvCmH+4LFWlfr/Ew1I7yi4nqfA5VH+jLvv7MdhXQUc7TN
         n8QrOpYaXLw/Y5MbKHhSF+31FYlygg8xNhSz48Hycir/Pzebgu2afUkQdg2iq/nJe6
         92SaK/Y1oz8iCxjc6OS3EftTfhpde626t0I0Y/u22Wv4aOevCEyP7JrGivO7Xq/X55
         OtqVoeUtTnYozo22/PNi9ALkon1ZN/S+BWzGPLe3cPH7ldlB23iV6KBzmLPiZMsGb3
         /I/HrkcR1fqIQ==
Date:   Thu, 1 Apr 2021 18:15:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v14 00/10] iommu: I/O page faults for SMMUv3
Message-ID: <20210401171501.GC9447@willie-the-truck>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 01, 2021 at 05:47:09PM +0200, Jean-Philippe Brucker wrote:
> Add stall support to the SMMUv3 driver, along with a common I/O Page
> Fault handler.
> 
> Since [v13] I added review and ack tags (Thanks!), and a lockdep_assert.
> It would be good to have all of it in v5.13, since patch 10 introduces
> the first user for the IOPF interface from patch 6.  But if that's not
> possible, please pick patches 1-6 so the Vt-d driver can start using
> them.

Patches 1-7 look good to me, but I'm not convinced about the utility of
stalling faults so I'd prefer the later patches to come along with a
real user.

Will
