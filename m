Return-Path: <linux-acpi+bounces-18978-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C0C66043
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 20:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id BEC0F29481
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830402FB602;
	Mon, 17 Nov 2025 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izj/o9n1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95B26A1A7
	for <linux-acpi@vger.kernel.org>; Mon, 17 Nov 2025 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408827; cv=none; b=oW3iSfF0XBToO+CceudnQ2E7U/HM88YRzBsMYLz8qsg9KYGEst5S2xcnmRHrcgx7awFUqylHK9ZdDsRCkWUBCGQl5m3eDU7q3YxeBSGv3phl4ER24na9etfYyfYBqbBwsSR5pyjLWWQecaHZ9S/OF1X0Viv/Kr7PLZlqji0vx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408827; c=relaxed/simple;
	bh=oi69ubzOmcWFnTTKfRQwkdBK9UrATVG/MfQMp9iqORg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0dm5rZiJKVaad2L5vK0ziEPLK9AOBilOojQjbx3vfXOZkFoT3+kfcjojHVbEH/x0wRpQW54HU5EP0V1rZXR/j8fp9+KesJsZDavA3SugjPvvJ7N654cCGwXS/y+Qh4BoFK91bMZ9P7gnAufMMR/IG7tqcGObcY1YZ1tYwYxYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izj/o9n1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AA1C19421
	for <linux-acpi@vger.kernel.org>; Mon, 17 Nov 2025 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763408826;
	bh=oi69ubzOmcWFnTTKfRQwkdBK9UrATVG/MfQMp9iqORg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Izj/o9n1YFttiiUdjvA+XVAKbdM9YIML4JJWObXTcOZfq1KE/YJiu3ZA8o0DEnrnN
	 BQH0Czl2O5F51t4o26nzmduNW9Q70Xf1xHPRs2W86WhUjJwqDHqZZukcwZlpmuioGx
	 13YNIBCfjLdbhfUwYfB+iVfJS6beRo+sw5niOmNtgrBNOIlmRY54Iacbm4t3Qupqa1
	 rTgCnB3+ISGO1Oz51YgX2TDia4XrTo/wvZlsS2TMBmBvRS8y+5qmkSHoTw3OF1ge9W
	 O+YrGcUrcXHZXQGG4E/Rg43gaaQR+s9u8Khkw99dqs0daxyUuQYMb0P73fxyblFOQ7
	 oZDPnzsgcJseA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45090ef26c6so657736b6e.2
        for <linux-acpi@vger.kernel.org>; Mon, 17 Nov 2025 11:47:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6WZIZIcqlXB3EgwOMZKNSE34x9BRWBMLzLAwOWvdUSfH0xdg80KWJX2y4ki/hkCzAZRRIvOUAr1AL@vger.kernel.org
X-Gm-Message-State: AOJu0YyuqD2615rZHSXhpOcY/iBeAejOjC+EZAl3m3f5oUjsW2G6DTM3
	h6jwhZ9dG9/l9mkzHhsC/gMeuljTE/qJ/p7Tpbn903G0HvsSG2Fx/jYrR0HzYJx9l7jYeosEFmE
	Ebqj0tG4ynBPbrllB+IyzSs4iUE2rgTs=
X-Google-Smtp-Source: AGHT+IH0IDOS0jWW+2CcgxSKT4rM/q/3QpPlqyYMAztkSrbQ6LlWMQIlex/xYO/eLfb/v/eEjABpLCDHWZNByM8wq1w=
X-Received: by 2002:a05:6808:1b24:b0:43f:5619:ce72 with SMTP id
 5614622812f47-4509741adbcmr6421105b6e.4.1763408824124; Mon, 17 Nov 2025
 11:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117170014.4113754-1-ben.horgan@arm.com> <20251117170014.4113754-9-ben.horgan@arm.com>
In-Reply-To: <20251117170014.4113754-9-ben.horgan@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Nov 2025 20:46:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hAPoE96C7=ynR=Ex4huPP3b896sBRNdBiLe=3Q9vKwHQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmWW5WMwkoNO9miPOqWpTmGCYnIxjnfsWWdSfIjl34zJdMaHEbUGRqKZIE
Message-ID: <CAJZ5v0hAPoE96C7=ynR=Ex4huPP3b896sBRNdBiLe=3Q9vKwHQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/34] ACPI: Define acpi_put_table cleanup handler and
 acpi_get_table_ret() helper
To: Ben Horgan <ben.horgan@arm.com>
Cc: james.morse@arm.com, amitsinght@marvell.com, baisheng.gao@unisoc.com, 
	baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com, 
	carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org, 
	dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com, 
	fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com, 
	guohanjun@huawei.com, jeremy.linton@arm.com, jonathan.cameron@huawei.com, 
	kobak@nvidia.com, lcherian@marvell.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org, peternewman@google.com, 
	quic_jiles@quicinc.com, rafael@kernel.org, robh@kernel.org, 
	rohit.mathew@arm.com, scott@os.amperecomputing.com, sdonthineni@nvidia.com, 
	sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, will@kernel.org, 
	xhao@linux.alibaba.com, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
	Zeng Heng <zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:01=E2=80=AFPM Ben Horgan <ben.horgan@arm.com> wro=
te:
>
> Define a cleanup helper for use with __free to release the acpi table whe=
n
> the pointer goes out of scope. Also, introduce the helper
> acpi_get_table_ret() to simplify a commonly used pattern involving
> acpi_get_table().
>
> These are first used in a subsequent commit.
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>  include/linux/acpi.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a9dbacabdf89..1124b7dc79fd 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -8,6 +8,7 @@
>  #ifndef _LINUX_ACPI_H
>  #define _LINUX_ACPI_H
>
> +#include <linux/cleanup.h>
>  #include <linux/errno.h>
>  #include <linux/ioport.h>      /* for struct resource */
>  #include <linux/resource_ext.h>
> @@ -221,6 +222,17 @@ void acpi_reserve_initial_tables (void);
>  void acpi_table_init_complete (void);
>  int acpi_table_init (void);
>
> +static inline struct acpi_table_header *acpi_get_table_ret(char *signatu=
re, u32 instance)

Maybe call this acpi_get_table_pointer() ?

> +{
> +       struct acpi_table_header *table;
> +       int status =3D acpi_get_table(signature, instance, &table);
> +
> +       if (ACPI_FAILURE(status))
> +               return ERR_PTR(-ENOENT);
> +       return table;
> +}
> +DEFINE_FREE(acpi_put_table, struct acpi_table_header *, if (!IS_ERR_OR_N=
ULL(_T)) acpi_put_table(_T))
> +
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>  int __init_or_acpilib acpi_table_parse_entries(char *id,
>                 unsigned long table_size, int entry_id,
> --

