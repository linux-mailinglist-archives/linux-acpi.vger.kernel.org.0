Return-Path: <linux-acpi+bounces-195-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8F57B06E7
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C6330282645
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E07328AF
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718C125CC
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 13:00:33 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBD89F;
	Wed, 27 Sep 2023 06:00:32 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-57be74614c0so439055eaf.1;
        Wed, 27 Sep 2023 06:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695819631; x=1696424431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UowtY9Y57ZHYtV50QD+m/C2BoRLwstcWDx8SsaL2Xk=;
        b=LiNfg38k1b8Wsn+r5Bxh+TepygphhumQq4vQtAiyHyxmQuc8P55fE3QR5ygs+ax+Jf
         sgTIIKqiusbE9V2Yrp24//wXJplKvE1VAAtpUz0t7LKSTwQwvItGYuiMqp5GOhpjh9yU
         BdPfriPoCslpLb0g0lM0Yae4JvnhXdlecKYE0h5eEij5mNFwqQUYNXRCvKxKKnyeB4qv
         DUemAjbzUn15JzqWGJl+z8tyb6a+WdkndhhDSpwYWxufpSd97Mv5+h2F1j53BXhmcd9F
         Tp7ZeIryMx147Ou20K6fOSEJsAeqQByoyahA/YUJx9VbFh1r5Z041+ijv3NJOhv5nIjM
         ZjNQ==
X-Gm-Message-State: AOJu0YzLGbw3CCw6Cw9UAgOoy4ysuHXmWa2tcb7ryvP7tC7qLTBQOtei
	7rf3PNUuJkC4EKRq/Uc+GKVhOEd2hrsHCdTe1JQ=
X-Google-Smtp-Source: AGHT+IE7jZEvC22EjnPYoZA8DpH3DSvAtrBQSQS7hvSbjup+O/6tl3gJ7uJ9LDcxGygit7dzkZ0cGCoZNYT4BhmXVs4=
X-Received: by 2002:a4a:e687:0:b0:57b:3b64:7ea5 with SMTP id
 u7-20020a4ae687000000b0057b3b647ea5mr2182482oot.1.1695819631322; Wed, 27 Sep
 2023 06:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37eb30ba-1dc9-42e7-a22e-af44f6270e67@moroto.mountain>
In-Reply-To: <37eb30ba-1dc9-42e7-a22e-af44f6270e67@moroto.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Sep 2023 15:00:20 +0200
Message-ID: <CAJZ5v0gQ38rFaYuHdFBhjf+S-BGeWj8kWf_M6WUSYwwOrcP-Tw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: Fix a small leak in acpi_thermal_add()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 2:37=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Free "tz" if the "trip" allocation fails.
>
> Fixes: 5fc2189f9335 ("ACPI: thermal: Create and populate trip points tabl=
e earlier")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/acpi/thermal.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 10720a038846..f8a95939c88d 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -928,8 +928,10 @@ static int acpi_thermal_add(struct acpi_device *devi=
ce)
>         acpi_thermal_guess_offset(tz, crit_temp);
>
>         trip =3D kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
> -       if (!trip)
> -               return -ENOMEM;
> +       if (!trip) {
> +               result =3D -ENOMEM;
> +               goto free_memory;
> +       }
>
>         tz->trip_table =3D trip;
>
> --

Applied, thanks!

