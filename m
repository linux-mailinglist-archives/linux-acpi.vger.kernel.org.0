Return-Path: <linux-acpi+bounces-18501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C3DC32029
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 17:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8123A8D15
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BBC331A49;
	Tue,  4 Nov 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7+PnSG1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2AB3314D9
	for <linux-acpi@vger.kernel.org>; Tue,  4 Nov 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273196; cv=none; b=mw/001NadX23pePX4ItXHRZPjf7XhGd2r9HCrM+HDl1XDKIEnacJWvd2eKA+yQi7h/f0vsu+3QnZUqRKuVoQr8HWRkf5yYwCncAxvbCEOc5Blbn9YibUkVEHQJZxWzBDjhn9JgJfJ0AekOvnLJr4bmAhl+C2Wal5ivFUxubIHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273196; c=relaxed/simple;
	bh=u5x4oF3JNJTwRbaa5c/DHuS6u+ZbH15kjS5T8fJ6NAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1rgd4ShKrJjpvcSORRPwEErVwvA71OwUOerts7MNRD14F7m8415Y1ZvqWqjT6Pl6T685WlQqEF0/YS1DYvhs9ZMdS8Zxai6sfg8kdH6T6GyxzrjmJ8jpcpUAg6te/P06lEHYTicXML6VQWKHc37Rc3NU38bIMxH8YGoorJvCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7+PnSG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AD2C2BC87
	for <linux-acpi@vger.kernel.org>; Tue,  4 Nov 2025 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762273196;
	bh=u5x4oF3JNJTwRbaa5c/DHuS6u+ZbH15kjS5T8fJ6NAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p7+PnSG1ty8zvAr6+DfcaNCLQ8TLRt9DiXL83go4nil7mF+l8vSSwzDMXfJHJU9mR
	 TRPufiBNCXHgj4u3TbjXifIWWCG3hwWD9wIiA4AoG6kHIrOS55dTRDC0R8+d3XGK9C
	 oGtBt6nir2ZGgJbgxY9Zo4jSbg8L4Q6Rker/isqkkbUux4EKCiF3ihhWFVfG19kIJn
	 MGGUJN5xLQzL+vdn7bMsIoF/nejpBmhe/jiBLya7NnBDot+o2lWuL/aALTLB9HmCL+
	 kuk7PeyeViRV1xwco+vEc/bPXFFDCB8Lb2n7tgqsR2J5Nthpa1nrG7LIjY8GydiBjP
	 SMkr3Incr1GkA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3d37c1fb05aso2252274fac.0
        for <linux-acpi@vger.kernel.org>; Tue, 04 Nov 2025 08:19:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVa9idvGjWfPheHAUwvDlf08WH1b4Ablt/oT/pKpscivTm0Bd0af5nW3quibYSI7tax5fFZ32da007/@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTNWVUygbBgbh8MHLEGHcB22SyhW/1wQ4E7CUZPOKTkAwmQLL
	ilCcByX2NGr6lBEzrHtcINWw2Qr3Rn7LVGeWPtR/3tyZrsnwQ/VGAfC4obcVu21WDHso9puKkA7
	wzkVSBmTmXsj4gayIEnwyFospQzYiAuQ=
X-Google-Smtp-Source: AGHT+IGEim1RbXPCe722nmurcjGc49CZrpe42ZB9j/2qzTiaQ6NOm4zdYG9kulJZfW/hxXopTQS2D1VDyA6xMo7XzuE=
X-Received: by 2002:a05:6870:3c0e:b0:3d3:fc6d:b5ee with SMTP id
 586e51a60fabf-3dace9d9673mr7523325fac.40.1762273195316; Tue, 04 Nov 2025
 08:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103084244.2654432-1-lihuisong@huawei.com>
 <20251103084244.2654432-5-lihuisong@huawei.com> <CAJZ5v0idhxfOa8_Zp4Z_j5Rqh4GW4JsBpGT_hT=v=NgcEZRb+g@mail.gmail.com>
 <339a202a-86aa-46f5-b45d-aea653f3e382@huawei.com>
In-Reply-To: <339a202a-86aa-46f5-b45d-aea653f3e382@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Nov 2025 17:19:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ii=ZJeCisXx3EOOMfqe8rRn=FvKBDsNuBucxvM0WXvgg@mail.gmail.com>
X-Gm-Features: AWmQ_bkPiYsg5rbCV7kZbpLXAc0u5R7QFp3Gf34GCpne8qPfVOb0gKF-4q9N56c
Message-ID: <CAJZ5v0ii=ZJeCisXx3EOOMfqe8rRn=FvKBDsNuBucxvM0WXvgg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ACPI: processor: idle: Disable ACPI idle if get
 power information failed in power notify
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 10:54=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2025/11/4 2:09, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Nov 3, 2025 at 9:42=E2=80=AFAM Huisong Li <lihuisong@huawei.com=
> wrote:
> >> The old states may not be usable any more if get power information
> >> failed in power notify. The ACPI idle should be disabled entirely.
> > How does it actually disable anything?  It only changes the
> > acpi_processor_power_state_has_changed() return value AFAICS, but that
> > return value isn't checked.
> The acpi_processor_power_state_has_changed() will disable all cpuidle
> device first.
> AFAICS, the disabled cpuidle_device would not do cpuidle, please see
> cpuidle_not_available() and cpuidle_idle_call().
> It's enough for this?

Well, not really.

acpi_processor_register_idle_driver() has been changed to call
acpi_processor_get_power_info() for each CPU before registering the
idle driver and if that is successful, it will set
flags.power_setup_done for the given processor and call
acpi_processor_setup_cpuidle_states().  That processor need not be
CPU0.

However, the code updated by the $subject patch calls
acpi_processor_get_power_info() for CPU0 and the patch would make it
skip re-enabling cpuidle for all CPUs if it failed.

It essentially needs to do what is done in
acpi_processor_register_idle_driver(): find a CPU for which
acpi_processor_get_power_info() does not fail, then call
acpi_processor_setup_cpuidle_states() and re-enable cpuidle for all
CPUs unless acpi_processor_get_power_info() fails for all of them.

But there is still a question of whether or not this addresses any
breakage seen in the field.  If not, maybe it's better to leave this
code as is for the time being?

I don't see why it is part of this series to be honest.  It is not a cleanu=
p.

