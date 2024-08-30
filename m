Return-Path: <linux-acpi+bounces-8006-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728719660C1
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 13:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273071F233C5
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED3D17BB0A;
	Fri, 30 Aug 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxjkoAYY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B14E152170
	for <linux-acpi@vger.kernel.org>; Fri, 30 Aug 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017468; cv=none; b=fU2hLvnijR4HECbkA5OYc40a4o68v4xGT3KSqOn4ZKjgY/diBR/TqbshjlDaoTC9BEAeRbNXaThZT8yHsfDaZoG9AfUXIFDOe8NXZ/QixYgzP1ggVheNcT+8AHr8EwXThIPszouZ7/WXp2BEp2hwDO/mUOiZIj7e4IALZfUQRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017468; c=relaxed/simple;
	bh=oaoA/hJd3wzTSBowZT+QNt0PUjVFnEnqJxKWIK5k9UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhkOqk66M7nXvZnsk8FQaes4sXlTMkmmEhMqnNXN9ElfLjqQKi1eoCUAe/4ule6FifyFvxuat6KkEI7pjvIRvnQ/rCSYqSt+WTkTSoXv+42iLgd/WtHrswH4pCTQ7T7xUFA9hZ5f8EBd+lyMPNeTkfaUDFgm7EPhd21k8SMnUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxjkoAYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D5DC4CEC7
	for <linux-acpi@vger.kernel.org>; Fri, 30 Aug 2024 11:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725017468;
	bh=oaoA/hJd3wzTSBowZT+QNt0PUjVFnEnqJxKWIK5k9UU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KxjkoAYYiHhhBYwxmkkdBZiw0ChubUTx8OTLKm67sWumEseyOxwWfc14duC3ffMCm
	 EsH06IUz2ASix5Fl1ZoXvh69BLJnKGZj/yXgMKQBT294Fq+8z4hRPF8DTwfFhQz4cy
	 vVdD1hiWFWjkYEofilm+MLWVrcAXRd7JsdegH9niCbfma817RZia5XcOGo3fkVSeDP
	 NeH2FbzOTG+w02sTZFMyJrd8bL4pp8lTLLt+YKu958mPk++WCa0UrfulKbESAIaomv
	 NeScOe0uCfyVa7Exf6bPXkV8DMrM6TNuxSnnzSHO3r6oaZZYbN7/xKXsnVPkU3jFmV
	 LwxMZgrQG2/vQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5df9dec9c0eso1095465eaf.2
        for <linux-acpi@vger.kernel.org>; Fri, 30 Aug 2024 04:31:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhA7lFYl77foVTlBggMc5rSiFIckGbPAesGYOh657BxnP4Q8Zj3WAkF/u7BD/eXKMEin/9Ed+jmON+@vger.kernel.org
X-Gm-Message-State: AOJu0YwFvpT0foyCRO9pItI05qtqtFobDnSlZ0cAjxFlBSRsPcPtmUSy
	pz288wMAlo1tCyt5QaqditVyq2urQ8BrjPWRSZGQmWAYjnDOAgVkbJ/M9HrZz5qQeCkC9Q+tBV/
	binofWSwafZSV6vXhyAfYed3JJQc=
X-Google-Smtp-Source: AGHT+IHh8Q6yhUzfR5b1AdChCVseAFNNBFw4IFVoRCrd0lkybEuGHzKx7m8eXyTXjPjY189nAaDn1xrvctzykRWFsRo=
X-Received: by 2002:a05:6820:545:b0:5c6:8eb6:91b2 with SMTP id
 006d021491bc7-5dfacdde2c6mr2025121eaf.1.1725017467434; Fri, 30 Aug 2024
 04:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830075403.3540985-1-lihongbo22@huawei.com>
In-Reply-To: <20240830075403.3540985-1-lihongbo22@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Aug 2024 13:30:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1Ya4HHi_R2oCKjUsXfCerG1hY6KHd6r-Rtf=xTX7w2g@mail.gmail.com>
Message-ID: <CAJZ5v0h1Ya4HHi_R2oCKjUsXfCerG1hY6KHd6r-Rtf=xTX7w2g@mail.gmail.com>
Subject: Re: [PATCH -next] ACPICA: Use swap() to improve code
To: Hongbo Li <lihongbo22@huawei.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 9:46=E2=80=AFAM Hongbo Li <lihongbo22@huawei.com> w=
rote:
>
> Use the swap() macro to simplify the code and improve its
> readability.
>
> The target code segment uses the bubble sort, we can use
> this macro to simplify the code.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

To make changes in ACPICA, please submit a pull request to the
upstream ACPICA project on GitHub.

Once your upstream ACPICA pull request has been merged, please submit
a corresponding Linux patch pointing to the original upstream ACPICA
commit.

Thanks!

> ---
>  drivers/acpi/acpica/nsrepair2.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 1bb7b71f07f1..5d56b2fd9151 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **element=
s,
>  {
>         union acpi_operand_object *obj_desc1;
>         union acpi_operand_object *obj_desc2;
> -       union acpi_operand_object *temp_obj;
>         u32 i;
>         u32 j;
>
> @@ -891,11 +890,8 @@ acpi_ns_sort_list(union acpi_operand_object **elemen=
ts,
>                               obj_desc2->integer.value))
>                             || ((sort_direction =3D=3D ACPI_SORT_DESCENDI=
NG)
>                                 && (obj_desc1->integer.value <
> -                                   obj_desc2->integer.value))) {
> -                               temp_obj =3D elements[j - 1];
> -                               elements[j - 1] =3D elements[j];
> -                               elements[j] =3D temp_obj;
> -                       }
> +                                   obj_desc2->integer.value)))
> +                               swap(elements[j - 1], elements[j]);
>                 }
>         }
>  }
> --
> 2.34.1
>
>

