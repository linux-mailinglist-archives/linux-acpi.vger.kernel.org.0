Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2FE42A9EE
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhJLQvM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 12:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhJLQuq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 12:50:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6766960C4A;
        Tue, 12 Oct 2021 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634057324;
        bh=dQr2VpoFjdcdGHPcXHE4RlJJqGepnYsh8L1WP2cZqwE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=etezSoXYRv8G5gdM9JAwpaLoXkRuPHTUNQ22Ir7ZiXy5BG/C/7aBZl50YYtXMfImY
         Rs3FuUN6QLGcUQQiMDxy8Vaz12xwGQ6nsLlKTlKF0Uv4B7y8TvM8hshDyASxa0+Z/N
         wB2BNvnf2K1D+ZfsYZqtwBfSdAmXy1xsJuV3HhlBQWW+4wpGqkP/pwyxQdz3tOjJkW
         EkiU6KJ2dsbJBZJKgbHJCgll3PQeQAxoLJEqkka7kXxfLJib/u0iLPG0bANH8ZoOL7
         iaB6PJMCeS5e1GGEPtKH/isvpcdw4UkV/xup9/Ab1tEtRpvideBlJ28tX8HhB9rowN
         ChunIAdQzNYRg==
Message-ID: <73c711bc548b661977ff26e3d9cc87c9466a8f66.camel@kernel.org>
Subject: Re: [PATCH v9 0/7] Basic recovery for machine checks inside SGX
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        naoya.horiguchi@nec.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 12 Oct 2021 19:48:42 +0300
In-Reply-To: <20211011185924.374213-1-tony.luck@intel.com>
References: <20211001164724.220532-1-tony.luck@intel.com>
         <20211011185924.374213-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-10-11 at 11:59 -0700, Tony Luck wrote:
> Posting latest version to a slightly wider audience.
>=20
> The big picture is that SGX uses some memory pages that are walled off
> from access by the OS. This means they:
> 1) Don't have "struct page" describing them
> 2) Don't appear in the kernel 1:1 map
>=20
> But they are still backed by normal DDR memory, so errors can occur.
>=20
> Parts 1-4 of this series handle the internal SGX bits to keep track of
> these pages in an error context. They've had a fair amount of review
> on the linux-sgx list (but if any of the 37 subscribers to that list
> not named Jarkko or Reinette want to chime in with extra comments and
> {Acked,Reviewed,Tested}-by that would be great).
>=20
> Linux-mm reviewers can (if they like) skip to part 5 where two changes ar=
e
> made: 1) Hook into memory_failure() in the same spot as device mapping 2)
> Skip trying to change 1:1 map (since SGX pages aren't there).
>=20
> The hooks have generic looking names rather than specifically saying
> "sgx" at the suggestion of Dave Hansen. I'm not wedded to the names,
> so better suggestions welcome.=C2=A0 I could also change to using some
> "ARCH_HAS_PLATFORM_PAGES" config bits if that's the current fashion.
>=20
> Rafael (and other ACPI list readers) can skip to parts 6 & 7 where there
> are hooks into error injection and reporting to simply say "these odd
> looking physical addresses are actually ok to use). I added some extra
> notes to the einj.rst documentation on how to inject into SGX memory.
>=20
> Tony Luck (7):
> =C2=A0 x86/sgx: Add new sgx_epc_page flag bit to mark in-use pages
> =C2=A0 x86/sgx: Add infrastructure to identify SGX EPC pages
> =C2=A0 x86/sgx: Initial poison handling for dirty and free pages
> =C2=A0 x86/sgx: Add SGX infrastructure to recover from poison
> =C2=A0 x86/sgx: Hook arch_memory_failure() into mainline code
> =C2=A0 x86/sgx: Add hook to error injection address validation
> =C2=A0 x86/sgx: Add check for SGX pages to ghes_do_memory_failure()
>=20
> =C2=A0.../firmware-guide/acpi/apei/einj.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 19 ++++
> =C2=A0arch/x86/include/asm/processor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> =C2=A0arch/x86/include/asm/set_memory.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0arch/x86/kernel/cpu/sgx/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 104 ++++++++++++++=
+++-
> =C2=A0arch/x86/kernel/cpu/sgx/sgx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
6 +-
> =C2=A0drivers/acpi/apei/einj.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0drivers/acpi/apei/ghes.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0include/linux/mm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +++
> =C2=A0mm/memory-failure.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +++-
> =C2=A09 files changed, 168 insertions(+), 11 deletions(-)
>=20
>=20
> base-commit: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc

I think you instructed me on this before but I've forgot it:
how do I simulate this and test how it works?

/Jarkko

