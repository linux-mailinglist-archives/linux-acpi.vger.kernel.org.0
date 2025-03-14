Return-Path: <linux-acpi+bounces-12261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F853A61C34
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 21:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FBE7A8C83
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 20:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E492054FF;
	Fri, 14 Mar 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWvsYNgj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB7204C2B;
	Fri, 14 Mar 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983191; cv=none; b=F3ASRmYkLdwjHawYTkiMzytutqBuvnZrTO/bnxMgSmjCGZDDkecsGW8XzM1PKnIDMlVAloZjdwHd+IhqdQhKLgJIfT+DNKd3xSy3UEeGLWh8ZSIDCbrBmJmLpk07x16cVfVD74BIm3ufyr5nvyht3SSeZLyI733sZjKUS0Eg8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983191; c=relaxed/simple;
	bh=SRZhjkmehzZBEvC3oDCw/sRygUrcVGuFKOmk99vqfVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raVNpsp4hTo575/HwswrsRqC5n3V1BcbgSHngEyIj1IOikCUyB/Ernh1p+zVjxa4e0Mb1F1tT3mCI0wBfHyFfJ0iKoaDT0hnyP5Fg8xuhGAfCEnpx8jYkaw11Y7QrmKp7EKsGnFFmgAFhq1/CZLsb1xXYqU+YMOtsOqWaD0KzaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWvsYNgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80F2C4CEEF;
	Fri, 14 Mar 2025 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741983190;
	bh=SRZhjkmehzZBEvC3oDCw/sRygUrcVGuFKOmk99vqfVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZWvsYNgjITiLsZdrePpvv4CT67dqQ6hEUqye9FvJRdvxZ4W+chZq1KUDQ7O3O+Twp
	 fKGNbDqle/CKOZLWFonJrcvM5Sol34jmlJwin6l83EvVNpbBSYmlokZc7FBdY+S/Ls
	 zYfXxQj7mCTcBDYyrdgXg/BgSbr5hMDxm+SM1VP+3K51nlcHr2GyTNPrQChuhriHFX
	 qOsnM/2tzA7JEVWGgW3N1b3tDR1SqLy2gvUbxkj772PlP0bBAw1vZz2pDqj8d80/py
	 XvszV+FY7hxcPzkmBG7Bf3dynEYkLZ7MK5dUxKoT95i7XPXr6/zYZWGueEfu/zAhQW
	 LrTHZLyEZWIEg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bcbd92d5dbso1351142fac.2;
        Fri, 14 Mar 2025 13:13:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUez7rHefhnujfUf3IMtcQa+Ox64l3KNAoJX7b/yqSs4k/uCZTTs6aoXt5TnSEioEQIhtARI+KHktgTiw==@vger.kernel.org, AJvYcCVT52RWW1Zfekt/Pv9Fz+juHLLu+/dTnYhDBUDoLP1ld90KI5VD311DN93ktU2Ac57O88VLjB1PMFMB@vger.kernel.org, AJvYcCWdXzryswf4rnCdxy5j1eZiY1VOolDlFfXxY7AtxwyFIOpgs1FFYoH05Nhrqa0RTzvOciG/kITJ6Ijbptyp@vger.kernel.org, AJvYcCXdMHgn7g7t/gyHeQIfcMwu4vXoysCtkkL/7bxGLGwjMBjrn1CbJpq8jwsEzFjEA445hpoPBOQuL02P@vger.kernel.org
X-Gm-Message-State: AOJu0YxJC6k+K48IlWTY4JFtFObvDGGFmD3eIieIy0UIFS2FbamAo92O
	CQB8c5RIyIseOuh9Nec8mHH6Vq7++uLbOTDt6MLKU241qyu/kK6OQ1yj2VNJj/tWBQa/PhYbKYN
	D31Kfu2Lq6tfkmSMAmqd3dsD5CDo=
X-Google-Smtp-Source: AGHT+IGmABUgq93wpmmAX1OWd3S8vWyNXtmmbOZA3gPdYnN68o8ZqrNHt+4lqcxj/RC+Zxg7dvl5ge06ELPI4Pgy6zA=
X-Received: by 2002:a05:6871:4145:b0:2c2:5028:70bd with SMTP id
 586e51a60fabf-2c691140b7fmr2149180fac.24.1741983189940; Fri, 14 Mar 2025
 13:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com> <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Mar 2025 21:12:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ia-K1bPT-A3TbmZ6T18nbrJ8aUsdU2zbbTfvS0eGbwOw@mail.gmail.com>
X-Gm-Features: AQ5f1JpD27XX7GKH0JoAJhN4-R5SwlqrRghlvbqZvTkUxcM_j5DPO_HuD4OL0N4
Message-ID: <CAJZ5v0ia-K1bPT-A3TbmZ6T18nbrJ8aUsdU2zbbTfvS0eGbwOw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] device property: Split fwnode_get_child_node_count()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rob Herring (Arm)" <robh@kernel.org>, 
	Markus Elfring <elfring@users.sourceforge.net>, Jakob Riepler <jakob+lkml@paranoidlabs.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 4:08=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The new helper is introduced to allow counting the child firmware nodes
> of their parent without requiring a device to be passed. This also makes
> the fwnode and device property API more symmetrical with the rest.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/property.c  | 12 ++++++------
>  include/linux/property.h |  7 ++++++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c1392743df9c..805f75b35115 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -928,22 +928,22 @@ bool fwnode_device_is_available(const struct fwnode=
_handle *fwnode)
>  EXPORT_SYMBOL_GPL(fwnode_device_is_available);
>
>  /**
> - * device_get_child_node_count - return the number of child nodes for de=
vice
> - * @dev: Device to count the child nodes for
> + * fwnode_get_child_node_count - return the number of child nodes for a =
given firmware node
> + * @fwnode: Pointer to the parent firmware node
>   *
> - * Return: the number of child nodes for a given device.
> + * Return: the number of child nodes for a given firmware node.
>   */
> -unsigned int device_get_child_node_count(const struct device *dev)
> +unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwn=
ode)
>  {
>         struct fwnode_handle *child;
>         unsigned int count =3D 0;
>
> -       device_for_each_child_node(dev, child)
> +       fwnode_for_each_child_node(fwnode, child)
>                 count++;
>
>         return count;
>  }
> -EXPORT_SYMBOL_GPL(device_get_child_node_count);
> +EXPORT_SYMBOL_GPL(fwnode_get_child_node_count);
>
>  bool device_dma_supported(const struct device *dev)
>  {
> diff --git a/include/linux/property.h b/include/linux/property.h
> index e214ecd241eb..bc5bfc98176b 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -208,7 +208,12 @@ DEFINE_FREE(fwnode_handle, struct fwnode_handle *, f=
wnode_handle_put(_T))
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int inde=
x);
>  int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char=
 *name);
>
> -unsigned int device_get_child_node_count(const struct device *dev);
> +unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwn=
ode);
> +
> +static inline unsigned int device_get_child_node_count(const struct devi=
ce *dev)
> +{
> +       return fwnode_get_child_node_count(dev_fwnode(dev));
> +}
>
>  static inline int device_property_read_u8(const struct device *dev,
>                                           const char *propname, u8 *val)
> --
> 2.47.2
>

