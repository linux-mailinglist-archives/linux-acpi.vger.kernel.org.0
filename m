Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB37836D611
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbhD1LGZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 07:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhD1LGZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 07:06:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC74C061574;
        Wed, 28 Apr 2021 04:05:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z16so3538334pga.1;
        Wed, 28 Apr 2021 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=dSYE6S+BpcUBKa5NtVmSI9y2K7ZECLccftb7NzlWRZE=;
        b=oIOW/P3gGCyaEqya8fliX+TX43gs9Q2ndvIvEnfrvXUadpI5OM4++NdTiata6lwF2z
         mLMHZ655n1yfiZe9DI62+sYYeLXTd5Mgj8DYpq35xSamKlAmbhA1IDy4hqjrTCmffFfv
         zT1YP0HEcPvTyOecQTG/mnHLYnrmDCzAkMW9a1Uq0+GmLqBuOB/l4y2IS8Dvpp56Jbmz
         eDjW6pPiNunG+GP21mMjEVPR11b03FXoe2CaecVnLmi7Gi9tW7YhtEm0mscfNP7mmsdJ
         pBzX6eEafuzoUL7NuNguVVCwHrmvTJW5hgDVZHQzJhUWVXtsz96OSaB18f5cX6U9qnl3
         RJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=dSYE6S+BpcUBKa5NtVmSI9y2K7ZECLccftb7NzlWRZE=;
        b=Fu6xG8BZ4RzIzVutIfHC8qPwVpP+VGP+qPZTpJ0VztJnyeD/K0r1xZZCo7qjultcCI
         9LI8sPQ1muGKNgZyFS19oVroOz4BlNIH8cz+saXvnlfAhcVFKN9My+6B3u1kjjnI/8tV
         BBOzrtOw/YzAZ7CxpoLYIGKzelzTzbdexERRnaSl75Lbckf0M5zxlLv3pYgAjLL92new
         DbKlpRDS5yp5WKAeWPyc05lRx5/z3t8LaooC8zaJdJVvE6N5Qlsve87frCD1AWL4jluT
         N3EL2TL0zJwFD8w1qAP4W1gsAnAH3LJuRNxuxDIE1ib34xk6cwN/Y8pXXea7N84jhbDX
         dM4w==
X-Gm-Message-State: AOAM531XHwMyEEvy0+TY8FGDg9TkzoFl4S6AdvrTqSmfRf1omZt/VrUD
        hp5FR9tUKI5DSt//AA8ecVU=
X-Google-Smtp-Source: ABdhPJz8ad6L51o3pgxkW3+IWNyWQ82AvlbD/fnyXCK4Y5OEk+0tTQ3oVCigyh9ts7CTLJvVmR1/eA==
X-Received: by 2002:a62:d409:0:b029:27d:338:1cca with SMTP id a9-20020a62d4090000b029027d03381ccamr2689145pfh.25.1619607940314;
        Wed, 28 Apr 2021 04:05:40 -0700 (PDT)
Received: from localhost ([122.172.37.94])
        by smtp.gmail.com with ESMTPSA id f18sm5749098pfk.144.2021.04.28.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:05:39 -0700 (PDT)
Date:   Wed, 28 Apr 2021 16:35:36 +0530
From:   Anupama K Patil <anupamakpatil123@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Leon Romanovsky <leon@kernel.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        gregkh@linuxfoundation.org, kernelnewbies@kernelnewbies.org
Subject: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <20210428110536.edy74gsobkgtd6al@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vgvwmq3n6vsc46qh"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--vgvwmq3n6vsc46qh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

isapnp code is very old and according to this link
https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
=66rom Wikipedia, even Windows Vista disabled ISA PnP by default.

This change is in follow up to
https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u

Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04e7de8c95be..215e05d93c60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9534,7 +9534,7 @@ F:	drivers/media/radio/radio-isa*
=20
 ISAPNP
 M:	Jaroslav Kysela <perex@perex.cz>
-S:	Maintained
+S:	Obsolete
 F:	Documentation/driver-api/isapnp.rst
 F:	drivers/pnp/isapnp/
 F:	include/linux/isapnp.h
--=20
2.25.1


--vgvwmq3n6vsc46qh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEDSQZGCDcREXgcOjQtGmOOZV75b4FAmCJQXoACgkQtGmOOZV7
5b74uAv+I+Ww6fdeCEYtqOmZqkH/uUxw9jCrzuhGxB4i2kuf+BCO5QQyWjaRde32
Vf1BBYKkNjpjE4l8xQmWGfjKDna8C+t4MBjxM6aZt+xg5XtxmQEriSeoHMlj+C87
1DUE66IDOxFnn5K2Wv7MPdXy24QTrPe19O3YJVUTeuQLHOZpUGvjHWvwxuL8xhgK
PSPqCHes8ud1rP+wJd+RrtCIdNkC/TUGEEB/oeFPNiBocLys2kA1cE0TXdyVPaBG
+b9BxItUEW3FIganxoXvmQ/xf8yyducadx27TcGOEuiNLxEBwbOTpmL8hYb/Ea0F
U2L6q4fjEDThyz2wXCe0qOAl7tE4pu9wb/vy6ctfR1ZBMDmQuXp07gU3+MiLZXhV
jNdxa3kClq0ssN5mWYfdM61ZgF556HFNCMxGpoEcLwYQqcHEkqucsQx6c9zpNBEB
sS0n8N5JV1P68E9S1bIZOvG+e6kskRYxaIBaYuI5YHE/OVCfbU96YJWSxWnsUZYC
l91RsqBD
=qVfS
-----END PGP SIGNATURE-----

--vgvwmq3n6vsc46qh--
