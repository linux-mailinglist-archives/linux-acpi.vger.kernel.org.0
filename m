Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5263774B42
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 22:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjHHUoG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 16:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjHHUny (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 16:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65097271E
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 13:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 266AF62C35
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 20:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7A3C433C8;
        Tue,  8 Aug 2023 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691525937;
        bh=6gqxv3INJ4ZEPQUhaCDLMY1vc1+DCDuzEt5dPGtJ1+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/SHK5AFiK0O/Gw3/v/gSIk7JXcCZ+0vg19bAY4K12i7wUZid5gbADrK4M5de8csD
         LVi8AvFnNShG8Pi6Ev45b1t5TKSRQR7CZqFWAWU26uY4pVSjMmuViK7iRiiRKsTN70
         AbPVakgvZVWLuK1zQGW1O2t0qG5zvyCz2NtscFBTI6pi9oI+SaLtZGjKiBz2bfka9y
         0lgWeFsvdgrRoPbSm3pQHndRrmTLa0Ynf2s+Bn/WlsVISnOv4wLtVrCyO7YbXCt4Gi
         bNDl+spkueePYxELzFMHEDWDl82ond1MXWLkX6lLmA5hWRAiWGgMTt7F4sIymusgtl
         Owv0DTjK6Qh2Q==
Date:   Tue, 8 Aug 2023 21:18:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen-Yu Tsai <wenst@chromium.org>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 0/3] Fix device_lock deadlock on two probe() paths
Message-ID: <0bf0557d-1dd9-45e7-a4a3-8b2527eeff7e@sirena.org.uk>
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aKHBjBx3iwUEeJQb"
Content-Disposition: inline
In-Reply-To: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
X-Cookie: Every solution breeds new problems.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--aKHBjBx3iwUEeJQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 02:27:04PM -0300, Jason Gunthorpe wrote:
> I missed two paths where __iommu_probe_device() can be called while
> already holding the device_lock() for the device that is to be probed.
>=20
> This causes a deadlock because __iommu_probe_device() will attempt to
> re-acquire the lock.
>=20
> Organize things so that these two paths can re-use the existing already
> held device_lock by marking the call chains based on if the lock is held
> or not.
>=20
> This is an incremental on top of Joerg's next, but it could also be handl=
ed by
> respinning the last patch in that series. Please let me know.

The issues this series fixes have been causing quite a bit of breakage
in a range of CI systems (Arm's internal stuff, KernelCI and my personal
CI).  Both the KernelCI bot and my colleague Aishwarya (CCed) bisected
which pointed to this series so I've tested them - I didn't cover every
board but this does fix at least some boots so:

Tested-by: Mark Brown <broonie@kernel.org>

It'd be great to get these fixes into -next, thanks for getting the
patches out so quickly.

--aKHBjBx3iwUEeJQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTSoyoACgkQJNaLcl1U
h9CW0wf/W/pjGFGgTE9Wf1ci+gK1RanzAa19FUc2aRHQYrX8ws2pBOc6zyWUQkBH
0618UoxVmI/2jQ8wJwzgg7ALPpraXosFv1p0me2ZS6p+QgVr1jJvDWlS3hgloSIP
623DAAumHbxOmQUOS75R9pNJKRWIkneUV22QLvR9E6CYzGfgfjBHkZaj/vQYaVW4
AYkLVM9Ene2HH5u0qZyXSrZagjOm4YP+4JRkCz3s8rqV/Ez6OmyHw3Fvuj9Tj5Sy
DomWIrwrTTYDSF/p6cFMa3OrRub99EgeAbG/ibNN+g1B5tyJRXVSbxqqSOfcz8T1
9ofA7D6mY5sCdIxZ8wS3svw9tOhLeQ==
=dkd2
-----END PGP SIGNATURE-----

--aKHBjBx3iwUEeJQb--
