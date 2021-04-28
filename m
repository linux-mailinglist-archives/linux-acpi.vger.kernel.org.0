Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC536D738
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhD1M1G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhD1M1F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 08:27:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750AC061574
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 05:26:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v13so19129734ple.9
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 05:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JMwJGdIWdi7xFwNpnmArqtQaDTr1WwA31fAKNAAW8rk=;
        b=g4S6E2iIm8MCB4dwJ6ei37kjAqFAoDCHFi3jJHulwS8WzpyxNGHQjp894x3tMrS4tY
         QWUalS7ZyNwU269IzdACExyPJUz3pm8F57Obc3r91smrMHhx6ZaRJxvk/9u+aBmQiHVJ
         /FdnwIAgsPxvG08IumSMPR/kJP87mWBfaCG5b8JaoM8tp3aXor9ZUOVeRQWyoy5jIGzd
         0XUF6rrAG755GmkDhrHkjgnjhQEN3ze2YL3z1/kSu+LYNEEtRSRXxHxq9wABuL/UyY/O
         DZvyb2xrcSdxE4t2WkrMuAbb6zx2VkvTUIyYa7u7EO0YhtALoCCKuXgbhcpOJ66Qd6X5
         szuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JMwJGdIWdi7xFwNpnmArqtQaDTr1WwA31fAKNAAW8rk=;
        b=Lo3QHXhcyLbCFMwCVeSQu5NxrCzuXlji1Ay49kbEzhLP+sWt/O4zUy1pPjnGkJCU8u
         /uqfKtJVEoLeM7F9Hgd9nTpChACI/lNPC30v6QqUfQm9CljoSL50hSrJrSAYEfs9eo5a
         WdneQftrL1PcZwHPpdlFXEJfJ5yUyHSljI3fdaprlQhn/bZSQXxMzA7lffuxh92AwA41
         TJQCOT6ANqBpr7ofzN/hB0p11bff3jBqabdwu8ZieEeSzVFZxDshAb9B9qopBrZcPJ9Q
         xXMEiug5M1EhCoQ0+isQrJYlicpiv/vtj3Bao/gioCFKekIX7Rm2lS5gCDmojdpMvY5u
         Ffew==
X-Gm-Message-State: AOAM531XJ4YK0n5vRJKM25xP5qZGfll4it8pmBig06cB70NeDck9CVhU
        sOvr0eBiM0UvD2qFNF8kJjVXzA==
X-Google-Smtp-Source: ABdhPJxSACh2Q/hh5SW1d1jcHyrUztB9sKOmbhZWqtkY8hjbCT6OIFv8P6RQxZpBLnJkxPod7UarPg==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr32225942pjb.191.1619612779607;
        Wed, 28 Apr 2021 05:26:19 -0700 (PDT)
Received: from localhost ([2406:7400:73:8968:d957:fdf:9d7:1a08])
        by smtp.gmail.com with ESMTPSA id c13sm4726982pjv.21.2021.04.28.05.26.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 05:26:18 -0700 (PDT)
Date:   Wed, 28 Apr 2021 17:56:14 +0530
From:   bkkarthik <bkkarthik@pesu.pes.edu>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching
 devices
Message-ID: <20210428122614.xhqgv5bneytooczk@burgerking>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
 <YIZJwkux0ghJ8k9d@unreal>
 <20210426175031.w26ovnffjiow346h@burgerking>
 <59a5d631-6658-2034-06c4-467520b5b9f7@perex.cz>
 <YIlTY8p4kpkORPfl@unreal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cm3rvmjl7mhm5aus"
Content-Disposition: inline
In-Reply-To: <YIlTY8p4kpkORPfl@unreal>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--cm3rvmjl7mhm5aus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/04/28 03:21PM, Leon Romanovsky wrote:
> On Wed, Apr 28, 2021 at 02:04:49PM +0200, Jaroslav Kysela wrote:
> > Dne 26. 04. 21 v 19:50 bkkarthik napsal(a):
> > > On 21/04/26 08:04AM, Leon Romanovsky wrote:
> > >> On Sun, Apr 25, 2021 at 01:13:01AM +0530, Anupama K Patil wrote:
> > >>> isapnp_proc_init() does not look at the return value from
> > >>> isapnp_proc_attach_device(). Check for this return value in
> > >>> isapnp_proc_detach_device().
> > >>>
> > >>> Cleanup in isapnp_proc_detach_device and
> > >>> isapnp_proc_detach_bus() for cleanup.
> > >>>
> > >>> Changed sprintf() to the kernel-space function scnprintf() as it re=
turns
> > >>> the actual number of bytes written.
> > >>>
> > >>> Removed unnecessary variables de, e of type 'struct proc_dir_entry'=
 to
> > >>> save memory.
> > >>
> > >> What exactly do you fix for such an old code?
> > >=20
> > > I was not aware that this code is so old. This fix was made after che=
ckpatch reported assignment inside an if-statement.
> > > Please ignore this patch if th change is not necessary as the code is=
 probably not being used anywhere :)
> > >=20
> > > Maybe the code has to be marked as obsolete in the MAINTAINERS file t=
o prevent patches being sent?
> > >=20
> > >>
> > >>>
> > >>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> > >>> Co-developed-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > >>> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > >>> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> > >>> ---
> > >>>  drivers/pnp/isapnp/proc.c | 40 +++++++++++++++++++++++++++++------=
----
> > >>>  1 file changed, 30 insertions(+), 10 deletions(-)
> > >>>
> > >>> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> > >>> index 785a796430fa..46ebc24175b7 100644
> > >>> --- a/drivers/pnp/isapnp/proc.c
> > >>> +++ b/drivers/pnp/isapnp/proc.c
> > >>> @@ -54,34 +54,54 @@ static const struct proc_ops isapnp_proc_bus_pr=
oc_ops =3D {
> > >>>  	.proc_read	=3D isapnp_proc_bus_read,
> > >>>  };
> > >>> =20
> > >>> +static int isapnp_proc_detach_device(struct pnp_dev *dev)
> > >>> +{
> > >>> +	proc_remove(dev->procent);
> > >>> +	dev->procent =3D NULL;
> > >>> +	return 0;
> > >>> +}
> > >>> +
> > >>> +static int isapnp_proc_detach_bus(struct pnp_card *bus)
> > >>> +{
> > >>> +	proc_remove(bus->procdir);
> > >>> +	return 0;
> > >>> +}
> > >>
> > >> Please don't add one line functions that are called only once and ha=
ve
> > >> return value that no one care about it.
> > >=20
> > > These were only intended for a clean-up job, the idea of this functio=
n came from how PCI handles procfs.
> > > Maybe those should be changed?
> >=20
> > Which code you refer? I see:
> >=20
> >        for_each_pci_dev(dev)
> >                 pci_proc_attach_device(dev);
>=20
> He talks about isapnp_proc_detach_*() functions.

Yes, pci_proc_detach_device() and pci_proc_detach_bus() are both one-line f=
unctions as well.
I don't mean to question working code, we only tried to do something simila=
r here for ISA.

thanks,

karthik

>=20
> >=20
> >=20
> > The error codes are ignored, too. It does not harm, if proc entries are=
 not
> > created (in this case - the system is unstable anyway). We should conce=
ntrate
> > only to the wrong pointers usage.
> >=20
> > 						Jaroslav
> >=20
> > --=20
> > Jaroslav Kysela <perex@perex.cz>
> > Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

--cm3rvmjl7mhm5aus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEIRwfsurAmIAiSNrGB1QtCt0juC0FAmCJVGUACgkQB1QtCt0j
uC2ksAv+JU5viUb1QYtJfkCDGxwTlT3dctCstPQ1rSSs0ca8ixgJCrRD2n8DjVQm
0WTR72ZoD5WFbYsfN2q0zDG1MkHJ4dQ2kzRXr/vy59xN9AlCiPKJ6iXQXgsM4H8c
bAfmLYZIwgJAJ59G3BKWpsLbEwhojvTc1tcnGpObk5oNRouaVSi6UnO/+kFyChpJ
M+OlhoJMr64WukQskSu3fKXXzou4DAA6Dzii4JkMssC08RMumf/fReCovkDzDmry
l5wNi0MHzgBPMISCRjHwHUVId2LL8reqib8gZJ6Ok6ILln1qI00jJJChjKhHL3TU
FY8MlWCXz/uW6lwWHiHP00ioeoU2u+IQqifQqd9gQzucp1Ekxw4QQDiDTReT4ob4
FMYo2cOaJm1uLDWKfmamIp6ZCHM7Om1aSms6oOq8F5OzK+VHvUs+9kPiqN9opIf6
/6FM3LyytWxsKAd7NQdI95OLC7EvBMu3iJRNOYj/eCXys8EkfGkff9mCAAnDySjN
S36lDsFk
=VxVi
-----END PGP SIGNATURE-----

--cm3rvmjl7mhm5aus--
