Return-Path: <linux-acpi+bounces-14866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A7AEE7FF
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 22:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975BF7A1E62
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C59202976;
	Mon, 30 Jun 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrDHvwih"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE691B87F0;
	Mon, 30 Jun 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751314271; cv=none; b=BAioQx9I+ijxgeRUWO1qzO6s/xq4xlD//hprQN0avEFXUmNkQGTJkmDusCIPxrG3k1xUxOateZCGTbCzCLvGkfRUcvgpmb8OAprNSb2JmvnhlLy7/SH4ei9ErPtZCKkUYX2bkB4klxeIkL/Z/v06qPO5OKDbddxh5VeWkyu7riM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751314271; c=relaxed/simple;
	bh=CF8N+TwAuO0PoFnw1FLiMkt7/JQwaRY88SAx44FaeVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqdECW2NtRbEVZ/yNOt8bLJOKUJNhf8NWeplljMY8UW88nazK42kMNCSoFzjk4fN2ukHUcxrc+DYHonxqJSvMx755oLM7DHJqrjK+A5XRBbwTeQHE6CNnB1d5zeFSSetArMeDH1kYRRUGAFko/3rvBkhVMRpinUUCS/04o3Mdqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrDHvwih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBDDC4CEEB;
	Mon, 30 Jun 2025 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751314271;
	bh=CF8N+TwAuO0PoFnw1FLiMkt7/JQwaRY88SAx44FaeVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MrDHvwih+6HKXG4deS9oTfTkK6q0kkCIdFuwgTx7Mwpca5Lqk8KVL2vOBeAikJIbB
	 AA14ZInbFhOXTDb5sHly+HLFu8UdYC94/E8SiUjYIwlyOfUEZiOMoLB2x3ZcPpG1WT
	 88T76kqy0hlR21wJaGlrXgQPcXURyjOOxPThvQ287unOwKULU3wghGrFJ/uFRzACRJ
	 MB1viJ9QI7WTCL9biKIRLASCHN0VOxSX8HiRNF+yFnoGVe8EsZoLvpV8DcG80Wlbnl
	 bJMjsUvU5Ro+5z7ryfRHXBAwPc7xQ9jiXDJZ8oKcEjLMLJ80mm1HZA+VtLEenzMNh+
	 TlBpCt5lBaleg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-40669fd81b5so1501941b6e.1;
        Mon, 30 Jun 2025 13:11:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU808v5M3A1L4VtaP946jMMxRxtIVlRFYWe/SWcJBm/qp8t+F49QFrkW6bu6nWAKtG6VcqmQv8OfLSW9UQs@vger.kernel.org, AJvYcCVjR0bw8oaGf6sT89Tzl600G3UJfZwVOcDIxYdAGyeUXNMy0h/tPid0fCuKgFmy5FePYP5Dy3w4hvGt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx91rYkSMYuW6DQ0COlh4GKlUyJAUgvBV/NcNK1aXtE5M4A/ZBH
	CbZ7iGpA1I0nPyj7hVtnznT1mhxEoa6CGwekyaG38z4aezVrrIMvS86VHdS9xr4ZBmUY6bMZy0E
	V2y3GkMePIbBHDYz9ttBg4+drHfMWJKY=
X-Google-Smtp-Source: AGHT+IH6VbaWNDgEp4LsIzOC5laKKwbjfEgyJslwNPDiGRh9moPgDyA+YDecbRWUixH02vzpC/9d13K0ebO8CBOHXVQ=
X-Received: by 2002:a05:6808:1208:b0:40a:5765:eee2 with SMTP id
 5614622812f47-40b33e18341mr12815177b6e.21.1751314270313; Mon, 30 Jun 2025
 13:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604022956.3723438-1-yu.c.chen@intel.com>
In-Reply-To: <20250604022956.3723438-1-yu.c.chen@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jun 2025 22:10:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9r0TdS7EVRz0RHzi=F11t3EHq8xyf81=Z4kW0HXAueA@mail.gmail.com>
X-Gm-Features: Ac12FXziDLO2YdCjInjGZYVycQtkKNscFf_UZIrwOZ99lmsmnm2u8OQjNpqKLYA
Message-ID: <CAJZ5v0j9r0TdS7EVRz0RHzi=F11t3EHq8xyf81=Z4kW0HXAueA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: pfr_update: Add more debug information when
 firmware update failed
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 4:36=E2=80=AFAM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Users reported insufficient error information for debugging during
> firmware update failures on certain platforms. Add verbose error logs
> in the error code path to enhance debuggability.
>
> Reported-by: "Govindarajulu, Hariganesh" <hariganesh.govindarajulu@intel.=
com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/acpi/pfr_update.c | 63 +++++++++++++++++++++++++++++----------
>  1 file changed, 48 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 031d1ba81b86..318683744ed1 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -127,8 +127,11 @@ static int query_capability(struct pfru_update_cap_i=
nfo *cap_hdr,
>                                           pfru_dev->rev_id,
>                                           PFRU_FUNC_QUERY_UPDATE_CAP,
>                                           NULL, ACPI_TYPE_PACKAGE);
> -       if (!out_obj)
> +       if (!out_obj) {
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Query cap failed with no object\n");
>                 return ret;
> +       }
>
>         if (out_obj->package.count < CAP_NR_IDX ||
>             out_obj->package.elements[CAP_STATUS_IDX].type !=3D ACPI_TYPE=
_INTEGER ||
> @@ -141,13 +144,17 @@ static int query_capability(struct pfru_update_cap_=
info *cap_hdr,
>             out_obj->package.elements[CAP_DRV_SVN_IDX].type !=3D ACPI_TYP=
E_INTEGER ||
>             out_obj->package.elements[CAP_PLAT_ID_IDX].type !=3D ACPI_TYP=
E_BUFFER ||
>             out_obj->package.elements[CAP_OEM_ID_IDX].type !=3D ACPI_TYPE=
_BUFFER ||
> -           out_obj->package.elements[CAP_OEM_INFO_IDX].type !=3D ACPI_TY=
PE_BUFFER)
> +           out_obj->package.elements[CAP_OEM_INFO_IDX].type !=3D ACPI_TY=
PE_BUFFER) {
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Query cap failed with invalid package count/type=
\n");
>                 goto free_acpi_buffer;
> +       }
>
>         cap_hdr->status =3D out_obj->package.elements[CAP_STATUS_IDX].int=
eger.value;
>         if (cap_hdr->status !=3D DSM_SUCCEED) {
>                 ret =3D -EBUSY;
> -               dev_dbg(pfru_dev->parent_dev, "Error Status:%d\n", cap_hd=
r->status);
> +               dev_dbg(pfru_dev->parent_dev, "Query cap Error Status:%d\=
n",
> +                       cap_hdr->status);
>                 goto free_acpi_buffer;
>         }
>
> @@ -193,24 +200,32 @@ static int query_buffer(struct pfru_com_buf_info *i=
nfo,
>         out_obj =3D acpi_evaluate_dsm_typed(handle, &pfru_guid,
>                                           pfru_dev->rev_id, PFRU_FUNC_QUE=
RY_BUF,
>                                           NULL, ACPI_TYPE_PACKAGE);
> -       if (!out_obj)
> +       if (!out_obj) {
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Query buf failed with no object\n");
>                 return ret;
> +       }
>
>         if (out_obj->package.count < BUF_NR_IDX ||
>             out_obj->package.elements[BUF_STATUS_IDX].type !=3D ACPI_TYPE=
_INTEGER ||
>             out_obj->package.elements[BUF_EXT_STATUS_IDX].type !=3D ACPI_=
TYPE_INTEGER ||
>             out_obj->package.elements[BUF_ADDR_LOW_IDX].type !=3D ACPI_TY=
PE_INTEGER ||
>             out_obj->package.elements[BUF_ADDR_HI_IDX].type !=3D ACPI_TYP=
E_INTEGER ||
> -           out_obj->package.elements[BUF_SIZE_IDX].type !=3D ACPI_TYPE_I=
NTEGER)
> +           out_obj->package.elements[BUF_SIZE_IDX].type !=3D ACPI_TYPE_I=
NTEGER) {
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Query buf failed with invalid package count/type=
\n");
>                 goto free_acpi_buffer;
> +       }
>
>         info->status =3D out_obj->package.elements[BUF_STATUS_IDX].intege=
r.value;
>         info->ext_status =3D
>                 out_obj->package.elements[BUF_EXT_STATUS_IDX].integer.val=
ue;
>         if (info->status !=3D DSM_SUCCEED) {
>                 ret =3D -EBUSY;
> -               dev_dbg(pfru_dev->parent_dev, "Error Status:%d\n", info->=
status);
> -               dev_dbg(pfru_dev->parent_dev, "Error Extended Status:%d\n=
", info->ext_status);
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Query buf failed with Error Status:%d\n", info->=
status);
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Query buf failed with Error Extended Status:%d\n=
", info->ext_status);
>
>                 goto free_acpi_buffer;
>         }
> @@ -295,12 +310,16 @@ static bool applicable_image(const void *data, stru=
ct pfru_update_cap_info *cap,
>         m_img_hdr =3D data + size;
>
>         type =3D get_image_type(m_img_hdr, pfru_dev);
> -       if (type < 0)
> +       if (type < 0) {
> +               dev_dbg(pfru_dev->parent_dev, "Invalid image type\n");
>                 return false;
> +       }
>
>         size =3D adjust_efi_size(m_img_hdr, size);
> -       if (size < 0)
> +       if (size < 0) {
> +               dev_dbg(pfru_dev->parent_dev, "Invalid image size\n");
>                 return false;
> +       }
>
>         auth =3D data + size;
>         size +=3D sizeof(u64) + auth->auth_info.hdr.len;
> @@ -346,8 +365,11 @@ static int start_update(int action, struct pfru_devi=
ce *pfru_dev)
>         out_obj =3D acpi_evaluate_dsm_typed(handle, &pfru_guid,
>                                           pfru_dev->rev_id, PFRU_FUNC_STA=
RT,
>                                           &in_obj, ACPI_TYPE_PACKAGE);
> -       if (!out_obj)
> +       if (!out_obj) {
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Update failed to start with no object\n");
>                 return ret;
> +       }
>
>         if (out_obj->package.count < UPDATE_NR_IDX ||
>             out_obj->package.elements[UPDATE_STATUS_IDX].type !=3D ACPI_T=
YPE_INTEGER ||
> @@ -355,8 +377,11 @@ static int start_update(int action, struct pfru_devi=
ce *pfru_dev)
>             out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].type !=3D=
 ACPI_TYPE_INTEGER ||
>             out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].type !=3D =
ACPI_TYPE_INTEGER ||
>             out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].type !=3D=
 ACPI_TYPE_INTEGER ||
> -           out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].type !=3D =
ACPI_TYPE_INTEGER)
> +           out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].type !=3D =
ACPI_TYPE_INTEGER) {
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Update failed with invalid package count/type\n"=
);
>                 goto free_acpi_buffer;
> +       }
>
>         update_result.status =3D
>                 out_obj->package.elements[UPDATE_STATUS_IDX].integer.valu=
e;
> @@ -365,8 +390,10 @@ static int start_update(int action, struct pfru_devi=
ce *pfru_dev)
>
>         if (update_result.status !=3D DSM_SUCCEED) {
>                 ret =3D -EBUSY;
> -               dev_dbg(pfru_dev->parent_dev, "Error Status:%d\n", update=
_result.status);
> -               dev_dbg(pfru_dev->parent_dev, "Error Extended Status:%d\n=
",
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Update failed with Error Status:%d\n", update_re=
sult.status);
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Update failed with Error Extended Status:%d\n",
>                         update_result.ext_status);
>
>                 goto free_acpi_buffer;
> @@ -450,8 +477,10 @@ static ssize_t pfru_write(struct file *file, const c=
har __user *buf,
>         if (ret)
>                 return ret;
>
> -       if (len > buf_info.buf_size)
> +       if (len > buf_info.buf_size) {
> +               dev_dbg(pfru_dev->parent_dev, "Capsule image size too lar=
ge\n");
>                 return -EINVAL;
> +       }
>
>         iov.iov_base =3D (void __user *)buf;
>         iov.iov_len =3D len;
> @@ -460,10 +489,14 @@ static ssize_t pfru_write(struct file *file, const =
char __user *buf,
>         /* map the communication buffer */
>         phy_addr =3D (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.ad=
dr_lo);
>         buf_ptr =3D memremap(phy_addr, buf_info.buf_size, MEMREMAP_WB);
> -       if (!buf_ptr)
> +       if (!buf_ptr) {
> +               dev_dbg(pfru_dev->parent_dev, "Failed to remap the buffer=
\n");
>                 return -ENOMEM;
> +       }
>
>         if (!copy_from_iter_full(buf_ptr, len, &iter)) {
> +               dev_dbg(pfru_dev->parent_dev,
> +                       "Failed to copy the data from the user space buff=
er\n");
>                 ret =3D -EINVAL;
>                 goto unmap;
>         }
> --

Applied as 6.17 material, thanks!

