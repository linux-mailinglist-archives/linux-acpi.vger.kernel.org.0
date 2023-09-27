Return-Path: <linux-acpi+bounces-176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13C97AF968
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 06:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5A19E281314
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 04:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E275250
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 04:31:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FE17CA
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 04:03:46 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1619B4;
	Tue, 26 Sep 2023 21:03:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso11861113276.1;
        Tue, 26 Sep 2023 21:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695787421; x=1696392221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZWmen4JLaB5x8ESbke0gsUwehKeCChPmC+1mwTtUuc=;
        b=fZ0YkKlhgDotlE9HR+rhVmoPYM5dn13c3GHiw5V4/WFnxc7a5+ow/vFtKfAGAqEf3n
         BHM59Sg8CAQk5LbpZ4bzqdhEy8B1LM29toA0CylGm6cn7/CdaBQ5k/YDqFuPNlJ4BjeC
         l1nmqPu8bU6E3//mdYhwd7O6c6iRYbwVKIF9qGjv6/gajRs82N4s76gB/cr3HuJIhZGM
         lCehkP2E7O/2fVtAExd+r0wEpHvBbj3uPT05bIaoo7n2SyrvDXQ9d5ujx7quIx3ZrWY5
         0UEfAs94pzzhIbKdZ8y7KLfzPm3Q+7hpdoB0lN/ybY5RLaMLFQhCaQ1vDrTpU4u9b1Sd
         kMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787421; x=1696392221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZWmen4JLaB5x8ESbke0gsUwehKeCChPmC+1mwTtUuc=;
        b=vHP7DAvtx9nN2Lb0ZJUD96nhbeXNwDXNhYb0tNuPFbHkXf6iGef2PgKsbNRkWbLyf2
         11XxqTl4A8BdA7bewDLpF37mZO0bLzti/VGzdtgLCwameVcwffS+f4LAeMfklcvyJnER
         M4VN4G70Y61PV8GHzGve+1CxHD1MSW/TBV8ZePoVuhYRR672xwyuO0hjZvs+IL3QW8XV
         ZuBbEW1dglRZBeTn9vMeyHVZYJPCCPQ32VnbPvjocj4UajW7ngG0Pr94GlY0Sbu3fsnj
         fzYyb6WQ/MJqaeG/FHlK6Ye9AdzvDUVAn9B86fr7Sx4BV9GmkTfCg/qD6Rd21r/htx5d
         9Bng==
X-Gm-Message-State: AOJu0YxtV9NfxJlXDU33M+4NgXX4x71x6ZlfEhEf/kNCglda3qw0l3VO
	HOMAqHgH+xcpbXettEUOuQQWBjwPLX/0p1brUfg=
X-Google-Smtp-Source: AGHT+IF/vVrJQC7R1KNQ8hd+XcJr7nFxUONmpUX2ez40DLteEgJFOZKReYjsBtv6ACZD43negIIJXfw85N4ywMxMNuI=
X-Received: by 2002:a25:d6c9:0:b0:d78:ae6:e75a with SMTP id
 n192-20020a25d6c9000000b00d780ae6e75amr797922ybg.60.1695787420719; Tue, 26
 Sep 2023 21:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fdc7a4ee-250f-7ec8-ca15-32cbd480bd3e@linux.alibaba.com> <20230926230247.GA429368@bhelgaas>
In-Reply-To: <20230926230247.GA429368@bhelgaas>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 27 Sep 2023 14:03:28 +1000
Message-ID: <CAOSf1CF0nxSbLGhuB8LbK=LgpSQ1hfwPcH=-TV7VFj0N8adm2A@mail.gmail.com>
Subject: Re: Questions: Should kernel panic when PCIe fatal error occurs?
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	gregkh@linuxfoundation.org, Linux PCI <linux-pci@vger.kernel.org>, 
	mahesh@linux.ibm.com, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"tanxiaofei@huawei.com" <tanxiaofei@huawei.com>, "bp@alien8.de" <bp@alien8.de>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bhelgaas@google.com, 
	"james.morse@arm.com" <james.morse@arm.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 9:03=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Sep 22, 2023 at 10:46:36AM +0800, Shuai Xue wrote:
> > ...
>
> > Actually, this is a question from my colleague from firmware team.
> > The original question is that:
> >
> >     "Should I set CPER_SEV_FATAL for Generic Error Status Block when a
> >     PCIe fatal error is detected? If set, kernel will always panic.
> >     Otherwise, kernel will always not panic."
> >
> > So I pull a question about desired behavior of Linux kernel first :)
> > From the perspective of the kernel, CPER_SEV_FATAL for Generic Error
> > Status Block is not reasonable. The kernel will attempt to recover
> > Fatal errors, although recovery may fail.
>
> I don't know the semantics of CPER_SEV_FATAL or why it's there.
> With CPER, we have *two* error severities: a "native" one defined by
> the PCIe spec and another defined by the platform via CPER.
>
> I speculate that the reason for the CPER severity could be to provide
> a severity for error sources that don't have a "native" severity like
> AER does, or for the vendor to force the OS to restart (for
> CPER_SEV_FATAL, anyway) in cases where it might not otherwise.
>
> In the native case, we only have the PCIe severity and don't have the
> CPER severity at all, and I suspect that unless there's uncontained
> data corruption, we would rather handle even the most severe PCIe
> fatal error by disabling the specific device(s) instead of panicking
> and restarting the whole machine.

From a user's point of view disabling a device is often worse than a
reboot. If you get a fatal error from a system's only network card
then disabling the card may result in the system being uncontactable
until someone manually recovers it. Similarly, if the disk hosting the
root filesystem disappears the system may not crash immediately (most
of what it needs will be in page cache), but there's no guarantee that
it can do anything useful in that state. In both cases forcing a
reboot will probably bring the system back into a usable state.

> So for PCIe errors, I'm not sure setting CPER_SEV_FATAL is beneficial
> unless the platform wants to force the OS to panic, e.g., maybe the
> platform knows about data corruption and/or the vendor wants the OS to
> panic as part of a reliability story.

The PCIe spec is (intentionally?) vague about the causes of fatal
errors. For all we know a device is reporting one because the embedded
OS it was running crashed and as a side effect it's been DMAing junk
into system memory for the past hour. If you know something about the
device in question maybe you can make those assumptions, but in
general it's impossible to assess the actual severity of an error.
Even in the case of a noisy link causing bit flips (it's possible,
LCRC is only 16bit and ECEC is optional) if we get corruption of the
address bits of the TLP header then the DMA might have overwritten
something important to the OS. From a hardware vendor's point of view
just forcing a reboot makes a lot of sense.

Paranoia aside, in a lot of cases PCI device errors are nothing major
and can be resolved by just restarting the device. However, there's no
way for generic kernel code to make that assessment and we probably
shouldn't have the kernel guess. I'd say the safest option would be to
punt that decision to userspace and provide some way to whitelist
devices that we can ignore errors from. I'm not familiar enough with
the ACPI to know if we have enough details in the notification it
sends to actually implement that though.

Oliver

