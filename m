Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19142A9F7
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhJLQwy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 12:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhJLQwx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 12:52:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78F3360295;
        Tue, 12 Oct 2021 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634057452;
        bh=pfbPeDtfbr0MXPAA3uePFkBsXCgKnh9lLRXZpAVZiJg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DQrTc+nGZzmE/EcnGEnpwMSqbfbUIELYcTBRz5GZdul3sx1yGmCELnwY4X17t/HkI
         AZCHHEOzJCTiqjvy8B+47JqxCvzeoVnaOmYo1wcTBn+AlCoaA5sHS6sUnxfUO05CUb
         UWle/lrhV5Q2sdH6T9FA+DuycjU73EK1xiRgLCXEtsr4liFAmr1isNzv9AvKPFycPo
         ONqdVtnhQ+Pm0W0uI45gQSYM2wkIe7epZ6HZNnEod4kevn5DLBoq2LD1BorExpjkqU
         DbEBAyXzCXyImrzgEXzKyJbxX5ximpOaZMy/vioKYllEi/LNkczWh6d1t2lJmM2/kE
         8F1VlUxRZUZPg==
Message-ID: <86c924fad46291f962381e9e23a6cdbb95d4d31e.camel@kernel.org>
Subject: Re: [PATCH v9 6/7] x86/sgx: Add hook to error injection address
 validation
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
Date:   Tue, 12 Oct 2021 19:50:49 +0300
In-Reply-To: <20211011185924.374213-7-tony.luck@intel.com>
References: <20211001164724.220532-1-tony.luck@intel.com>
         <20211011185924.374213-1-tony.luck@intel.com>
         <20211011185924.374213-7-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-10-11 at 11:59 -0700, Tony Luck wrote:
> SGX reserved memory does not appear in the standard address maps.
>=20
> Add hook to call into the SGX code to check if an address is located
> in SGX memory.
>=20
> There are other challenges in injecting errors into SGX. Update the
> documentation with a sequence of operations to inject.
>=20
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> =C2=A0.../firmware-guide/acpi/apei/einj.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 19 +++++++++++++++++++
> =C2=A0drivers/acpi/apei/einj.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A02 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentat=
ion/firmware-guide/acpi/apei/einj.rst
> index c042176e1707..55e2331a6438 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -181,5 +181,24 @@ You should see something like this in dmesg::
> =C2=A0=C2=A0 [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422=
553404 SOCKET 0 APIC 0
> =C2=A0=C2=A0 [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID=
#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 synd=
rome:0x0 -=C2=A0 area:DRAM err_code:0001:0090 socket:0
> channel_mask:1 rank:0)
> =C2=A0
> +Special notes for injection into SGX enclaves:
> +
> +There may be a separate BIOS setup option to enable SGX injection.
> +
> +The injection process consists of setting some special memory controller
> +trigger that will inject the error on the next write to the target
> +address. But the h/w prevents any software outside of an SGX enclave
> +from accessing enclave pages (even BIOS SMM mode).
> +
> +The following sequence can be used:
> +=C2=A0 1) Determine physical address of enclave page
> +=C2=A0 2) Use "notrigger=3D1" mode to inject (this will setup
> +=C2=A0=C2=A0=C2=A0=C2=A0 the injection address, but will not actually in=
ject)
> +=C2=A0 3) Enter the enclave
> +=C2=A0 4) Store data to the virtual address matching physical address fr=
om step 1
> +=C2=A0 5) Execute CLFLUSH for that virtual address
> +=C2=A0 6) Spin delay for 250ms
> +=C2=A0 7) Read from the virtual address. This will trigger the error
> +
> =C2=A0For more information about EINJ, please refer to ACPI specification
> =C2=A0version 4.0, section 17.5 and ACPI 5.0, section 18.6.
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 2882450c443e..67c335baad52 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -544,7 +544,8 @@ static int einj_error_inject(u32 type, u32 flags, u64=
 param1, u64 param2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((regi=
on_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!=3D REGION_INTERSECTS) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_M=
EMORY)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!=3D REGION_INTERSECTS)))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!=3D REGION_INTERSECTS) &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !arch=
_is_platform_page(base_addr)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> =C2=A0
> =C2=A0inject:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

