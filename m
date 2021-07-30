Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304F23DB825
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jul 2021 14:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbhG3MAy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Jul 2021 08:00:54 -0400
Received: from mx1.emlix.com ([136.243.223.33]:42230 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238275AbhG3MAy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Jul 2021 08:00:54 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2021 08:00:54 EDT
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id D26EE5FCF2;
        Fri, 30 Jul 2021 13:52:05 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     linux-acpi@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH][RESEND] tools/thermal/tmon: simplify Makefile and fix cross build
Date:   Fri, 30 Jul 2021 13:47:20 +0200
Message-ID: <2149399.oOxd0sxVbX@devpool47>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1627647755.ozqCpXpxaW"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--nextPart1627647755.ozqCpXpxaW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Markus Mayer <mmayer@broadcom.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH][RESEND] tools/thermal/tmon: simplify Makefile and fix cross build
Date: Fri, 30 Jul 2021 13:47:20 +0200
Message-ID: <2149399.oOxd0sxVbX@devpool47>
Organization: emlix GmbH

Hi,

cross-building tmon can fail because it uses the non-prefixed, i.e. host, p=
kg-
config.

If you prefer a merge the code is also available at:

   https://github.com/emlix/linux thermal-makefile

Would be nice if someone could finally pick this up, it's almost 3 years no=
w=E2=80=A6

If someone knows anyone who better fits into these reviews please add CC's,=
=20
sadly tools/thermal/ is not covered in MAINTAINERS.

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart1627647755.ozqCpXpxaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYQPmyAAKCRCr5FH7Xu2t
/KiQA/9XUdQ7eHdvuapPVi/2sSmpiKJLcHuP6Fr52fB14b3f9Ssi1PuMht1fhkyy
JoesrKMRsxZJ0PBVNpUKshgRtZqKnvvDcb4lAdhWYCR2Qm/udbqpA3UwNLXO1H29
8M4RPfXxPjuxH+Q/PG/dGvNRKdHXJp9nKcIsU5tC1SkiFGc13w==
=XbLH
-----END PGP SIGNATURE-----

--nextPart1627647755.ozqCpXpxaW--



