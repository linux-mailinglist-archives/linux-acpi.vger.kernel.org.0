Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2CC3A550
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2019 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfFIMMP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 9 Jun 2019 08:12:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55928 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfFIMMP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jun 2019 08:12:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 325A0802A3; Sun,  9 Jun 2019 14:12:02 +0200 (CEST)
Date:   Sun, 9 Jun 2019 14:12:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
Message-ID: <20190609121212.GA4520@amd>
References: <20190609111732.GA2885@amd>
 <20190609112340.GA9966@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20190609112340.GA9966@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > When I start flightgear, I get framerates around 20 fps and cpu at
> > 3GHz:
> >=20
> > pavel@duo:~/bt$ cat /proc/cpuinfo  | grep MHz
> > cpu MHz		    : 3027.471
> > cpu MHz		      : 2981.863
> > cpu MHz		      	: 2958.352
> > cpu MHz			  : 2864.001
> > pavel@duo:~/bt$
> >=20
> > (Ok, fgfs is really only running at single core, so why do both cores
> > run at 3GHz?)
> >=20
> > But temperatures get quite high:
> >=20
> > pavel@duo:~/bt$ sensors
> > thinkpad-isa-0000
> > Adapter: ISA adapter
> > fan1:        4485 RPM
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Package id 0:  +98.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
> > Core 0:        +98.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
> > Core 1:        +91.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
> >=20
> > And soon cpu goes to 1.5GHz range, with framerates going down to
> > 12fps. That's a bit low.
> >=20
> > Room temperature is 26Celsius.
> >=20
> > The CPU is Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz . I guess it means
> > it should be able to sustain both cores running at 2.5GHz?
> >=20
> > Any ideas? Were there any recent changes in that area?
>=20
> I tried kernel compile. It keeps both cores at 3GHz, temperature goes
> up over 95C, and then cpus start going down to 2.3GHz... and then down
> to 2GHz... and down to 1.9GHz.
>=20
> watch bash -c 'sensors;  cat /proc/cpuinfo | grep MHz'

Situation is very different with v4.6 distro based kernel.

CPU MHz is only getting values round to 100MHz. It does not go above
2.5GHz, but it does not go below 2.5GHz under the load, either.

ACPI adapter appears in sensors output.

Now I tried going to 5.2-rc4. It behaves the same as 5.2-rc2. Goes up
to 3GHz briefly but then down to 2.0GHz and below under load.

Ideas welcome.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz895sACgkQMOfwapXb+vLzQACfaNgtBUgelwIUG6aapimpv8KT
y3MAnRSWm/0YigHw60pFSpoR3HDkRs8L
=oO9i
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
