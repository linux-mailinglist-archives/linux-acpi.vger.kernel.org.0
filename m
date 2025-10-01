Return-Path: <linux-acpi+bounces-17486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A65DBB188C
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 20:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E48F192464A
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089702D6E51;
	Wed,  1 Oct 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWvktExo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76652D4817
	for <linux-acpi@vger.kernel.org>; Wed,  1 Oct 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344611; cv=none; b=tfEhLmueERWbH8Hp0uq6wndE3kFQhC8FZd7D5GqtUAELhDCaZzwWBlguLZxSIA+jP6qlpUS9GwFFHCJcCKTATa8bpTk/r71wQkXxWfNuPScZhth5d704D80Y7AB4zvHU5XnH2o9S/hGFMVTJtz9aFTawhzhFKQV2XaQ0GJv5Hkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344611; c=relaxed/simple;
	bh=M/78JxiO1ZzbJUy/dxugVQFantitH5ZHQMKbSwC8n4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JW5uaYlj5bfjyozv+V/rTiu5i3bCN4Va26ZPYwRD7S3l12rifBRrLH6ZgGy4xi/fvS+Nq6hp9oSmecg9+AttNPQ9GlxjoKkd4Q4Jtnw8zIjqMA3aPyYXLzFCce9IK999odji5o49TscwGCg5GGiFj4RLGPEMYGIoEKK1KJK9+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWvktExo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3FFC4CEF1
	for <linux-acpi@vger.kernel.org>; Wed,  1 Oct 2025 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759344611;
	bh=M/78JxiO1ZzbJUy/dxugVQFantitH5ZHQMKbSwC8n4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NWvktExoPD+6kOWQpYYDea9E7bAahBK19vwVC6mz/xDati7D46qcgv/IkqhVyos2A
	 kr6mFiUIbSg9AZrxgeid4xGTpS2Xo7+oPGeybTv/Mv0Iu5UTV6pgr6LFH97kudBD2/
	 TJ4ZYrX4cA5gC/VuwINiQTbZaHDHrsc6uFqiiwVeB/70vPyzW3325UaI46GIWd21/9
	 pV5USe5L2ONh7ZTbGdYDPE448ju55OEewokOC8bnOGX5fQh0DUJqLMqNKS6f0q9L2M
	 RxF5ywxf45leWSBymRHN+YJndNQU3/VjbWobSUipEIieLmhVgQDCFx2u8PP4LzRHFE
	 zmKeFAG9thaFw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-35c80c1dc3fso107567fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 01 Oct 2025 11:50:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YybUBWYgbQXGAGc4SB0Z0BdsHwbAQOGmKuU5mn/YYwsMoAe4tJk
	MEUiH05Plyzx4i4cGV9MsLkVOyf3FDTpj+8GF39H3zyZLn8zMzDyjsiZtqYoQVH24VloVMbOw5l
	ShbJ7ZE2L+XPVyDOMXjXAKLS5lwy1g8c=
X-Google-Smtp-Source: AGHT+IFWqC5k9TljfmKNrQP6w0faxI6lgmDy+8oVhKzY5vZNp3AKR1awzZgbzGpcc6r4TWRN6ibOTuRehljlcNyaA+0=
X-Received: by 2002:a05:6870:912c:b0:353:f24:e95a with SMTP id
 586e51a60fabf-39bb3c3eef6mr2541529fac.42.1759344610783; Wed, 01 Oct 2025
 11:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001102636.1272722-1-sakari.ailus@linux.intel.com> <20251001102636.1272722-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20251001102636.1272722-2-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Oct 2025 20:49:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hdgbLG3fjtsiWcKS0JO0r=O3zywvZhOqn26xEG3VnMbw@mail.gmail.com>
X-Gm-Features: AS18NWBR-0hiJbCA7i-G13AnZiagHfW07PGEYJMjLEPbAo07gs6WHj8GHou4sMY
Message-ID: <CAJZ5v0hdgbLG3fjtsiWcKS0JO0r=O3zywvZhOqn26xEG3VnMbw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Return present device nodes only on
 fwnode interface
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 12:26=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> fwnode_graph_get_next_subnode() may return fwnode backed by ACPI device
> nodes and there has been no check these devices are present in the system=
,
> unlike there has been on fwnode OF backend. In order to provide consisten=
t
> behaviour towards callers, add a check for device presence by introducing
> a new function acpi_get_next_present_subnode(), used as the
> get_next_child_node() fwnode operation that also checks device node
> presence.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  drivers/acpi/property.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 436019d96027..10bab30300f3 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1318,6 +1318,28 @@ struct fwnode_handle *acpi_get_next_subnode(const =
struct fwnode_handle *fwnode,
>         return NULL;
>  }
>
> +/*
> + * acpi_get_next_present_subnode - Return the next present child node ha=
ndle for a fwnode
> + * @fwnode: Firmware node to find the next child node for.
> + * @child: Handle to one of the device's child nodes or a null handle.
> + *
> + * Like acpi_get_next_subnode(), but the device nodes returned by
> + * acpi_get_next_present_subnode() are guaranteed to be present.
> + *
> + * Returns: The next sub-node fwnode handle.
> + */
> +static struct fwnode_handle *
> +acpi_get_next_present_subnode(const struct fwnode_handle *fwnode,
> +                             struct fwnode_handle *child)
> +{
> +       do {
> +               child =3D acpi_get_next_subnode(fwnode, child);
> +       } while (is_acpi_device_node(child) &&
> +                !acpi_device_is_present(to_acpi_device_node(child)));
> +
> +       return child;
> +}
> +
>  /**
>   * acpi_node_get_parent - Return parent fwnode of this fwnode
>   * @fwnode: Firmware node whose parent to get
> @@ -1662,7 +1684,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_=
handle *fwnode,
>                 .property_read_string_array =3D                          =
 \
>                         acpi_fwnode_property_read_string_array,         \
>                 .get_parent =3D acpi_node_get_parent,                    =
 \
> -               .get_next_child_node =3D acpi_get_next_subnode,          =
 \
> +               .get_next_child_node =3D acpi_get_next_present_subnode,  =
 \
>                 .get_named_child_node =3D acpi_fwnode_get_named_child_nod=
e, \
>                 .get_name =3D acpi_fwnode_get_name,                      =
 \
>                 .get_name_prefix =3D acpi_fwnode_get_name_prefix,        =
 \
> --

Applied with some minor tweaks as 6.18 material, thanks!

