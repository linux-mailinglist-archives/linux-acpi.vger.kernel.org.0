Return-Path: <linux-acpi+bounces-18909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC38C5DE65
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 16:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 23ED524186
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152A633D6D8;
	Fri, 14 Nov 2025 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ew5LjKYV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZRvu6zW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C725CC63
	for <linux-acpi@vger.kernel.org>; Fri, 14 Nov 2025 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133655; cv=none; b=orqgiknX7AtkLQf+yUn4PWFHNgmZbVDiDHziaJ8dyrl28fYyNbCanscwfyq7Fclvn7MC0g3hiv6zfVpSv/W3FsuqjsQclYp6SHrNuIzvnOO43PpSQklG7IM6WUtj4Ck8ZIDZrjD9XH4JFiFBqX9KfWo9QXu6SmkSE1+tFG1pM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133655; c=relaxed/simple;
	bh=qD8aJLWLSChXa+7UxGGoyxhNoOvE0PFki0T7Q9eTvMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOJNCdvQc+QpcnwcO6KZjxMpS8x1D8/hf7/8R/R/2jeAojQ2fg/Zc8CHTXZ2IEz0AJgH+cAnKjG+LGGPE3rFSxq4o5CBOHX//LJyGdfGO+vtfam/Dituw8Sb3VAiPE6ACdzzTFPIA4ZUg7QsCVxIC+SE35F88frBxnLe13h3pDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ew5LjKYV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZRvu6zW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763133652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DLb+u2m++zYhPCsKv4fp95OreDIFSClSppBVG8RRcE=;
	b=Ew5LjKYV7EXjil3ADU8h0i+ETGckhFi/5ZsFsXKBvjUjYbFPevS5Ubs5Jy6/fEyaWvrpt8
	kEGGLM/6RURlSm9/hz7yU1bbjwC0P6SsDVxWmu3MZbOFBcZIPB2jO231BCveQ41NckBG6J
	0a01o1ik2uFQjDyhiFarQq3/hAdcma8=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-abLRre-pODqiIzyjRjjoig-1; Fri, 14 Nov 2025 10:20:51 -0500
X-MC-Unique: abLRre-pODqiIzyjRjjoig-1
X-Mimecast-MFC-AGG-ID: abLRre-pODqiIzyjRjjoig_1763133651
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-559e9092276so1528097e0c.2
        for <linux-acpi@vger.kernel.org>; Fri, 14 Nov 2025 07:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763133650; x=1763738450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DLb+u2m++zYhPCsKv4fp95OreDIFSClSppBVG8RRcE=;
        b=KZRvu6zWw5XrIBh9qI/iB7PjgLfsdm6ox6MpAX/gOpTcLhwbVZkdARUUAlPLg1z+8Y
         tLBxvuvBOjTnCiv6DR6pgAu6ZyUAGcEMoi6sqeRtNyRk2CZ91kmFyriferGPJJiT7ecK
         ModDOVSAkm2kwLQNflkA3Xddm8THODESyWzmePaoULRUSt0V6oEPbSahhOugScbDdg3q
         cwH/LVEVhQmkJUFhWlu6AIu/5co3HGWKayfhcuUWyXxAHGrQI4BIkSZXlu7OcAbDdn7q
         +OyE0u5SuAS4X2Y5ivu88WWzcWBrULM0Zi1uKVpNCAMV7ywAgtm6CZj8iJc3VMlfcA/u
         nTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763133650; x=1763738450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DLb+u2m++zYhPCsKv4fp95OreDIFSClSppBVG8RRcE=;
        b=WDg2engtYmqLa00+G1qMUwVsWV6M4nyEW0QjVZg1XTN2/u8JD5HbGgM/eFdaa1oVcw
         QvsiRFYIVb3sWZwOS8csoTSEYseQb3oOF+4FxO717vLiJcMu4KPkCXixWxk9uwjh2KWV
         CqgC5iV3p8AKFxRzparnbiM5h47yZz0DrCvjbHXgkVToDCxt14GlXeJE8dghrEDaBgcq
         lN7YwQlJpT1FmrR4g1Vgb+db1b9Nn1FwLbfgei5Z1DKQ9iJIztx1JnipRQ7kyGkO4oMZ
         j05NjLMI3DX0J0r2dkHhd0g2k2asjPpbqjNdykDRNf8IF5lI8K0RCCSWeXhKMDKZcKMP
         NVgw==
X-Forwarded-Encrypted: i=1; AJvYcCXj3PrIWtyogCf7ZPagdkNruTZ8rTaOcFMNU1sOBjlrBTQgNaEkcJ/lNmj5QmteJmPWFr/KSfFQ8PST@vger.kernel.org
X-Gm-Message-State: AOJu0YyhCZjqp7jFVwnt6/eT4lDSRZVbKmbEn2HYfdmqMDMJzR2vZXU0
	VtFfavlnQEsbJGYiEuq0fnA6g/k/DzFIL2nPPY1mJijMllL8Sdv69B9R8h+ujOP1uYCfCqDEchv
	1u/KN5zdZVGQMtWNqZoTST0d+BEGZQmm3cCVNPlYvqakxjeo0r40Yod4193IxPye7+ywL25Bvww
	0k3vv0rV+6XtlH3uyfWn/fCvZTfTVljm11+pzz+g==
X-Gm-Gg: ASbGncvHLr8e8hWeuCl4BE1lobLSR4vORtKqPRblDz6OyBtd4rlaeD65NZoGqJC+Wr0
	BbLQ+oCRRQP62+m8IrKZNxzkTAj64qqoG7Oj4OjG5eGkWXwNgFsIb9xQWD6CPKj71IpP3/qG9i4
	GjKdMdc5jDPcR94P1aW3b4uFDp5vB+IRB3xs5twMCiQnzfykCRjcuLaOPkoeqZM1ZyceVQqy0kQ
	AA=
X-Received: by 2002:a05:6122:6585:b0:54a:a178:3c9f with SMTP id 71dfb90a1353d-55b1bf181e2mr1416964e0c.15.1763133650595;
        Fri, 14 Nov 2025 07:20:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwOgEk9JDYnJQCX0CVIJOYaMUQ/P8i74lyi0aGXl3NYbUH63IfhO5xvW2+KLD3JkJlbkAx+2Z+T3b7Owns/Pc=
X-Received: by 2002:a05:6122:6585:b0:54a:a178:3c9f with SMTP id
 71dfb90a1353d-55b1bf181e2mr1416946e0c.15.1763133650243; Fri, 14 Nov 2025
 07:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OSAPR01MB7669F9B9E145A50B38819E13D5CEA@OSAPR01MB7669.jpnprd01.prod.outlook.com>
 <20251112044239.4049011-1-cmirabil@redhat.com> <OSCPR01MB16310F566905156A462CE3727D5CAA@OSCPR01MB16310.jpnprd01.prod.outlook.com>
In-Reply-To: <OSCPR01MB16310F566905156A462CE3727D5CAA@OSCPR01MB16310.jpnprd01.prod.outlook.com>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Fri, 14 Nov 2025 10:20:39 -0500
X-Gm-Features: AWmQ_bloHOBRdq3Kde73RaJVhHF8yxO3koJ_3zHVWYjR2333fBL3ZDUd0bhU9Nk
Message-ID: <CABe3_aE7EjKX1uJbA_r9W_Em3Eu8F4xzdcKh0vfjjJ4YQe7C4Q@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
To: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>, "guohanjun@huawei.com" <guohanjun@huawei.com>, 
	"ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "will@kernel.org" <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi=E2=80=94

On Fri, Nov 14, 2025 at 3:21=E2=80=AFAM Kazuhiro Abe (Fujitsu)
<fj1078ii@fujitsu.com> wrote:
>
> Hi Charlie,
>
> > Hi All=E2=80=94
> >
> > On Mon, Nov 10, 2025 at 07:38:17AM +0000, Kazuhiro Abe (Fujitsu) wrote:
> > > Hi Will,
> > >
> > > > Hi Will,
> > > >
> > > > > [You don't often get email from will@kernel.org. Learn why this i=
s
> > > > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > >
> > > > > On Mon, Oct 20, 2025 at 09:23:05PM +0800, Hanjun Guo wrote:
> > > > > > On 2025/10/17 15:39, Kazuhiro Abe wrote:
> > > > > > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > > > > > Currently, the AGDI driver only supports SDEI.
> > > > > > > Therefore, add support for interrupt signaling mode The
> > > > > > > interrupt vector is retrieved from the AGDI table, and call
> > > > > > > panic function when an interrupt occurs.
> > > > > > >
> > > > > > > Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > > > > > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > > > > > > ---
> > > > > > > Hanjun, I have addressed all your comments.
> > > > > > > Please review them.
> > > > > > >
> > > > > > > v3->v4
> > > > > > >   - Add a comment to the flags member.
> > > > > > >   - Fix agdi_interrupt_probe.
> > > > > > >   - Fix agdi_interrupt_remove.
> > > > > > >   - Add space in struct initializsation.
> > > > > > >   - Delete curly braces.
> > > > > >
> > > > > > Looks good to me,
> > > > > >
> > > > > > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> > > > >
> > > > > I wasn't cc'd on the original patch but I couldn't figure out why
> > > > > it uses IRQF_NO_AUTOEN when requesting the irq given that the
> > > > > first thing it does is enable it.
> > > >
> > > > I misunderstood the usage of request_irq and enable_irq.
> > > > Since there's no need to separate them, I will remove IRQF_NO_AUTOE=
N
> > > > and the enable_irq call, and send v5.
> > >
> > > I found out when calling request_nmi, removing IRQF_NO_AUTOEN results=
 in an
> > error (-EINVAL).
> > > Therefore, I would like to keep IRQF_NO_AUTOEN specified.
> > > If you have any comments on this version, please let me know.
> >
> > Could it be that this is just a bug in `request_nmi`? I see the followi=
ng:
> >
> > if (!desc || (irq_settings_can_autoenable(desc) &&
> >     !(irqflags & IRQF_NO_AUTOEN)) ||
> >     !irq_settings_can_request(desc) ||
> >     WARN_ON(irq_settings_is_per_cpu_devid(desc)) ||
> >     !irq_supports_nmi(desc))
> >         return -EINVAL;
> >
> > Perhaps there is just a missing `!` before `irq_settings_can_autoenable=
`.
>
> I tried this change without specifying NO_AUTOEN, but it resulted in an e=
rror.
> __setup_irq succeeded, but irq_nmi_setup failed with -EINVAL.
> I haven't investigated further beyond that point yet.

Thank you for trying, from reading the other commentary in the thread,
I recognize now that that was a naive suggestion.

I think that this patch should go in as is then unless there are other
concerns, because it seems like it is not possible and should not be
possible to autoenable NMIs and that explains why the code does what
it does to answer Will's original question.

Whether or not that behavior can or should be changed is a different
concern, but given that all the other callers use IRQ_NOAUTOEN and
later enable the NMI explicitly, I think that should be acceptable
here and a subsequent patch could be made to change that if it becomes
possible to use IRQ_NOAUTOEN later.

>
> Best Regards,
> Kazuhiro Abe
>
> >
> > As far as I can tell it has always been wrong - git blame points me to =
the original
> > commit where that code was introduced:
> >
> > b525903c254da ("genirq: Provide basic NMI management for interrupt line=
s")
> >
> > I looked and the only two callers are using `IRQF_NO_AUTOEN` so I guess=
 it just
> > hasn't been noticed yet.
> >
> > Happy to send a patch to fix it.
> >
> > >
> > > Best Regards,
> > > Kazuhiro Abe
> > >
> > > >
> > > > Best Regards,
> > > > Kazuhiro Abe
> > > >
> > > > >
> > > > > Will
> >
> > Best=E2=80=94Charlie
>

Best=E2=80=94Charlie


