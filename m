Return-Path: <linux-acpi+bounces-724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED37CDBE8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36911C20BED
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0E63588E
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735D315AFE
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 11:23:17 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7488FE;
	Wed, 18 Oct 2023 04:23:15 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57f137dffa5so959209eaf.1;
        Wed, 18 Oct 2023 04:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628195; x=1698232995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL8d1Wy2RYg7Z3Gg7sRF+6FjUhQukhbwr28QCxGfYwQ=;
        b=rI/ZQCdYay37wlm1u4sGslUIdm/JtoOwobWoV74LtPxBogTx2hmmkUmD0asDS5iPWZ
         ST0R/e5h5mM6kE8EbA7UfcO/TX5h0nfAfK1gZ2hFbo4xz4fOOI0By6a1YAL4p5uGWDaa
         Mx8CJ6aD8rYpgy7IlUUVCDWzNZf4kkTNVxfAX87dFNdLOR9Wscx7AGLl5jf84RAQN6x5
         ovzuNOBLzvBw8ijt83hAQL8m53Edq8ElhMLyznyocE3LNCGpBJoSs9fpMIg2gySC2r4x
         Tnx/HMQv83MOhr7Dyj/1GdnJZ3WXmgkELtk4NwGQl60iRO/T+6XoM8tFWw5IQ5F5nbTO
         h02Q==
X-Gm-Message-State: AOJu0YzY4ySYh8GE+2g8nioo1UZli6Kaf3ZaCyP1Vzdva+vd5ADotJF4
	zxSE9CJEnTkOWTjq1vckO7TfHTVq0tSK6aDN6KsWbsS0
X-Google-Smtp-Source: AGHT+IHwAj/x3rnK0iruCbW5d4oq4fAlIoJHsIB1GFHgvd4bGUjDgCn1lE771+MBeeCJ74DtLny7PLmN3Dz2rGI/BUs=
X-Received: by 2002:a4a:e1cd:0:b0:581:feb5:ac87 with SMTP id
 n13-20020a4ae1cd000000b00581feb5ac87mr970404oot.1.1697628195091; Wed, 18 Oct
 2023 04:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <547f8b.93e.18b26e5e031.Coremail.chenguohua@jari.cn>
In-Reply-To: <547f8b.93e.18b26e5e031.Coremail.chenguohua@jari.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 13:23:04 +0200
Message-ID: <CAJZ5v0jJDr0w2R2Up_e_ZSeuw9Z-29FdHheGHwCjh05++GKe=g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Clean up errors in acpi.h
To: chenguohua@jari.cn
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

First, the subject is misleading, because the patch doesn't address
any errors, but cleans up the usage of white space.

On Fri, Oct 13, 2023 at 6:32=E2=80=AFAM <chenguohua@jari.cn> wrote:
>
> Fix the following errors reported by checkpatch:

Why does it make sense to run checkpatch on the existing code?

> ERROR: "foo * bar" should be "foo *bar"
> ERROR: space required after that ';' (ctx:VxV)
>
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

Please fix the changelog to simply state that it cleans up the usage
of white space so it is consistent with the kernel coding style.

> ---
>  include/linux/acpi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 9bcf5641a7cf..b55a8ac627e9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1421,7 +1421,7 @@ acpi_graph_get_remote_endpoint(const struct fwnode_=
handle *fwnode,
>  }
>
>  #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid,=
 data, fn) \
> -       static const void * __acpi_table_##name[]                       \
> +       static const void *__acpi_table_##name[]                        \
>                 __attribute__((unused))                                 \
>                  =3D { (void *) table_id,                                =
 \
>                      (void *) subtable,                                 \
> @@ -1429,7 +1429,7 @@ acpi_graph_get_remote_endpoint(const struct fwnode_=
handle *fwnode,
>                      (void *) fn,                                       \
>                      (void *) data }
>
> -#define acpi_probe_device_table(t)     ({ int __r =3D 0; __r;})
> +#define acpi_probe_device_table(t)     ({ int __r =3D 0; __r; })
>  #endif
>
>  #ifdef CONFIG_ACPI_TABLE_UPGRADE
> --

