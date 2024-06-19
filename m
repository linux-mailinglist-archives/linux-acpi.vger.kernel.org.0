Return-Path: <linux-acpi+bounces-6527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4340890F515
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 19:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B121F216AB
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8637143;
	Wed, 19 Jun 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ZJJGKneb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B92139D1;
	Wed, 19 Jun 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818266; cv=none; b=ks+UQhq4lbjo396/wJPygrVVkM/3shgr/YLluRfMjbMbKYH+tXjSOIHoy4KvZFmKUzuGMWPjovgcNRJHLlVyIJ35SbUnwU7B9+RdLRqfCzwU3VJBRZU1fM6nWvWyZekMALsZXlf7iTOvKKCVHHfDqvwnvZ2GT+pdhN1U3BTPozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818266; c=relaxed/simple;
	bh=JtyV6fTrNqECekypB4WJ1prctjopYH8/7+VyiVgTFAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWZcCU4oKjSX6rjP6GzBbe1XFmPc+k2McxFjt5dwyoM0ip9O9NkRqjmVijxKNxgVwbNv5g7/GFqUk9DNmp0MwwZHdv6sSiBTAGPENRcXlEwvhqSinqe11vu8h3aYn3o+JAc2DtpZypNRy4FFpPpA4O3zEw5fj/zTwmNuvDlJgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ZJJGKneb reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id aed01b5e3570948f; Wed, 19 Jun 2024 19:30:56 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A63086A55B8;
	Wed, 19 Jun 2024 19:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718818256;
	bh=JtyV6fTrNqECekypB4WJ1prctjopYH8/7+VyiVgTFAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJJGKnebEy6wVg1RtGUUgjmnYe4KEnxc0dywXcm0dlreilXLz9lowA/LKmJOIajhq
	 X/8TlhtC4p/E+ImzwX4cmDBp8C7KLTaHFoRYmDC6BTXxiJ9X6FHPbiaEV/A3R4UhlR
	 02zPcpNtG+cDGgwCIJX3UbyxV+XZvOuGJoFxwSVM+avmTkQsc4cJ3+uaTScFtHW07j
	 Z/fk/rDd1orIlN3092pIu364rErqqMe70N5Abn1pPQ5mMEqjUpqBfdzUPNzszOsXWV
	 q7kd/RAuDLRF453J5iEhHS0fOUU1fCH5s0gxCLWnj9kVuE2i+UcJI5ptOcTelrwbws
	 k3zozlzPCw42Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 mmikowski@kfocus.org, Perry.Yuan@amd.com,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
Date: Wed, 19 Jun 2024 19:30:55 +0200
Message-ID: <12457165.O9o76ZdvQC@rjwysocki.net>
In-Reply-To:
 <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
References:
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com> <ZnJfmUXmU_tsb9pV@kf-XE>
 <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeeftddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedtvdefgeelvdefvdevveehvdetfeefhedvueeiudekieeltdetgfdviefhgfetteenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegrrhgrihhnsgholhhtsehkfhhotghushdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
 nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

On Wednesday, June 19, 2024 7:09:35 PM CEST Rafael J. Wysocki wrote:
> On Wed, Jun 19, 2024 at 6:33=E2=80=AFAM Aaron Rainbolt <arainbolt@kfocus.=
org> wrote:
> >
> > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> >
> > The _OSC is supposed to contain a bit indicating whether the hardware
> > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > be considered absent. This results in severe single-core performance
> > issues with the EEVDF scheduler on heterogenous-core Intel processors.
>=20
> While some things can be affected by this, I don't immediately see a
> connection between CPPC v2, Intel hybrid processors and EEVDF.
>=20
> In particular, why would EEVDF alone be affected?
>=20
> Care to explain this?

And the reason why I am asking is because I think that you really need
something like this (untested beyond compilation):

=2D--
 drivers/cpufreq/intel_pstate.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -355,16 +355,16 @@ static void intel_pstate_set_itmt_prio(i
 	int ret;
=20
 	ret =3D cppc_get_perf_caps(cpu, &cppc_perf);
=2D	if (ret)
=2D		return;
=2D
 	/*
=2D	 * On some systems with overclocking enabled, CPPC.highest_perf is hard=
coded to 0xff.
=2D	 * In this case we can't use CPPC.highest_perf to enable ITMT.
=2D	 * In this case we can look at MSR_HWP_CAPABILITIES bits [8:0] to decid=
e.
+	 * If CPPC is not available, fall back to MSR_HWP_CAPABILITIES bits [8:0].
+	 *
+	 * Also, on some systems with overclocking enabled, CPPC.highest_perf is
+	 * hardcoded to 0xff, so CPPC.highest_perf cannot be used to enable ITMT.
+	 * Fall back to MSR_HWP_CAPABILITIES then too.
 	 */
=2D	if (cppc_perf.highest_perf =3D=3D CPPC_MAX_PERF)
=2D		cppc_perf.highest_perf =3D HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu=
]->hwp_cap_cached));
+	if (ret || cppc_perf.highest_perf =3D=3D CPPC_MAX_PERF)
+		cppc_perf.highest_perf =3D
+			HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
=20
 	/*
 	 * The priorities can be set regardless of whether or not




