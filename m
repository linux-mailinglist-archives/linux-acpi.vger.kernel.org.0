Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1284A097
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 14:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFRMRZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 18 Jun 2019 08:17:25 -0400
Received: from ozlabs.org ([203.11.71.1]:56151 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMRZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jun 2019 08:17:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45SnC6001Qz9s3l;
        Tue, 18 Jun 2019 22:17:21 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-acpi@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Arun KS <arunks@codeaurora.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 1/6] mm: Section numbers use the type "unsigned long"
In-Reply-To: <20190617185757.b57402b465caff0cf6f85320@linux-foundation.org>
References: <20190614100114.311-1-david@redhat.com> <20190614100114.311-2-david@redhat.com> <20190614120036.00ae392e3f210e7bc9ec6960@linux-foundation.org> <701e8feb-cbf8-04c1-758c-046da9394ac1@c-s.fr> <20190617185757.b57402b465caff0cf6f85320@linux-foundation.org>
Date:   Tue, 18 Jun 2019 22:17:19 +1000
Message-ID: <87pnnbozow.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:
> On Sat, 15 Jun 2019 10:06:54 +0200 Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>> Le 14/06/2019 à 21:00, Andrew Morton a écrit :
>> > On Fri, 14 Jun 2019 12:01:09 +0200 David Hildenbrand <david@redhat.com> wrote:
>> > 
>> >> We are using a mixture of "int" and "unsigned long". Let's make this
>> >> consistent by using "unsigned long" everywhere. We'll do the same with
>> >> memory block ids next.
>> >>
>> >> ...
>> >>
>> >> -	int i, ret, section_count = 0;
>> >> +	unsigned long i;
>> >>
>> >> ...
>> >>
>> >> -	unsigned int i;
>> >> +	unsigned long i;
>> > 
>> > Maybe I did too much fortran back in the day, but I think the
>> > expectation is that a variable called "i" has type "int".
...
>> Codying style says the following, which makes full sense in my opinion:
>> 
>> LOCAL variable names should be short, and to the point.  If you have
>> some random integer loop counter, it should probably be called ``i``.
>> Calling it ``loop_counter`` is non-productive, if there is no chance of it
>> being mis-understood.
>
> Well.  It did say "integer".  Calling an unsigned long `i' is flat out
> misleading.

I always thought `i` was for loop `index` not `integer`.

But I've never written any Fortran :)

cheers
