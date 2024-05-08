Return-Path: <linux-acpi+bounces-5660-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003298BFEC8
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 15:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE8E1C21261
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A9178C7B;
	Wed,  8 May 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RD4DiQn3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E76BFA6
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175137; cv=none; b=tv3V/btRsxmcpREWL7biNh67FywaBHty2QN0IwhuOUTbTWQovTM0lHXCFfFTYRbsnIomx01L/ClqPTVmtLEXiqRx+wPvopMxa172eSmC4Ynyqjnxg8Txp1RK5ngW9aO2hfVr5FUXcFN1O9NMVh3oqlHWZP7xN7RYFlvPe0MY2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175137; c=relaxed/simple;
	bh=wka9Os7kHgWEeR60L7QksAxGHNGDKFoxJqNakovt0UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeKFBMEyJafYA/oeI5mFQ1Ybx/xkote/2o60y+/1O26K3zKQVmoPoUy4jEH9bslNgA15Qa1SF2ZAmz5jP1RKPLmqDXDAVTWp7EWUU2HugFSsOvxOHEi2/RCZ8j/WtGZrNXS0+0DmE5lEtaFHBaz3WtSVwE7TY7yKwgdKZTJU2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RD4DiQn3 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 0ee97e2b3c29e7ff; Wed, 8 May 2024 14:32:12 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A9654A46625;
	Wed,  8 May 2024 14:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715171532;
	bh=wka9Os7kHgWEeR60L7QksAxGHNGDKFoxJqNakovt0UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RD4DiQn3zxNq0xtieXf8B2Qr78J/CJJMbLJLweBEj5c2mOqSuE5HTANCCOnkYhZ8H
	 iaM3rMh7dGxBpbu/PWndSKp7bh4U5E98fahPImJW5EfG0Z/ZkIHQfPEVXMXADOCT/2
	 VPtOmPokVt23bjbpVjK76T45/y33VbJ5YqliJ8cUAqp6YVCv/MVxVdwJCAxtRTluoV
	 E57CZzqHpd35wDaZUu+OyGfEP+DaFh4qccOY4m06rp3bivIQ1W+MG8bpF48niRyEJW
	 uTkUGBtXhU6bWSMSPbNGo2Nkf3yqlbfwwr6KgI1WH4pEhcG9tPPOvYdVZ2nMafJFuE
	 27vTuI7xA9M5Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
Date: Wed, 08 May 2024 14:32:11 +0200
Message-ID: <6044671.lOV4Wx5bFT@kreacher>
In-Reply-To: <ZjtuKzqpfKFbRaUi@kuha.fi.intel.com>
References:
 <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
 <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
 <ZjtuKzqpfKFbRaUi@kuha.fi.intel.com>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkeeileehffelfefggfdtjedvkeettdejfeevueegfedvhffgudeuteeigfeileetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtohephhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgt
 phhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

On Wednesday, May 8, 2024 2:20:59 PM CEST Heikki Krogerus wrote:
> On Mon, May 06, 2024 at 07:45:07PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> >=20
> > On Mon, Apr 29, 2024 at 4:55=E2=80=AFPM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > There's a bug that is caused by an EmbeddedControl OpRegion which is
> > > declared inside the scope of a specific USB Type-C device (PNP0CA0):
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D218789
> >=20
> > And in this bug you are essentially proposing to install the EC
> > OpRegion handler at the namespace root instead of the EC device.
> >=20
> > This sounds reasonable, although AFAICS this is a matter of modifying
> > the EC driver (before the EC OpRegion handler is installed by the EC
> > drvier, ACPICA has no way to handle EC address space accesses anyway).
> >=20
> > > It looks like that's not the only case where that OpRegion ID is used
> > > outside of the EC device scope. There is at least one driver in Linux
> > > Kernel (drivers/platform/x86/wmi.c) that already has a custom handler
> > > for the EmbeddedControl OpRegion, and based on a quick search, the
> > > problem "Region EmbeddedControl (ID=3D3) has no handler" has happened
> > > with some other devices too.
> >=20
> > AFAICS, installing the EC address space handler at the EC device
> > object itself is not based on any sound technical arguments, it's just
> > been always done this way in Linux.  It's quite possible that the EC
> > address space handler should have been installed at the namespace root
> > from the outset.
>=20
> Okay, thank you for the explanation. So can we simply change it like
> this (I may have still misunderstood something)?

Roughly speaking, yes, but it is missing an analogous change around
the removal.

Please see the appended patch (which I have created independently in
the meantime).  It doesn't break stuff for me and Andy points out that
there are examples of EmbeddedControl OpRegions outside the EC device
scope in the spec (see Section 9.17.15 in ACPI 6.5, for instance).

So I think that this change can be made relatively safely (but adding Hans =
and
Mario to the CC in case they know something that might be broken by it).


> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 02255795b800..6b9dd27171ee 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct acpi_ec *ec, =
struct acpi_device *device,
> =20
>         if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>                 acpi_ec_enter_noirq(ec);
> -               status =3D acpi_install_address_space_handler_no_reg(ec->=
handle,
> +               status =3D acpi_install_address_space_handler_no_reg(ACPI=
_ROOT_OBJECT,
>                                                                    ACPI_A=
DR_SPACE_EC,
>                                                                    &acpi_=
ec_space_handler,
>                                                                    NULL, =
ec);
> @@ -1497,7 +1497,7 @@ static int ec_install_handlers(struct acpi_ec *ec, =
struct acpi_device *device,
>                         return -ENODEV;
>                 }
>                 set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
> -               ec->address_space_handler_holder =3D ec->handle;
> +               ec->address_space_handler_holder =3D ACPI_ROOT_OBJECT;
>         }
> =20
>         if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
>=20

=2D--
 drivers/acpi/ec.c       |   10 +++++-----
 drivers/acpi/internal.h |    1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct ac
=20
 	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
 		acpi_ec_enter_noirq(ec);
=2D		status =3D acpi_install_address_space_handler_no_reg(ec->handle,
+		status =3D acpi_install_address_space_handler_no_reg(ACPI_ROOT_OBJECT,
 								   ACPI_ADR_SPACE_EC,
 								   &acpi_ec_space_handler,
 								   NULL, ec);
@@ -1497,11 +1497,10 @@ static int ec_install_handlers(struct ac
 			return -ENODEV;
 		}
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
=2D		ec->address_space_handler_holder =3D ec->handle;
 	}
=20
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
=2D		acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);
+		acpi_execute_reg_methods(ACPI_ROOT_OBJECT, ACPI_ADR_SPACE_EC);
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
=20
@@ -1555,8 +1554,9 @@ static void ec_remove_handlers(struct ac
 {
 	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
 		if (ACPI_FAILURE(acpi_remove_address_space_handler(
=2D					ec->address_space_handler_holder,
=2D					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
+						ACPI_ROOT_OBJECT,
+						ACPI_ADR_SPACE_EC,
+						&acpi_ec_space_handler)))
 			pr_err("failed to remove space handler\n");
 		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
 	}
Index: linux-pm/drivers/acpi/internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -186,7 +186,6 @@ enum acpi_ec_event_state {
=20
 struct acpi_ec {
 	acpi_handle handle;
=2D	acpi_handle address_space_handler_holder;
 	int gpe;
 	int irq;
 	unsigned long command_addr;




