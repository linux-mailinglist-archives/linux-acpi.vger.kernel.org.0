Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4436B852
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 19:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbhDZRvV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbhDZRvU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2021 13:51:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D08C061574
        for <linux-acpi@vger.kernel.org>; Mon, 26 Apr 2021 10:50:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p17so1535171pjz.3
        for <linux-acpi@vger.kernel.org>; Mon, 26 Apr 2021 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h9LWCOWHC0GMijbiMtiImgD8ClqnZSAqZ11QuJHpVYk=;
        b=x+SV7A/FAHaPR7u2hfg9wJuW/1PCQpCTHkIC7ZUGfn3XDVyYZIS+7nUQ0jSbszDFF8
         SYvTrRxtrGSYG9B6JEnCyn55lNzNFAnqp30/PhB/6kclCbRbntHDAAunE6nbgSuEVQUD
         7TtW1nvu9l1X0uhwaouiN6PpBEANjB+EZV1cEGG/z0dyhmtzWsFKoRvv5cMx6DAPJpLE
         3qA4uPl3hBxrdntdK+gjkcIT4APhYI9RVLuNc55yfLlkIgbEBMqMjXNryBZQaJSWBShR
         jfiXGK4x5GD7DuOD0eVel9kxjNUSzd8l6rwND7yC35tJm2fgftzzDVIHENqstdOU0reN
         E89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9LWCOWHC0GMijbiMtiImgD8ClqnZSAqZ11QuJHpVYk=;
        b=e00GC0fsCn/TOY0t5uz5xHKy5zY4Xurn1a+0AuZgnSmR30aeO3YrZOdi1d/axqQDwy
         0u69L9sLPsVgHjVnr5hfL5ShO/n8x/73NHBnNYBq6fqIuulq8ndLFmA/luFMhk7HfUKd
         PmM9Knz+EZizBxFncEM6yWf3PosOZUp75kCTKKKDcQ2+HqTJA357lCYrmdGKxUR8Z4Hn
         pDH/iDdrPuPAkdxt3n0pfAEepA7pVPencBxPr3pngJVLDq2c5wrCH7a4zv4SldQkvN0Z
         0jLgOp1ZdQ1b43I9Afo1zkP7v9hF9tnujA2PcoEqNMVahVO5Djgjytg+sdVVeKQm0Hib
         zD6g==
X-Gm-Message-State: AOAM533SlRMm8xPtr1vcnPgeEvD5DcZsspo9LGZF5IKLxBj6NtfBZYXO
        3FVW8VhEmFbVBkZLqsqmjpgBQQ==
X-Google-Smtp-Source: ABdhPJyJSPXoiamrAB1ba5fIYxxiXandhSynW2tRTPiMYBBfIC9rMJz+SxO5CtsFO2VcrFAi6vU+Rg==
X-Received: by 2002:a17:90a:e643:: with SMTP id ep3mr263249pjb.194.1619459438062;
        Mon, 26 Apr 2021 10:50:38 -0700 (PDT)
Received: from localhost ([2406:7400:73:bf98:cdf4:fbe8:4446:3272])
        by smtp.gmail.com with ESMTPSA id r3sm306586pfl.159.2021.04.26.10.50.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Apr 2021 10:50:37 -0700 (PDT)
Date:   Mon, 26 Apr 2021 23:20:32 +0530
From:   bkkarthik <bkkarthik@pesu.pes.edu>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching
 devices
Message-ID: <20210426175031.w26ovnffjiow346h@burgerking>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
 <YIZJwkux0ghJ8k9d@unreal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lavq234wszdgqeqb"
Content-Disposition: inline
In-Reply-To: <YIZJwkux0ghJ8k9d@unreal>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--lavq234wszdgqeqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/04/26 08:04AM, Leon Romanovsky wrote:
> On Sun, Apr 25, 2021 at 01:13:01AM +0530, Anupama K Patil wrote:
> > isapnp_proc_init() does not look at the return value from
> > isapnp_proc_attach_device(). Check for this return value in
> > isapnp_proc_detach_device().
> >=20
> > Cleanup in isapnp_proc_detach_device and
> > isapnp_proc_detach_bus() for cleanup.
> >=20
> > Changed sprintf() to the kernel-space function scnprintf() as it returns
> > the actual number of bytes written.
> >=20
> > Removed unnecessary variables de, e of type 'struct proc_dir_entry' to
> > save memory.
>=20
> What exactly do you fix for such an old code?

I was not aware that this code is so old. This fix was made after checkpatc=
h reported assignment inside an if-statement.
Please ignore this patch if th change is not necessary as the code is proba=
bly not being used anywhere :)

Maybe the code has to be marked as obsolete in the MAINTAINERS file to prev=
ent patches being sent?

>=20
> >=20
> > Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> > Co-developed-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> > ---
> >  drivers/pnp/isapnp/proc.c | 40 +++++++++++++++++++++++++++++----------
> >  1 file changed, 30 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> > index 785a796430fa..46ebc24175b7 100644
> > --- a/drivers/pnp/isapnp/proc.c
> > +++ b/drivers/pnp/isapnp/proc.c
> > @@ -54,34 +54,54 @@ static const struct proc_ops isapnp_proc_bus_proc_o=
ps =3D {
> >  	.proc_read	=3D isapnp_proc_bus_read,
> >  };
> > =20
> > +static int isapnp_proc_detach_device(struct pnp_dev *dev)
> > +{
> > +	proc_remove(dev->procent);
> > +	dev->procent =3D NULL;
> > +	return 0;
> > +}
> > +
> > +static int isapnp_proc_detach_bus(struct pnp_card *bus)
> > +{
> > +	proc_remove(bus->procdir);
> > +	return 0;
> > +}
>=20
> Please don't add one line functions that are called only once and have
> return value that no one care about it.

These were only intended for a clean-up job, the idea of this function came=
 from how PCI handles procfs.
Maybe those should be changed?

thanks,

karthik

>=20
> Thanks
>=20
> > +
> >  static int isapnp_proc_attach_device(struct pnp_dev *dev)
> >  {
> >  	struct pnp_card *bus =3D dev->card;
> > -	struct proc_dir_entry *de, *e;
> >  	char name[16];
> > =20
> > -	if (!(de =3D bus->procdir)) {
> > -		sprintf(name, "%02x", bus->number);
> > -		de =3D bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
> > -		if (!de)
> > +	if (!bus->procdir) {
> > +		scnprintf(name, 16, "%02x", bus->number);
> > +		bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
> > +		if (!bus->procdir)
> >  			return -ENOMEM;
> >  	}
> > -	sprintf(name, "%02x", dev->number);
> > -	e =3D dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, de,
> > +	scnprintf(name, 16, "%02x", dev->number);
> > +	dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, bus->procd=
ir,
> >  					    &isapnp_proc_bus_proc_ops, dev);
> > -	if (!e)
> > +	if (!dev->procent) {
> > +		isapnp_proc_detach_bus(bus);
> >  		return -ENOMEM;
> > -	proc_set_size(e, 256);
> > +	}
> > +	proc_set_size(dev->procent, 256);
> >  	return 0;
> >  }
> > =20
> >  int __init isapnp_proc_init(void)
> >  {
> >  	struct pnp_dev *dev;
> > +	int dev_attach;
> > =20
> >  	isapnp_proc_bus_dir =3D proc_mkdir("bus/isapnp", NULL);
> >  	protocol_for_each_dev(&isapnp_protocol, dev) {
> > -		isapnp_proc_attach_device(dev);
> > +		dev_attach =3D isapnp_proc_attach_device(dev);
> > +		if (!dev_attach) {
> > +			pr_info("procfs: pnp: Unable to attach the device, not enough memor=
y");
> > +			isapnp_proc_detach_device(dev);
> > +			return -ENOMEM;
> > +		}
> >  	}
> >  	return 0;
> >  }
> > --=20
> > 2.25.1
> >=20
>=20
>=20
>=20
> > _______________________________________________
> > Kernelnewbies mailing list
> > Kernelnewbies@kernelnewbies.org
> > https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>=20

--lavq234wszdgqeqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEIRwfsurAmIAiSNrGB1QtCt0juC0FAmCG/WcACgkQB1QtCt0j
uC11vwwAi4ARtpvImmmTw+EvCLEVfj2smNdk3Gxx11VQqDO/9k0Ab/+gmuQabNQO
etGO9SKLY11b2jXhOAklk+O+2aHx7zqcBS+3svTAo591Oy9VYhwE9OsTjG51zQTK
x+wS9NtJyLG3YgrAjRhfeNs+eu3iYO5R3NPP2TEkESFND0B/T66oZ/0/++Idu8tj
pDtWG7ga1DaQrCrMTSBKYIa4pSFDCS3u0trAzvduBhPWDXaXaeGTwjO/a9Wc5RgL
DxkKUQc7RmBOFKr/HjgKOqsbMnDU5c29LZTkka3ZuXq2/2+KXCqHppBdI04ksJad
aZDS2oz3Xc4NrbhR9bW/Q0KaYDwJYXt4SEooS34BKNazq3GvHvVcjfF7ItbQKhqk
74+QgEzhwiaj38fF00OHOu/ygrg6n20QJgsEfpiR7Q2XeABakKkSOXp/9QWZkwKq
0/nQubSy7ANQNZpeVW18dwU71eeAV6D3mi7lZTD+FaHJfkOsh0qKfLDs7qTi0MnF
1nX5yucQ
=SNr5
-----END PGP SIGNATURE-----

--lavq234wszdgqeqb--
