Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D399527A45C
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Sep 2020 00:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgI0W1q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Sep 2020 18:27:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33730 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgI0W1p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 27 Sep 2020 18:27:45 -0400
X-Greylist: delayed 2219 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 18:27:45 EDT
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1kMeZA-000857-4l; Sun, 27 Sep 2020 22:50:44 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1kMeZ9-001BJl-02; Sun, 27 Sep 2020 22:50:43 +0100
Date:   Sun, 27 Sep 2020 22:50:42 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-acpi@vger.kernel.org
Cc:     971058@bugs.debian.org, jim@photojim.ca
Subject: [PATCH] ACPI / extlog: Check for RDMSR failure
Message-ID: <20200927215042.GA281693@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

extlog_init() uses rdmsrl() to read an MSR, which on older CPUs
provokes a error message at boot:

    unchecked MSR access error: RDMSR from 0x179 at rIP: 0xcd047307 (native=
_read_msr+0x7/0x40)

Use rdmsrl_safe() instead, and return -ENODEV if it fails.

Reported-by: jim@photojim.ca
References: https://bugs.debian.org/971058
Cc: stable@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/acpi/acpi_extlog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f138e12b7b82..72f1fb77abcd 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -222,9 +222,9 @@ static int __init extlog_init(void)
 	u64 cap;
 	int rc;
=20
-	rdmsrl(MSR_IA32_MCG_CAP, cap);
-
-	if (!(cap & MCG_ELOG_P) || !extlog_get_l1addr())
+	if (rdmsrl_safe(MSR_IA32_MCG_CAP, &cap) ||
+	    !(cap & MCG_ELOG_P) ||
+	    !extlog_get_l1addr())
 		return -ENODEV;
=20
 	rc =3D -EINVAL;

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl9xCS0ACgkQ57/I7JWG
EQmC9hAApmEJU8xc2QiNwsCSfISziRSAoZcN1x6PNqLyiep2ZCQDpr82OYrrTVZx
Z6lrCaOssmplxfbeNstgIlxedDSpydwHyF8vZPa5PYF7hcWukufBf1BQbPNIYVmN
7CeWsIq/jjPA+EAr4kk+Ugrl8R5X+UjpLkjt7eVffiC+P8wUpJqenH21RNN/tURk
O/6SkXkywit/nXUotGmEceZWkf2dozs6BQ/VtZNjSDE8jYHjWxcVfCg2oCJ2zLsw
4LZsbitO2GH3AFd+goQKQ1yS7hjMbsg6D/zRMbdb1OHsF/bJOGBCgzW7mluZny5b
RN3zrBFRNXt1Ch0IPO5KurVUHj8VSAk7IzVPkGYTP/hD6NoZja5j5vijx1SIkGUd
zoNtN5AcW4Jp1DP17RgwApWTTZTCEA3wcRaR6JC1e6GtOaqMAMszwAIQgxVtKOWM
PSCOgJ3Pp/1Opw8ioO87tzYR7Mhhfmm5sQmFXi67oP6QOCuElzjVrGwW4MnjTVGp
Zw+zcszjj62M1Fpj+YCLLULLPB0tKBfdcedKsqi9TRNWJ8ORFKKaWqlHgBWmqcNy
RCVY+6w6N+ivG5yxKO9q+AxB4jxAHMouK31MLImKSgqIe087c9IwLxFG/CJUdQRP
tBw/qtj/ef0GkjDWUUGVX8r7prD1kusypRI7H7jJJiTeLxl2m+o=
=kp79
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
