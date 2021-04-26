Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23E36ABB6
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 07:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhDZFEq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 01:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhDZFEq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Apr 2021 01:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B9A461041;
        Mon, 26 Apr 2021 05:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619413445;
        bh=vg9FrcX7fnnWjsfj1DWNcHuEm791l4biO7dyo7VTsiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDNlisuUpVO+CIGUlB4GMvm0jmG7xYLgNg+6EJGgaIMCdiMVgYwjYabyLPCaI2NPM
         4fZ/OqTdlgo22CPWGrDDNTH5YmR/vuMPYZ5yb0L/TP+/qnsAyDqZC+CgZvXLtZT3D8
         7x08pUB+wzpZif4Ez2L5HfaiWt9h8Wpht7R0tTh2axPkfhNQjJ1aKOP+daCpKIyN3Q
         RVGFd0aWLEHXMCmuu0Rjvd1/UY6534/nZOJsPe6e4ldlR/Ho0eXMcIJBmAUrGJnVir
         l+Jugm0ALwpq/kicXz5QONFaQRbQ+nzVAw8c+7ynloB7yi1DD9Y09bmaBUGEHtrVp6
         IAiiKu5oUy8aA==
Date:   Mon, 26 Apr 2021 08:04:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anupama K Patil <anupamakpatil123@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, bkkarthik@pesu.pes.edu,
        gregkh@linuxfoundation.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching
 devices
Message-ID: <YIZJwkux0ghJ8k9d@unreal>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Apr 25, 2021 at 01:13:01AM +0530, Anupama K Patil wrote:
> isapnp_proc_init() does not look at the return value from
> isapnp_proc_attach_device(). Check for this return value in
> isapnp_proc_detach_device().
>=20
> Cleanup in isapnp_proc_detach_device and
> isapnp_proc_detach_bus() for cleanup.
>=20
> Changed sprintf() to the kernel-space function scnprintf() as it returns
> the actual number of bytes written.
>=20
> Removed unnecessary variables de, e of type 'struct proc_dir_entry' to
> save memory.

What exactly do you fix for such an old code?

>=20
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Co-developed-by: B K Karthik <bkkarthik@pesu.pes.edu>
> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> ---
>  drivers/pnp/isapnp/proc.c | 40 +++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> index 785a796430fa..46ebc24175b7 100644
> --- a/drivers/pnp/isapnp/proc.c
> +++ b/drivers/pnp/isapnp/proc.c
> @@ -54,34 +54,54 @@ static const struct proc_ops isapnp_proc_bus_proc_ops=
 =3D {
>  	.proc_read	=3D isapnp_proc_bus_read,
>  };
> =20
> +static int isapnp_proc_detach_device(struct pnp_dev *dev)
> +{
> +	proc_remove(dev->procent);
> +	dev->procent =3D NULL;
> +	return 0;
> +}
> +
> +static int isapnp_proc_detach_bus(struct pnp_card *bus)
> +{
> +	proc_remove(bus->procdir);
> +	return 0;
> +}

Please don't add one line functions that are called only once and have
return value that no one care about it.

Thanks

> +
>  static int isapnp_proc_attach_device(struct pnp_dev *dev)
>  {
>  	struct pnp_card *bus =3D dev->card;
> -	struct proc_dir_entry *de, *e;
>  	char name[16];
> =20
> -	if (!(de =3D bus->procdir)) {
> -		sprintf(name, "%02x", bus->number);
> -		de =3D bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
> -		if (!de)
> +	if (!bus->procdir) {
> +		scnprintf(name, 16, "%02x", bus->number);
> +		bus->procdir =3D proc_mkdir(name, isapnp_proc_bus_dir);
> +		if (!bus->procdir)
>  			return -ENOMEM;
>  	}
> -	sprintf(name, "%02x", dev->number);
> -	e =3D dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, de,
> +	scnprintf(name, 16, "%02x", dev->number);
> +	dev->procent =3D proc_create_data(name, S_IFREG | S_IRUGO, bus->procdir,
>  					    &isapnp_proc_bus_proc_ops, dev);
> -	if (!e)
> +	if (!dev->procent) {
> +		isapnp_proc_detach_bus(bus);
>  		return -ENOMEM;
> -	proc_set_size(e, 256);
> +	}
> +	proc_set_size(dev->procent, 256);
>  	return 0;
>  }
> =20
>  int __init isapnp_proc_init(void)
>  {
>  	struct pnp_dev *dev;
> +	int dev_attach;
> =20
>  	isapnp_proc_bus_dir =3D proc_mkdir("bus/isapnp", NULL);
>  	protocol_for_each_dev(&isapnp_protocol, dev) {
> -		isapnp_proc_attach_device(dev);
> +		dev_attach =3D isapnp_proc_attach_device(dev);
> +		if (!dev_attach) {
> +			pr_info("procfs: pnp: Unable to attach the device, not enough memory"=
);
> +			isapnp_proc_detach_device(dev);
> +			return -ENOMEM;
> +		}
>  	}
>  	return 0;
>  }
> --=20
> 2.25.1
>=20



> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

