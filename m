Return-Path: <linux-acpi+bounces-15039-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4956AFA825
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 00:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F43189AFA3
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Jul 2025 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB21E51EF;
	Sun,  6 Jul 2025 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuJ9SQWQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B219DFB4;
	Sun,  6 Jul 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751840858; cv=none; b=FzV2bkQOaYfB9z/jVDHBm+qVMSwTaMvNQQSHdDOTn/QAc6UM/y50Xw00WXoTHHnGHHD+3ZOvgNxsbeDh4xLSLsHw+sfp1Ej2P6Spt/bfQIajdmLt9s+U5v09bkrjnEtCK8l6xegfxdgvP32++RS5/9NylTjbh6dMBCm4rliDibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751840858; c=relaxed/simple;
	bh=IZgg+2iD1yTKcHgBTsL+83GOuqI+j+Nd8t622NOqRJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUF4BYd/J0N/IfDd9oSW9+5r5ndCWxR+IOMz7aQOs0fLagGD77m7+c3bItiz1WV1LZW9/1f23/Pok37wVEMbBALPWQBnJYFkYesaQ757fBM2X6U2rHnU8wOqzADskKkYHqCrzguOoq3DJTQAge/zUdP42AGeFleRREoqd7wnJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuJ9SQWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FE1C4CEED;
	Sun,  6 Jul 2025 22:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751840856;
	bh=IZgg+2iD1yTKcHgBTsL+83GOuqI+j+Nd8t622NOqRJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuJ9SQWQA/0FuWPzc0us58I4qzy9gfFKr5ChPJrM4CVLUbWMi391cCtCCAdx++pLL
	 n8fF+EbxG0SpTmq3Uk2/CjrSE751IdH8169feuPcpxTW33owAVFE7IRVnUjOmv6PC6
	 3OCzS8XqqlzUrwKheHbNLZK1V7hqwcetiOFJvz+w90UFx3l4rkgmLAh8gYYNukmLnK
	 3NPr88K785bd57lvU7AxHkOreJOrlcYbcTx1d/aFF0rk1c7aFZjVK0DPSRDgtkaeyy
	 G2vKCPF7AXxBZeT/IQzEttMGRSm7ZsvEsAJRVtZlepEkFh2NhHkDZ9gz7N31rp8Ib7
	 vmRwq+VvG8OzA==
Received: by venus (Postfix, from userid 1000)
	id 0B5BC180F14; Mon, 07 Jul 2025 00:27:34 +0200 (CEST)
Date: Mon, 7 Jul 2025 00:27:34 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Hans de Goede <hansg@kernel.org>, pmarheine@chromium.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, rafael.j.wysocki@intel.com, 
	linux-acpi@vger.kernel.org
Subject: Re: [REGRESSION] - Multiple userspace implementations of battery
 estimate broken after "ACPI: battery: negate current when discharging"
Message-ID: <l7capl22ei2mc4ooalcyysmpfrtsik5hgbqqrud5orw4ukj5ob@l4ou3yvif6nc>
References: <84dfa466-d201-4a51-8794-6c64568bec95@kernel.org>
 <10A90071-DC0B-4860-845F-556A33FC79BC@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7bxvrtjfaytekrra"
Content-Disposition: inline
In-Reply-To: <10A90071-DC0B-4860-845F-556A33FC79BC@linux.dev>


--7bxvrtjfaytekrra
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REGRESSION] - Multiple userspace implementations of battery
 estimate broken after "ACPI: battery: negate current when discharging"
MIME-Version: 1.0

Hi,

On Thu, Jul 03, 2025 at 08:51:10AM -0700, Matthew Schwartz wrote:
> > On Jul 3, 2025, at 7:47=E2=80=AFAM, Hans de Goede <hansg@kernel.org> wr=
ote:
> > Hi Matthew,
> >=20
> >> On 3-Jul-25 3:54 AM, Matthew Schwartz wrote:
> >> Hello,
> >>=20
> >> I installed kernel 6.15.4 to find that my battery estimate on
> >> my handheld gaming device was completely inaccurate, instead
> >> giving negative values and an unknown estimated battery life in
> >> multiple places.
> >>=20
> >> After bisecting, I landed on "ACPI: battery: negate current
> >> when discharging=E2=80=9D as the bad commit. This commit breaks not one
> >> but several userspace implementations of battery monitoring:
> >> Steam and MangoHud. Perhaps it breaks more, but those are the
> >> two I have noticed so far.
> >=20
> > Thank you for reporting this.
> >=20
> > As Rafael already indicated this patch will need to be reverted to
> > unbreak userspace.
> >=20
> > But, the patch was actually doing the right thing, according to:
> >=20
> > Documentation/ABI/testing/sysfs-class-power
> >=20
> > What:           /sys/class/power_supply/<supply_name>/current_avg
> > Date:           May 2007
> > Contact:        linux-pm@vger.kernel.org
> > Description:
> >                Battery:
> > ...
> >                Access: Read
> >=20
> >                Valid values: Represented in microamps. Negative values =
are
> >                used for discharging batteries, positive values for char=
ging
> >                batteries and for USB IBUS current.
> >=20
> > (and the same for current_now)
> >=20
> > and there are many power_supply fuel-gauge drivers (1) under
> > drivers/power/supply/ which do adhere to this specification
> > and report a negative current for discharging.
> >=20
> > So if any of the userspace consumers of this API you mention
> > were to run on hw with these drivers the same problem will
> > be hit. Can you please file bugs against these userspace
> > projects so that they can fix this?
>=20
> Sure, I filed a bug with MangoHud last night about the kernel
> change breaking the current battery logic so I will mention this
> concern when updating that issue, and I will also file a new bug
> with Steam.

I also asked the Collabora team supporting Valve with the Steamdeck
to look into it. So I hope that it will be fixed soon :)

Thanks for coordinating this Hans. I fully agree with your analysis
and middle term plans to revert the revert :)

Greetings,

-- Sebastian

--7bxvrtjfaytekrra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhq+FIACgkQ2O7X88g7
+poF6Q/+NW+5POUjFDRX1qZIQbdKLNd/QTTuOyDAr6x5T/0Cbb92B1Fzh7+nir1c
GqKQahquvhAWtk5eY8IEn9dFdLnPaXyU4wojYHOJYgVkf3N/4gQAFcooRxzOQNzH
6GUUxgeOszWpK0oltqm12RWubXt3Ft0vOUk1M+Uqg/MY9PuvrUCXMnTZzk8W7ROi
2qtPpBfXXqEHanP2gKfgHcT46sDauzxVt/CUID5ep3yqhvvAU8Sd1f7+fNkTUWJL
njpJhK6UFl5uK3HlAJiAnynGYcd8RLqWMpmA1pXp4ev56WV1OoJgPJJruTzZe9g1
k6+3gw6y5lp0u9VYUD3bFqh0dwcnd4nEQwdOEea+/Wc7fpKy2vCL3mEmBE/ZDdl6
OanVoOknVRMuUP4cTDr0bTDuKiNjXurJV8LLsf+Mn4WfrT8G/kdvk3MO3/Btf+Sd
52/al98qe4nZ5KfsBYauw0Y4UXhAxubRnA8svSuVLR47/OECvR/yLpczJct8Omnz
6o3RQV8+V7cUJzasc1wNNmuYkQhXBjOiwTafLKJ6xr2yu+706hVA6fE6qb792yMO
G3VO8CG300RvSHWrkj3iXG1cT0k+N1HW/l4l4zp9ppTfPFR4XDlpil/nTmTugDBQ
uLWdrZhsOYS7YrcqgrDVii0LC3Y2m8Uvc4nsGbWY0wp0B+ETmg0=
=FdfW
-----END PGP SIGNATURE-----

--7bxvrtjfaytekrra--

