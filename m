Return-Path: <linux-acpi+bounces-10570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA15A0C0FD
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 20:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB991644ED
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 19:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315DE1C5F33;
	Mon, 13 Jan 2025 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6KSLyDf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DE1C5D7E;
	Mon, 13 Jan 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795227; cv=none; b=tiCSBO74Dp/EUp/urjtAFgQzz4dRn8ZhNNzsTAdzw5t9fnK2W1JkePHa4f8Mr3S+nOQ8bRPGd4P2B9PYH7O0JjOT22VpEzOGE5YuWxPA3PqrnQ8bp8id9uHIMSwhiUpw131XvlFzgHFGKoR3UgyZDsbAuu6vIHuuXiJN5FFGKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795227; c=relaxed/simple;
	bh=neSfE58i4fnzsbfa6TYmWzXaNDP/Yd32y1rQtV91eW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOsJrWNAojva9hhn3j6vujtke8lfTYfj6PQpF5gpdPwWDXpiwLu+FpPYXBAkHppspdUEzeLGlMhD/Y3hjXVqZEcIPev5h3WRNssaY5Utsh1GcdDD6alA0BMfuQfpGbKMgpXtz/i2k5v9V6LMBgiksW815GAGJf4EFz/hX/dKC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6KSLyDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB06FC4CEE1;
	Mon, 13 Jan 2025 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736795226;
	bh=neSfE58i4fnzsbfa6TYmWzXaNDP/Yd32y1rQtV91eW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N6KSLyDf2pYBc70KRR6jNY4sLVMoDeZPFrYN6wnczFKfzb3kTjESTzFfwaOsNctWP
	 iCrAesTbmhbgv1K2UpxHrxMPt67ypaJQE5CeFU3TIMD9z258tUIG1jHBg0tC2nxJ6K
	 qvo/fVsfGysrIUeVGxUzaxqJj3wstsczbxmUvnq49sCXJwBZY+sLQ7qglTQng4u3Iy
	 gx610ovumXA5SPw0Du87YLILtmGDzSJIZr+mbdQfk3wMvgC04GXKNCzBgI9D/yBhUb
	 gjoG8aBg1OI6hs+PcgEFdkECDo30hQTiSBPfZZq8T85SHHxUZZ/1mFl0rx2cCH83QS
	 cvzJuluYm8nwA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ebbec36900so2438538b6e.1;
        Mon, 13 Jan 2025 11:07:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVD5M4nwEzVjPNs3+8XY/l/A+bVbA0NinZAfRHqoaQ1Wk+SPE+CBHoRQsmzwjYS1Suv+JmHb95jp0z8zA==@vger.kernel.org, AJvYcCVYkTRbP+3pDiZxau0TNl241Y1/y07HFPOzAY12wTYAy7uoEWBPvjeoRVlxSdBLGZZE8manGzaW5L/ot5nq@vger.kernel.org, AJvYcCX5iOlP2qyBhrv+AoUs/EVLqmUw8fLJ74HWoAgUJNgMWKamo6LwNj2Rtk0dqvs3VQFqAwukuNredzuA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpsu0EeLoOkHVk8IlQsRLghF5V/hKqbLROGRVJDJO/sxXDvXLY
	BUL2eIHxTokDsiLqDb30Jzk0L6aY2FW7UogIl95OHA3BFrX9qQqgifzFduhPsPNFD9F9oEjjZRb
	hfClVXNAntr+85UdTIBEZyt+XZx0=
X-Google-Smtp-Source: AGHT+IE08C/FxLo3ZpxSggNPcZPAjLCK8QFnRSF40ggnf/1vK9DIY7Crnqgiac84GQnJ212zudutnzEBk95Hg/Tx3NE=
X-Received: by 2002:a05:6808:302a:b0:3eb:6e12:add6 with SMTP id
 5614622812f47-3ef2edd3c48mr16715616b6e.31.1736795226111; Mon, 13 Jan 2025
 11:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org> <20250109-dt-type-warnings-v1-1-0150e32e716c@kernel.org>
In-Reply-To: <20250109-dt-type-warnings-v1-1-0150e32e716c@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Jan 2025 20:06:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jfiv3ARnZoAoWPUN57_JTXbV2DFKSy6Qe3PsYTZA7EXw@mail.gmail.com>
X-Gm-Features: AbW1kvYBOkt6jDi8tSDwW-IoHC-bXKPBpv6hTpdd5VQxVporiH-zi1ISEe7_AtM
Message-ID: <CAJZ5v0jfiv3ARnZoAoWPUN57_JTXbV2DFKSy6Qe3PsYTZA7EXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] device property: Split property reading bool and
 presence test ops
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 8:42=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> The fwnode/device property API currently implement
> (fwnode|device)_property_read_bool() with (fwnode|device)_property_presen=
t().
> That does not allow having different behavior depending on the backend.
>
> Specifically, the usage of (fwnode|device)_property_read_bool() on
> non-boolean properties is deprecated on DT. In order to add a warning
> on this deprecated use, these 2 APIs need separate ops for the backend.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please route this as needed.

> ---
>  drivers/acpi/property.c  |  1 +
>  drivers/base/property.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/base/swnode.c    |  1 +
>  drivers/of/property.c    |  7 +++++++
>  include/linux/fwnode.h   |  3 +++
>  include/linux/of.h       |  4 +++-
>  include/linux/property.h | 15 +++------------
>  7 files changed, 56 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 80a52a4e66dd167e70c80a164a89beb8c834ae13..8c53959ee31e700004de098bd=
ab21dec118cf111 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1656,6 +1656,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_=
handle *fwnode,
>                         acpi_fwnode_device_dma_supported,               \
>                 .device_get_dma_attr =3D acpi_fwnode_device_get_dma_attr,=
 \
>                 .property_present =3D acpi_fwnode_property_present,      =
 \
> +               .property_read_bool =3D acpi_fwnode_property_present,    =
 \
>                 .property_read_int_array =3D                             =
 \
>                         acpi_fwnode_property_read_int_array,            \
>                 .property_read_string_array =3D                          =
 \
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 837d77e3af2bd5bf655e6fa0f64c10a05b361b90..c1392743df9c3f6c554f093f4=
efae3ea1ad1fdf2 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -70,6 +70,44 @@ bool fwnode_property_present(const struct fwnode_handl=
e *fwnode,
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_present);
>
> +/**
> + * device_property_read_bool - Return the value for a boolean property o=
f a device
> + * @dev: Device whose property is being checked
> + * @propname: Name of the property
> + *
> + * Return if property @propname is true or false in the device firmware =
description.
> + *
> + * Return: true if property @propname is present. Otherwise, returns fal=
se.
> + */
> +bool device_property_read_bool(const struct device *dev, const char *pro=
pname)
> +{
> +       return fwnode_property_read_bool(dev_fwnode(dev), propname);
> +}
> +EXPORT_SYMBOL_GPL(device_property_read_bool);
> +
> +/**
> + * fwnode_property_read_bool - Return the value for a boolean property o=
f a firmware node
> + * @fwnode: Firmware node whose property to check
> + * @propname: Name of the property
> + *
> + * Return if property @propname is true or false in the firmware descrip=
tion.
> + */
> +bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
> +                            const char *propname)
> +{
> +       bool ret;
> +
> +       if (IS_ERR_OR_NULL(fwnode))
> +               return false;
> +
> +       ret =3D fwnode_call_bool_op(fwnode, property_read_bool, propname)=
;
> +       if (ret)
> +               return ret;
> +
> +       return fwnode_call_bool_op(fwnode->secondary, property_read_bool,=
 propname);
> +}
> +EXPORT_SYMBOL_GPL(fwnode_property_read_bool);
> +
>  /**
>   * device_property_read_u8_array - return a u8 array property of a devic=
e
>   * @dev: Device to get the property of
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index eb6eb25b343bafaa9c03f881b98a528305fa6093..b1726a3515f6fbe13c2186af1=
f74479263798e42 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -677,6 +677,7 @@ static const struct fwnode_operations software_node_o=
ps =3D {
>         .get =3D software_node_get,
>         .put =3D software_node_put,
>         .property_present =3D software_node_property_present,
> +       .property_read_bool =3D software_node_property_present,
>         .property_read_int_array =3D software_node_read_int_array,
>         .property_read_string_array =3D software_node_read_string_array,
>         .get_name =3D software_node_get_name,
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 519bf9229e613906547b57d8c68e7b8558eff327..1b46be88cc0498fcbe74e7b98=
8f22a86245c366e 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -965,6 +965,12 @@ of_fwnode_device_get_dma_attr(const struct fwnode_ha=
ndle *fwnode)
>
>  static bool of_fwnode_property_present(const struct fwnode_handle *fwnod=
e,
>                                        const char *propname)
> +{
> +       return of_property_present(to_of_node(fwnode), propname);
> +}
> +
> +static bool of_fwnode_property_read_bool(const struct fwnode_handle *fwn=
ode,
> +                                        const char *propname)
>  {
>         return of_property_read_bool(to_of_node(fwnode), propname);
>  }
> @@ -1562,6 +1568,7 @@ const struct fwnode_operations of_fwnode_ops =3D {
>         .device_dma_supported =3D of_fwnode_device_dma_supported,
>         .device_get_dma_attr =3D of_fwnode_device_get_dma_attr,
>         .property_present =3D of_fwnode_property_present,
> +       .property_read_bool =3D of_fwnode_property_read_bool,
>         .property_read_int_array =3D of_fwnode_property_read_int_array,
>         .property_read_string_array =3D of_fwnode_property_read_string_ar=
ray,
>         .get_name =3D of_fwnode_get_name,
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 0d79070c5a70f21e9d73751941f28cefb244950d..0731994b9d7c832cae8a30063=
f3a64194e4f19aa 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -112,6 +112,7 @@ struct fwnode_reference_args {
>   * @device_is_available: Return true if the device is available.
>   * @device_get_match_data: Return the device driver match data.
>   * @property_present: Return true if a property is present.
> + * @property_read_bool: Return a boolean property value.
>   * @property_read_int_array: Read an array of integer properties. Return=
 zero on
>   *                          success, a negative error code otherwise.
>   * @property_read_string_array: Read an array of string properties. Retu=
rn zero
> @@ -141,6 +142,8 @@ struct fwnode_operations {
>         (*device_get_dma_attr)(const struct fwnode_handle *fwnode);
>         bool (*property_present)(const struct fwnode_handle *fwnode,
>                                  const char *propname);
> +       bool (*property_read_bool)(const struct fwnode_handle *fwnode,
> +                                  const char *propname);
>         int (*property_read_int_array)(const struct fwnode_handle *fwnode=
,
>                                        const char *propname,
>                                        unsigned int elem_size, void *val,
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f921786cb8ac782286ed5ff4425a35668204d050..1cb4eb7fc2eded2246c697c3b=
caf1b85d43108ab 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1271,7 +1271,9 @@ static inline bool of_property_read_bool(const stru=
ct device_node *np,
>   */
>  static inline bool of_property_present(const struct device_node *np, con=
st char *propname)
>  {
> -       return of_property_read_bool(np, propname);
> +       struct property *prop =3D of_find_property(np, propname, NULL);
> +
> +       return prop ? true : false;
>  }
>
>  /**
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 61fc20e5f81f8da992aa021996ddf68ef3eff0ed..e214ecd241eb4e6d9e0873d09=
4f2c956bbf66c34 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -37,6 +37,7 @@ struct fwnode_handle *__dev_fwnode(struct device *dev);
>                  struct device *: __dev_fwnode)(dev)
>
>  bool device_property_present(const struct device *dev, const char *propn=
ame);
> +bool device_property_read_bool(const struct device *dev, const char *pro=
pname);
>  int device_property_read_u8_array(const struct device *dev, const char *=
propname,
>                                   u8 *val, size_t nval);
>  int device_property_read_u16_array(const struct device *dev, const char =
*propname,
> @@ -54,6 +55,8 @@ int device_property_match_string(const struct device *d=
ev,
>
>  bool fwnode_property_present(const struct fwnode_handle *fwnode,
>                              const char *propname);
> +bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
> +                            const char *propname);
>  int fwnode_property_read_u8_array(const struct fwnode_handle *fwnode,
>                                   const char *propname, u8 *val,
>                                   size_t nval);
> @@ -207,12 +210,6 @@ int fwnode_irq_get_byname(const struct fwnode_handle=
 *fwnode, const char *name);
>
>  unsigned int device_get_child_node_count(const struct device *dev);
>
> -static inline bool device_property_read_bool(const struct device *dev,
> -                                            const char *propname)
> -{
> -       return device_property_present(dev, propname);
> -}
> -
>  static inline int device_property_read_u8(const struct device *dev,
>                                           const char *propname, u8 *val)
>  {
> @@ -263,12 +260,6 @@ static inline int device_property_string_array_count=
(const struct device *dev,
>         return device_property_read_string_array(dev, propname, NULL, 0);
>  }
>
> -static inline bool fwnode_property_read_bool(const struct fwnode_handle =
*fwnode,
> -                                            const char *propname)
> -{
> -       return fwnode_property_present(fwnode, propname);
> -}
> -
>  static inline int fwnode_property_read_u8(const struct fwnode_handle *fw=
node,
>                                           const char *propname, u8 *val)
>  {
>
> --
> 2.45.2
>

