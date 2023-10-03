Return-Path: <linux-acpi+bounces-384-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C47B6E81
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5AB24280C71
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5D3AC1F
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:32:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D831A6E
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 15:06:07 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E824A1;
	Tue,  3 Oct 2023 08:06:05 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ae473c0bd6so167619b6e.0;
        Tue, 03 Oct 2023 08:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696345563; x=1696950363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfoixr3m5U2kSBjb6JlXLVlRiawHL3INUa4p8i7QVO8=;
        b=EGKiHwssB+3hEl7sR8ziEiP0wm+YTLupvnzkQCvwAkgBUlpX+N5U0YWhYJH1q+frXS
         X2wsRniSuSqszKP5MJd58HRpz4vuahVOhz018FKh5xOexQa5IESpOZaVs0h+wa4ODJyg
         /nQwpYyMmYJWXmPaV9dwQtbwfei9TxPLEHQNh4gKuIxXAiWxILwL4wKjTprLh/JibxYg
         cer6/vfOy3DtGHWkhq96/rElQnMFscDfkW1TiydAWOSBf2/EhQYrXk36t5r5nSkjCQF8
         JOZTj9zEusFAub7i0JIT99+CO7cl4GVHd142HMaYEX2zQfyw+YNGStbG+NJIZiXP1q5s
         Y9BA==
X-Gm-Message-State: AOJu0Yy156lKQfNA5ccMMsD3om797F5kSD1GeilgfohDn9oW8/EvgZcx
	AkGQZ0DhcQ5+32PV3ObVfcH+OVsquwzao00JOpk=
X-Google-Smtp-Source: AGHT+IF6yQOv5Bd0Ys7eq6T3EpkgBj6morZBhiV0kVnxnU6R8v7KgN2XWufAjmIYmrWYJW8JCxX6U0NFVRXOcsdo4ls=
X-Received: by 2002:a05:6808:3c47:b0:3ad:af12:2fe0 with SMTP id
 gl7-20020a0568083c4700b003adaf122fe0mr16914427oib.3.1696345563091; Tue, 03
 Oct 2023 08:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927-pcc_defines-v2-0-0b8ffeaef2e5@arm.com>
 <20230927-pcc_defines-v2-1-0b8ffeaef2e5@arm.com> <CAJZ5v0hG0sDJ4VOY+Gk0Fg1gebNft+z3YK9Jf-7NHb9Ow-C2mg@mail.gmail.com>
 <20231003142916.6nbg5sfwd3tk6ol4@bogus>
In-Reply-To: <20231003142916.6nbg5sfwd3tk6ol4@bogus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 17:05:51 +0200
Message-ID: <CAJZ5v0iH97P=S3rRSKVqJwVadSMsPVfOZswoenaRxpAjwDxeVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ACPI: PCC: Add PCC shared memory region command
 and status bitfields
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 4:29=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Tue, Oct 03, 2023 at 03:29:16PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 27, 2023 at 6:32=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.=
com> wrote:
> > >
> > > Define the common macros to use when referring to various bitfields i=
n
> > > the PCC generic communications channel command and status fields.
> > >
> > > Currently different drivers that need to use these bitfields have def=
ined
> > > these locally. This common macro is intended to consolidate and repla=
ce
> > > those.
> > >
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  include/acpi/pcc.h | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> > > index 73e806fe7ce7..021891a7434f 100644
> > > --- a/include/acpi/pcc.h
> > > +++ b/include/acpi/pcc.h
> > > @@ -18,7 +18,20 @@ struct pcc_mbox_chan {
> > >         u16 min_turnaround_time;
> > >  };
> > >
> > > +/* Generic Communications Channel Shared Memory Region */
> > > +#define PCC_SIGNATURE                  0x50424300
> > > +/* Generic Communications Channel Command Field */
> > > +#define PCC_CMD_GENERATE_DB_INTR       BIT(15)
> > > +/* Generic Communications Channel Status Field */
> > > +#define PCC_STATUS_CMD_COMPLETE                BIT(0)
> > > +#define PCC_STATUS_SCI_DOORBELL                BIT(1)
> > > +#define PCC_STATUS_ERROR               BIT(2)
> > > +#define PCC_STATUS_PLATFORM_NOTIFY     BIT(3)
> > > +/* Initiator Responder Communications Channel Flags */
> > > +#define PCC_CMD_COMPLETION_NOTIFY      BIT(0)
> > > +
> > >  #define MAX_PCC_SUBSPACES      256
> > > +
> > >  #ifdef CONFIG_PCC
> > >  extern struct pcc_mbox_chan *
> > >  pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
> > >
> > > --
> >
> > Do you want me to pick up this lot?
>
> I have applied this to me branch [1]. It also has long pending PCC driver
> changes. I will send the pull request by end of this week.

Sounds good, thanks!

