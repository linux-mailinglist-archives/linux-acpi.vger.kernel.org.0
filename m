Return-Path: <linux-acpi+bounces-337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010FC7B57EC
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A930A282347
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920851DA44
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 16:34:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841F1CFBE
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 15:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E29C433CA;
	Mon,  2 Oct 2023 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696261610;
	bh=CmmG84b/1OBnh9RduBYlaC31PLcl9rWTf7tM7hAt0i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/PAwkBadBvbGrpkDaXWNVVBDnVeHkW1OSHNMHBGISuRWXaQT9+M0PS00iAThcFaU
	 mIpBADPxntPzj9BWoSebDW8KKXItg8G+Xf0IH4smglI1BecONgtU+tws0KE7dmweRr
	 hi3pi2gHuCjar8xeO4b1UDHk+mz8TQ6b9KAFV7wOukcAk/h66Sk6CGKhp90/qhN2Jz
	 T8SNYwPq+Euel24AtDA23nefvRHTVuTBXgCTKhPfGpRltqgDX11sM3TwzyOlDK8/TG
	 YwVnw0ilipHuN/tuLIa6MXzz2UgaWGg5yjLSxQlrI9zEIu2wfDZTjUrft6vgk1EscK
	 5kFcJYt0aFXBA==
Date: Mon, 2 Oct 2023 16:46:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 -next 4/4] clocksource/timer-riscv: ACPI: Add
 timer_cannot_wakeup_cpu
Message-ID: <20231002-doorman-catchy-ff5b9ba14c3a@spud>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-5-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aL1TA5F1n3lbU8nP"
Content-Disposition: inline
In-Reply-To: <20230927170015.295232-5-sunilvl@ventanamicro.com>


--aL1TA5F1n3lbU8nP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 10:30:15PM +0530, Sunil V L wrote:
> The timer capability to wakeup the cpu irrespective of its idle state is
> provided by the flag in RHCT. Update the timer code to set this flag.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  drivers/clocksource/timer-riscv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 9c8f3e2decc2..06f5bad3c3e0 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -225,6 +225,10 @@ TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_i=
nit_dt);
>  #ifdef CONFIG_ACPI
>  static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
>  {
> +	struct acpi_table_rhct *rhct =3D (struct acpi_table_rhct *)table;
> +
> +	riscv_timer_cannot_wake_cpu =3D rhct->flags & ACPI_RHCT_TIMER_CANNOT_WA=
KEUP_CPU;
> +
>  	return riscv_timer_init_common();
>  }
> =20
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--aL1TA5F1n3lbU8nP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRrl5AAKCRB4tDGHoIJi
0hIpAP4l78wWWSJgv9GiRYKP3viLL22FMxgc4K5BcjViUuXTFgEA1phiOLRhZJXQ
5THh1DtDO53ISPllC0QaOhA0ZPUYoAs=
=6uzF
-----END PGP SIGNATURE-----

--aL1TA5F1n3lbU8nP--

