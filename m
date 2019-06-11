Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5639B3C847
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2019 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405196AbfFKKMR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jun 2019 06:12:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:32827 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404501AbfFKKMR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jun 2019 06:12:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D7E9580239; Tue, 11 Jun 2019 12:12:03 +0200 (CEST)
Date:   Tue, 11 Jun 2019 12:12:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Zhang Rui <rui.zhang@intel.com>, daniel.lezcano@linaro.org
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
Message-ID: <20190611101213.GA4256@amd>
References: <20190609111732.GA2885@amd>
 <20190609112340.GA9966@amd>
 <20190609121212.GA4520@amd>
 <1560089580.2363.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <1560089580.2363.10.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to provide all the required info below. Any ideas?

> > > > The CPU is Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz . I guess it
> > > > means
> > > > it should be able to sustain both cores running at 2.5GHz?
> > > >=20
> > > > Any ideas? Were there any recent changes in that area?
> > > I tried kernel compile. It keeps both cores at 3GHz, temperature
> > > goes
> > > up over 95C, and then cpus start going down to 2.3GHz... and then
> > > down
> > > to 2GHz... and down to 1.9GHz.

> what temperature does coretemp report?
> can you please provide the sensors output in 4.6 during kernel
> compiling?
>=20
> can you attach the output of "grep . /sys/class/thermal/thermal*/*"
> when the temperature goes high in both kernels?

v5.2:
bash -c sensors;  cat /proc/cpuinfo

thinkpad-isa-0000
Adapter: ISA adapter
fan1:        4493 RPM

coretemp-isa-0000
Adapter: ISA adapter
Package id 0:  +97.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 0:        +97.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 1:        +94.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)

cpu MHz         : 2351.857
cpu MHz         : 2351.920
cpu MHz         : 2351.980
cpu MHz         : 2352.036
pavel@duo:~$ cat /sys/devices/system/cpu/*/cpufreq/scaling_governor
powersave
powersave
powersave
powersave
pavel@duo:~$ grep . /sys/class/thermal/thermal*/* 2> /dev/null
/sys/class/thermal/thermal_zone0/available_policies:step_wise
/sys/class/thermal/thermal_zone0/mode:enabled
/sys/class/thermal/thermal_zone0/passive:0
/sys/class/thermal/thermal_zone0/policy:step_wise
/sys/class/thermal/thermal_zone0/temp:96000
/sys/class/thermal/thermal_zone0/trip_point_0_temp:99000
/sys/class/thermal/thermal_zone0/trip_point_0_type:critical
/sys/class/thermal/thermal_zone0/type:acpitz
pavel@duo:~$

v4.6:

acpitz-virtual-0
Adapter: Virtual device
temp1:        +96.0=B0C  (crit =3D +99.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +97.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 0:         +97.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 1:         +94.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)

thinkpad-isa-0000
Adapter: ISA adapter
fan1:        4493 RPM

cpu MHz         : 2501.000
cpu MHz         : 2501.000
cpu MHz         : 2501.000
cpu MHz         : 2501.000

pavel@duo:~$ cat /sys/devices/system/cpu/*/cpufreq/scaling_governor
ondemand
ondemand
ondemand
ondemand

pavel@duo:~$ grep . /sys/class/thermal/thermal*/* 2> /dev/null
/sys/class/thermal/thermal_zone0/available_policies:step_wise
/sys/class/thermal/thermal_zone0/mode:enabled
/sys/class/thermal/thermal_zone0/passive:0
/sys/class/thermal/thermal_zone0/policy:step_wise
/sys/class/thermal/thermal_zone0/temp:96000
/sys/class/thermal/thermal_zone0/trip_point_0_temp:99000
/sys/class/thermal/thermal_zone0/trip_point_0_type:critical
/sys/class/thermal/thermal_zone0/type:acpitz
pavel@duo:~$


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz/fn0ACgkQMOfwapXb+vI4/gCfZWiuM7gFaEDRrpqBP6EStUri
xDgAn08/m/jp6q40tYmFk9yCgh87jXvd
=U8fN
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
