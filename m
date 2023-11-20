Return-Path: <linux-acpi+bounces-1629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3862D7F1CC2
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 19:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665981C20F6F
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC332181
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D6198A;
	Mon, 20 Nov 2023 08:45:18 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5841a3ffd50so167062eaf.1;
        Mon, 20 Nov 2023 08:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700498716; x=1701103516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkAGuCakBDhIxabLKIQHjls5jYpV9LhzQ/PhHmuLCvo=;
        b=qaWL556B4Xz0eA/avzJMWyRrPFGpdzlTCyVDb9U8gyrzCA/BbT387hD2PXpdrOLUww
         pgQJoCl1HRfq9iZwlYJapiVMLpMYZ5Z/EKh1ixhZH38NiJGWz6ROncDagzHBEVh4aLgT
         VaAH7rIjLtPSsCA+m057tmAYzNSh8EC3wa7PKGZztW4DlLfQOSYzqdvfT8JGuS5LhEC2
         jkTYS9O9J3LGHU6WXqtBRLM8VOOlYsxNjeIASC5Ib1OH31HIwGU10UMYVqxivw1SFUIt
         gYZSowQ3BjoTNnPcZ1sT231IQCefOQwR4621TVORBxSklm6sxKB5dTv5sRUDf6tHj3xg
         vMOg==
X-Gm-Message-State: AOJu0Yy+6Zk93bi+LJAqpaK6lVZ+6ngrocWXYj/vdFPCeGmvh6MCI5LJ
	iF4kqY9rJj9dGn4suKAs0PpoTey04kBpIGFGxOo=
X-Google-Smtp-Source: AGHT+IHackjYrQx5rVRooxZCmccg59iJebELvqxZcqaB5TnjcVpdX+BBNoBZobGYh4C47X+F0VCETMkzXjyQ/CPGJes=
X-Received: by 2002:a05:6820:169:b0:583:fc94:c3fd with SMTP id
 k9-20020a056820016900b00583fc94c3fdmr7586606ood.0.1700498716704; Mon, 20 Nov
 2023 08:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115180222.10436-1-hdegoede@redhat.com>
In-Reply-To: <20231115180222.10436-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Nov 2023 17:45:05 +0100
Message-ID: <CAJZ5v0jdf8meCstid+i=bcvr0oG_K=Sxs2FOv05EwxmJMNvpmA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 7:02=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Like various other ASUS ExpertBook-s, the ASUS ExpertBook B1402CVA
> has an ACPI DSDT table that describes IRQ 1 as ActiveLow while
> the kernel overrides it to EdgeHigh.
>
> This prevents the keyboard from working. To fix this issue, add this lapt=
op
> to the skip_override_table so that the kernel does not override IRQ 1.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218114
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 15a3bdbd0755..9bd9f79cd409 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -447,6 +447,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
>                 },
>         },
> +       {
> +               /* Asus ExpertBook B1402CVA */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
> +               },
> +       },
>         {
>                 /* Asus ExpertBook B1502CBA */
>                 .matches =3D {
> --

Applied as 6.7-rc material, thanks!

