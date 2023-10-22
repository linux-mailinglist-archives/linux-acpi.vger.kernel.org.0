Return-Path: <linux-acpi+bounces-830-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3109D7D2319
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Oct 2023 14:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A2C1F217E4
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Oct 2023 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E7101C6
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Oct 2023 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD063D7
	for <linux-acpi@vger.kernel.org>; Sun, 22 Oct 2023 10:53:27 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE604A7
	for <linux-acpi@vger.kernel.org>; Sun, 22 Oct 2023 03:53:25 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1ea1742c1a5so714312fac.0
        for <linux-acpi@vger.kernel.org>; Sun, 22 Oct 2023 03:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697972005; x=1698576805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfYc3oyXjD26uJSjhhKNLi/S0Ywtcen6nLz0AHIHCTk=;
        b=w2AYIVG+uinco9cuQg+JFDg3Kiy84zWTnWmSkdiGSDEDu7Vf/hfGEeIgkvk0Q0IUbN
         dLLD9d7sPIL5N6ksGat2xvQq0jfk7G1Ks2oC72A9ahqLZKf7keNtFSYvQLug0j33O2i9
         mwjPlbbrCKCRQH4+73ZLpAsiTJF3+vUiY4407OA3b9+I5DWeCfEI7XAcerQX12odMAhC
         Q9AGluptg52Cc89/5/zP76zEOMraGv9Yf9z21DCxci11o/SiOMdOyFeJGzXSQXHhlFUb
         hSEGeoGkbRWgS+Xn+HeBg5SbpOMoRb5yfYXd0Gas/0bfP/Je2thqSLdLX+65pwYmd/+8
         MnAg==
X-Gm-Message-State: AOJu0YxFs2KEIZU1BmiqZRxgWOiAtmgx6wCeyu4W0JcyfsS3KrxubE/J
	Wpuoa+zARPFqO8utHcoNm3iQZjc14cv2pg6UN6I=
X-Google-Smtp-Source: AGHT+IE5RXtXxjmh42dzyiNfUTMBz+d9mDkBuS9KV5pGOqunuJIGgE+tpclPHGNBtfKVkVuqZBCn7lHUUNiyaJEi1fI=
X-Received: by 2002:a05:6870:9e47:b0:1e1:e6ee:94b6 with SMTP id
 pt7-20020a0568709e4700b001e1e6ee94b6mr8440632oab.4.1697972004824; Sun, 22 Oct
 2023 03:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1697720481-150095-1-git-send-email-chenxiang66@hisilicon.com>
 <CAJZ5v0j0A4637V5OEtjP-HMGhH80T=1kPjO_QXbgbBSZHvJY=w@mail.gmail.com> <6532e292ae459_21a972945@iweiny-mobl.notmuch>
In-Reply-To: <6532e292ae459_21a972945@iweiny-mobl.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 22 Oct 2023 12:53:12 +0200
Message-ID: <CAJZ5v0hU0Sm2Z7oAshfUqL_k5+-iytr1e4T0us2G3YW48NobiQ@mail.gmail.com>
Subject: Re: [PATCH] Install Notify() handler before getting NFIT table
To: Ira Weiny <ira.weiny@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, chenxiang <chenxiang66@hisilicon.com>, 
	"Williams, Dan J" <dan.j.williams@intel.com>, 
	"Wilczynski, Michal" <michal.wilczynski@intel.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 10:27=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wr=
ote:
>
> Rafael J. Wysocki wrote:
> > On Thu, Oct 19, 2023 at 2:57=E2=80=AFPM chenxiang <chenxiang66@hisilico=
n.com> wrote:
> > >
> > > From: Xiang Chen <chenxiang66@hisilicon.com>
> > >
> > > If there is no NFIT at startup, it will return 0 immediately in funct=
ion
> > > acpi_nfit_add() and will not install Notify() handler. If hotplugging
> > > a nvdimm device later, it will not be identified as there is no Notif=
y()
> > > handler.
> >
> > Yes, this is a change in behavior that shouldn't have been made.
> >
> > > So move handler installing before getting NFI table in function
> > > acpi_nfit_add() to avoid above issue.
> >
> > And the fix is correct if I'm not mistaken.
> >
> > I can still queue it up for 6.6 if that's fine with everyone.  Dan?
>
> That is fine with me.  Vishal, Dave Jiang, and I are wrangling the nvdimm
> tree these days.  I've prepared 6.7 already so I'll ignore this.

Applied now (with some minor edits in the subject and changelog).

Thanks!

> > > Fixes: dcca12ab62a2 ("ACPI: NFIT: Install Notify() handler directly")
> > > Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> > > ---
> > >  drivers/acpi/nfit/core.c | 22 +++++++++++-----------
> > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > > index 3826f49..9923855 100644
> > > --- a/drivers/acpi/nfit/core.c
> > > +++ b/drivers/acpi/nfit/core.c
> > > @@ -3339,6 +3339,16 @@ static int acpi_nfit_add(struct acpi_device *a=
dev)
> > >         acpi_size sz;
> > >         int rc =3D 0;
> > >
> > > +       rc =3D acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTI=
FY,
> > > +                                            acpi_nfit_notify, adev);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       rc =3D devm_add_action_or_reset(dev, acpi_nfit_remove_notify_=
handler,
> > > +                                       adev);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > >         status =3D acpi_get_table(ACPI_SIG_NFIT, 0, &tbl);
> > >         if (ACPI_FAILURE(status)) {
> > >                 /* The NVDIMM root device allows OS to trigger enumer=
ation of
> > > @@ -3386,17 +3396,7 @@ static int acpi_nfit_add(struct acpi_device *a=
dev)
> > >         if (rc)
> > >                 return rc;
> > >
> > > -       rc =3D devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi=
_desc);
> > > -       if (rc)
> > > -               return rc;
> > > -
> > > -       rc =3D acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTI=
FY,
> > > -                                            acpi_nfit_notify, adev);
> > > -       if (rc)
> > > -               return rc;
> > > -
> > > -       return devm_add_action_or_reset(dev, acpi_nfit_remove_notify_=
handler,
> > > -                                       adev);
> > > +       return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi=
_desc);
> > >  }
> > >
> > >  static void acpi_nfit_update_notify(struct device *dev, acpi_handle =
handle)
> > > --
> >
>
>

