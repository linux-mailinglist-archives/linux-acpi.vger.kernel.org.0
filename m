Return-Path: <linux-acpi+bounces-14964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA7AF6ACA
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F29170DFA
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D62951DD;
	Thu,  3 Jul 2025 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aHS/a1HJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA0293C53
	for <linux-acpi@vger.kernel.org>; Thu,  3 Jul 2025 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751525551; cv=none; b=XStCKF3JHO3VAfbBsnOi/iEEAnUvfXiOcQw21c0MmNa+IYz2yy3knw/tvb566/evI9Ro+dBCSOP82zSJkbKKg0dcXRA6YsGTYuwE7fz1mPkLbH6NOG9nwv5AlrycVIenG3hkqzMz+YK4CqTMmqCBVwNSJjp6/TZQwtaTCetbI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751525551; c=relaxed/simple;
	bh=zxTn4QjIATfPFj0EA04L/Z5RFehZCa01EYBDdE041G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chLG+jcv5O3aU4xj08WzZGonOQp8CvdsblN5ZmiflBdyQ6p5aJJ250tK9yv9Qmye1Ieo0U1VHtgzteU8tyPfNFcOJLr0NZN289yFBrY9mxH6NyCZ+irM2+RAOp/7bnGTssAprRe6yNweb59ay1NxP6FlUzA59Ih27i7Kdl8Rwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aHS/a1HJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5550dca1241so5320407e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jul 2025 23:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751525547; x=1752130347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+t8qaZaASkcGXdoWA35eNP1EflrIEUtqV40vcx1K04=;
        b=aHS/a1HJTXqd6rr8cDwrwa4k9qBBlD7I9k4wG1gKGsRZOUeSV9ryaiS8A7x78zUQ5I
         Dll0wbnfnm1kyUvY4+0SXuCQaLK2zBJhqs8KtJ3flcOBsjlw55JO0c1G3xjjYVCDA+zx
         RGMtcN3ivpk1f3LXv3NVKYKJwm389UNtYI+7W5MxwjePjSJR+y/AYGAaIweKIYEAIqmY
         I75ijfzF8OO7U6j3Qsyu5SW5nhqsFJPwtJ4uiHyvXbn5puw4J1DrjYG7MmpE3G6LPf4Y
         Ts2bOb71U9Iw6vr4985qeMW8qGjWLbV0tRwvSmw/7EG0cWGqzJ3GGTcD5Lc5MfXbkJP2
         exaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751525547; x=1752130347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+t8qaZaASkcGXdoWA35eNP1EflrIEUtqV40vcx1K04=;
        b=PRA1B6vQtm2j+n9UPoqbfOsBom2ypILsora/do/I18mFiI5ZaHU/a8YahB1vdNHVex
         SHLWTAk3TR3YcwrfFKD+sr1e1VyNiG9VcyyLc6wUyRVEqAe9xKxqM7eYHKaYoz/4yvh0
         T/53VbWW/HiAQu33hfeN1qv3OkaX4TxISK66EMuyu4ALY41ZCmTGw3jLY8eAlD2c+gNl
         BU4EnulTkeAQSDp0P/KV4eqsIEP8dS4QKjD58xzFmsGkeArB5jF6vH73zeCvVxj0vhQs
         LFRNFpUMrBkNSxiiqYfVgODSP8c0XSCDiYS1oSlsgX4QdJdgh+Zl9JrVdlJDUNajy22e
         Dr4A==
X-Forwarded-Encrypted: i=1; AJvYcCUP2hy1eZPgsKMYceghh4zxDLKkXme6axGYi4FIQVnWeXEpnP1XTrcNWEbvCTe0fqfoTAOcmU6FbVSn@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBt4X4O3MbsENzskPy1CilS4bOI7s4W49cdeohXJ7pNBg2yTa
	AoOqt6icymJncwnJOHu8y9K7feMWyJmAthf3c+d2KIzktIsGlo8bi6jk3TUp+Nk1zSQAqMJDTOb
	EuVaQjka7fima/XgjLmGH+KuxfryMP5pU0wnkLtIHPw==
X-Gm-Gg: ASbGncvpSTBWquBJhg8+30jKmVA0iPq9lCm/KVoP0jjZN5C7yutizebYoBmEJTxsHfg
	uDQSsAMoOueDu8qlJOke2BILwElLdYWtEYPRLYi++ybkYkg/FIpGqXMa2dcD4pEUUKOrCdjLsbl
	xTmNty+LZRovtNeObusBM6R+T7UZOA1pqJ1QyF4E6ELw==
X-Google-Smtp-Source: AGHT+IHbi1gQFqRmasUb4qWudIovvz+/GSsC9cANKrFd6vIVhqvCQ0NUP0rOGxz1jjKFprATyMsosXGbto/mEwYfXdY=
X-Received: by 2002:a05:6512:1296:b0:553:349c:646c with SMTP id
 2adb3069b0e04-5562eed4488mr617947e87.27.1751525546592; Wed, 02 Jul 2025
 23:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-8-apatel@ventanamicro.com> <aGUrD2Ht1idIlDCd@smile.fi.intel.com>
In-Reply-To: <aGUrD2Ht1idIlDCd@smile.fi.intel.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 3 Jul 2025 12:22:14 +0530
X-Gm-Features: Ac12FXzyg1GEPIjsFkPoEEFqlxgKvQAbhgMlaEgB0ImqOgXuXqeE13eqTHLZnXU
Message-ID: <CAK9=C2Ume2CmBYHYob7HSJHu=ZdfdWM+4JYPgFJ9Hir5Oi8cOg@mail.gmail.com>
Subject: Re: [PATCH v7 07/24] mailbox: Add RISC-V SBI message proxy (MPXY)
 based mailbox driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 02, 2025 at 10:43:28AM +0530, Anup Patel wrote:
> > Add a mailbox controller driver for the new SBI message proxy extension
> > which is part of the SBI v3.0 specification.
>
> ...
>
> > +#include <linux/cpu.h>
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/mailbox_controller.h>
> > +#include <linux/mailbox/riscv-rpmi-message.h>
>
> + minmax.h

Okay, I will add this.

>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/msi.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/percpu.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/smp.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/sbi.h>
>
> ...
>
> > +static void mpxy_mbox_send_rpmi_data(struct mpxy_mbox_channel *mchan,
> > +                                  struct rpmi_mbox_message *msg)
> > +{
> > +     int rc =3D 0;
>
> Is it useful? I mean can you assign msg.error directly in each case?
> (Just asking)

I think it is more readable with a local variable for errors
but I don't mind directly assigning msg->error.

>
> > +     switch (msg->type) {
> > +     case RPMI_MBOX_MSG_TYPE_GET_ATTRIBUTE:
> > +             switch (msg->attr.id) {
> > +             case RPMI_MBOX_ATTR_SPEC_VERSION:
> > +                     msg->attr.value =3D mchan->attrs.msg_proto_versio=
n;
> > +                     break;
> > +             case RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE:
> > +                     msg->attr.value =3D mchan->max_xfer_len;
> > +                     break;
> > +             case RPMI_MBOX_ATTR_SERVICEGROUP_ID:
> > +                     msg->attr.value =3D mchan->rpmi_attrs.servicegrou=
p_id;
> > +                     break;
> > +             case RPMI_MBOX_ATTR_SERVICEGROUP_VERSION:
> > +                     msg->attr.value =3D mchan->rpmi_attrs.servicegrou=
p_version;
> > +                     break;
> > +             case RPMI_MBOX_ATTR_IMPL_ID:
> > +                     msg->attr.value =3D mchan->rpmi_attrs.impl_id;
> > +                     break;
> > +             case RPMI_MBOX_ATTR_IMPL_VERSION:
> > +                     msg->attr.value =3D mchan->rpmi_attrs.impl_versio=
n;
> > +                     break;
> > +             default:
> > +                     rc =3D -EOPNOTSUPP;
> > +                     break;
> > +             }
> > +             break;
> > +     case RPMI_MBOX_MSG_TYPE_SET_ATTRIBUTE:
> > +             /* None of the RPMI linux mailbox attributes are writeabl=
e */
> > +             rc =3D -EOPNOTSUPP;
> > +             break;
> > +     case RPMI_MBOX_MSG_TYPE_SEND_WITH_RESPONSE:
> > +             if ((!msg->data.request && msg->data.request_len) ||
> > +                 (msg->data.request &&
> > +                  msg->data.request_len > mchan->max_xfer_len) ||
> > +                 (!msg->data.response && msg->data.max_response_len)) =
{
> > +                     rc =3D -EINVAL;
> > +                     break;
> > +             }
> > +             if (!(mchan->attrs.capability & SBI_MPXY_CHAN_CAP_SEND_WI=
TH_RESP)) {
> > +                     rc =3D -EIO;
> > +                     break;
> > +             }
> > +             rc =3D mpxy_send_message_with_resp(mchan->channel_id,
> > +                                              msg->data.service_id,
> > +                                              msg->data.request,
> > +                                              msg->data.request_len,
> > +                                              msg->data.response,
> > +                                              msg->data.max_response_l=
en,
> > +                                              &msg->data.out_response_=
len);
> > +             break;
> > +     case RPMI_MBOX_MSG_TYPE_SEND_WITHOUT_RESPONSE:
> > +             if ((!msg->data.request && msg->data.request_len) ||
> > +                 (msg->data.request &&
> > +                  msg->data.request_len > mchan->max_xfer_len)) {
> > +                     rc =3D -EINVAL;
> > +                     break;
> > +             }
> > +             if (!(mchan->attrs.capability & SBI_MPXY_CHAN_CAP_SEND_WI=
THOUT_RESP)) {
> > +                     rc =3D -EIO;
> > +                     break;
> > +             }
> > +             rc =3D mpxy_send_message_without_resp(mchan->channel_id,
> > +                                                 msg->data.service_id,
> > +                                                 msg->data.request,
> > +                                                 msg->data.request_len=
);
> > +             break;
> > +     default:
> > +             rc =3D -EOPNOTSUPP;
> > +             break;
> > +     }
> > +
> > +     msg->error =3D rc;
> > +}
>
> ...
>
> > +static void mpxy_mbox_peek_rpmi_data(struct mbox_chan *chan,
> > +                                  struct mpxy_mbox_channel *mchan,
> > +                                  struct sbi_mpxy_notification_data *n=
otif,
> > +                                  unsigned long events_data_len)
> > +{
> > +     struct rpmi_notification_event *event;
> > +     unsigned long pos =3D 0, event_size;
> > +     struct rpmi_mbox_message msg;
> > +
> > +     while ((pos < events_data_len) && !(pos & 0x3) &&
>
> 0x3 looks like a magic used for the non-aligned data.

This is paranoide check and can be dropped. I will update.

The RPMI spec clearly states that "An RPMI event may have associated
data whose size is specified in the EVENT_DATALEN field of the header
and this data size must be a multiple of 4-byte."

>
> > +            ((events_data_len - pos) <=3D sizeof(*event))) {
> > +             event =3D (struct rpmi_notification_event *)(notif->event=
s_data + pos);
> > +
> > +             msg.type =3D RPMI_MBOX_MSG_TYPE_NOTIFICATION_EVENT;
> > +             msg.notif.event_datalen =3D le16_to_cpu(event->event_data=
len);
> > +             msg.notif.event_id =3D event->event_id;
> > +             msg.notif.event_data =3D event->event_data;
> > +             msg.error =3D 0;
> > +
> > +             event_size =3D sizeof(*event) + msg.notif.event_datalen;
>
> Do you trust the source? This may wrap-around...
>
> > +             if (event_size > (events_data_len - pos)) {
> > +                     event_size =3D events_data_len - pos;
> > +                     goto skip_event;
> > +             }
> > +             if (event_size & 0x3)
> > +                     goto skip_event;
>
> ...and these checks be skipped. Is it a problem?

I agree these checks can be skipped.

>
> > +             mbox_chan_received_data(chan, &msg);
>
> > +skip_event:
>
> I think this may be replaced by a continue inside if you make a loop to b=
e
> do {} while (). But it's just a thought, you can check if it gives a bett=
er
> readability after all.

I am more comfortable with "while ()" over here.

>
> > +             pos +=3D event_size;
> > +     }
> > +}
>
> ...
>
> > +static int mpxy_mbox_probe(struct platform_device *pdev)
> > +{
> > +     u32 i, *channel_ids __free(kfree) =3D NULL;
>
> It's not recommended. Can you split channel_ids to the actual scope where=
 it's
> used? Somewhere...

Let me create a separate function to populate channels
so that channel_ids will be used only in a limited scope.

>
> > +     struct device *dev =3D &pdev->dev;
> > +     struct mpxy_mbox_channel *mchan;
> > +     struct mpxy_mbox *mbox;
> > +     int msi_idx, rc;
> > +
> > +     /*
> > +      * Initialize MPXY shared memory only once. This also ensures
> > +      * that SBI MPXY mailbox is probed only once.
> > +      */
> > +     if (mpxy_shmem_init_done) {
> > +             dev_err(dev, "SBI MPXY mailbox already initialized\n");
> > +             return -EALREADY;
> > +     }
> > +
> > +     /* Probe for SBI MPXY extension */
> > +     if (sbi_spec_version < sbi_mk_version(1, 0) ||
> > +         sbi_probe_extension(SBI_EXT_MPXY) <=3D 0) {
> > +             dev_info(dev, "SBI MPXY extension not available\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Find-out shared memory size */
> > +     rc =3D mpxy_get_shmem_size(&mpxy_shmem_size);
> > +     if (rc)
> > +             return dev_err_probe(dev, rc, "failed to get MPXY shared =
memory size\n");
> > +
> > +     /*
> > +      * Setup MPXY shared memory on each CPU
> > +      *
> > +      * Note: Don't cleanup MPXY shared memory upon CPU power-down
> > +      * because the RPMI System MSI irqchip driver needs it to be
> > +      * available when migrating IRQs in CPU power-down path.
> > +      */
> > +     cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/sbi-mpxy-shmem",
> > +                       mpxy_setup_shmem, NULL);
> > +
> > +     /* Mark as MPXY shared memory initialization done */
> > +     mpxy_shmem_init_done =3D true;
> > +
> > +     /* Allocate mailbox instance */
> > +     mbox =3D devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> > +     if (!mbox)
> > +             return -ENOMEM;
> > +     mbox->dev =3D dev;
> > +     platform_set_drvdata(pdev, mbox);
> > +
> > +     /* Find-out of number of channels */
> > +     rc =3D mpxy_get_channel_count(&mbox->channel_count);
> > +     if (rc)
> > +             return dev_err_probe(dev, rc, "failed to get number of MP=
XY channels\n");
> > +     if (!mbox->channel_count)
> > +             dev_err_probe(dev, -ENODEV, "no MPXY channels available\n=
");
> > +
> > +     /* Allocate and fetch all channel IDs */
> > +     channel_ids =3D kcalloc(mbox->channel_count, sizeof(*channel_ids)=
, GFP_KERNEL);
>
> ...here.
>
> > +     if (!channel_ids)
> > +             return -ENOMEM;
> > +     rc =3D mpxy_get_channel_ids(mbox->channel_count, channel_ids);
> > +     if (rc)
> > +             return dev_err_probe(dev, rc, "failed to get MPXY channel=
 IDs\n");
> > +
> > +     /* Populate all channels */
> > +     mbox->channels =3D devm_kcalloc(dev, mbox->channel_count,
> > +                                   sizeof(*mbox->channels), GFP_KERNEL=
);
> > +     if (!mbox->channels)
> > +             return -ENOMEM;
> > +     for (i =3D 0; i < mbox->channel_count; i++) {
> > +             mchan =3D &mbox->channels[i];
> > +             mchan->mbox =3D mbox;
> > +             mchan->channel_id =3D channel_ids[i];
> > +
> > +             rc =3D mpxy_read_attrs(mchan->channel_id, SBI_MPXY_ATTR_M=
SG_PROT_ID,
> > +                                  sizeof(mchan->attrs) / sizeof(u32),
> > +                                  (u32 *)&mchan->attrs);
> > +             if (rc) {
> > +                     return dev_err_probe(dev, rc,
> > +                                          "MPXY channel 0x%x read attr=
s failed\n",
> > +                                          mchan->channel_id);
> > +             }
> > +
> > +             if (mchan->attrs.msg_proto_id =3D=3D SBI_MPXY_MSGPROTO_RP=
MI_ID) {
> > +                     rc =3D mpxy_mbox_read_rpmi_attrs(mchan);
> > +                     if (rc) {
> > +                             return dev_err_probe(dev, rc,
> > +                                                  "MPXY channel 0x%x r=
ead RPMI attrs failed\n",
> > +                                                  mchan->channel_id);
> > +                     }
> > +             }
> > +
> > +             mchan->notif =3D devm_kzalloc(dev, mpxy_shmem_size, GFP_K=
ERNEL);
> > +             if (!mchan->notif)
> > +                     return -ENOMEM;
> > +
> > +             mchan->max_xfer_len =3D min(mpxy_shmem_size, mchan->attrs=
.msg_max_len);
> > +
> > +             if ((mchan->attrs.capability & SBI_MPXY_CHAN_CAP_GET_NOTI=
FICATIONS) &&
> > +                 (mchan->attrs.capability & SBI_MPXY_CHAN_CAP_EVENTS_S=
TATE))
> > +                     mchan->have_events_state =3D true;
> > +
> > +             if ((mchan->attrs.capability & SBI_MPXY_CHAN_CAP_GET_NOTI=
FICATIONS) &&
> > +                 (mchan->attrs.capability & SBI_MPXY_CHAN_CAP_MSI))
> > +                     mchan->msi_index =3D mbox->msi_count++;
> > +             else
> > +                     mchan->msi_index =3D U32_MAX;
> > +             mchan->msi_irq =3D U32_MAX;
> > +     }
> > +
> > +     /* Initialize mailbox controller */
> > +     mbox->controller.txdone_irq =3D false;
> > +     mbox->controller.txdone_poll =3D false;
> > +     mbox->controller.ops =3D &mpxy_mbox_ops;
> > +     mbox->controller.dev =3D dev;
> > +     mbox->controller.num_chans =3D mbox->channel_count;
> > +     mbox->controller.fw_xlate =3D mpxy_mbox_fw_xlate;
> > +     mbox->controller.chans =3D devm_kcalloc(dev, mbox->channel_count,
> > +                                           sizeof(*mbox->controller.ch=
ans),
> > +                                           GFP_KERNEL);
> > +     if (!mbox->controller.chans)
> > +             return -ENOMEM;
> > +     for (i =3D 0; i < mbox->channel_count; i++)
> > +             mbox->controller.chans[i].con_priv =3D &mbox->channels[i]=
;
> > +
> > +     /* Set the MSI domain if not available */
> > +     if (!dev_get_msi_domain(dev)) {
> > +             /*
> > +              * The device MSI domain for OF devices is only set at th=
e
> > +              * time of populating/creating OF device. If the device M=
SI
> > +              * domain is discovered later after the OF device is crea=
ted
> > +              * then we need to set it explicitly before using any pla=
tform
> > +              * MSI functions.
> > +              */
>
> > +             if (dev_of_node(dev))
>
> Do you really need this check? What about ACPI?

Yes, this check is needed because of_msi_configure() only
works for OF does. For ACPI, we have a different way of
to re-configure MSI domain which is in a later patch.

In general, there is no generic fwnode API to find and
re-configure MSI domain in a bus independent way.

>
> > +                     of_msi_configure(dev, dev_of_node(dev));
> > +     }
> > +
> > +     /* Setup MSIs for mailbox (if required) */
> > +     if (mbox->msi_count) {
> > +             mbox->msi_index_to_channel =3D devm_kcalloc(dev, mbox->ms=
i_count,
> > +                                                       sizeof(*mbox->m=
si_index_to_channel),
> > +                                                       GFP_KERNEL);
> > +             if (!mbox->msi_index_to_channel)
> > +                     return -ENOMEM;
> > +
> > +             for (msi_idx =3D 0; msi_idx < mbox->msi_count; msi_idx++)=
 {
> > +                     for (i =3D 0; i < mbox->channel_count; i++) {
> > +                             mchan =3D &mbox->channels[i];
> > +                             if (mchan->msi_index =3D=3D msi_idx) {
> > +                                     mbox->msi_index_to_channel[msi_id=
x] =3D mchan;
> > +                                     break;
> > +                             }
> > +                     }
> > +             }
> > +
> > +             rc =3D platform_device_msi_init_and_alloc_irqs(dev, mbox-=
>msi_count,
> > +                                                          mpxy_mbox_ms=
i_write);
> > +             if (rc) {
> > +                     return dev_err_probe(dev, rc, "Failed to allocate=
 %d MSIs\n",
> > +                                          mbox->msi_count);
> > +             }
> > +
> > +             for (i =3D 0; i < mbox->channel_count; i++) {
> > +                     mchan =3D &mbox->channels[i];
> > +                     if (mchan->msi_index =3D=3D U32_MAX)
> > +                             continue;
> > +                     mchan->msi_irq =3D msi_get_virq(dev, mchan->msi_i=
ndex);
> > +             }
> > +     }
> > +
> > +     /* Register mailbox controller */
> > +     rc =3D devm_mbox_controller_register(dev, &mbox->controller);
> > +     if (rc) {
> > +             dev_err_probe(dev, rc, "Registering SBI MPXY mailbox fail=
ed\n");
> > +             if (mbox->msi_count)
> > +                     platform_device_msi_free_irqs_all(dev);
> > +             return rc;
> > +     }
>
> > +     dev_info(dev, "mailbox registered with %d channels\n",
> > +              mbox->channel_count);
>
> Working driver doesn't need to issue a message.

The expected mailbox channels available to Linux will
vary based on platform. If there is a firmware bug then
Linux will not see all expected mailbox channels but the
probe of this driver will succeed.

From the end user perspective (or user space), there
is no direct way of knowing the number of channels
details of each channel. In fact, the Linux mailbox
framework does not have common sysfs interface
to allow users know the mailbox controller instances
and their mailbox channels.

Regards,
Anup

