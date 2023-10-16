Return-Path: <linux-acpi+bounces-677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2C97CB2C8
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744EB281811
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D33399F
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3FA30CED
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 17:32:42 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6D89F;
	Mon, 16 Oct 2023 10:32:41 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57ddba5ba84so392305eaf.0;
        Mon, 16 Oct 2023 10:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477561; x=1698082361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQp7jMcfyyRCN1wY+v8LGuAQYjTYb3WC+VTe+hPBaic=;
        b=vVa2lDrNWW2ULmneI9wAqjmwSe50kKhTTj6FwiSHaE2ecbu4OupvF6wfbsshZtzvmA
         02FEqFmsde+B2tWstlRsWwpofN1/YhpdZZVEoVyNdxFjhuQxkRbcqaEJtHoVlf0p5yWW
         pTlQe2vfdTf5VpEYN8Yxm6+9OiXUboujOH/6t8ERy5cAfJOlykRzFAG1JPgux4sW2UBz
         pyVLeDWfqwvoQC67JDOsLGc0dwuBkKJ3GWn2NY9D78uVmcVwYAnOKD/iDEu/jaeLwnvT
         3q6KV5+x7xpEYFlAXxsTYNfGNne6nu51UHUg88PFKst8Kl2xf4J+cZgbDKv3KOqufdB/
         8klA==
X-Gm-Message-State: AOJu0YwoOHetT1ML/FpIoE9lFsEc7DAurF2ZX31/GqL5xAQe8yQClffd
	/aB7wl+dJ/qtE25TL1/+6GcdoJupQc/6pQvMSmM6Km4v
X-Google-Smtp-Source: AGHT+IHahk+crEjN+AR0VRCmBIzdYS9IT1aUZbZFKN+ad+Gel9z6XTOF/5FLyzPD5mFvp3tJUAjtSbXf2ZBnKvLiuM4=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr32268569ooo.0.1697477561161; Mon, 16 Oct
 2023 10:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <90bd1071-317e-4dfe-b94b-9bcee15d66c5@gmail.com>
 <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com> <206f0f25-8a83-4e53-89fd-cbe025e5798d@gmail.com>
 <66418e44-6862-4555-9280-2633ffb34d23@intel.com>
In-Reply-To: <66418e44-6862-4555-9280-2633ffb34d23@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Oct 2023 19:32:25 +0200
Message-ID: <CAJZ5v0hfSZCgoW1mq=jeqjMBtsr=6JJaG8OWfUkAW80KF509Nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: i801: Use new helper acpi_use_parent_companion
To: "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
	Andi Shyti <andi.shyti@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 6:10=E2=80=AFPM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
> Hi,
>
> On 10/15/2023 11:36 PM, Heiner Kallweit wrote:
> > Use new helper acpi_use_parent_companion to simplify the code.
> >
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  drivers/i2c/busses/i2c-i801.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i80=
1.c
> > index a41f5349a..ac223146c 100644
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -1620,7 +1620,7 @@ static int i801_probe(struct pci_dev *dev, const =
struct pci_device_id *id)
> >       priv->adapter.class =3D I2C_CLASS_HWMON;
> >       priv->adapter.algo =3D &smbus_algorithm;
> >       priv->adapter.dev.parent =3D &dev->dev;
> > -     ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->dev))=
;
> > +     acpi_use_parent_companion(&priv->adapter.dev);
>
> I think this case is a bit too trivial for a helper, it's one line before=
, and
> one line after, so it doesn't really save much.

If this pattern is repeated in multiple places, the helper makes sense IMO.

>
> >       priv->adapter.retries =3D 3;
> >
> >       priv->pci_dev =3D dev;
>

