Return-Path: <linux-acpi+bounces-1279-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7BB7E2C15
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 19:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D291C209A2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A842D02B
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B929433
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 16:47:42 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC7BD7B;
	Mon,  6 Nov 2023 08:47:40 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-587310758ccso303237eaf.0;
        Mon, 06 Nov 2023 08:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289259; x=1699894059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuXeInvy8TGXX3AV6oVtebaCgSp6dmA0Oof7bIAl6Ow=;
        b=wJ4Ne2y4HDst2CUpJCPmZ1tngNRQgktAq78iiWorfV5SabAarOQGGbeTCjRPukROR5
         dRJeIk5AZIhPNE8aUURFLS9DrVtwlYEWcMLTZGyRe72+1lG+SetKUPW0uE5MWPL/TU4v
         Cv7Urx0uyxE1IsuWg+NkGclq137WYS/D/NC8Lox2f1ju1MsLjK27Ib+fmAqGia1f6VTm
         jcUYZEcuUmcGAOx+0UpgUBmPfGATgdfxWa6UGtZ2po/dMPUq6Zp8U8/FEWsvfkii4K6c
         dIX+cjrzmKaJHeFmgq3+1Dk/0nmTOf/VlGsTY4rVxhUc208t82/Dr9dIvIHOhUe5Sn6l
         Kg+w==
X-Gm-Message-State: AOJu0Yw1Np+ESXPtS+wK5Hb8lQwBU9Zq4v6ZLfReIws0xdUUYaKMzPts
	7cWLSOdCTwdnhYGSoAtGz+UWaG+l7mPMz6ygxEDVEDdp
X-Google-Smtp-Source: AGHT+IE2Y7/J4aSKcPe3LhkLglxB7LdL3VoxnA1zaMlJTPUdA5T3jSswFF0VEcy3NJAL/YNF3E1/Pv8b1XF/xwW30/g=
X-Received: by 2002:a05:6820:1899:b0:581:e7b8:dd77 with SMTP id
 bm25-20020a056820189900b00581e7b8dd77mr33946399oob.1.1699289259115; Mon, 06
 Nov 2023 08:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4542595.LvFx2qVVIh@kreacher>
In-Reply-To: <4542595.LvFx2qVVIh@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2023 17:47:28 +0100
Message-ID: <CAJZ5v0isSbMdOC2V24m2CNaxNtu83DfRbCeX66Mkm9W9dtz1VQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] ACPI: scan: MIPI DisCo for Imaging support
To: Linux ACPI <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 5:34=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> Hi Folks,
>
> This is a new revision of
>
> https://lore.kernel.org/linux-acpi/2187487.irdbgypaU6@kreacher/
>
> addressing comments from Sakari and adding one more patch (also from
> Sakari).
>
> The main points from the original cover letter are still valid:
>
> > The general idea is the same - CSI-2 resource descriptors, introduced i=
n
> > ACPI 6.4 and defined by
> >
> > https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-ser=
ial-i
> > nterface-csi-2-connection-resource-descriptor
> >
> > are found and used for creating a set of software nodes that represent =
the
> > CSI-2 connection graph.
> >
> > These software nodes need to be available before any scan handlers or A=
CPI
> > drivers are bound to any struct acpi_device objects, so all of that is =
done
> > at the early stage of ACPI device enumeration, but unnecessary ACPI
> > namespace walks are avoided.
> >
> > The CSI-2 software nodes are populated with data extracted from the CSI=
-2
> > resource descriptors themselves and from device properties defined by t=
he
> > MIPI DisCo for Imaging specification (see
> > https://www.mipi.org/specifications/mipi-disco-imaging).
> >
> > Patches [4,6/6] come from the original series directly, but the other
> > patches have been changes substantially, so I've decided to re-start pa=
tch
> > series versioning from scratch.
>
> The series is based on the current mainline.

And now it is available in the acpi-mipi-disco-img branch of
linux-pm.git, for easier access.

Thanks!

