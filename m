Return-Path: <linux-acpi+bounces-1749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBAA7F4D15
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 17:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1191C204F5
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A056B75
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36214109
	for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 07:25:42 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58a106dd421so306451eaf.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 07:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700666741; x=1701271541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMOxtFY6vWKRRv66xbvZdMMKO7h5vSyrulsXjVdSHlk=;
        b=XF5LV7Rx5SgYNBbhkW6nj0K/w0siyvRARhZji9TRCblVmXNEaSNE34hXHUI4bileYN
         TAN3Of1UrP/jJMqC+G7k7k+9FznGLxacscYwlP6ZjuOgij82xl33QZ8CFGt+EY2L6myA
         coZ0AGKukNomHaUopj77urw6f0+pFAtDgYAY6xRB38IWIHKZLjIZpDQNK1pSm1TO6KMV
         aYyNJ1yRuI899waCv3xxg+viOk0g9zTvPNdED36mLhwonRCyUrvNRejDhLdgB6IJRjX+
         N3psv9cMQ8n+0K+s0UTRCurPfx0Sk+UDyJxYZCFaqx33N5FlmcHjfjfNElljkSc1Gfl3
         K7Fw==
X-Gm-Message-State: AOJu0YwuOnv4rod5xXKgasIX3upumaMIDTtYJ0dyR3Q1s4cOkuZzwh2B
	D0nxtT2AlqX8scXSJJ9ped1NCcf+zyu/Ra/ca9Y=
X-Google-Smtp-Source: AGHT+IGNJOCwSbTb4tJr/fGWGiDnIqVd+ebxw/eAN+BSfCiNiMoYU8LM0mI8Z1alPVn6sdFg2RBPACSXZSq/vcIjs+s=
X-Received: by 2002:a4a:a604:0:b0:589:daaf:44a1 with SMTP id
 e4-20020a4aa604000000b00589daaf44a1mr2916605oom.0.1700666741336; Wed, 22 Nov
 2023 07:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120173053.49597-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231120173053.49597-1-u.kleine-koenig@pengutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 16:25:30 +0100
Message-ID: <CAJZ5v0iW_B72o8EMbZaH_x2SOHOvqnieP8EsK2A6d93GRDYtBA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 6:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Instead of returning an error code, emit a better error message than the
> core. Apart from the improved error message this patch has no effects
> for the driver.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> I tried to improve this driver before, see
>
>         https://lore.kernel.org/linux-acpi/CAJZ5v0ifb-wvyp0JRq_4c1L6vTi_q=
EeXJ6P=3DPmmq_56xRL74_A@mail.gmail.com
>         https://lore.kernel.org/linux-arm-kernel/20221219221439.1681770-1=
-u.kleine-koenig@pengutronix.de
>         https://lore.kernel.org/linux-arm-kernel/20221220154447.12341-1-u=
.kleine-koenig@pengutronix.de
>
> but this didn't result in any patch being applied.
>
> I think it's inarguable that there is a problem that wants to be fixed.
> My tries to fix this problem fixxled out, so here comes a minimal change
> that just points out the problem and otherwise makes ghes_remove()
> return void without further side effects to allow me to continue my
> quest to make platform_driver remove callbacks return no error.

Tony, Boris, any objections against this patch?

>  drivers/acpi/apei/ghes.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 63ad0541db38..dd8cd10b7809 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1438,7 +1438,7 @@ static int ghes_probe(struct platform_device *ghes_=
dev)
>         return rc;
>  }
>
> -static int ghes_remove(struct platform_device *ghes_dev)
> +static void ghes_remove(struct platform_device *ghes_dev)
>  {
>         int rc;
>         struct ghes *ghes;
> @@ -1475,8 +1475,15 @@ static int ghes_remove(struct platform_device *ghe=
s_dev)
>                 break;
>         case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
>                 rc =3D apei_sdei_unregister_ghes(ghes);
> -               if (rc)
> -                       return rc;
> +               if (rc) {
> +                       /*
> +                        * Returning early results in a resource leak, bu=
t we're
> +                        * only here if stopping the hardware failed.
> +                        */
> +                       dev_err(&ghes_dev->dev, "Failed to unregister ghe=
s (%pe)\n",
> +                               ERR_PTR(rc));
> +                       return;
> +               }
>                 break;
>         default:
>                 BUG();
> @@ -1490,8 +1497,6 @@ static int ghes_remove(struct platform_device *ghes=
_dev)
>         mutex_unlock(&ghes_devs_mutex);
>
>         kfree(ghes);
> -
> -       return 0;
>  }
>
>  static struct platform_driver ghes_platform_driver =3D {
> @@ -1499,7 +1504,7 @@ static struct platform_driver ghes_platform_driver =
=3D {
>                 .name   =3D "GHES",
>         },
>         .probe          =3D ghes_probe,
> -       .remove         =3D ghes_remove,
> +       .remove_new     =3D ghes_remove,
>  };
>
>  void __init acpi_ghes_init(void)
>
> base-commit: 5a82d69d48c82e89aef44483d2a129f869f3506a
> --
> 2.42.0
>

