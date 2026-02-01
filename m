Return-Path: <linux-acpi+bounces-20809-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L41Oy3Yf2kIygIAu9opvQ
	(envelope-from <linux-acpi+bounces-20809-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 23:48:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A582C7733
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 23:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18F0E30010D5
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7902EB840;
	Sun,  1 Feb 2026 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7ZWswdj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32C26059D
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986088; cv=none; b=EmlTEFRMZo4J5EZsvzydph9ynxERx740WgMrfyDhfNul6hRF2e+1pxHKAzeG0iPNmzwulym+pwDgbbO+UXxu6TNi6sc0uu0HQq6VnUk5+l44RMv58uboDuHZKOH4AkDmj+VtTwYl8gaCEqAI57HtR6QTjTrEgnesU8MBb4RiYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986088; c=relaxed/simple;
	bh=kPXYKw64d+jtcY3lxRoah56tsMgtUtCgn6SKRHtQhDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZOPHc8o92nCETcUC0op3LR0J5b1VIECZ15PH8I+HwzsJfgBw9wwp2fBzb+xwBdOlTpdEuxnrCgwmoUQdn+uYEQgMWPuC+EuG2ejmi58BrRJqI6l25vyqC1XelZiMrI09/7DJksbnhpx5TWnfKxOgZjMlZaL3TW0IGa7Zq/JLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7ZWswdj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so42663165e9.2
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 14:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769986083; x=1770590883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeIFE62uRClcxIIMvVybquzDz6/s2PS0WZIdflKEiOA=;
        b=D7ZWswdjF7qpoOkdna7lZwCTT2wYVogvp4P2zVBD2ZZE8Qx+gE9f/u6vILiPomZvG7
         idA3tEGsdX2LEe1toz9qbey9+EgirwZhnZKOlJjMUz3Jz8zcJuttBYglcuy+zuh+VfbR
         yvhKCZSJqOZz80TcWtjlLOpXE8bDc7n0RerbsQZoPjn3xNOvXShHJzvNBNVs1uYKFMbu
         hSfngsqXsC6Sd0boIHxQJA3QnwUuAEwjM1oJnHDbsOfNgjSPpDlTaHQ5wpf8JfCDwqZ7
         MhG+E3KpVQ1Vatkz6IIyaqdYlgr+RW7G1h8mbbzGysGlE8MsKSTEtv/stWA7PlLtjglv
         EYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769986083; x=1770590883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yeIFE62uRClcxIIMvVybquzDz6/s2PS0WZIdflKEiOA=;
        b=RP5Ja/nWVdzVLAMyk7g3tgWlO+VeL/+wimPB3SAnrrwJVwA0hMygwiQmGtY5TbBjJp
         yvY1Z49FydypA8ul4yv2LJEr6upVNMH4l5tv02C8dLpmlTDKHZXTm+XiDNsTxKid3lQT
         njjdidRMP1RBOMPZMH2k5a2MTXRuKILtwnGWrOpiQErkPB2zoeQ3x9yNaMYGiLk/X1DM
         DY+8XBQI+ZrDk2yIzXqGQELZolL2tGSIbRyIlhxTZV92ePr6X36d6UvXBujrcx/nGfvs
         7w0lvpR33XCgkVqu15NADS/BlrCDHRMzGPeBFQr3BSputqqlvpzVkoHaIIiOarE+3e8l
         pFUA==
X-Forwarded-Encrypted: i=1; AJvYcCU2SmEZyKsmXPH0A0K04cPBeEye07vf/67GjmuRUAd8hveW+UEyR/MgXYoXyuP0iiB9mGAIEmjjJzT0@vger.kernel.org
X-Gm-Message-State: AOJu0YzBGyxRifXUmcQgu4TI79nSYmXJuKfQEDyfO2b27ymkBGECqcrm
	M+C7B1KbyeAmmERk6MWZNpZgBJVLEee4fXQeHrfdk95wLHQRndRE+zz8
X-Gm-Gg: AZuq6aJmGVSgkzzL2djHe/uaulCmJCefTB1YQHl1gxujfn34wVQKoFRQpzyee+V9lh7
	4ERFZfragFUS/JRuMZpiAL3UYuJJNKxabgi8g1Fq8TdNH+hOn3lLD1ZV2L6b3AKj/v/p8Fi6BhD
	59Cfa+V91z/Bg9Gz3IwhR8ST9+9zamMAJW66yYQmKbANzEqRVAmdAiG9wPsLe5yct4r3pLNEpCR
	E4Q0+6PqDYoUyvB1vjpZ0y0nD39hVmrzM3Tomi+UmxI1qRFwkJwgLPvAu87ww5zuuGszOWxmhfO
	6xjC5ONTwJbW/MPiiEjbC8YJYJguygQpKpDhJLhf4pkDul0tzd8cRo+/N1SVkHlzLeYVGxDLou3
	gPF9vKPXVl9Y0GHAYrQm+IUbnoxzoRGC+IbX5HMOB9aAQTnAXL51U/o6JQWNkAErDW4mH5K1oL9
	KDGz/My37gWG+xe3wSifwsRUUgKR30HLnuCS2PZqlEdSZv2j6EgB1H
X-Received: by 2002:a05:600c:6214:b0:480:1c53:208b with SMTP id 5b1f17b1804b1-482db49da0bmr116715605e9.36.1769986083142;
        Sun, 01 Feb 2026 14:48:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c42895sm429732215e9.14.2026.02.01.14.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 14:48:02 -0800 (PST)
Date: Sun, 1 Feb 2026 22:48:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Huang <sef1548@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, paladin@ntub.edu.tw, kusogame68@gmail.com,
 ceyanglab@gmail.com, n1136402@ntub.edu.tw
Subject: Re: [PATCH 1/2] ACPI: nsrepair2: Replace =?UTF-8?B?TyhuwrIp?=
 bubble sort with O(n log n) sort_r()
Message-ID: <20260201224801.609e94d0@pumpkin>
In-Reply-To: <20260201130334.3107-2-sef1548@gmail.com>
References: <20260201130334.3107-1-sef1548@gmail.com>
	<20260201130334.3107-2-sef1548@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20809-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,vger.kernel.org,lists.linux.dev,ntub.edu.tw,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A582C7733
X-Rspamd-Action: no action

On Sun,  1 Feb 2026 13:03:33 +0000
Nick Huang <sef1548@gmail.com> wrote:

>    Replace the O(n=C2=B2) bubble sort implementation in acpi_ns_sort_list=
()
>    with the kernel's sort_r() function which uses heapsort, providing
>    O(n log n) time complexity.
>=20
>    This improves performance for large ACPI package lists while also
>    reducing code complexity by leveraging the existing kernel sort API.

What is the break even size?
While the heapsort is O(n long n) it is also more complicated.
There is also the cost of the function call - especially with all the
mitigations that distro kernels are likely to enable.

For large datasets the d-cache locality of both sorts is particularly horri=
d.
It is almost certainly better to allocate an array of index:value pairs
and sort that.
For very big datasets you want to sort small sections (that fit in the
d-cache) and then use merge sorts (also O(n log n)) to combine them.
(Yes - this is how you sort data with 3 mag-tape drives....)

Oh, in any case, write separate functions for ascending/descending.

	David

>=20
> Signed-off-by: Nick Huang <sef1548@gmail.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 87 +++++++++++++++++++++++----------
>  1 file changed, 62 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 8dbb870f4..a39ef59fe 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -9,6 +9,7 @@
>   ***********************************************************************=
******/
> =20
>  #include <acpi/acpi.h>
> +#include <linux/sort.h>
>  #include "accommon.h"
>  #include "acnamesp.h"
> =20
> @@ -84,6 +85,14 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *i=
nfo,
>  static void
>  acpi_ns_remove_element(union acpi_operand_object *obj_desc, u32 index);
> =20
> +/* Context structure for sort comparison function */
> +struct acpi_sort_context {
> +	u32 sort_index;
> +	u8 sort_direction;
> +};
> +
> +static int acpi_ns_sort_cmp(const void *a, const void *b, const void *pr=
iv);
> +
>  static void
>  acpi_ns_sort_list(union acpi_operand_object **elements,
>  		  u32 count, u32 index, u8 sort_direction);
> @@ -851,6 +860,52 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info =
*info,
>  	return (AE_OK);
>  }
> =20
> +/***********************************************************************=
*******
> + *
> + * FUNCTION:    acpi_ns_sort_cmp
> + *
> + * PARAMETERS:  a               - First element to compare
> + *              b               - Second element to compare
> + *              priv            - Pointer to sort context (acpi_sort_con=
text)
> + *
> + * RETURN:      -1, 0, or 1 depending on sort order
> + *
> + * DESCRIPTION: Comparison function for sort_r() API. Compares the integ=
er
> + *              values at the specified index within package elements.
> + *
> + ***********************************************************************=
******/
> +
> +static int acpi_ns_sort_cmp(const void *a, const void *b, const void *pr=
iv)
> +{
> +	union acpi_operand_object *obj_a =3D *(union acpi_operand_object **)a;
> +	union acpi_operand_object *obj_b =3D *(union acpi_operand_object **)b;
> +	const struct acpi_sort_context *ctx =3D priv;
> +	union acpi_operand_object *value_a;
> +	union acpi_operand_object *value_b;
> +	u64 a_val;
> +	u64 b_val;
> +
> +	value_a =3D obj_a->package.elements[ctx->sort_index];
> +	value_b =3D obj_b->package.elements[ctx->sort_index];
> +
> +	a_val =3D value_a->integer.value;
> +	b_val =3D value_b->integer.value;
> +
> +	if (ctx->sort_direction =3D=3D ACPI_SORT_ASCENDING) {
> +		if (a_val < b_val)
> +			return -1;
> +		if (a_val > b_val)
> +			return 1;
> +	} else {
> +		if (a_val > b_val)
> +			return -1;
> +		if (a_val < b_val)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  /***********************************************************************=
*******
>   *
>   * FUNCTION:    acpi_ns_sort_list
> @@ -873,31 +928,13 @@ static void
>  acpi_ns_sort_list(union acpi_operand_object **elements,
>  		  u32 count, u32 index, u8 sort_direction)
>  {
> -	union acpi_operand_object *obj_desc1;
> -	union acpi_operand_object *obj_desc2;
> -	union acpi_operand_object *temp_obj;
> -	u32 i;
> -	u32 j;
> -
> -	/* Simple bubble sort */
> -
> -	for (i =3D 1; i < count; i++) {
> -		for (j =3D (count - 1); j >=3D i; j--) {
> -			obj_desc1 =3D elements[j - 1]->package.elements[index];
> -			obj_desc2 =3D elements[j]->package.elements[index];
> -
> -			if (((sort_direction =3D=3D ACPI_SORT_ASCENDING) &&
> -			     (obj_desc1->integer.value >
> -			      obj_desc2->integer.value))
> -			    || ((sort_direction =3D=3D ACPI_SORT_DESCENDING)
> -				&& (obj_desc1->integer.value <
> -				    obj_desc2->integer.value))) {
> -				temp_obj =3D elements[j - 1];
> -				elements[j - 1] =3D elements[j];
> -				elements[j] =3D temp_obj;
> -			}
> -		}
> -	}
> +	struct acpi_sort_context ctx;
> +
> +	ctx.sort_index =3D index;
> +	ctx.sort_direction =3D sort_direction;
> +
> +	sort_r(elements, count, sizeof(union acpi_operand_object *),
> +	       acpi_ns_sort_cmp, NULL, &ctx);
>  }
> =20
>  /***********************************************************************=
*******


