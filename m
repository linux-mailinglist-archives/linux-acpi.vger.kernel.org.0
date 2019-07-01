Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1351349733
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 03:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFRB6A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 21:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFRB57 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Jun 2019 21:57:59 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D602080C;
        Tue, 18 Jun 2019 01:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560823079;
        bh=8eJzG0QkG+7iwVlI/t7yW6Fig5RNCmwWmykPQq2nGgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OE+XgpgtZhH0f75UQlTQL3rSRdRRP05S+vKJvMay+8BmyMAjkXZLwJC6z89WkLyWv
         6xTZtwGGzs/c3VHzQzw94somd65KvS6zN7TbnwRgUQ+WTFBiYdGcHlHPlJeDB/vFEn
         R7E5dmgyl20XVW7R8vwXalARxFtvIQNepfCrhC/4=
Date:   Mon, 17 Jun 2019 18:57:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     David Hildenbrand <david@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Baoquan He <bhe@redhat.com>, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
        linux-acpi@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Arun KS <arunks@codeaurora.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org, Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 1/6] mm: Section numbers use the type "unsigned long"
Message-Id: <20190617185757.b57402b465caff0cf6f85320@linux-foundation.org>
In-Reply-To: <701e8feb-cbf8-04c1-758c-046da9394ac1@c-s.fr>
References: <20190614100114.311-1-david@redhat.com>
        <20190614100114.311-2-david@redhat.com>
        <20190614120036.00ae392e3f210e7bc9ec6960@linux-foundation.org>
        <701e8feb-cbf8-04c1-758c-046da9394ac1@c-s.fr>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 15 Jun 2019 10:06:54 +0200 Christophe Leroy <christophe.leroy@c-s.f=
r> wrote:

>=20
>=20
> Le 14/06/2019 =E0 21:00, Andrew Morton a =E9crit=A0:
> > On Fri, 14 Jun 2019 12:01:09 +0200 David Hildenbrand <david@redhat.com>=
 wrote:
> >=20
> >> We are using a mixture of "int" and "unsigned long". Let's make this
> >> consistent by using "unsigned long" everywhere. We'll do the same with
> >> memory block ids next.
> >>
> >> ...
> >>
> >> -	int i, ret, section_count =3D 0;
> >> +	unsigned long i;
> >>
> >> ...
> >>
> >> -	unsigned int i;
> >> +	unsigned long i;
> >=20
> > Maybe I did too much fortran back in the day, but I think the
> > expectation is that a variable called "i" has type "int".
> >=20
> > This?
> >=20
> >=20
> >=20
> > s/unsigned long i/unsigned long section_nr/
>=20
>  From my point of view you degrade readability by doing that.
>=20
> section_nr_to_pfn(mem->start_section_nr + section_nr);
>=20
> Three times the word 'section_nr' in one line, is that worth it ? Gives=20
> me headache.
>=20
> Codying style says the following, which makes full sense in my opinion:
>=20
> LOCAL variable names should be short, and to the point.  If you have
> some random integer loop counter, it should probably be called ``i``.
> Calling it ``loop_counter`` is non-productive, if there is no chance of it
> being mis-understood.

Well.  It did say "integer".  Calling an unsigned long `i' is flat out
misleading.

> What about just naming it 'nr' if we want to use something else than 'i' ?

Sure, that works.


