Return-Path: <linux-acpi+bounces-1117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A8D7DD610
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C487B20A76
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7D82230C
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3091DDD0;
	Tue, 31 Oct 2023 16:51:52 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBE826A0;
	Tue, 31 Oct 2023 09:51:49 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5845b7ee438so540466eaf.1;
        Tue, 31 Oct 2023 09:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698771108; x=1699375908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKfeDXplD7QDzXFC59zNdGvt2XbDeFiAZ4OghKsIHeA=;
        b=VeHLt1TK1qXFrMce9A2oI+zRCvdpPST7IMTlvMnYNnw8DKfU8166vOPkXsYouePDpa
         W8fhyaAY3nwflt8I4w4R+Fp7WS85yGq8jpaTQYzW6/rAA+S56defM3BQeJ7+/XaB1Hxx
         m/zqs2+lLqb8kXmgVlhL+pNr1KJXAJWKWhiXI57BXK7QA0QjoYXrlrrFyhadRNfbCWyA
         +dKEJ7qXmzvmuJrbOatMpgTz9ND4XQnZq77JiWpgW7gRpy5tHKLbQH5ddviMCf7DWszm
         DiyG4Cp6WwsqSPVycK6FJ1KmMf0oC1WdwsueR1fQVHxBt43uIDSTaCYj4uYCex+s4tdt
         UGAg==
X-Gm-Message-State: AOJu0YzImQGq2OTBBPjoSdbV7AGnSLwuDL4XhYlc0jmQaqsMYbvxb5zi
	vDs2atu935AxoBIPd58VNfSa3mBZMHS/16Wd0jJc+9A2
X-Google-Smtp-Source: AGHT+IFCAu4DMA3LQYzEqnypCV6JeO0z1sUZ91LjW5HgWOTofT2ytKMj93D6aNNFWtzvbevMv+Zl+XUhXLForgIsw1k=
X-Received: by 2002:a4a:d8d1:0:b0:586:abc4:2c18 with SMTP id
 c17-20020a4ad8d1000000b00586abc42c18mr13300604oov.0.1698771108293; Tue, 31
 Oct 2023 09:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45750e0c-ce53-4994-8abc-19e75377ba5f@moroto.mountain>
In-Reply-To: <45750e0c-ce53-4994-8abc-19e75377ba5f@moroto.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Oct 2023 17:51:37 +0100
Message-ID: <CAJZ5v0g6We3QFyYkvhtNa2BhSokgUwM55X7qKDMxyfcL5cpEZw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: Fix acpi_thermal_unregister_thermal_zone() cleanup
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:53=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> The acpi_thermal_unregister_thermal_zone() is paired with
> acpi_thermal_register_thermal_zone() so it should mirror it.  It should
> clean up all the resources that the register function allocated and
> leave the stuff that was allocated elsewhere.
>
> Unfortunately, it doesn't call thermal_zone_device_disable().  Also it
> calls kfree(tz->trip_table) when it shouldn't.  That was allocated in
> acpi_thermal_add().  Putting the kfree() here leads to a double free
> in the acpi_thermal_add() clean up function.
>
> Likewise, the acpi_thermal_remove() should mirror acpi_thermal_add() so
> it should have an explicit kfree(tz->trip_table) as well.
>
> Fixes: ec23c1c462de ("ACPI: thermal: Use trip point table to register the=
rmal zones")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/acpi/thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index d98ff69303b3..f74d81abdbfc 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -702,9 +702,9 @@ static int acpi_thermal_register_thermal_zone(struct =
acpi_thermal *tz,
>
>  static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz=
)
>  {
> +       thermal_zone_device_disable(tz->thermal_zone);
>         acpi_thermal_zone_sysfs_remove(tz);
>         thermal_zone_device_unregister(tz->thermal_zone);
> -       kfree(tz->trip_table);
>         tz->thermal_zone =3D NULL;
>  }
>
> @@ -967,7 +967,7 @@ static void acpi_thermal_remove(struct acpi_device *d=
evice)
>
>         flush_workqueue(acpi_thermal_pm_queue);
>         acpi_thermal_unregister_thermal_zone(tz);
> -
> +       kfree(tz->trip_table);
>         acpi_thermal_free_thermal_zone(tz);
>  }
>
> --

Applied, thanks!

