Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C586774FB56
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 00:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGKWxC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jul 2023 18:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGKWxC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2023 18:53:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CD10CF
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2023 15:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9D1A61601
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2023 22:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A61C433C8;
        Tue, 11 Jul 2023 22:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689115980;
        bh=VHdFIq+SW8gZEm6SJctrHJ5/TSSkyzbus8jPIeeXyzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5I6Kv8Jnvqgio8y+HMLYe2qz1nNcgUZvbwoXBCnfaWDHhboAGDlMnsEHZPCpeS05
         pMw6gPywC4cc16ep01GzvxgbwhUQgucg6O39SXzRIXXbVUfcX/cAr2mce7MWayBaTM
         kFFphtCqkJMYh0u99iO8iPwEqI/FtflOablrGtK6Xzju2Q/DDPfgUrDZdYM5qHhaUY
         NTaqfFKGRsosWq0i3v545ft5Yf8KoWX2926iB8MGO36q2fKfl9CDxufb6hlRMi7vqc
         vFcEH6soptrweqiXHpNRiTYxLcFSnGDdTxPvCrdwtbqbXXocvTg4zpKrRcXdA/s41L
         4ckVJVmTh6KBA==
Date:   Tue, 11 Jul 2023 23:52:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Don't include Zicsr or Zifencei in I from ACPI
Message-ID: <20230711-slideshow-plaza-4ceaa37f6c00@spud>
References: <20230711224600.10879-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EpgXFXdc1xhpMk5M"
Content-Disposition: inline
In-Reply-To: <20230711224600.10879-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--EpgXFXdc1xhpMk5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 03:46:00PM -0700, Palmer Dabbelt wrote:
> ACPI ISA strings are based on a specification after Zicsr and Zifencei
> were split out of I, so we shouldn't be treating them as part of I.  We
> haven't release an ACPI-based kernel yet, so we don't need to worry
> about compatibility with the old ISA strings.
>=20
> Fixes: 396c018332a1 ("RISC-V: cpufeature: Add ACPI support in riscv_fill_=
hwcap()")

I think, if anything, this is actually:
Fixes: 07edc32779e3 ("RISC-V: always report presence of extensions formerly=
 part of the base ISA")

Although my rationale was that if we get as far as here, then Zicsr and
Zifencei are going to be enabled anyway so there is no harm in setting
it for both. I probably should have been less of a cute hoor though.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index bdcf460ea53d..a8f66c015229 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -317,19 +317,14 @@ void __init riscv_fill_hwcap(void)
>  #undef SET_ISA_EXT_MAP
>  		}
> =20
> -		/*
> -		 * Linux requires the following extensions, so we may as well
> -		 * always set them.
> -		 */
> -		set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
> -		set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
> -
>  		/*
>  		 * These ones were as they were part of the base ISA when the
>  		 * port & dt-bindings were upstreamed, and so can be set
>  		 * unconditionally where `i` is in riscv,isa on DT systems.
>  		 */
>  		if (acpi_disabled) {
> +			set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
> +			set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
>  			set_bit(RISCV_ISA_EXT_ZICNTR, isainfo->isa);
>  			set_bit(RISCV_ISA_EXT_ZIHPM, isainfo->isa);
>  		}
> --=20
> 2.40.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--EpgXFXdc1xhpMk5M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK3dSAAKCRB4tDGHoIJi
0jeuAQCxEeVNdDOolHW0/YyR+5G6rR0cwe2qNyDyibjz8lzlrQD/SSPEDx+KiDVJ
VxbhhUUdS77awYlyg7yc3V68mTvxWgM=
=7eNX
-----END PGP SIGNATURE-----

--EpgXFXdc1xhpMk5M--
