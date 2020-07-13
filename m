Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6D21DD10
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 18:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgGMQgb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 12:36:31 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6797 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbgGMQga (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2020 12:36:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c8d810000>; Mon, 13 Jul 2020 09:36:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 09:36:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 09:36:30 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 16:36:17 +0000
Subject: Re: [PATCH v2 19/22] mm/memremap_pages: Convert to 'struct range'
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-nvdimm@lists.01.org>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>, <peterz@infradead.org>,
        <dave.hansen@linux.intel.com>, <ard.biesheuvel@linaro.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <hch@lst.de>,
        <joao.m.martins@oracle.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457126779.754248.3575056680831729751.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <52e00a67-b686-8554-8b92-a172ba9f34b6@nvidia.com>
Date:   Mon, 13 Jul 2020 09:36:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <159457126779.754248.3575056680831729751.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594658177; bh=pEu43f6TYC38teVwUvS5veiq+jHDv/8kh2CbYzLWE6U=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fNpeW/b9FMcDuL8oBoNL4fjzJoqpiaHBjJ5dsdIG5lrR+4Y/gb8oxeR9pNqs5p58E
         jg/E8fTCGVG/pvYTlGNYMJ4np0poYz626qjoxbOuxMSk67Oh9xeDZjp9Dlx+JvN/yI
         anmR/T+xHKXScxT+q/iQrtkW+yLeCbIRALu8t1RHIL23PtB5Gt3fPRk3mkNbf55HbY
         rurMSczEzdbFa7CP+/s/hv3jIlWgQnc/l3MXL6dU1kdaK+Pru79j771P+5fyYyqL5O
         XSYWgz3RPaAQhvk7/olB0odRYdNQkhmC2b55QRVX3q2JPs4J6+AQSE73bzRJ26O6Q9
         P7158pxFYmDSQ==
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 7/12/20 9:27 AM, Dan Williams wrote:
> The 'struct resource' in 'struct dev_pagemap' is only used for holding
> resource span information. The other fields, 'name', 'flags', 'desc',
> 'parent', 'sibling', and 'child' are all unused wasted space.
> 
> This is in preparation for introducing a multi-range extension of
> devm_memremap_pages().
> 
> The bulk of this change is unwinding all the places internal to
> libnvdimm that used 'struct resource' unnecessarily.
> 
> P2PDMA had a minor usage of the flags field, but only to report failures
> with "%pR". That is replaced with an open coded print of the range.
> 
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   arch/powerpc/kvm/book3s_hv_uvmem.c     |   13 +++--
>   drivers/dax/bus.c                      |   10 ++--
>   drivers/dax/bus.h                      |    2 -
>   drivers/dax/dax-private.h              |    5 --
>   drivers/dax/device.c                   |    3 -
>   drivers/dax/hmem/hmem.c                |    5 ++
>   drivers/dax/pmem/core.c                |   12 ++---
>   drivers/gpu/drm/nouveau/nouveau_dmem.c |    3 +
>   drivers/nvdimm/badrange.c              |   26 +++++------
>   drivers/nvdimm/claim.c                 |   13 +++--
>   drivers/nvdimm/nd.h                    |    3 +
>   drivers/nvdimm/pfn_devs.c              |   12 ++---
>   drivers/nvdimm/pmem.c                  |   26 ++++++-----
>   drivers/nvdimm/region.c                |   21 +++++----
>   drivers/pci/p2pdma.c                   |   11 ++---
>   include/linux/memremap.h               |    5 +-
>   include/linux/range.h                  |    6 ++
>   mm/memremap.c                          |   77 ++++++++++++++++----------------
>   tools/testing/nvdimm/test/iomap.c      |    2 -
>   19 files changed, 135 insertions(+), 120 deletions(-)

I think you are missing a call to memremap_pages() in lib/test_hmm.c
and a call to release_mem_region() that need to be converted too.
Try setting CONFIG_TEST_HMM=m.

Also, what about the call to release_mem_region() in
drivers/gpu/drm/nouveau/nouveau_dmem.c? Doesn't that need a small change too?
