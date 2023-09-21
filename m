Return-Path: <linux-acpi+bounces-43-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886A67AA03F
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 22:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639C31C20845
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB1519455
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 20:35:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB912B69
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 18:53:09 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD37914FD;
	Thu, 21 Sep 2023 11:52:48 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ae0df6494bso68213b6e.1;
        Thu, 21 Sep 2023 11:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322368; x=1695927168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S368RYIxIE+vfbv4FtAkq0lxjLR2QQXx+z91SUfGEkA=;
        b=JLHc4XAtJy9L4auLTrVerezSNqQGMotveQFaLVrVIkCWsNuUT9Dhi9zcff8ES3/K49
         f0CGvKT95ZsWgQU3QPMXF5WZsqrg0h4sBx0geT5N96UD9MLu/wgB9lRdECYgy8/LWxEr
         K+xrD+AWv3KK2WPYQBy5Fd56Gcmi+ZfTkXHNAD7YhywxOpmEGUIjF/wE2GrquXX2Gjdb
         XRg41Rksp/mHmGguN39HNxVsy4zFsxRdgQ3pWeAiMCqHSY7NWtNi7d2xHpjGGwNCXRF1
         fmPPOCiABCE16Aob0M29RYT+ymHN2DscukHI0PWXq0w5CUCv36Ndhj60SvfL9RpBBNMc
         x7Dg==
X-Gm-Message-State: AOJu0YxQ17+zMsY3l25fsEefcthm1FwQNR35G4hguRY6oarl5hn+DAwP
	Fc6kcmHnVdPr7+O5ZanR/BTdDwbb0z61a2KlVfnWhksj
X-Google-Smtp-Source: AGHT+IEn8NLYB0nu5g45X7aTiJystRGnaPlbDekU48JgG/maT3448p4/tZ9WQhxai3uevSrP3pklcUd3uC3Bbhpwqow=
X-Received: by 2002:a05:6808:1496:b0:3ab:8ae5:e7c6 with SMTP id
 e22-20020a056808149600b003ab8ae5e7c6mr7272698oiw.1.1695322367835; Thu, 21 Sep
 2023 11:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831073456.1713093-1-suhui@nfschina.com>
In-Reply-To: <20230831073456.1713093-1-suhui@nfschina.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Sep 2023 20:52:37 +0200
Message-ID: <CAJZ5v0gH6XF1tD7=8O1Qb8OA2U-8MOS7EiLUUN-TBOo69+qQhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: OSL: add __printf format attribute to acpi_os_vprintf
To: Su Hui <suhui@nfschina.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 9:35=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> With gcc and W=3D1 option to compile kernel, warning happends:
>
> drivers/acpi/osl.c:156:2: error:
> function =E2=80=98acpi_os_vprintf=E2=80=99 might be a candidate for =E2=
=80=98gnu_printf=E2=80=99
> format attribute [-Werror=3Dsuggest-attribute=3Dformat].
>
> Allow the compiler to recognize and check format strings is safer.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/acpi/osl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f725813d0cce..357f1325485d 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -149,7 +149,7 @@ void acpi_os_printf(const char *fmt, ...)
>  }
>  EXPORT_SYMBOL(acpi_os_printf);
>
> -void acpi_os_vprintf(const char *fmt, va_list args)
> +void __printf(1, 0) acpi_os_vprintf(const char *fmt, va_list args)
>  {
>         static char buffer[512];
>
> --

Applied (with some subject and changelog edits) as 6.7 material, thanks!

