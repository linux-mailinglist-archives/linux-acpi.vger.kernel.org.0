Return-Path: <linux-acpi+bounces-2728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CB1824D9C
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jan 2024 05:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493182830AE
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jan 2024 04:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2F442F;
	Fri,  5 Jan 2024 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gcOAo5jb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D236522F
	for <linux-acpi@vger.kernel.org>; Fri,  5 Jan 2024 04:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A5D073F18E
	for <linux-acpi@vger.kernel.org>; Fri,  5 Jan 2024 04:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704428690;
	bh=bMtR0jtLuxQl+BURO8iHeL6NPIGQ4o8OtXkryzx2uQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=gcOAo5jbqf93v+RW/7kq+GY6i1BqPCBDw9aDMmfdBrRK7abWEYaQP08yeKZla8GSI
	 xDWBFYl02+O6vvGu9C6IzvZZ8ZcE/CER6ilIsCBJuajbolUg+U1l0mT7irWyAzOHUM
	 +RgBYcWxu95klnCLPkni6rAD62SGLJNKU4xjh3zSVBayOifK3WNMoHOjDQZt+N1NOS
	 pr4r5DbdT0SjJEAp25xExKJDwHhTuB2iK3f1y09xPJR3CCvrPrsMUvv90iRpIxMH/Z
	 FAB7skBv4ld88NxB+pYxY4wyiY+qFVRy947wjaoa1N/tjvUd9zF6dPDf7AJ5GicEjE
	 5cfW+hV4ShXjg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28c183f8205so1242551a91.3
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jan 2024 20:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704428689; x=1705033489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMtR0jtLuxQl+BURO8iHeL6NPIGQ4o8OtXkryzx2uQQ=;
        b=Qp1uUp6bYEa+Blh3J4sp0hTMEXaTNCwdldgsQLVv8g86FMMUxbTg6e1Kgo7vvVpo4f
         UMovwHPYWNym/RrI96j3ishXNhv8yVdGhbw7wtvJk9QZtxuE05/b2Ef0u52WwXAfN4CV
         wMIbTNK5n3RRPR7TE8XWXghr6j4apsiLfH+S+Vh0sV/507Th1w4a2HNFY9MzeVxz8ozc
         UJp1Wd/N26p/NQo4VSysDXLCKlI+8VC1SZacFBrWJRWwW94sFQgyqRkZL9kDS4tokzeX
         orbV+FMkUKVr1PwFaXfqdyz9jNezBG+mrOTNcsj+6WpKaypfK3MaXxTl1y9a61ujxCco
         YGTg==
X-Gm-Message-State: AOJu0Yx2QF6Qv9jfttiSmsdPK6yGZm5j5J2Ddt3ETVERaMKld/NUNjS4
	jpAPUbzkqEPW2SGHIaRWPWgVG9O/B6djL6SoJhl891BjKMhmNXUslcGVlP7yRVFiPQXwQEqYMhc
	VyPbORj4klc1Pwva9TWXGXvnI6Zwx/7P0CifmscPZxRoCZUwvoJN+mwAiePs74g==
X-Received: by 2002:a17:90b:a58:b0:28b:dfcb:f8dc with SMTP id gw24-20020a17090b0a5800b0028bdfcbf8dcmr1452365pjb.32.1704428689103;
        Thu, 04 Jan 2024 20:24:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmqabsvalmQhHK3ZGgFt4j7cQYL3oTcPzaAV73xTOZlKRXqu7eGb1RjuLiwJbVaIs3QK+4CjmGMuS+LjAsAUY=
X-Received: by 2002:a17:90b:a58:b0:28b:dfcb:f8dc with SMTP id
 gw24-20020a17090b0a5800b0028bdfcbf8dcmr1452361pjb.32.1704428688785; Thu, 04
 Jan 2024 20:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024819.848979-1-kai.heng.feng@canonical.com> <CAJZ5v0gNa7XvUo3B1srXaWBrWx+Bx=w=D7ddi-mqda8xBdWwCQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gNa7XvUo3B1srXaWBrWx+Bx=w=D7ddi-mqda8xBdWwCQ@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 5 Jan 2024 12:24:36 +0800
Message-ID: <CAAd53p4yTYZw4x76Cz8qQhkZBa1T3Cg45Kds6288WN2ZsyF9pQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: IPMI: Add helper to wait for when SMI is selected
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:35=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Thu, Jan 4, 2024 at 3:48=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > The function of acpi_power_meter module on Dell system requires IPMI
> > handler is installed and SMI is selected.
>
> Does the firmware use _DEP to let the OS know about this dependency?

No. _DEP is missing.

Kai-Heng

>
> > So add a helper to let acpi_power_meter know when IPMI handler and SMI
> > are ready.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >  - New patch.
> >
> >  drivers/acpi/acpi_ipmi.c | 17 ++++++++++++++++-
> >  include/acpi/acpi_bus.h  |  5 +++++
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> > index 0555f68c2dfd..54862cab7171 100644
> > --- a/drivers/acpi/acpi_ipmi.c
> > +++ b/drivers/acpi/acpi_ipmi.c
> > @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
> >  #define IPMI_TIMEOUT                   (5000)
> >  #define ACPI_IPMI_MAX_MSG_LENGTH       64
> >
> > +static struct completion smi_selected;
> > +
> >  struct acpi_ipmi_device {
> >         /* the device list attached to driver_data.ipmi_devices */
> >         struct list_head head;
> > @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct de=
vice *dev)
> >                 if (temp->handle =3D=3D handle)
> >                         goto err_lock;
> >         }
> > -       if (!driver_data.selected_smi)
> > +       if (!driver_data.selected_smi) {
> >                 driver_data.selected_smi =3D ipmi_device;
> > +               complete(&smi_selected);
> > +       }
> >         list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
> >         mutex_unlock(&driver_data.ipmi_lock);
> >
> > @@ -578,10 +582,21 @@ acpi_ipmi_space_handler(u32 function, acpi_physic=
al_address address,
> >         return status;
> >  }
> >
> > +int acpi_wait_for_acpi_ipmi(void)
> > +{
> > +       long ret;
> > +
> > +       ret =3D wait_for_completion_interruptible_timeout(&smi_selected=
, 2 * HZ);
> > +
> > +       return ret > 0 ? 0 : -ETIMEDOUT;
>
> What will happen if the IPMI driver is unloaded after this has returned 0=
?
>
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_wait_for_acpi_ipmi);
> > +
> >  static int __init acpi_ipmi_init(void)
> >  {
> >         int result;
> >         acpi_status status;
> > +       init_completion(&smi_selected);
> >
> >         if (acpi_disabled)
> >                 return 0;
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 1216d72c650f..afa6e4d4bf46 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -821,11 +821,16 @@ static inline void acpi_put_acpi_dev(struct acpi_=
device *adev)
> >  {
> >         acpi_dev_put(adev);
> >  }
> > +
> > +int acpi_wait_for_acpi_ipmi(void);
> > +
> >  #else  /* CONFIG_ACPI */
> >
> >  static inline int register_acpi_bus_type(void *bus) { return 0; }
> >  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> >
> > +static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> > +
> >  #endif                         /* CONFIG_ACPI */
> >
> >  #endif /*__ACPI_BUS_H__*/
> > --

