Return-Path: <linux-acpi+bounces-18785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070B0C508E1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 05:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D7D3AA5A0
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 04:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915729BD8C;
	Wed, 12 Nov 2025 04:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvcUDq0O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D523BD1B
	for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2025 04:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762922579; cv=none; b=ZPZe2oEmzpI4KMNmwRJkilwfkGe8FgESEnmfmM2KkPiYVrTXlbTXvp0stFKra1OTB7BkbGoJoaGEGUlePeeKWOSSON3YBwVN23L5l6V1vI5Bko//lpynKIeDjAbA0wGqmxICEKyo1nYXQHuWvLLJHy8GHf2OGnxPc5Rf7zRwrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762922579; c=relaxed/simple;
	bh=6HV5R0vQv4BNsQt+Yhsxf1lzNigzlSp6ywMkqsoT8N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COMZxvsSXyDKcm3UcKmeFEAMcxCyiTZkwhXMwlRc/eMlJv92JzGPxzPq9NqVkNAaPOR+ac3ApXqitp7cdbln0mE01lIuq/efYyPYMAazucYJbV2TxhJKRbJ/pXj9GUrGKoYgwq0wUZ3yoYUMpka+OBUyEqrf2qBLjcOGzSyytOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvcUDq0O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762922576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7wfzbMX9zppyyEMbKM6+79VccQHudzEP6zJVdKYqxo=;
	b=GvcUDq0OAuk2vJfncANY7PT73KuQpU+5K8szr3Vycj7ofyUGXjzwTeBUU/oclT+xpEidZ9
	GdmuhuTJAfNkwdTyQn3vKFGGPWcTXls27noZMIcS3ul7o+hZN2IdtCrhsY+gC24dYE9AXq
	PI+NabMto3V214P6Fmb8eBZzDF/wcjo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-szULz0khMiy_j8U_Wp5yjw-1; Tue,
 11 Nov 2025 23:42:50 -0500
X-MC-Unique: szULz0khMiy_j8U_Wp5yjw-1
X-Mimecast-MFC-AGG-ID: szULz0khMiy_j8U_Wp5yjw_1762922569
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 773831956089;
	Wed, 12 Nov 2025 04:42:47 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.65.154])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D57271955F1A;
	Wed, 12 Nov 2025 04:42:43 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: fj1078ii@fujitsu.com
Cc: catalin.marinas@arm.com,
	fj2767dz@fujitsu.com,
	guohanjun@huawei.com,
	ilkka@os.amperecomputing.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	rafael@kernel.org,
	sudeep.holla@arm.com,
	will@kernel.org
Subject: Re: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Date: Tue, 11 Nov 2025 23:42:37 -0500
Message-ID: <20251112044239.4049011-1-cmirabil@redhat.com>
In-Reply-To: <OSAPR01MB7669F9B9E145A50B38819E13D5CEA@OSAPR01MB7669.jpnprd01.prod.outlook.com>
References: <OSAPR01MB7669F9B9E145A50B38819E13D5CEA@OSAPR01MB7669.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi All—

On Mon, Nov 10, 2025 at 07:38:17AM +0000, Kazuhiro Abe (Fujitsu) wrote:
> Hi Will,
> 
> > Hi Will,
> > 
> > > [You don't often get email from will@kernel.org. Learn why this is
> > > important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > On Mon, Oct 20, 2025 at 09:23:05PM +0800, Hanjun Guo wrote:
> > > > On 2025/10/17 15:39, Kazuhiro Abe wrote:
> > > > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > > > Currently, the AGDI driver only supports SDEI.
> > > > > Therefore, add support for interrupt signaling mode The interrupt
> > > > > vector is retrieved from the AGDI table, and call panic function
> > > > > when an interrupt occurs.
> > > > >
> > > > > Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > > > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > > > > ---
> > > > > Hanjun, I have addressed all your comments.
> > > > > Please review them.
> > > > >
> > > > > v3->v4
> > > > >   - Add a comment to the flags member.
> > > > >   - Fix agdi_interrupt_probe.
> > > > >   - Fix agdi_interrupt_remove.
> > > > >   - Add space in struct initializsation.
> > > > >   - Delete curly braces.
> > > >
> > > > Looks good to me,
> > > >
> > > > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> > >
> > > I wasn't cc'd on the original patch but I couldn't figure out why it
> > > uses IRQF_NO_AUTOEN when requesting the irq given that the first thing
> > > it does is enable it.
> > 
> > I misunderstood the usage of request_irq and enable_irq.
> > Since there's no need to separate them, I will remove IRQF_NO_AUTOEN and the
> > enable_irq call, and send v5.
> 
> I found out when calling request_nmi, removing IRQF_NO_AUTOEN results in an error (-EINVAL).
> Therefore, I would like to keep IRQF_NO_AUTOEN specified.
> If you have any comments on this version, please let me know.

Could it be that this is just a bug in `request_nmi`? I see the following:

if (!desc || (irq_settings_can_autoenable(desc) &&
    !(irqflags & IRQF_NO_AUTOEN)) ||
    !irq_settings_can_request(desc) ||
    WARN_ON(irq_settings_is_per_cpu_devid(desc)) ||
    !irq_supports_nmi(desc))
	return -EINVAL;

Perhaps there is just a missing `!` before `irq_settings_can_autoenable`.

As far as I can tell it has always been wrong - git blame points me to the
original commit where that code was introduced:

b525903c254da ("genirq: Provide basic NMI management for interrupt lines")

I looked and the only two callers are using `IRQF_NO_AUTOEN` so I guess it
just hasn't been noticed yet.

Happy to send a patch to fix it.

> 
> Best Regards,
> Kazuhiro Abe
> 
> > 
> > Best Regards,
> > Kazuhiro Abe
> > 
> > >
> > > Will

Best—Charlie


