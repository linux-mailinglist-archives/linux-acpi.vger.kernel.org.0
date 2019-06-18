Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF06B49C11
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 10:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfFRIex (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 04:34:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44341 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRIex (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Jun 2019 04:34:53 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D615E80305; Tue, 18 Jun 2019 10:34:39 +0200 (CEST)
Date:   Tue, 18 Jun 2019 10:34:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'kernel list' <linux-kernel@vger.kernel.org>,
        'ACPI Devel Maling List' <linux-acpi@vger.kernel.org>,
        "'Zhang, Rui'" <rui.zhang@intel.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        'Viresh Kumar' <viresh.kumar@linaro.org>,
        'Linux PM' <linux-pm@vger.kernel.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        "'H. Peter Anvin'" <hpa@zytor.com>,
        'the arch/x86 maintainers' <x86@kernel.org>
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
Message-ID: <20190618083449.GA4541@amd>
References: <20190609111732.GA2885@amd>
 <007701d520c7$c397bda0$4ac738e0$@net>
 <CAJZ5v0j2pb2WxSA+S44Mr-6bpOx-P9A_T2-sDG3CiWSqLMg3sA@mail.gmail.com>
 <008f01d52178$07b3be70$171b3b50$@net>
 <CAJZ5v0gRaDe6Fajdx3wqaLz9LQr6Z6iD+2yrrZeXJV+3HiAOZg@mail.gmail.com>
 <002601d525ae$a2c00c90$e84025b0$@net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <002601d525ae$a2c00c90$e84025b0$@net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-06-18 01:20:01, Doug Smythies wrote:
> On 2019.06.13 01:53 Rafael J. Wysocki wrote:
>=20
> > I personally doubt that any thermal throttling is involved here.
>=20
> In earlier e-mails on this thread, Pavel showed his core and package
> temperatures as 97 and 98 degrees. If thermal throttling is not
> involved, it should be. The description of the observed CPU
> frequencies also matched my experiences with thermal throttling
> for the intel-pstate/powersave example. Myself, I can not determine
> if throttling is involved for the acpi-cpufreq/ondemand
> case, just from the clock frequencies, because,
> at least on my system, it uses the kidle_inject method
> instead of the pstate method.

Yes, I'm pretty sure it is thermal throttling. System is running >
3GHz when cold, and going below 2GHz when hot...

And I'm pretty sure the throttling works, too, because temperature
goes to ~98C quickly, and stays there.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0IoikACgkQMOfwapXb+vJV8gCfcqCwVwZID6HpXgg4CVIPrSnT
3dMAoIwd4ZnSLDub83/RvqsWweszPhpA
=t1EA
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
