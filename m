Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF81CE48D
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbgEKTgb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731199AbgEKTga (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 May 2020 15:36:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96725C061A0C
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 12:36:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f15so4350884plr.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2020 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=v1qEow1xr6Tl9HbXqv92zljMgDOgKRbT8DcK2r8augk=;
        b=plDyvByAezPxhtBNLRCuVK5NXRrexQXBfSR++YGjC0ACfezjvSTQ4rrVuyxXsCEEtI
         BbW2+qXKERUMz2XYA8LhCw/+uX3PWkPklugw6VNmlNZHrIV9ej6nD8FWRwEx4o/TnPww
         kdkwcs9KYpIuASMr/BNGVsia2pyZK0W8b74Y7BYxSeziRLkruJFJtlwWfB42Jb/9JiYn
         jpE//U7WrRm9hAm7hc+DTdNO5lt3CAdRHqXSFSO4ZA0Pcf/8p0ITa134SktFrq7OsKod
         PUhx3J9d5uROpjm74uAh0LSUBbPjFLkfCcx5a7c2NiuPxx+1GBDwMHyv2zsWWB661Y5j
         xlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=v1qEow1xr6Tl9HbXqv92zljMgDOgKRbT8DcK2r8augk=;
        b=sTlibm1i5lkBtXOO8sgjyIaBeVDNWk5vaN/ddPHdgpBSTsANPtx8RL+2ctS2qZZLgg
         pMJPjyFGLiYUCkm7BTs2GaJ2eTop5+2gSxniqdFgisQFkDfSWzdVDeDMiyaJnsWn1MVp
         EIvvuMuuXnsnIEqbVyfbo1TmrEm0IECc724HkTCXKTcGTKUJc8my+7ImVmDW4Y+NaWxT
         bMlavkW0qTYw6SEyYJQUYBE+DM71eBJ2AtfTsPh6rQJB3uGVJ+nvzs5BnbemwqbIhcMG
         /z8IcTDeY7iK1PFEtnUiNRZ5AJSmoLJx+EI+J5Uzn5iY0daWo/otMjDgumMPN1HYppFD
         X2Zw==
X-Gm-Message-State: AGi0Pua0ctt0U3Jj6SlVulHjNZkP8p4M5HxRJiBZTZ1aAKUoarCK8no9
        pQgvkkX48rNRKP1pO8HLZ9xqF2xuxpI=
X-Google-Smtp-Source: APiQypJ1YiMdk4N4C7CbB/W/+fhruAj/pk5oDUlcqa/TNtBxnj77+hdowSnvFuUKeaQO4a8ClZqGSA==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6mr16163755plb.338.1589225790091;
        Mon, 11 May 2020 12:36:30 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:8:ac6e:cd4:7f73? ([2601:646:c200:1ef2:8:ac6e:cd4:7f73])
        by smtp.gmail.com with ESMTPSA id u17sm4090429pgo.90.2020.05.11.12.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 12:36:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date:   Mon, 11 May 2020 12:36:19 -0700
Message-Id: <8D6745B7-0EC2-4FCC-B6FC-E7E1557EB18E@amacapital.net>
References: <20200511191414.GY8135@suse.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
In-Reply-To: <20200511191414.GY8135@suse.de>
To:     Joerg Roedel <jroedel@suse.de>
X-Mailer: iPhone Mail (17E262)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


> On May 11, 2020, at 12:14 PM, Joerg Roedel <jroedel@suse.de> wrote:
>=20
> =EF=BB=BFOn Mon, May 11, 2020 at 08:36:31AM -0700, Andy Lutomirski wrote:
>> What if we make 32-bit PTI depend on PAE?
>=20
> It already does, PTI support for legacy paging had to be removed because
> there were memory corruption problems with THP. The reason was that huge
> PTEs in the user-space area were mapped in two page-tables (kernel and
> user), but A/D bits were only fetched from the kernel part. To not make
> things more complicated we agreed on just not supporting PTI without
> PAE.
>=20
>> And drop 32-bit Xen PV support?  And make 32-bit huge pages depend on
>> PAE?  Then 32-bit non-PAE can use the direct-mapped LDT, 32-bit PTI
>> (and optionally PAE non-PTI) can use the evil virtually mapped LDT.
>> And 32-bit non-PAE (the 2-level case) will only have pointers to page
>> tables at the top level.  And then we can preallocate.
>=20
> Not sure I can follow you here. How can 32-bit PTI with PAE use the LDT
> from the direct mapping? I am guessing you want to get rid of the
> SHARED_KERNEL_PMD=3D=3D0 case for PAE kernels.

I wrote nonsense. I mean bite off a piece of the *user* portion of the addre=
ss space and stick the LDT there.

I contemplated doing this when I wrote the 64-bit code, but I decided we had=
 so much address space to throw around that I liked my solution better.

> This would indeed make
> syncing unneccessary on PAE, but pre-allocation would still be needed
> for 2-level paging. Just the amount of memory needed for the
> pre-allocated PTE pages is half as big as it would be with PAE.
>=20
>> Or maybe we don't want to defeature this much, or maybe the memory hit
>> from this preallocation will hurt little 2-level 32-bit systems too
>> much.
>=20
> It will certainly make Linux less likely to boot on low-memory x86-32
> systems, whoever will be affected by this.
>=20
>=20

I=E2=80=99m guessing the right solution is either your series or your series=
 plus preallocation on 64-bit. I=E2=80=99m just grumpy about it...=
