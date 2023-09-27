Return-Path: <linux-acpi+bounces-220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3887B0A2A
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 38DCE281D20
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84F3C684
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405B1170F
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:08:09 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF8F4;
	Wed, 27 Sep 2023 08:08:08 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57de3096e25so281522eaf.1;
        Wed, 27 Sep 2023 08:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827288; x=1696432088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLgUPwRvAPA8jd102uQ0DZ4SGf6ggVl5r/JJMTLaDvY=;
        b=uTPfJLbwkjKPKxblqCJeWmZHAuEeeflTvFid9gSzEDStPJ/gx3ebB2BWiaQ/wZDloV
         ZW0/AGzBkN9T0UFtwIcUtP3wqoV/4DQEWeHIxC54vO0OQZlLUnX/UdZBGS5ZDhzmWSHB
         GrVt8ESUqsA8oQoTXCwRdSMm6degsNhYVkwitsHspo7xGzSXrWRZ31nuieM62onKgHXJ
         f/5/SMh7DVAP04zE9JLQ1utII2qRTMll0/wr4mZTsXitkhh1X2Y3avEfcO7HLbN917BO
         243bK/+oefsa2JHtwwKbr0nPIlnuh9vsLew3y70AELHM3P5N11mL6m9RhjeCNNRJfMwY
         Q/5g==
X-Gm-Message-State: AOJu0YxnNInrNEKXRNeLBq6bhxsChoc4xlBnUiWVQ8oKph1YJDjF+Cw8
	iQXdFAtlFax9FUkKTDHwpljD4c8Gcgy6V1jhTA8=
X-Google-Smtp-Source: AGHT+IGxapHK1mKy+yb4sAqwkZyYR20GheCsnbkVDbtaT2auUj/pRBrwkd5ToZJDeesAl9lSkE/l+ey1Vav5vfcPGE4=
X-Received: by 2002:a4a:c58f:0:b0:57b:7804:9d72 with SMTP id
 x15-20020a4ac58f000000b0057b78049d72mr2592125oop.1.1695827287685; Wed, 27 Sep
 2023 08:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
 <CAJZ5v0hq37x_v6Z0Vqj2h8D5QZM8zWE4=GfrMk7YAEfUjeRydA@mail.gmail.com> <20230927144552.pqolbw5p22sgc22l@bogus>
In-Reply-To: <20230927144552.pqolbw5p22sgc22l@bogus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Sep 2023 17:07:56 +0200
Message-ID: <CAJZ5v0iXcqxBWY7hCWkQ+iXUvnrVGHFTnNBtn88iVGj=LLBJcg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: PCC: Define and use the common PCC shared
 memory regions related macros
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 4:47=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Wed, Sep 27, 2023 at 04:19:21PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Sep 26, 2023 at 2:33=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.=
com> wrote:
> > >
> > > This set of 3 small patches intend to consolidate and replace the exi=
sting
> > > locally defined macros within couple of PCC client drivers when acces=
sing
> > > the command and status bitfields.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > > Sudeep Holla (3):
> > >       ACPI: PCC: Add PCC shared memory region command and status bitf=
ields
> > >       i2c: xgene-slimpro: Migrate to use generic PCC shmem related ma=
cros
> > >       hwmon: (xgene) Migrate to use generic PCC shmem related macros
> > >
> > >  drivers/hwmon/xgene-hwmon.c            | 16 +++++-----------
> > >  drivers/i2c/busses/i2c-xgene-slimpro.c | 16 ++++------------
> > >  include/acpi/pcc.h                     | 11 +++++++++++
> > >  3 files changed, 20 insertions(+), 23 deletions(-)
> > > ---
> >
> > This is fine with me.
> >
> > How do you want to route it?
>
> I have to respin this to include another driver.
>
> I also have 2 PCC mailbox driver changes that I wanted to send a pull req=
uest
> to you. I can make this part of that PR or you can take it directly. Both
> hwmon and i2c maintainers have acked now.

A PR would be convenient. :-)

