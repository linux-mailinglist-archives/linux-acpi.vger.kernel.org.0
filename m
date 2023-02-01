Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE19685D30
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Feb 2023 03:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjBACMh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Jan 2023 21:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjBACMg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2023 21:12:36 -0500
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913ED59E57
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jan 2023 18:12:20 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id CFC962F20227; Wed,  1 Feb 2023 02:12:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
Received: from localhost (broadband-188-32-10-232.ip.moscow.rt.ru [188.32.10.232])
        by air.basealt.ru (Postfix) with ESMTPSA id 331322F2022B;
        Wed,  1 Feb 2023 02:12:16 +0000 (UTC)
Date:   Wed, 1 Feb 2023 05:12:13 +0300
From:   "Alexey V. Vissarionov" <gremlin@altlinux.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lvc-project@linuxtesting.org,
        gremlin@altlinux.org
Subject: [PATCH] ACPI/IORT: Increase allocation size up to sizeof(struct
 acpi_iort_node)
Message-ID: <20230201021213.GC446@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The node is a pointer to struct acpi_iort_node, so it's just 4 or 8
bytes, while the structure itself is several times bigger.

Found by ALT Linux Team (altlinux.org) and Linux Verification Center
(linuxtesting.org) using SVACE.

Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>
Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")

---

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 38fb84974f352cc8..edb94b52bf3a21ce 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1832,7 +1832,8 @@ static int __init iort_add_platform_device(struct acp=
i_iort_node *node,
 	if (ops->dev_add_platdata)
 		ret =3D ops->dev_add_platdata(pdev);
 	else
-		ret =3D platform_device_add_data(pdev, &node, sizeof(node));
+		ret =3D platform_device_add_data(pdev, &node,
+						sizeof(struct acpi_iort_node));
=20
 	if (ret)
 		goto dev_put;



--=20
Alexey V. Vissarionov
gremlin =F0=F2=E9 altlinux =F4=FE=EB org; +vii-cmiii-ccxxix-lxxix-xlii
GPG: 0D92F19E1C0DC36E27F61A29CD17E2B43D879005 @ hkp://keys.gnupg.net

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJj2cp9AAoJEFv2F9znRj5KqrIP/0Hemgf7fBCwiUf7whyI7mbB
sNZXvAbeawNfI5PIDo2h0hEQvzv/KQqn2sGCOcDkotmUTOgyJJGHxI8vJS0behVF
uVqKMxIVNqtEBabOCqMF+cIpYZxW3UWBHm7WIRIycAebTpCh0ORgodVdAbyQjFJo
VDHkVAFfzhfGtocUKWw1w910AfTb1/xvQ6AkoHZHCRvx3rz+m0u2JiK9xgXFIKWN
Guemhvc6cH8q10LQto5giQ9LkhLLLOMqze3sVBvHYOm3aM7FXaB0xRz435QVa3BO
f1OiPaPQzOXa/6Q4lqR0jEI2ZLuI0sY17O9CpZJof5XXtNmMNudU+GkyfYEBSRO5
VchFXJK9+sYORfWXeWHFExQ0ptvRMnDFpSbzw0oNfgZpnkk5KkIpG2pAU2QSHXyQ
86ZUuDn6aE5UX0hAbsHboXzMG5Fzrhq6Jy1gLr3eg5hauiSaLJo9woa999GK+ALt
mtMKJyqyklsw7BORXgrEAL97L0peFO6EH8gmb27Vz9UgdQvaq8PnJ8QQ2MNVOn4P
hXWFca8lAGcWxUSosCOTqoiuExxSmM2cCKKA1rwIcP6k6m4aB4XKmn8qv8ZzfUeG
iQ7ol8Gkc5MA8snljL5AexPYNllXe+N7/Q1GjEu7lvqr28/yo/hixOUU7PKXQWSW
0kSeYop6dX5tEg/aiU6d
=LSvi
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
