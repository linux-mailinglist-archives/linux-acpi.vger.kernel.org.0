Return-Path: <linux-acpi+bounces-3759-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71285CDBA
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 03:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9D6B20C04
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC6D522C;
	Wed, 21 Feb 2024 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HY0K8rZ1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369B46BF
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481377; cv=none; b=dGKm7UQLkDsWQ0IG8AgITXwSEX7M8YuVShhTrmAWqFXRcDG0x8iQTId/wcllJF7wMyj8UfvVB4xbIM577MRmThYXb/QD8p4bfeA9LGHNWvOfYblFIzjdacqJVDOv3FlyHexRHZbQXEbrH25g02ZA+MZQy6Z4zAOE1r4/6VsFxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481377; c=relaxed/simple;
	bh=szYKJrGmDp93JCS78nmQ3szqAsbuBjTO7gxM7SgdWmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnLAviv0Mo4NxV90oxUNn12+y2dUgZRoU0Mogo1Mm6vltgknro7Z5FnbLOFyrDctG2STDhmoGAkKPnkQ57dbVODr8f8WlLyAnPcT43iYFwsVYKA5MIYVH6hR4hVgHy1jQT59793AyDsPYbEHzCPRu8aI69UBw8wChQ7+Gh4Vz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HY0K8rZ1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42e2507c6e1so76081cf.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Feb 2024 18:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708481374; x=1709086174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1VM94YAF3zp4otk2Hvp6TAgshqoTETLzdYzzpGhRoQ=;
        b=HY0K8rZ16BKUCkNrGRh25BQfCw/ungo8PB0CmJqjdvjJjHlZbphrZcC1Lq22TJX08r
         fmjTGLo3TxbXJPjjpWdTYXF/Me7Gs3dTbxHK1X4/lYXXJS3tyDH0Y8dbnjNhVx1SrVGy
         uxyCpVA/wiYk/4fF2vDZ+TiuIVmZc3kYmHA4EnMmDWiHAFTcrXmOj34zUbtqvLiICTbc
         jyLkmOzju8eYaO4mR+R/b77xbljtXTf82bi1UOW9NG11dC/OBa39Axo3TgcqcNANhZG5
         wVWuXEtpcUeeb8hcb5PgbR+GpDFUREHHLLXJ49tjlrJy4ofCgQ+u3N69oHbVCTc+Xt3u
         QMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708481374; x=1709086174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1VM94YAF3zp4otk2Hvp6TAgshqoTETLzdYzzpGhRoQ=;
        b=eDJe0YTeo8w/pa/x4Lz18ql6nhm+f135INTRG7OUVu8zr61sFRy8BumhaRBkmEVHmF
         Si8quQ6Osf0cIbLDcF06zkQx9zokzf6VudLH0XQeoDsV/8lxNHvGRdRC4vUn176z0SD1
         eHqkofc2zVVbAaJZaeZurZ/mKyjwwzV5xOisVyrMX7z1hL+G8cwfLSFjXJbjpo3OxdVM
         jAGkIFvRrnHup6SG4+udeD/cF1o5Fl/Mg59gpetz9ydOQdxIRaTeeu6qJg4zH8PofFlP
         PyxHDVqmSOWWGeEvuzef+dG1SgibeZfd+FjpmCh4cUTBBHHegudtJJ0epitDtZ7zWnWC
         mXAA==
X-Forwarded-Encrypted: i=1; AJvYcCUg5ZVvc4Psvk6gKQZiZfJy4tONU76ycS1tdLNKP6QcZ/0rq8mI0ZFYQ+fxzCQMUSDF6Pa+r9UGogAUaTByWqYDxQlBLKOIwGvWTA==
X-Gm-Message-State: AOJu0Yzw/dYpVT3KTG2fi/KP4vM19NmNo314x2eoCnqUsDQeItnsMByt
	jQXNQRDPO5JTV3Ca1gIKLrwhYrSjwc1lSRggOM1VzTqPPr9ogoQx11s52h0QW68NIdOzEhGC2o3
	+H73DSPQJajzZXV6VIR+ia5SGaRQq2DqKnctQ
X-Google-Smtp-Source: AGHT+IE4zvEttWNpeKE0T11pIYvLpTo0R5aTyHAaiaUj8r7KFCsvEi0g+mE8WZ8l+OXrqb7mhsiveLrF+6Sag++iVlY=
X-Received: by 2002:ac8:7643:0:b0:42e:1260:c4e6 with SMTP id
 i3-20020ac87643000000b0042e1260c4e6mr137559qtr.10.1708481374445; Tue, 20 Feb
 2024 18:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 18:08:56 -0800
Message-ID: <CAGETcx8hzYzjKWPz4ACgS=XrVXqg46QHB4hTpP5bDTY9=WFK+Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it belongs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 8:10=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> A few APIs that belong specifically to the fw_devlink APIs
> - are exposed to others without need
> - prevents device property code to be cleaned up in the future
>
> Resolve this mess by moving fw_devlink code to where it belongs
> and hide from others.
>
> Fixes: b5d3e2fbcb10 ("device property: Add fwnode_is_ancestor_of() and fw=
node_get_next_parent_dev()")
> Fixes: 372a67c0c5ef ("driver core: Add fwnode_to_dev() to look up device =
from fwnode")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/core.c      | 58 ++++++++++++++++++++++++++++++++++++++++
>  drivers/base/property.c  | 56 --------------------------------------
>  include/linux/fwnode.h   |  1 -
>  include/linux/property.h |  2 --
>  4 files changed, 58 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 9828da9b933c..35ccd8bb2c9b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1871,6 +1871,7 @@ static void fw_devlink_unblock_consumers(struct dev=
ice *dev)
>         device_links_write_unlock();
>  }
>
> +#define get_dev_from_fwnode(fwnode)    get_device((fwnode)->dev)
>
>  static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
>  {
> @@ -1901,6 +1902,63 @@ static bool fwnode_ancestor_init_without_drv(struc=
t fwnode_handle *fwnode)
>         return false;
>  }
>
> +/**
> + * fwnode_is_ancestor_of - Test if @ancestor is ancestor of @child
> + * @ancestor: Firmware which is tested for being an ancestor
> + * @child: Firmware which is tested for being the child
> + *
> + * A node is considered an ancestor of itself too.
> + *
> + * Return: true if @ancestor is an ancestor of @child. Otherwise, return=
s false.
> + */
> +static bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor,
> +                                 const struct fwnode_handle *child)
> +{
> +       struct fwnode_handle *parent;
> +
> +       if (IS_ERR_OR_NULL(ancestor))
> +               return false;
> +
> +       if (child =3D=3D ancestor)
> +               return true;
> +
> +       fwnode_for_each_parent_node(child, parent) {
> +               if (parent =3D=3D ancestor) {
> +                       fwnode_handle_put(parent);
> +                       return true;
> +               }
> +       }
> +       return false;
> +}
> +
> +/**
> + * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
> + * @fwnode: firmware node
> + *
> + * Given a firmware node (@fwnode), this function finds its closest ance=
stor
> + * firmware node that has a corresponding struct device and returns that=
 struct
> + * device.
> + *
> + * The caller is responsible for calling put_device() on the returned de=
vice
> + * pointer.
> + *
> + * Return: a pointer to the device of the @fwnode's closest ancestor.
> + */
> +static struct device *fwnode_get_next_parent_dev(const struct fwnode_han=
dle *fwnode)
> +{
> +       struct fwnode_handle *parent;
> +       struct device *dev;
> +
> +       fwnode_for_each_parent_node(fwnode, parent) {
> +               dev =3D get_dev_from_fwnode(parent);
> +               if (dev) {
> +                       fwnode_handle_put(parent);
> +                       return dev;
> +               }
> +       }
> +       return NULL;
> +}
> +
>  /**
>   * __fw_devlink_relax_cycles - Relax and mark dependency cycles.
>   * @con: Potential consumer device.
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index a1b01ab42052..afa1bf2b3c5a 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -699,34 +699,6 @@ struct fwnode_handle *fwnode_get_next_parent(struct =
fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
>
> -/**
> - * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
> - * @fwnode: firmware node
> - *
> - * Given a firmware node (@fwnode), this function finds its closest ance=
stor
> - * firmware node that has a corresponding struct device and returns that=
 struct
> - * device.
> - *
> - * The caller is responsible for calling put_device() on the returned de=
vice
> - * pointer.
> - *
> - * Return: a pointer to the device of the @fwnode's closest ancestor.
> - */
> -struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fw=
node)
> -{
> -       struct fwnode_handle *parent;
> -       struct device *dev;
> -
> -       fwnode_for_each_parent_node(fwnode, parent) {
> -               dev =3D get_dev_from_fwnode(parent);
> -               if (dev) {
> -                       fwnode_handle_put(parent);
> -                       return dev;
> -               }
> -       }
> -       return NULL;
> -}
> -
>  /**
>   * fwnode_count_parents - Return the number of parents a node has
>   * @fwnode: The node the parents of which are to be counted
> @@ -773,34 +745,6 @@ struct fwnode_handle *fwnode_get_nth_parent(struct f=
wnode_handle *fwnode,
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
>
> -/**
> - * fwnode_is_ancestor_of - Test if @ancestor is ancestor of @child
> - * @ancestor: Firmware which is tested for being an ancestor
> - * @child: Firmware which is tested for being the child
> - *
> - * A node is considered an ancestor of itself too.
> - *
> - * Return: true if @ancestor is an ancestor of @child. Otherwise, return=
s false.
> - */
> -bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const s=
truct fwnode_handle *child)
> -{
> -       struct fwnode_handle *parent;
> -
> -       if (IS_ERR_OR_NULL(ancestor))
> -               return false;
> -
> -       if (child =3D=3D ancestor)
> -               return true;
> -
> -       fwnode_for_each_parent_node(child, parent) {
> -               if (parent =3D=3D ancestor) {
> -                       fwnode_handle_put(parent);
> -                       return true;
> -               }
> -       }
> -       return false;
> -}
> -
>  /**
>   * fwnode_get_next_child_node - Return the next child node handle for a =
node
>   * @fwnode: Firmware node to find the next child node for.
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 0428942093a7..4228c45d5ccc 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -193,7 +193,6 @@ struct fwnode_operations {
>                 if (fwnode_has_op(fwnode, op))                          \
>                         (fwnode)->ops->op(fwnode, ## __VA_ARGS__);      \
>         } while (false)
> -#define get_dev_from_fwnode(fwnode)    get_device((fwnode)->dev)
>
>  static inline void fwnode_init(struct fwnode_handle *fwnode,
>                                const struct fwnode_operations *ops)
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 07fbebc73243..1f0135e24d00 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -150,11 +150,9 @@ struct fwnode_handle *fwnode_get_next_parent(struct =
fwnode_handle *fwnode);
>         for (parent =3D fwnode_get_parent(fwnode); parent;        \
>              parent =3D fwnode_get_next_parent(parent))
>
> -struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fw=
node);
>  unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
>  struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
>                                             unsigned int depth);
> -bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const s=
truct fwnode_handle *child);

The rest of the functions here are related to parents and children of
a fwnode. So, why is this function considered to be in the wrong
place?

-Saravana

>  struct fwnode_handle *fwnode_get_next_child_node(
>         const struct fwnode_handle *fwnode, struct fwnode_handle *child);
>  struct fwnode_handle *fwnode_get_next_available_child_node(

