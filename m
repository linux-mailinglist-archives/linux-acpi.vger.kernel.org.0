Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD532F775B
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 12:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbhAOLPH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 06:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbhAOLPH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 06:15:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D629D235F9;
        Fri, 15 Jan 2021 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610709266;
        bh=5lyd6863Ma27pfAieJ1TVSBg4uSrd4TdeURetyMDZ5s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JgLoSKVFZXEFLeQ9VJ6doX1KcvL+dKiPZU9EI2ux/xHVxXAM8Wa+aE15bjHoQaYYW
         Ni2tuj4Ss0tEMlWy1MvpICkTxMNV719fsug7BBFZ2pkt5TbV4/uZ1eGpHj7y0bNGmR
         gM4QRu7BOGqdp1ZBG5xzoeqWH+rUS0OztIQhO6zKxMQaAihYyKEjIqz6RODX5mtcCp
         vcg64mWL9p8mIgAmANGKAVOeDqqC1F+JEvaMplAXiq7DDoQDuEaPCIY0xNXDkpQc4X
         E5NG/Pkl9QVFpNNMcgXxqoAXrIS59v10bGgympBE9y6NjhHuZjyMlnQTyMZvyQkkTM
         20SIB5W08XuBg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <greg@kroah.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 4/4] usb: dwc3: pci: add support for the Intel Alder
 Lake-P
In-Reply-To: <20210115094914.88401-5-heikki.krogerus@linux.intel.com>
References: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
 <20210115094914.88401-5-heikki.krogerus@linux.intel.com>
Date:   Fri, 15 Jan 2021 13:14:19 +0200
Message-ID: <87sg721mgk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Heikki Krogerus <heikki.krogerus@linux.intel.com> writes:

> This patch adds the necessary PCI ID for Intel Alder Lake-P
> devices.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The only missing my ack:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmABeQsRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbrIQ//ZAxEwchAfysHEqsi/Ie4N1H323D8J3HA
jkOYCv20KTb+uja9TWcp0r5Ef1yQ6ATqc5mheL+R+mVdVQQVpb0rotECK81fArur
BGYPLoR/wRe4yFMff+WuzG3idKaZEcY2lKwQOyClApU4PJpzdg6n36WfQJTzEx6s
WMaQETXakRACSdKY1mop6oMvbElG3Fgd2Da8posUBO00NKVkRpnSd0L339JDrf34
2WH9T/Lc94d1937xM/y4/PrC255vIkwtSYxS1ZwKcCpPIz9/HPpXNAMui2nXjTXT
NuFQ85oIU5R/kMdx3aDvIJ5d2t/vxxHDu6KN7AKdoGsJv+KH35XckCGKMPNl31AU
jei0Eseg20HZyi5aJEQoMLApzCGdLw7IBaDqvTujG9GJZfIJzqX3E5FavepZeO8v
vHT5jqKrzOvKDlSrm8Y53dAjyI+5iKVHXvsYr1vQxVzvp/ocK8SsOfBikEHcFwib
fLCXpg8o2iZ1Z5+MjULUQWVGkr3n8nQA703Ly/8pTWfiFZvfRMb7njxuHONhav4s
Fp3OcHrMmxGRalvVSLu3ngmPDdOiKZZ2ywiCZExF8wx8qWEs2oeywkXXTroEcx1l
7Wmj9UOMKdHhV9+xXOrTeyqr5kAqpO1vcTQ4RNaWYHtWMK1yO517ZmQAzFWBozno
DZcUEyRBYDM=
=ZzEF
-----END PGP SIGNATURE-----
--=-=-=--
