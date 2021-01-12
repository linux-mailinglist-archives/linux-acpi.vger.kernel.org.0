Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00CC2F2A49
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 09:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbhALIrP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 03:47:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbhALIrP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 03:47:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E2DD22D58;
        Tue, 12 Jan 2021 08:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610441194;
        bh=ciAXMWsi1OyGELvtpt/m0CxKb/Rp63H/1ov/9xDpsh0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dow033TIMEXBUvK39a+HbkQl5oExK3dD2H8Exj34bpAyN3K+YeGOG70iQbSyzOz59
         K+v+e1FOSy3JA2W7gtCTMGyzZfdeaGk9hChJth9En0QvssfkedVOlk1/ZHP6V3hx1x
         +5v7pZOhrffdm+fWLLEuOIhAl1NbhAw9IIDgv3eXALPd1EBSF0P2p8HibvAgeyqJT6
         LXhfpGzcNFBrDAn9txs+Pg8yKuEXGWJctpWyPx9qJIbteSwoRRRwdpD6SRoGLE8gHT
         dE5Z+puoi+dCmOhX7vvpMMXcycTaPz5VvGtkWCJhY3QUj6xEbyrTBMEqKZZye4xRzv
         BeYP7sfjtOP4Q==
From:   Felipe Balbi <balbi@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Remove one more platform_device_add_properties()
 call
In-Reply-To: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
Date:   Tue, 12 Jan 2021 10:46:17 +0200
Message-ID: <87v9c24k6e.fsf@kernel.org>
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

> Hi Felipe, Rafael,
>
> This is the second version of this series. There are no real changes,
> but I added the Tiger Lake ID patch to this series in hope that it
> will make your life a bit easier, assuming that Rafael will still pick
> these.
>
>
> The original over letter:
>
> I originally introduced these as part of my series where I was
> proposing PM ops for software nodes [1], but since that still needs
> work, I'm sending these two separately.
>
> So basically I'm only modifying dwc3-pci.c so it registers a software
> node directly at this point. That will remove one more user of
> platform_device_add_properties().
>
> [1] https://lore.kernel.org/lkml/20201029105941.63410-1-heikki.krogerus@l=
inux.intel.com/
>
> thanks,
>
> Heikki Krogerus (3):
>   software node: Introduce device_add_software_node()
>   usb: dwc3: pci: Register a software node for the dwc3 platform device
>   usb: dwc3: pci: ID for Tiger Lake CPU

Looks good to me.

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl/9YdkRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZP8Q//SjHqtKRaghDM4izhNhkimSEdFbeFCGzK
CmxKzi3ipE+TAXUceA2AEf1fjaVbn4L2yFQvaWx72exq3kco42rjNZMHURS+y0um
zpFsaNsuzUojMJe9nJcOP2or0fU/5bZzl0Dt7FeEtT66wIwhBBW+YeuA5Acb4Cvz
EV3JFq/YrCBoU5aaipyZmjH4E3WS8QWAfN40XkOc8Z5fGLNZ6XcdOyAxvLHX7W0S
M0P1McOUPOA6weaRfbCfwHQ5g1hebPnpK/5kXBr4usxJ9TkjU4mGu3EFYtfhP1aq
pds+DUXzTFnigBspfP/swr8t5lC7Qzqy07G4mKSNU0KnHH7lzrk1UKoKxlI5wy/o
s+PhylYkLmpeoasRQzni6S3n48xxeHuZDWxSHA/NL8jV/J489SahB5qcz9p+omOP
XCMM8Sf7xjSiXTohNw35RxqaAHo8kDJiof1yUSO13s9tpkjb8cSM+9wINGa34EPa
wgZeHLmyMZ+dwMW7o6xoPktvi82ybcAvgpAdwOR4r+1uZGsvxds+EPtSZOI9cnc9
1M8GnD/RnVJ5B2Aj+IZlsFcR3Elumk5NZJeJ/CnuXpBHshlZmStDDekoaZWGAOrd
lK5VkgSUBxzl5hJrvna6MXS4nT3Ji4BWp6yAoykIMuDYjW6rsW0ssHAgk22BOVGC
JQIyOTA7uKk=
=FYgQ
-----END PGP SIGNATURE-----
--=-=-=--
