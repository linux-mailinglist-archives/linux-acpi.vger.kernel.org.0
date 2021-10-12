Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97F042A9FA
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJLQxW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 12:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhJLQxW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 12:53:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B835960D42;
        Tue, 12 Oct 2021 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634057480;
        bh=xZrkpJnf1xZwCaEbXMHPPsuTmya/AWfx/7gi6uu/h4I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F9blHUmXI6SilVlyRENOPVSyFQYn47i/pPYBAJKk+Hfjbs4Z3TlqCzjlHz2dGRKDH
         qZe/WQArQfbSaxMnTaxzAE/wFeH14G2Rb31TH11h4l0rvW8s+lEqnG44uA8N+pKpwJ
         E9UcpNgsO4rr7V/qPUiIq9xU4pazfzaBlz0WW4hkCAqsypoo8NbxPDag2H1y7uwgxR
         SsO5Vz1bjZhUunDuf84Lv5EEra9TEs9N0TMCnP9fz39eX4PKj8VtO7t3FsFx8n7N23
         dPVDo3UloKPRQtJyMGlJ3kCQwGYqwj64vFLmjZLY+LNKUbyMyS7w3JpM8ppoP5/niI
         I16p0CLKdt8XA==
Message-ID: <b16b8883d19600ca35f6a109cd2669c3c126437a.camel@kernel.org>
Subject: Re: [PATCH v9 7/7] x86/sgx: Add check for SGX pages to
 ghes_do_memory_failure()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        naoya.horiguchi@nec.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        Reinette Chatre <reinette.chatre@intel.com>
Date:   Tue, 12 Oct 2021 19:51:17 +0300
In-Reply-To: <20211011185924.374213-8-tony.luck@intel.com>
References: <20211001164724.220532-1-tony.luck@intel.com>
         <20211011185924.374213-1-tony.luck@intel.com>
         <20211011185924.374213-8-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-10-11 at 11:59 -0700, Tony Luck wrote:
> SGX EPC pages do not have a "struct page" associated with them so the
> pfn_valid() sanity check fails and results in a warning message to
> the console.
>=20
> Add an additional check to skip the warning if the address of the error
> is in an SGX EPC page.
>=20
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> =C2=A0drivers/acpi/apei/ghes.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0c8330ed1ffd..0c5c9acc6254 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -449,7 +449,7 @@ static bool ghes_do_memory_failure(u64 physical_addr,=
 int flags)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return false;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pfn =3D PHYS_PFN(physical=
_addr);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!pfn_valid(pfn)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!pfn_valid(pfn) && !arch_i=
s_platform_page(physical_addr)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_warn_ratelimited(FW_WARN GHES_PFX
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"Invalid address in generic error data: %#llx\n",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0physical_addr);

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

