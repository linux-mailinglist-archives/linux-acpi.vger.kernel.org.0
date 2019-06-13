Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FC9443DD
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbfFMQdH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 12:33:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42736 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730836AbfFMIMC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 04:12:02 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8539480343; Thu, 13 Jun 2019 10:11:48 +0200 (CEST)
Date:   Thu, 13 Jun 2019 10:11:58 +0200
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
Message-ID: <20190613081158.GA6853@amd>
References: <20190609111732.GA2885@amd>
 <007701d520c7$c397bda0$4ac738e0$@net>
 <CAJZ5v0j2pb2WxSA+S44Mr-6bpOx-P9A_T2-sDG3CiWSqLMg3sA@mail.gmail.com>
 <008f01d52178$07b3be70$171b3b50$@net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <008f01d52178$07b3be70$171b3b50$@net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On 2019.06.12 14:25 Rafael J. Wysocki wrote:
> > On Wed, Jun 12, 2019 at 4:45 AM Doug Smythies <dsmythies@telus.net> wro=
te:
> >>
> >> So, currently there seems to be 3 issues in this thread
> >> (and I am guessing a little, without definitive data):
> >>
> >> 1.) On your system Kernel 5.4-rc2 (or 4) defaults to the intel_pstate =
CPU frequency
> >> scaling driver and the powersave governor, but kernel 4.6 defaults to =
the
> >> acpi-cpufreq CPU frequency scaling driver and the ondemand governor.
> >
> > Which means that intel_pstate works in the active mode by default and
> > so it uses its internal governor.
>=20
> Note sure what you mean by "internal governor"?
> If you meant HWP (Hardware P-state), Pavel's processor doesn't have it.
> If you meant the active powersave governor code within the driver, then a=
greed.
>=20
> > That governor is more performance-oriented than ondemand and it very
> > well may cause more power to be allocated for the processor - at the
> > expense of the GPU.
>=20
> O.K. I mainly use servers and so have no experience with possible GPU
> verses CPU tradeoffs.
>=20
> However, I did re-do my tests measuring energy instead of CPU frequency
> and found very little difference between the acpi-cpufreq/ondemand verses
> intel_pstate/powersave as a function of single threaded load. Actually,
> I did the test twice, one at 20 hertz work/sleep frequency and also
> at 67 hertz work/sleep frequency. (Of course, Pavel's processor might
> well have a different curve, but it is a similar vintage to mine
> i5-2520M verses i7-2600K.) The worst difference was approximately
> 1.1 extra processor package watts (an extra 5.5%) in the 80% to 85%
> single threaded load range at 67 hertz work/sleep frequency for
> the intel-pstate/powersave driver/governor.=20
>=20
> What am I saying? For a fixed amount of work to do per work/sleep cycle
> (i.e. maybe per video frame related type work) while the CPU frequency Ve=
rses load
> curves might differ, the resulting processor energy curve differs much le=
ss.
> (i.e. the extra power for higher CPU frequency is for less time because i=
t gets
> the job done faster.) So, myself, I don't yet understand why only the one=
 method
> would have hit thermal throttling, but not the other (if indeed it
> doesn't).

It seems there are serious differences in reporting :-(. How do I
determine which frequency CPU really runs at, in 4.6 kernel?

But it seems that your assumptions are incorrect for my workload.

flightgear is single-threaded, and in my configuration saturates the
CPU, because it would like to achieve higher framerate than my system
is capable of.

> Just for information: CPU frequency verses single threaded load curves
> for the conservative governor is quite different between the two drivers.
> (tests done in February, perhaps I should re-do and also look at energy
> at the same time, or instead of CPU frequency.)

So this might be my problem?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0CBU4ACgkQMOfwapXb+vIA2ACgosp1TsX5OkrWOaRWttdwzNPP
S8EAoI+okCL2bRqt3AKPFbSPngilmwwC
=fxjZ
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
