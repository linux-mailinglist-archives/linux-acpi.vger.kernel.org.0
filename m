Return-Path: <linux-acpi+bounces-12133-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B7A5E499
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 20:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C663A7FEB
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 19:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A68253B73;
	Wed, 12 Mar 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3PMhgLi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D51E8353;
	Wed, 12 Mar 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808365; cv=none; b=k5r8+y8GNiszPFOJSadntRm99PyQMlQWLtr3oF4KDppcDMhe8FvT2Ct691KfkW4ecOgyoMde+uNR54EN0Hx4dF1tHDYCZDCZfabCXaP7OPFW4Nnra6eHhxS+bb4Hbd9fxi4O0sGXADnsuHfI5OHazUA4DaX1Gy6ECjWv09axRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808365; c=relaxed/simple;
	bh=CKbvTcQjktbb/fkm2xvKUFHJAUWPFJnyE/7YkFwSoUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsCRdfu79734wALfUgj8QkKgTyFd6DamdnXhw4qg9kciivTPMGReX+RB44phLM8A4Fn653WfOKQLAb/iuviibYwz3ou0vqRdBeudZBHbQr3uVIpdpJbm0OIdlQvwkKtBnEgYhM5hYYWYqcITCZaEwBYGFjAZoFyqA4YqPhmhwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3PMhgLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131A6C4AF09;
	Wed, 12 Mar 2025 19:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741808365;
	bh=CKbvTcQjktbb/fkm2xvKUFHJAUWPFJnyE/7YkFwSoUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T3PMhgLiC+1jN2fQn/s868b7rQ4xuI6jCK7ojznJRarsOayJt/9kF0gFd7jd/iYyb
	 G772gtE9y/TQyqnd9lvi1gqvGrC76fLi4Ho7YBpioi5+QOfOpdUVeB4tHZ8G+dT0qs
	 pXpBBd51/rP23Iat5xyDHYzcjbs3mCNTIXvUAY8uWMoGtMf9ry+M/3Fub9OANd+Ry3
	 It5R0yQ6ghT3QEK9dddsbb8H47+sTDAEqIgwH7y1lvcR3Fg+Rbm04NWqlMhC+y9Ufy
	 l7XzMgJTtri6ZJd7TM2lhWjb1vloMFH5u1kvvJF9NA/4ssGRtn7F7lAXm2OqgpJoEL
	 +zgDzc5GzdnFQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso188642fac.1;
        Wed, 12 Mar 2025 12:39:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW04ZQ8dvw3SP+7fagWU7Ka80vWviUZDZuQb+EqObe+PxOpqdfAg+Uj285lRsZW1Wfbo2le6FOOBYfN9viw@vger.kernel.org, AJvYcCWT+IPffjgs1d0PS478Yd5fj9tA17I1hrdp7aKBDobYm3TZ2cpq9U58lRgnzyTlpxgbgW2x6I0GZM0T@vger.kernel.org, AJvYcCXr+s3PbhlisGmXUj926eQKI9GFlUaaN1ucrQxM06z34PepHUP+Sqe88owQJu+mYOaR41IZfEUjDlET@vger.kernel.org
X-Gm-Message-State: AOJu0YyiK5ig4xQT5zD9Zs3Yf559ZjGWIuJVnWyhHpBI27MhEvKOEbI9
	nt8kaPb3SrSfb4nzpoqtxrnGBG5nyz21J6EuPvo/3wEMdBFpvvi3nW6EihfGw7hc0SqblOPAbNH
	FWDKvMm7jU0ePz2yi/u0jJw7/QUQ=
X-Google-Smtp-Source: AGHT+IHuNDHlZF9Ucfxr2gTlbfeWhfR5MVXJQ/d0SqzrupN1QuL8KSZ2cjTwH8+Q2igiU3qP86o6sWS8Qs+oYXJUACA=
X-Received: by 2002:a05:6871:8a8:b0:2c2:50a5:1248 with SMTP id
 586e51a60fabf-2c2614d4a3cmr11747453fac.38.1741808364302; Wed, 12 Mar 2025
 12:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307214936.74504-1-linux@treblig.org>
In-Reply-To: <20250307214936.74504-1-linux@treblig.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 20:39:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+=WYm+j340Z+1fs3aZ4PtTaF4XAFeSgm9s7NA=BR0=g@mail.gmail.com>
X-Gm-Features: AQ5f1JrtyjGeDehvAPKabOsddC766J_8Cjm-oJ9-AbMlE98bvzAsdgHk-YLJY9E
Message-ID: <CAJZ5v0j+=WYm+j340Z+1fs3aZ4PtTaF4XAFeSgm9s7NA=BR0=g@mail.gmail.com>
Subject: Re: [PATCH] PNP: Remove prehistoric deadcode
To: linux@treblig.org
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 10:49=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> pnp_remove_card() is currently unused, it has been since it was
> added in 2003's BKrev: 3e6d3f19XSmESWEZnNEReEJOJW5SOw
>
> pnp_unregister_protocol() is currently unused,  it has been since
> it was added in 2002's BKrev: 3df0cf6d4FVUKndhbfxjL7pksw5PGA
>
> Remove them, and pnp_remove_card_device() and __pnp_remove_device()
> which are now no longer used.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  Documentation/admin-guide/pnp.rst |  3 ---
>  drivers/pnp/base.h                |  4 ----
>  drivers/pnp/card.c                | 32 -------------------------------
>  drivers/pnp/core.c                | 16 ----------------
>  4 files changed, 55 deletions(-)
>
> diff --git a/Documentation/admin-guide/pnp.rst b/Documentation/admin-guid=
e/pnp.rst
> index 3eda08191d13..24d80e3eb309 100644
> --- a/Documentation/admin-guide/pnp.rst
> +++ b/Documentation/admin-guide/pnp.rst
> @@ -129,9 +129,6 @@ pnp_put_protocol
>  pnp_register_protocol
>    use this to register a new PnP protocol
>
> -pnp_unregister_protocol
> -  use this function to remove a PnP protocol from the Plug and Play Laye=
r
> -
>  pnp_register_driver
>    adds a PnP driver to the Plug and Play Layer
>
> diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
> index 4e80273dfb1e..b342570d0236 100644
> --- a/drivers/pnp/base.h
> +++ b/drivers/pnp/base.h
> @@ -9,7 +9,6 @@ extern const struct attribute_group *pnp_dev_groups[];
>  extern const struct bus_type pnp_bus_type;
>
>  int pnp_register_protocol(struct pnp_protocol *protocol);
> -void pnp_unregister_protocol(struct pnp_protocol *protocol);
>
>  #define PNP_EISA_ID_MASK 0x7fffffff
>  void pnp_eisa_id_to_string(u32 id, char *str);
> @@ -21,9 +20,7 @@ int pnp_add_device(struct pnp_dev *dev);
>  struct pnp_id *pnp_add_id(struct pnp_dev *dev, const char *id);
>
>  int pnp_add_card(struct pnp_card *card);
> -void pnp_remove_card(struct pnp_card *card);
>  int pnp_add_card_device(struct pnp_card *card, struct pnp_dev *dev);
> -void pnp_remove_card_device(struct pnp_dev *dev);
>
>  struct pnp_port {
>         resource_size_t min;    /* min base number */
> @@ -138,7 +135,6 @@ void pnp_init_resources(struct pnp_dev *dev);
>  void pnp_fixup_device(struct pnp_dev *dev);
>  void pnp_free_options(struct pnp_dev *dev);
>  int __pnp_add_device(struct pnp_dev *dev);
> -void __pnp_remove_device(struct pnp_dev *dev);
>
>  int pnp_check_port(struct pnp_dev *dev, struct resource *res);
>  int pnp_check_mem(struct pnp_dev *dev, struct resource *res);
> diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
> index 9610a9f08ff4..c7596dc24fbd 100644
> --- a/drivers/pnp/card.c
> +++ b/drivers/pnp/card.c
> @@ -269,25 +269,6 @@ int pnp_add_card(struct pnp_card *card)
>         return 0;
>  }
>
> -/**
> - * pnp_remove_card - removes a PnP card from the PnP Layer
> - * @card: pointer to the card to remove
> - */
> -void pnp_remove_card(struct pnp_card *card)
> -{
> -       struct list_head *pos, *temp;
> -
> -       device_unregister(&card->dev);
> -       mutex_lock(&pnp_lock);
> -       list_del(&card->global_list);
> -       list_del(&card->protocol_list);
> -       mutex_unlock(&pnp_lock);
> -       list_for_each_safe(pos, temp, &card->devices) {
> -               struct pnp_dev *dev =3D card_to_pnp_dev(pos);
> -               pnp_remove_card_device(dev);
> -       }
> -}
> -
>  /**
>   * pnp_add_card_device - adds a device to the specified card
>   * @card: pointer to the card to add to
> @@ -306,19 +287,6 @@ int pnp_add_card_device(struct pnp_card *card, struc=
t pnp_dev *dev)
>         return 0;
>  }
>
> -/**
> - * pnp_remove_card_device- removes a device from the specified card
> - * @dev: pointer to the device to remove
> - */
> -void pnp_remove_card_device(struct pnp_dev *dev)
> -{
> -       mutex_lock(&pnp_lock);
> -       dev->card =3D NULL;
> -       list_del(&dev->card_list);
> -       mutex_unlock(&pnp_lock);
> -       __pnp_remove_device(dev);
> -}
> -
>  /**
>   * pnp_request_card_device - Searches for a PnP device under the specifi=
ed card
>   * @clink: pointer to the card link, cannot be NULL
> diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
> index 6a60c5d83383..ac48db6dcfe3 100644
> --- a/drivers/pnp/core.c
> +++ b/drivers/pnp/core.c
> @@ -78,16 +78,6 @@ int pnp_register_protocol(struct pnp_protocol *protoco=
l)
>         return ret;
>  }
>
> -/**
> - * pnp_unregister_protocol - removes a pnp protocol from the pnp layer
> - * @protocol: pointer to the corresponding pnp_protocol structure
> - */
> -void pnp_unregister_protocol(struct pnp_protocol *protocol)
> -{
> -       pnp_remove_protocol(protocol);
> -       device_unregister(&protocol->dev);
> -}
> -
>  static void pnp_free_ids(struct pnp_dev *dev)
>  {
>         struct pnp_id *id;
> @@ -220,12 +210,6 @@ int pnp_add_device(struct pnp_dev *dev)
>         return 0;
>  }
>
> -void __pnp_remove_device(struct pnp_dev *dev)
> -{
> -       pnp_delist_device(dev);
> -       device_unregister(&dev->dev);
> -}
> -
>  static int __init pnp_init(void)
>  {
>         return bus_register(&pnp_bus_type);
> --

Applied as 6.15 material, thanks!

