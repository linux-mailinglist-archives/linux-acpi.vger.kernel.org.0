Return-Path: <linux-acpi+bounces-397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4897B7289
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 22:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5028E281234
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF53D962
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514FED2EB
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 18:57:20 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1706A7;
	Tue,  3 Oct 2023 11:57:18 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57bf04841ccso247500eaf.0;
        Tue, 03 Oct 2023 11:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696359438; x=1696964238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox0Selfc/25SDV9Q5jkJTLaDuAWtxvahlx8boOX57z8=;
        b=YcnTAg8kuFhLnBSF/ajXTqCijE7q1lPIPyXXhorWXBCKq6hBBPWl1AlmQCIoYycB/o
         S2ysuRlP8u3epd7msNJ5onE8LNLU/3DBUdN4iZOVgaFL+hwHFncqFDYxDWmpbjTe+Xz8
         R3JJpHxiAb02T7KT13kjoLrQkLW6O3zc6RQkV9zGIHlaQocwa9+TBsYwy8RYm3aZ9Dsd
         2DkRYAQ0QulEWKxrIjX3CQARwGnNWiflhtsXwLOZ5SQggNYrdOzPMD5pRxjH9rWgRyuU
         UWHh31XHMlqIcXDZP1NPCdOhb9cRfFVF1F8pweDF7Pfwfn8LiVlFYNs9iJPmv7n2of1t
         42kA==
X-Gm-Message-State: AOJu0YxvhHicb8Mnqtyd8wetB0b1uh3N2kN1grCNB7hIkEfv8jK5n+n4
	H147wtUe7a4fsjxag4oYX4FjIzYRX5kgyeWJ+WU=
X-Google-Smtp-Source: AGHT+IFc770QxCiRdEXoSuA4LwACsS/D4asXOGsel4is2Y9vaiEzom8WVcKBQ+RnwVSORl2YT/uuqD89QXrny6x10vA=
X-Received: by 2002:a4a:ee90:0:b0:57b:94b7:c6ba with SMTP id
 dk16-20020a4aee90000000b0057b94b7c6bamr278994oob.0.1696359438232; Tue, 03 Oct
 2023 11:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928221344.44289-1-bergh.jonathan@gmail.com>
In-Reply-To: <20230928221344.44289-1-bergh.jonathan@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 20:57:06 +0200
Message-ID: <CAJZ5v0i2h875LC6pxUcusJqPULKyQtTK3e_Fjz7RAM=mBN+bBw@mail.gmail.com>
Subject: Re: [PATCH] drivers: acpi: Fix formatting issues where braces should
 be on newlines
To: Jonathan Bergh <bergh.jonathan@gmail.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 12:31=E2=80=AFAM Jonathan Bergh
<bergh.jonathan@gmail.com> wrote:
>
> Fix the following formatting issues in thermal.c:
>  * braces following function declarations should be on a new line
>  * add single line between function declarations
>
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/acpi/thermal.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 312730f8272e..dea5f8a51f87 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -1046,7 +1046,8 @@ static struct acpi_driver acpi_thermal_driver =3D {
>         .drv.pm =3D &acpi_thermal_pm,
>  };
>
> -static int thermal_act(const struct dmi_system_id *d) {
> +static int thermal_act(const struct dmi_system_id *d)
> +{
>         if (act =3D=3D 0) {
>                 pr_notice("%s detected: disabling all active thermal trip=
 points\n",
>                           d->ident);
> @@ -1054,13 +1055,17 @@ static int thermal_act(const struct dmi_system_id=
 *d) {
>         }
>         return 0;
>  }
> -static int thermal_nocrt(const struct dmi_system_id *d) {
> +
> +static int thermal_nocrt(const struct dmi_system_id *d)
> +{
>         pr_notice("%s detected: disabling all critical thermal trip point=
 actions.\n",
>                   d->ident);
>         crt =3D -1;
>         return 0;
>  }
> -static int thermal_tzp(const struct dmi_system_id *d) {
> +
> +static int thermal_tzp(const struct dmi_system_id *d)
> +{
>         if (tzp =3D=3D 0) {
>                 pr_notice("%s detected: enabling thermal zone polling\n",
>                           d->ident);
> @@ -1068,7 +1073,9 @@ static int thermal_tzp(const struct dmi_system_id *=
d) {
>         }
>         return 0;
>  }
> -static int thermal_psv(const struct dmi_system_id *d) {
> +
> +static int thermal_psv(const struct dmi_system_id *d)
> +{
>         if (psv =3D=3D 0) {
>                 pr_notice("%s detected: disabling all passive thermal tri=
p points\n",
>                           d->ident);
> --

Applied as 6.7 material (with edited subject and changelog), thanks!

