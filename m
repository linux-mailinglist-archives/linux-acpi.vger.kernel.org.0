Return-Path: <linux-acpi+bounces-11146-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79449A3373F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 06:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DE1167D2B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 05:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA48205E3B;
	Thu, 13 Feb 2025 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyAiXhOb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA471EA84
	for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2025 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424693; cv=none; b=pso8yDUv1SBjed3KVMo1LJfEeSpwT32rNerPg+nv20mmLJXYbGUMilHIeyb57cX2BQzykjKLByboZSZKrdeRgn8BXhbWfS9Y4WwyqkbcYyJ+9MkdLPurIQRDkoQB9ENlsR1uKjQoAEu4teT6gCXRxCe4XBRHU8ANWeUfCzJLCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424693; c=relaxed/simple;
	bh=cnl2m4eSSFzUd2FI5RbArgk7aO/6MxFZUQsO6v5J5lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beUoU/vU5zNXjPzG7apMDuQSXjSf16jAu/Ok5cj64vR41zs8h5NuhaR/buYQc/mFbbhDYZkzOSVd1KkQJFxf7ilQtntjWoj39abgniwOWfRFzT+Gxex5++KnPdTm8gFAh8YJTD+uk27AHlGNh+/UrIsc2XUDMrycZYNgLR6x4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VyAiXhOb; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4bbdf3081acso278794137.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 21:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739424691; x=1740029491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vx7h+AT1hd02pbPgDY1t0vIhjDwtSi7eGcVZkGc6A8=;
        b=VyAiXhOboCruzyZg0WmhtOqWcSocuOliKA1bYpi4T10kzluScfFmftE0BQ2M9cUsfq
         cqLrmul82UAo6T/ffNrQuErQ6/zgZpQ5XcUenbEGQTwhcONoj6+3rI6kIzvw6YgmJA34
         mWbjrhi9BpwTu0CEWT1FInP2PRq15N2A13RyVqX6OG/+0mPNwjGbZRiMuhdb+IHuDoJN
         97y+LY6WUwH2WNu2dMJ6I/Gjkc9xZGr4OJB3fNzGoBuk5QitdYD1evdJwIRdBROKh0T4
         zJd0sAmuFl5IQIpz68FaJqI7i+r5pcPb6hhe9cCXtURAnbeIFtTd0NJVYER0/hlh1gTk
         asVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739424691; x=1740029491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Vx7h+AT1hd02pbPgDY1t0vIhjDwtSi7eGcVZkGc6A8=;
        b=BO36zJTTZDuAXZkoMV6baslPUTDHBcKDFNhRAtm6xgW++jx22iRSXylHqEvGk5cGpw
         kbyFPXRrHafQog6YatGAw9TKsjMNAmYHixdDaRkfPhGtoAEVzoqhgek4Q390KNE3aovF
         VQqRvLdbND7gFOF440Ux9knq5KqJvqDZfvniK08fNEUM39YuXmzYPcJ9FFgqBY9zQZFk
         qU43rWaXwMW4niMwhMTgYt/QKrjs0+7XgMhG4ceNf+PpgKHipXy/zBDroAlSt9D/F2u6
         rvxR03IUo5pi/ThHLkXJJR3v4j7KwABt/YNp2f1fYZaGgrZJa4dFK6wFLq2Et6FdMfWA
         LsRA==
X-Forwarded-Encrypted: i=1; AJvYcCVOF4rBy0XPHIvl5Ov2obDvjuiOVMJWkeyNKMX2EMexJphK8U5vex6wJ0MIxJvh/Mqt4vxUYJzmdKmC@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOg8Z6lhMIhZDFK9U+SlzcEumMHqbDFkVoygJYVAeHSJuR1eR
	jB5J9j6FpbBPoZpqqe+KWecR53ootRCeylhyCMG6GUA6anqvDBTTplAfLwiOhNH9MpeyKsNcQ+D
	TkRHHWETiSA5Ibn0rBUxmikCP6oS/sI8m6ITuDw==
X-Gm-Gg: ASbGncva9eQucwq2PKw7UTimxabX97r+BAX8TpkxE72KhaRelw2TmOirk4c5IYUiZyR
	HYXV2EcZ0BlHgVW4FMMOJCKZyIxAj8Ehs9tY/1NgLVIM+B806ehgYCg6IXF36DxTmq7aGnrOze5
	g=
X-Google-Smtp-Source: AGHT+IE1b09Y0oh2SgYAlecKTFu/d9b/vl21w0WdHCnWjWmlZjDq81Lo0AiehcZEq4EZhisIZQ80PeR271tttdICELo=
X-Received: by 2002:a05:6102:1620:b0:4bb:d062:422 with SMTP id
 ada2fe7eead31-4bbf209b9eemr6518734137.3.1739424690944; Wed, 12 Feb 2025
 21:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210232227.97761-1-stuart.yoder@arm.com> <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com> <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
 <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
In-Reply-To: <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 13 Feb 2025 11:01:20 +0530
X-Gm-Features: AWEUYZkUe-JQu9WB8sdTJHZU0cqiP0txO2dUkC_k7zFWA78tOzalgc25rjYtTJQ
Message-ID: <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de, 
	jgg@ziepe.ca, sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Wiklander <jens.wiklander@linaro.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

+ Rob

On Thu, 13 Feb 2025 at 03:25, Stuart Yoder <stuart.yoder@arm.com> wrote:
>
>
>
> On 2/12/25 1:39 AM, Sumit Garg wrote:
> > On Tue, 11 Feb 2025 at 21:39, Stuart Yoder <stuart.yoder@arm.com> wrote:
> >>
> >> Hi Sumit,
> >>
> >> On 2/11/25 12:45 AM, Sumit Garg wrote:
> >>> + Jens
> >>>
> >>> Hi Stuart,
> >>>
> >>> On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
> >>>>
> >>>> These patches add support for the CRB FF-A start method defined
> >>>> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> >>>> in the Arm TPM Service CRB over FF-A (DEN0138) specification.
> >>>> (https://developer.arm.com/documentation/den0138/latest/)
> >>>
> >>> Nice to have a specification standardizing interface to TPM
> >>> managed/implemented by the firmware. Care to add corresponding kernel
> >>> documentation under Documentation/security/tpm/.
> >>
> >> Yes, I can add some documentation there.
> >>
> >>> BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
> >>> possibilities for an abstraction layer on top of communication channel
> >>> based on either FF-A or TEE or platform bus?
> >>
> >> I think the CRB and OP-TEE based messaging approaches for interacting
> >> with a TZ-based TPM are fundamentally different and I don't see how
> >> to harmonize them through some abstraction.
> >>
> >> The OP-TEE TPM protocol copies the TPM command into a temp shared memory
> >> buffer and sends a message to the TPM referencing that buffer.
> >>
> >> The CRB uses a permanently shared memory carve-out that in addition
> >> to the command/response data has other fields for locality control,
> >> command control, status, TPM idle, etc. The only 'message' needed is
> >> something to signal 'start'.  Any OS that is FF-A aware and has a
> >> CRB driver can simply add a new start method, which is what this
> >> patch series does.
> >
> > Okay, I see how the CRB driver is closely tied to the ACPI based
> > systems.
>
> The CRB driver is currently probed based on ACPI, but it fundamentally
> doesn't have to be.  If there was a DT binding for CRB-based
> TPMs the different start methods would be defined there and the
> CRB driver could support that.
>

Can't we rather enable the CRB driver itself probed based on FF-A bus
and rather dynamically discover the shared memory buffer via FF-A
instead? AFAIU, FF-A provides you with a discovery framework for
firmware bits. But if we still want to overload ACPI or DT with the
discoverable firmware bits then it seems like an overkill here.

> > I was expecting the FF-A based TPM interface to be
> > independent of ACPI or DT such that it's not constrained by the
> > hardware description a platform chooses to use. I suppose there will
> > be a different TPM FF-A driver or spec when someone wants to deploy it
> > on DT based systems, right?
>
> The CRB is just a shared memory buffer, with some architected semantics
> defined by TCG. The basic CRB usage model is that a client puts
> something in the CRB, such as the bytes of a TPM command, and then
> notifies the TPM that a change was made to the CRB. The CRB over
> FF-A spec just defines the message to perform that notification
> when FF-A is used.
>
> So, whether the fTPM was advertised via ACPI or DT, it doesn't matter.
> The FF-A based interface is only about the the notification messages
> needed for the OS driver to tell the TPM that something has changed
> in the CRB.

-Sumit

