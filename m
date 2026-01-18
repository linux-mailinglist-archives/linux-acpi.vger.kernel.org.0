Return-Path: <linux-acpi+bounces-20420-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1152D399E3
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Jan 2026 21:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D92843007685
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Jan 2026 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D73074A1;
	Sun, 18 Jan 2026 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlKzeFi8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1EC3064A2
	for <linux-acpi@vger.kernel.org>; Sun, 18 Jan 2026 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768769742; cv=none; b=qe/afFKafcyZGc4R7xXMXh6OXJ4deZpSmtR66tTN9Tc9QVkrieMzc+aLEtyabIk/hLlhznc+3tGT8OuWvo05LUF1kjaJ89czOoA+i/kCLqSJBD0nj1Z1xCB/BF3xn6JG0JiIZeQQ87x0Wc93W488kQqGPrH4wzI76yv+4MOIO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768769742; c=relaxed/simple;
	bh=0IOeR/QlIEwrzeqzjdLr90v8L5HbfaxOxY7FREUT8KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJ474n2MtZPQYEkry99EL9oXGHal6XPNvDwUi4OW3YVRnfYUnUqUN69gBSmEomkCnDexHOxL8t3GOvX45yfn0MVyOKVJPgaQaA1/XD8QorPy68olH9olJxcFFjdTVjHc52RgJEoB8jHnWsgipa8UMOrkBPhVc0zX9G1s2lqsMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlKzeFi8; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45c7c841904so2222544b6e.3
        for <linux-acpi@vger.kernel.org>; Sun, 18 Jan 2026 12:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768769740; x=1769374540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WE1A768m44bJfo3XKDJmxUdMA8aOFBeGUhlMA2XN3A=;
        b=YlKzeFi89AyFxCxvGwvqwUceoMZSP07ZQz6LFC/5dnihFBWy8LhYx6eF6uI2InMSz6
         z5/IPPWjg61E2F4Mlcskj2T9KK8BQiDT5D45XGg7UTyNvQ1PpT3gpLLxH1YTZbulN83R
         EOMDsCutrHGecc5TPkIKJVJR5ut2NGUq7ubWMGxUFKi7ERy62UIn2mAmI//THPbr99fA
         wgw8II1shl37ShWY8M2zkNbzeZm6AP3Gqjo5To/1OADUCyLX8RAwo6U4QstahTU8UJOJ
         p1srK9br+4tk6uL1AwM5WI2iuYcOlatUYMvicTmp1+LN4FpqaDyE0AXTpNHR9RKyaYMN
         TlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768769740; x=1769374540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7WE1A768m44bJfo3XKDJmxUdMA8aOFBeGUhlMA2XN3A=;
        b=bdZKz9IPLPNP5Qz+hbsxJDhL/qRlNDa/VVfSCkJ+1kl8+QSVvZC9mHpDlmxSi2XqrP
         wloG4rEwe8IRjdB2/Qg4l8g3GZqbK/mHAL0+B4g9EdVzBJD8jJpKndHtXvmWG1dDBcmn
         ISkWdnGZKhvr6gwTEiX3vQPew2sr0mrsy1YVrhLxG4PZCgeHWcLQv7w3Vdt1JVcXrgK2
         itkRtN3Ok+tKDoeXTJZeBmuFtso9SF/Umud1Onw5Z28UJWM8U3/1WSvCCQlSYq14h+LW
         m7JdCMCxNBt2Z5HdxnNP2+5A2Zs2jbOny5J0HJJQjB7o8+PBUu5EcWf+KNwzPjLsJyoR
         urKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5nBL6yT91lq+nmorqU9DfohYcZXtUlWPVullV0MWHADkREigUXz9WfUDPoUuOjKk3JoLm0vvWSEmh@vger.kernel.org
X-Gm-Message-State: AOJu0YzjYmBNfX3M/5EiSSpp4hXv0uCPQTaj0tvFyQ4uZ26HwWlsOliF
	vvZq6dl3DaJRA0IeUUfbvwVIGv3oCDrXTj7KYkCgbk2oFMJOEbZtdWMM+46aGaDhCS2jemWb26s
	AM3TvqQzUp5Tk5oMfmjkm2FMhe23HMdc=
X-Gm-Gg: AY/fxX6IpOmoPr/icCWMDVshj2dlRLLd0P4I9v/ALGDWtYbJ5Wtoz6BCd/oLN0T1FZt
	vKRsh5BnLjIj67ut0IgbTLqtp0dPBxI6Xf0yedEYjUQCAywVzFd25L7daY1T/YM8yTTFdO37YzD
	IwHVMDZ8YD/eeSVEtGAUe3l9Z4JkIDm9KrXfA974oxQWIcWnK0V0MGCIBJA/USOH8qE2ItpL1ki
	dhwtX5s+YNy7eRKquFKLZ2EWbUjIfMLEsoB+msFC+eV7WvDgGdIsUI4o7DVevzSnYTEBAof
X-Received: by 2002:a05:6808:f94:b0:450:c456:10df with SMTP id
 5614622812f47-45c9d8fbebamr4109264b6e.55.1768769740299; Sun, 18 Jan 2026
 12:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-mailbox-pcc-non-threaded-irq-v1-1-916b093329cd@kernel.org>
In-Reply-To: <20260116-mailbox-pcc-non-threaded-irq-v1-1-916b093329cd@kernel.org>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 18 Jan 2026 14:55:28 -0600
X-Gm-Features: AZwV_Qizd63QYo8BVUHM6YfDzZGczlXwPXfwd7_I09id4r2khJDqDw1AZEqB5YE
Message-ID: <CABb+yY1z36Tt+4EGzgcDp1GDZqVseNF7ZzLPGESrjPdbMdwksA@mail.gmail.com>
Subject: Re: [PATCH] mailbox: pcc: Remove spurious IRQF_ONESHOT usage
To: Mark Brown <broonie@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 8:07=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> The PCC code currently specifies IRQF_ONESHOT if the interrupt could
> potentially be shared but doesn't actually use request_threaded_irq() and
> the interrupt handler does not use IRQ_WAKE_THREAD so IRQF_ONESHOT is
> never relevant. Since commit aef30c8d569c ("genirq: Warn about using
> IRQF_ONESHOT without a threaded handler") specifying it has resulted in a
> WARN_ON(), fix this by removing IRQF_ONESHOT.
>
> Reported-by: Aishwarya TCV <Aishwarya.TCV@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/mailbox/pcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index ff292b9e0be9..060489e5ae6d 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -552,7 +552,7 @@ static int pcc_startup(struct mbox_chan *chan)
>
>         if (pchan->plat_irq > 0) {
>                 irqflags =3D pcc_chan_plat_irq_can_be_shared(pchan) ?
> -                                               IRQF_SHARED | IRQF_ONESHO=
T : 0;
> +                                               IRQF_SHARED : 0;
>                 rc =3D devm_request_irq(chan->mbox->dev, pchan->plat_irq,=
 pcc_mbox_irq,
>                                       irqflags, MBOX_IRQ_NAME, chan);
>                 if (unlikely(rc)) {
>
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260115-mailbox-pcc-non-threaded-irq-1ca29631e051
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>
Applied to mailbox/for-next.
Thanks.

