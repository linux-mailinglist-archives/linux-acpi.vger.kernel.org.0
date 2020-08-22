Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B54C24E4A8
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Aug 2020 04:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHVCcY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Aug 2020 22:32:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35918 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbgHVCcX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Aug 2020 22:32:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08E845D8E658A6DDE47C;
        Sat, 22 Aug 2020 10:32:19 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 22 Aug 2020
 10:32:11 +0800
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved
 ranges
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Joao Martins" <joao.m.martins@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        "Brice Goglin" <Brice.Goglin@inria.fr>,
        Jeff Moyer <jmoyer@redhat.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com>
 <CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
 <20200821162134.97d551c6fe45b489992841a8@linux-foundation.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a78c341d-db88-afd8-abfa-b997eb094b0e@huawei.com>
Date:   Sat, 22 Aug 2020 10:32:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200821162134.97d551c6fe45b489992841a8@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 8/22/2020 7:21 AM, Andrew Morton wrote:
> On Wed, 19 Aug 2020 18:53:57 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> 
>>> I think I am missing some important pieces. Bear with me.
>>
>> No worries, also bear with me, I'm going to be offline intermittently
>> until at least mid-September. Hopefully Joao and/or Vishal can jump in
>> on this discussion.
> 
> Ordinarily I'd prefer a refresh&resend for 2+ week-old series such as
> this.
> 
> But given that v4 all applies OK and that Dan has pending outages, I'll
> scoop up this version, even though at least one change has been suggested.
> 
> Also, this series has killed Zhen Lei's little cleanup
> (http://lkml.kernel.org/r/20200817065926.2239-1-thunder.leizhen@huawei.com).
> I don't think the affected code was moved elsewhere, so I'll drop that
> patch.

OK, this patch is really optional.

> 
> 
> .
> 

