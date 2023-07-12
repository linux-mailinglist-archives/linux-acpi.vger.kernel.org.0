Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E371750F62
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGLRNo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGLRNn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 13:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423910B
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 10:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3483A6184B
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 17:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D86C433C9;
        Wed, 12 Jul 2023 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689182021;
        bh=jdP2IW8lJtw9pFwYHyPzszyKj7YicGSFexthA8eVI8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCq+gW6Rf3HdNJxWgfdMtsN3rxUI9M9Vk8AuUjKM+UM75LMo9wpSk6dQ3sCYsSxTi
         rLybzzo05eWfSQyzKpOhYoda7zL6Kp81MeAzCjTEfvaN8kHK3ekr/F2bw2t4FsQm5h
         ZVkIv7x/4WJ+KdemhUwtzspamNZkSojiYxOb+zSm8p8OaLzAXOk4B6PkWqLpVRovrg
         bGGwpz0oLi/EUoCTvwrhcrGu1HRhVo5u0DNdP+ilomkPVZVpY/QxLPgDi774QAQNtX
         dR+eaENmtJxKC5f5ZvtTYvDgEzFllZYugtOBYzsGgcE5Vh6nJieDVdgE7l7alMJEtk
         wSl79/g/puY3Q==
Date:   Wed, 12 Jul 2023 18:13:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Don't include Zicsr or Zifencei in I from ACPI
Message-ID: <20230712-quickness-viscosity-ca1a15ccdfcb@spud>
References: <20230711-slideshow-plaza-4ceaa37f6c00@spud>
 <mhng-c30cb4e2-0574-4051-b220-01601d9579de@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w8fytWipbkP9+/r7"
Content-Disposition: inline
In-Reply-To: <mhng-c30cb4e2-0574-4051-b220-01601d9579de@palmer-ri-x1c9a>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--w8fytWipbkP9+/r7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 10:05:39AM -0700, Palmer Dabbelt wrote:
> On Tue, 11 Jul 2023 15:52:56 PDT (-0700), Conor Dooley wrote:

> > Although my rationale was that if we get as far as here, then Zicsr and
> > Zifencei are going to be enabled anyway so there is no harm in setting
> > it for both. I probably should have been less of a cute hoor though.
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> I think there's no way to get here without the extensions, not 100% sure
> though.  I'm mainly trying to avoid going down the same rabbit hole of ISA
> string compatibility hacks in ACPI that we have for DT, though -- I'm sure
> we'll end up with a mess as soon as we release, but might as well catch as
> much as we can.

Seems reasonable to me chief :+1:

--w8fytWipbkP9+/r7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7fQgAKCRB4tDGHoIJi
0s0ZAP4xI2LN1e5OQkEZILOkLMwdHq9XT+3WOm+81MvzQvJ3ggEAzjr1AF8+HLQ+
h3R+mbaDOxbl3KYOdnNuUx5B6rG+tAU=
=2zmV
-----END PGP SIGNATURE-----

--w8fytWipbkP9+/r7--
