Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1C03CA51A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 20:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbhGOSPe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 14:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237690AbhGOSPe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 14:15:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1AF761289;
        Thu, 15 Jul 2021 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626372760;
        bh=563x5jc9W0wYdsYhRrwdZ2cKbN/d2MVtmAqW50LZyZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FsZnz9nP1bhbXjnQ1v7vfL8Px6/NRc9/Tw/5rjvcQ0W74+LUQmJOvDrhD7sN0bzCQ
         A/377ILCL8HxH19Q2Bq7wRbdh8O+CrDgK5A9RTOxBhwtSw48htNA/wZQtNIKA/f8jC
         7An5l1t6/H9nn+OV8w1rtEldUw2KaUAy48s9tI5o=
Date:   Thu, 15 Jul 2021 11:12:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jia He <justin.he@arm.com>, Joe Perches <joe@perches.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rich Felker <dalias@libc.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.osdn.me>
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: use "unsigned long" for PFN
 in zone_for_pfn_range()
Message-Id: <20210715111238.a557aec31381646d5cd71ef2@linux-foundation.org>
In-Reply-To: <99c59db8-4c3d-6bee-9acc-41a8f76899ef@redhat.com>
References: <20210712124052.26491-1-david@redhat.com>
        <20210712124052.26491-2-david@redhat.com>
        <YO9FWrT9h21e/G8X@osiris>
        <99c59db8-4c3d-6bee-9acc-41a8f76899ef@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 15 Jul 2021 11:42:21 +0200 David Hildenbrand <david@redhat.com> wrote:

> > I'd propose to add Cc: <stable@vger.kernel.org> since I actually had
> > the fun to try to debug something like this a couple of years ago:
> > 6cdb18ad98a4 ("mm/vmstat: fix overflow in mod_zone_page_state()")
> > 
> 
> Good point, and thinking again what can go wrong, I tend to agree. We 
> are trying to keep zones contiguous and it could happen that we end up 
> with something like ZONE_DMA here (via default_kernel_zone_for_pfn()) 
> and would consequently online something to ZONE_DMA that doesn't belong 
> there, resulting in crashes.
> 
> @Andrew can you add  Cc: <stable@vger.kernel.org> and
> 
> "As we will search for a fitting zone using the wrong pfn, we might end 
> up onlining memory to one of the special kernel zones, such as ZONE_DMA, 
> which can end badly as the onlined memory does not satisfy properties of 
> these zones."

Yep, all done.
