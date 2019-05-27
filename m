Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28012B249
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2019 12:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfE0Kha (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 May 2019 06:37:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51052 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfE0Kha (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2019 06:37:30 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 696A180491; Mon, 27 May 2019 12:37:17 +0200 (CEST)
Date:   Mon, 27 May 2019 12:37:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        bp@suse.de, hpa@zytor.com, mingo@redhat.com, x86@kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: ACPI enable on Thinkpad X60 hangs when temperatures are high
Message-ID: <20190527103727.GA3769@amd>
References: <20190527085155.GA11421@xo-6d-61-c0.localdomain>
 <20190527093938.GA12391@xo-6d-61-c0.localdomain>
 <20190527103155.GB12391@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20190527103155.GB12391@xo-6d-61-c0.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > So if you compile a kernel, then reboot, boot will hang after "Freein=
g SMP
> > > alternatives memory" (and then wastes power, making thermal situation=
 even worse).
> >=20
> > Normally, next message is "smpboot: CPU0: Genuine Intel...".
> >=20
> > I added some printks, and check_bugs() returns. Then it goes to ACPI an=
d never
> > comes back...
> >=20
> > kernel-parameters.txt points to Documentation/acpi/debug.txt, but that =
one does not exist.
> >=20
> > Any ideas what debugging parameters to use for ACPI? I either get nothi=
ng or
> > so much that machine does not boot...
>=20
> I ended up adding printks...
>=20
> It hangs in acpi_hw_set_mode().
>=20
> ACPI enable: set mode: acpi
> ACPI: hw_set_mode
> ACPI: hw_set_mode mode switch
> ACPI: write_port?
> ACPI: os write port
>=20
> we write to the port but that never returns.
>=20
> I assume SMM is doing its magic at that point. Any ideas how to debug it =
further?
>=20
> Is it possible that it is some kind of screaming interrupt?

Exact position of debug prints was this:

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index e528fe5..e9bb627 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -37,16 +37,20 @@ acpi_status acpi_enable(void)
=20
 	/* ACPI tables must be present */
=20
+	printk("ACPI enable: 1\n");
+
 	if (acpi_gbl_fadt_index =3D=3D ACPI_INVALID_TABLE_INDEX) {
 		return_ACPI_STATUS(AE_NO_ACPI_TABLES);
 	}
=20
+	printk("ACPI enable: 2\n");
 	/* If the Hardware Reduced flag is set, machine is always in acpi mode */
=20
 	if (acpi_gbl_reduced_hardware) {
 		return_ACPI_STATUS(AE_OK);
 	}
=20
+	printk("ACPI enable: 3\n");=09
 	/* Check current mode */
=20
 	if (acpi_hw_get_mode() =3D=3D ACPI_SYS_MODE_ACPI) {
@@ -57,13 +61,17 @@ acpi_status acpi_enable(void)
=20
 	/* Transition to ACPI mode */
=20
+	printk("ACPI enable: set mode: acpi\n");	=09
 	status =3D acpi_hw_set_mode(ACPI_SYS_MODE_ACPI);
+	printk("ACPI enable: set mode: acpi done\n");	=09
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO,
 			    "Could not transition to ACPI mode"));
 		return_ACPI_STATUS(status);
 	}
=20
+	printk("ACPI enable: sanity check\n");	=09
+
 	/* Sanity check that transition succeeded */
=20
 	for (retry =3D 0; retry < 30000; ++retry) {
@@ -76,6 +84,8 @@ acpi_status acpi_enable(void)
 		acpi_os_stall(100);	/* 100 usec */
 	}
=20
+	printk("ACPI enable: sanity check done\n");	=09
+
 	ACPI_ERROR((AE_INFO, "Hardware did not enter ACPI mode"));
 	return_ACPI_STATUS(AE_NO_HARDWARE_RESPONSE);
 }
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 926f7e0..e8063f9 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -38,6 +38,7 @@ acpi_status acpi_hw_set_mode(u32 mode)
 		return_ACPI_STATUS(AE_OK);
 	}
=20
+	printk("ACPI: hw_set_mode\n");
 	/*
 	 * ACPI 2.0 clarified that if SMI_CMD in FADT is zero,
 	 * system does not support mode transition.
@@ -62,13 +63,17 @@ acpi_status acpi_hw_set_mode(u32 mode)
 		return_ACPI_STATUS(AE_OK);
 	}
=20
+	printk("ACPI: hw_set_mode mode switch\n");=09
 	switch (mode) {
 	case ACPI_SYS_MODE_ACPI:
=20
 		/* BIOS should have disabled ALL fixed and GP events */
=20
+		printk("ACPI: write_port?\n");=09
 		status =3D acpi_hw_write_port(acpi_gbl_FADT.smi_command,
 					    (u32) acpi_gbl_FADT.acpi_enable, 8);
+		printk("ACPI: write_port done.\n");=09
+
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Attempting to enable ACPI mode\n"));
 		break;
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index cd57615..b3ed022 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -262,7 +262,9 @@ acpi_status acpi_hw_write_port(acpi_io_address address,=
 u32 value, u32 width)
=20
 	status =3D acpi_hw_validate_io_request(address, width);
 	if (ACPI_SUCCESS(status)) {
+		printk("ACPI: os write port\n");
 		status =3D acpi_os_write_port(address, value, width);
+		printk("ACPI: os write port done\n");	=09
 		return (status);
 	}
=20
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 9f3b1e3..4418fa9 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -45,6 +45,7 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_subsystem(=
void)
 	ACPI_DEBUG_EXEC(acpi_ut_init_stack_ptr_trace());
=20
 	/* Initialize the OS-Dependent layer */
+	printk("ACPI: os initialize\n");
=20
 	status =3D acpi_os_initialize();
 	if (ACPI_FAILURE(status)) {
@@ -53,6 +54,7 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_subsystem(=
void)
 	}
=20
 	/* Initialize all globals used by the subsystem */
+	printk("ACPI: globals\n");
=20
 	status =3D acpi_ut_init_globals();
 	if (ACPI_FAILURE(status)) {
@@ -62,6 +64,7 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_subsystem(=
void)
 	}
=20
 	/* Create the default mutex objects */
+	printk("ACPI: mutex\n");
=20
 	status =3D acpi_ut_mutex_initialize();
 	if (ACPI_FAILURE(status)) {
@@ -70,6 +73,8 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_subsystem(=
void)
 		return_ACPI_STATUS(status);
 	}
=20
+	printk("ACPI: ns root\n");
+=09
 	/*
 	 * Initialize the namespace manager and
 	 * the root of the namespace tree
@@ -82,6 +87,7 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_subsystem(=
void)
 	}
=20
 	/* Initialize the global OSI interfaces list with the static names */
+	printk("ACPI: interfaces\n");
=20
 	status =3D acpi_ut_initialize_interfaces();
 	if (ACPI_FAILURE(status)) {
@@ -90,6 +96,8 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_subsystem(=
void)
 		return_ACPI_STATUS(status);
 	}
=20
+	printk("ACPI: all done, all ok\n");
+
 	return_ACPI_STATUS(AE_OK);
 }
=20
@@ -113,6 +121,7 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u3=
2 flags)
=20
 	ACPI_FUNCTION_TRACE(acpi_enable_subsystem);
=20
+	printk("ACPI: enable subsys\n");
 	/*
 	 * The early initialization phase is complete. The namespace is loaded,
 	 * and we can now support address spaces other than Memory, I/O, and
@@ -124,19 +133,24 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(=
u32 flags)
=20
 	/* Enable ACPI mode */
=20
+	printk("ACPI: go to ACPI\n");=09
 	if (!(flags & ACPI_NO_ACPI_ENABLE)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "[Init] Going into ACPI mode\n"));
=20
+		printk("ACPI: get mode\n");
 		acpi_gbl_original_mode =3D acpi_hw_get_mode();
=20
+		printk("ACPI: enable\n");
 		status =3D acpi_enable();
+		printk("ACPI: enable done\n");
 		if (ACPI_FAILURE(status)) {
 			ACPI_WARNING((AE_INFO, "AcpiEnable failed"));
 			return_ACPI_STATUS(status);
 		}
 	}
=20
+	printk("ACPI: map FACS\n");=09
 	/*
 	 * Obtain a permanent mapping for the FACS. This is required for the
 	 * Global Lock and the Firmware Waking Vector
@@ -149,6 +163,7 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u3=
2 flags)
 		}
 	}
=20
+	printk("ACPI: event handling\n");	=09
 	/*
 	 * Initialize ACPI Event handling (Fixed and General Purpose)
 	 *
@@ -173,6 +188,7 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u3=
2 flags)
 		}
 	}
=20
+	printk("ACPI: SCI handler\n");		=09
 	/*
 	 * Install the SCI handler and Global Lock handler. This completes the
 	 * hardware initialization.
@@ -188,6 +204,7 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u3=
2 flags)
 	}
 #endif				/* !ACPI_REDUCED_HARDWARE */
=20
+	printk("ACPI: enable done\n");		=09
 	return_ACPI_STATUS(status);
 }
=20
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index eec263c..f712151 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1105,9 +1105,12 @@ void __init acpi_subsystem_init(void)
 {
 	acpi_status status;
=20
+	printk("ACPI: subsystem init\n");
+
 	if (acpi_disabled)
 		return;
=20
+	printk("ACPI: enable subsystem\n");
 	status =3D acpi_enable_subsystem(~ACPI_NO_ACPI_ENABLE);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to enable ACPI\n");
@@ -1121,6 +1124,7 @@ void __init acpi_subsystem_init(void)
 		 */
 		regulator_has_full_constraints();
 	}
+	printk("ACPI: init done\n");
 }
=20
 static acpi_status acpi_bus_table_handler(u32 event, void *table, void *co=
ntext)


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzrvecACgkQMOfwapXb+vKiiACfZpOVEPRh3atPVCUgPaBYWAdB
V2QAmgM410+42idThRThymgtvn5vRT1V
=04Zt
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
