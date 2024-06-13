Return-Path: <linux-acpi+bounces-6381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7788A907C7F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 21:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE088B265AC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D4114C585;
	Thu, 13 Jun 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1BosQHa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCC14D29B;
	Thu, 13 Jun 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306340; cv=none; b=Lwm0PFJA56/PDnQ9YtwF4YRr3aUzxo8+QceC9Rt3/8MmFU4UstU7EO3ShZ7Kh2TwTfUjM5NnKJtWaV78ZE26CWzmkcNBbfSOZmGrqicjlzaYN34+JimQMuiv0JBPwpFjQNAjLl0HJmGswIYOhPN+eQsp5JbfQSrUUoRK/cnyNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306340; c=relaxed/simple;
	bh=ay6UQtlKFWBDuxIwmYNg3cJJuKswWcYHFlUK5oXmK44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GodODo72kTARL8HlhAOoFJuhepgPfcd50CeLuwpAhlGobI2N8sBg92eC5TI/nzP3AYOoXIn8b2DJuZAg3uHXGbLE4DkUwRyganxUvCNVODdwGa3EbdTPag1peJYhFSNP4SyT66UIVxD99dXolTILacp6vDpU0+rbmKlJZUdmwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1BosQHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2019FC2BBFC;
	Thu, 13 Jun 2024 19:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718306340;
	bh=ay6UQtlKFWBDuxIwmYNg3cJJuKswWcYHFlUK5oXmK44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L1BosQHaKT3yUcBeF2YFAasNNr4433f9Vxk9AU567opQ99YxAW6KHKPO30H4O2MOc
	 9AYkCIsEOyTioXqx0S0/8lDml0MklLqs2ZcYTtlmvmGFVHSU6s3+yVILnmOSzr8/SV
	 1XlNE/zLA4xcDaKVcCCAJVJ4UDuwUO/qMAJfMzcVzmpNEvI6cHHHojf8yaEWecH5Rr
	 rrd/foMxzPJHf0UPlPHv5zwFYgaugQaozt5ZDxpd9n4EsYXeyklTskdJN3krlX+Flp
	 jEI0X8PLxRh6ibD7cVqJHcdEA7h0DS3ci9bQdvPpcHrOPn4YszM1YT+f/CPqxWdZT3
	 sddcXxvRc4Ymg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d1b8bacf67so208690b6e.2;
        Thu, 13 Jun 2024 12:19:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVz+Ac0K18Zk36tn39Oljybc/wSPB9z+LDmNN+Kqohxbn1d94Pw+XOXNGk6Lwq/EsY8xQ/NDrfIDrhmccPskyKqvgMvnBJGm2glT7MnMY4XQvO1e+YDI6ob7e8i1vJRzaC81p0jlZhLFg==
X-Gm-Message-State: AOJu0YwPo5TMbhIRcphcfV/X7innvmgGzk2Qm44n5LQvQnNTUfhU73Fa
	cQnmi0wK1+J894u/ueIPtvw4+NlCWHuSkMyn8zlVhiEpsaqAGqJPW6P52q9f8ypFtE96+t8X4Gg
	0b14xis/FSqCTjtZ9D8GY4gTsQag=
X-Google-Smtp-Source: AGHT+IFypBwee/3o3ZPXmp27CBQk3kxaqCh0xqesZ8ebhhA1CzmQO2FleW9pSvsQUQPdklQ0fl3qauN0WAhBRYs2H5U=
X-Received: by 2002:a05:6870:472c:b0:254:abd6:1a3d with SMTP id
 586e51a60fabf-25842c4d336mr487236fac.4.1718306339414; Thu, 13 Jun 2024
 12:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606185200.1596-3-thorsten.blum@toblux.com>
In-Reply-To: <20240606185200.1596-3-thorsten.blum@toblux.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 21:18:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jqWL8Ao6TCk71QWfEb4msPp8QYFac1LPytJj5K6_0Aag@mail.gmail.com>
Message-ID: <CAJZ5v0jqWL8Ao6TCk71QWfEb4msPp8QYFac1LPytJj5K6_0Aag@mail.gmail.com>
Subject: Re: [PATCH] ACPI/NUMA: Consolidate header includes
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 8:53=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux.=
com> wrote:
>
> The header file acpi/acpi_numa.h is included whether CONFIG_ACPI is
> defined or not.
>
> Include it only once before the #ifdef/#else/#endif preprocessor
> directives and fix the following make includecheck warning:
>
>         acpi/acpi_numa.h is included more than once
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  include/linux/acpi.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 28c3fb2bef0d..bb18e7bf8826 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -24,6 +24,7 @@ struct irq_domain_ops;
>  #define _LINUX
>  #endif
>  #include <acpi/acpi.h>
> +#include <acpi/acpi_numa.h>
>
>  #ifdef CONFIG_ACPI
>
> @@ -35,7 +36,6 @@ struct irq_domain_ops;
>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> -#include <acpi/acpi_numa.h>
>  #include <acpi/acpi_io.h>
>  #include <asm/acpi.h>
>
> @@ -777,8 +777,6 @@ const char *acpi_get_subsystem_id(acpi_handle handle)=
;
>  #define acpi_dev_uid_match(adev, uid2)                 (adev && false)
>  #define acpi_dev_hid_uid_match(adev, hid2, uid2)       (adev && false)
>
> -#include <acpi/acpi_numa.h>
> -
>  struct fwnode_handle;
>
>  static inline bool acpi_dev_found(const char *hid)
> --

Applied as 6.11 material, thanks!

