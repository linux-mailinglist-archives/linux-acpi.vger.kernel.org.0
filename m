Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82EA49EC82
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jan 2022 21:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiA0Uhw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jan 2022 15:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiA0Uhw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jan 2022 15:37:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602C0C06173B
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jan 2022 12:37:52 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so2905741pjb.5
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jan 2022 12:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5zRPiVXKQJnIvFiBGkHq6ju0/RKXpE5LqP8JIErA6+A=;
        b=CfT0fWYKB1hO4qQ9GV8xmqubclF/fIkanpe1lgeduXWSr/koO+yz/w6mA29iz7IzTq
         R7GscS3dUrZggCzr7Ne0/xMf0PF/tp7B5Lw31/3NBxoSsZSjvGw981Rnn/1bbwJLDY7T
         yViu+tcFBnzRPfpWnu0WJj1e2lmZd/6BqYWdS4GWbSK7RgReFr2aMWilBPIk0NtxcZgZ
         7pFUncOJzYQ334RFLv1ajP3sbXZ7wHxTezLe0stlt1is0bwQ5tbUJNBprVnrwMYKGOBf
         OFG0Vim+aAwy6vIaDI80pZsEp4Z0N5esaw//uvE/JBJqsizf+GEG60n9/OL7flYy0dP8
         o1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5zRPiVXKQJnIvFiBGkHq6ju0/RKXpE5LqP8JIErA6+A=;
        b=KNK5c0/ETNhDL9Z4gGrFM6FlxA0N2pjSWhtQ8mCqhj5UebwUoG7OAKe0Nf42sGfkV4
         yN/jCWShMhNz1tuj1KykJCzCgLEtgEYEUAH3r9KQZDn0rkU91nYdOVV0+oszKcP469ll
         oExbw78UzfKE2S9r5vVK1EyduSej9ydgMhNeP8gvKSvZqaFG+lcl6DwBdJZBhbRGS3cz
         bzj5vWrbLC82S7wbpouHlKirKQWC/ujOTlXDJQmRq1pXLtBiJfWjzEjxLN5Vze/38Wni
         7FRFgJ9mGkB3vmezNY+uX4WctrDeeVsxn+pBYv/HRQuoOOnsNtg83qxliyc+BlwEETmE
         2LSg==
X-Gm-Message-State: AOAM533lzsjwjsB94hMvWxNyYdYwkEglgh6xVsfqwlqJ22dN13emN8AY
        viiwgoBNdp30ymEVtbObIGNEVY+Y4EwyqQ==
X-Google-Smtp-Source: ABdhPJwvlYs9JcL+IH0gEFUp/iIZnp+yfrLv4nYE7ef/xpEhywq4U47rREEBrntl66R10kQ6zqL/4w==
X-Received: by 2002:a17:90a:39c6:: with SMTP id k6mr15969349pjf.194.1643315871478;
        Thu, 27 Jan 2022 12:37:51 -0800 (PST)
Received: from google.com ([2620:15c:202:201:7713:237d:48f3:f690])
        by smtp.gmail.com with ESMTPSA id j6sm6992623pfu.18.2022.01.27.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:37:50 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:37:44 -0800
From:   Benson Leung <bleung@google.com>
To:     Won Chung <wonchung@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: device_sysfs: Add sysfs support for _PLD
Message-ID: <YfMCmCb47zocYXCA@google.com>
References: <20220126235807.3164317-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yN0c5RbogYywFKuv"
Content-Disposition: inline
In-Reply-To: <20220126235807.3164317-1-wonchung@google.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--yN0c5RbogYywFKuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Won,

On Wed, Jan 26, 2022 at 11:58:07PM +0000, Won Chung wrote:
> When ACPI table includes _PLD fields for a device, create a new file
> (pld) in sysfs to share _PLD fields.

If you're adding a new attribute, you should also update the Documentation
file here: Documentation/ABI/testing/sysfs-bus-acpi

Thanks,
Benson


>=20
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
>  drivers/acpi/device_sysfs.c | 42 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index d5d6403ba07b..8d4df5fb1c45 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -509,6 +509,40 @@ static ssize_t status_show(struct device *dev, struc=
t device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(status);
> =20
> +static ssize_t pld_show(struct device *dev, struct device_attribute *att=
r,
> +			char *buf)
> +{
> +	struct acpi_device *acpi_dev =3D to_acpi_device(dev);
> +	acpi_status status;
> +	struct acpi_pld_info *pld;
> +
> +	status =3D acpi_get_physical_device_location(acpi_dev->handle, &pld);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	return sprintf(buf, "GROUP_TOKEN=3D%u\n"
> +		"GROUP_POSITION=3D%u\n"
> +		"USER_VISIBLE=3D%u\n"
> +		"DOCK=3D%u\n"
> +		"BAY=3D%u\n"
> +		"LID=3D%u\n"
> +		"PANEL=3D%u\n"
> +		"HORIZONTAL_POSITION=3D%u\n"
> +		"VERTICAL_POSITION=3D%u\n"
> +		"SHAPE=3D%u\n",
> +		pld->group_token,
> +		pld->group_position,
> +		pld->user_visible,
> +		pld->dock,
> +		pld->bay,
> +		pld->lid,
> +		pld->panel,
> +		pld->horizontal_position,
> +		pld->vertical_position,
> +		pld->shape);
> +}
> +static DEVICE_ATTR_RO(pld);
> +
>  /**
>   * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
>   * @dev: ACPI device object.
> @@ -595,6 +629,12 @@ int acpi_device_setup_files(struct acpi_device *dev)
>  						    &dev_attr_real_power_state);
>  	}
> =20
> +	if (acpi_has_method(dev->handle, "_PLD")) {
> +		result =3D device_create_file(&dev->dev, &dev_attr_pld);
> +		if (result)
> +			goto end;
> +	}
> +
>  	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
> =20
>  end:
> @@ -645,4 +685,6 @@ void acpi_device_remove_files(struct acpi_device *dev)
>  		device_remove_file(&dev->dev, &dev_attr_status);
>  	if (dev->handle)
>  		device_remove_file(&dev->dev, &dev_attr_path);
> +	if (acpi_has_method(dev->handle, "_PLD"))
> +		device_remove_file(&dev->dev, &dev_attr_pld);
>  }
> --=20
> 2.35.0.rc0.227.g00780c9af4-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--yN0c5RbogYywFKuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYfMCmAAKCRBzbaomhzOw
wv/lAP0fZ4J1IJCrLit7NHh8xFteID06c/Ga76+iIXX+6x6MjwEAox9Fhj77FOn1
QH3TPybVr1ADTo0TiUmRtUQbDxVpfAA=
=c5Dl
-----END PGP SIGNATURE-----

--yN0c5RbogYywFKuv--
