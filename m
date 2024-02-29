Return-Path: <linux-acpi+bounces-4030-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0972B86D079
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Feb 2024 18:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3501C21100
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Feb 2024 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7219170AEB;
	Thu, 29 Feb 2024 17:23:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F16CC13;
	Thu, 29 Feb 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227391; cv=none; b=tlTXMzCY2K6GOnWn/XeU0gPAFqRmGfl9b+nN35PcUGccKiMgHxeko77FZE0YxMolo8phG+pbyctV0s/IShKnDzXdxsJg0Lm6/gO3BfbbGPRxTo0YmNEDsYFCmHuuoMMQHyoa0Ku/j9CowMGNYpUBrUmbLtwDak9Fx9yGCvLYdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227391; c=relaxed/simple;
	bh=Wqp7vYvF1R5w9E4ZCFNHkQ8Crmpl3JfpX4QWPyqkqNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etTznWUL5E0IeOP6Z2Oh1ydLinf3QrN0WB4eQMKuA2LMpN9VxN4EYPXp1+1NgNwClAYwe6bBqOANeod90tY8OqQN5te5QgRqOT6hUwiKaG0OwVhkGRrVKkwlp6OfIG4oPS07G2732+Y86loY57mu5P8KqTujKn4EqCGRv9lf6+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e45f7c63f4so150177a34.1;
        Thu, 29 Feb 2024 09:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227389; x=1709832189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04w0TT0gz2a571F2BpcXXnr3ynupZiC2dhT3d967Bys=;
        b=Ae2K07Sjd4aE4DAD2kY70He2UYoYkGv0mf0Xisc9xZl5yvxHgtJLStQ9o2zKGmNUzw
         0JGsCklK4EaSQhsgCcjVcGpSoktkhbcEoDt/vZJtRecL3LhhisVtHJVOM3oKQVzGy9TJ
         p4XzYrUEhA5f5zgtIkLbdA870XuHIIYnOBIeS4vB3RzsBUB2ZLxIc0w2AIWH8NbQDQfi
         p2t2fhraN4PvtPVG90UJpm9q700oAfrupLzTWpVL/o0432UGRq7MuJ6EhSrXw0ujyOFU
         HKDEdr6OMIHUngYJWmWISo4KGE/tTXIMx2MuPQv5JY3a8w0pqDhnQtnVumsDy0ecy0L3
         eDeA==
X-Forwarded-Encrypted: i=1; AJvYcCVBuJG37/ZvCn4BRFfgwztsoFrzJKX36yXE/W6DsSkeR7SFlZqi8JBFMTi3/GuX+iU6KNuvbVCXcHNklCGn6ZHC41cGIRWhjrfJcKsnzZ1hNiMLAwHc/Dx7CSKnn86dYJmjPwq5
X-Gm-Message-State: AOJu0YweAB6OPvfY+4+yK9jMnsy/5IYGJJ+SByv2EkatK/OVixf6euqL
	4LYH6IHpo9urvoVut/JHeiC18DK6WoxJYiLljzDSppdScshIZcsRF+IaUTVx2CclVgXspbD+N1D
	NKL5MxVLIFc9Ud5E3rsBOJdkMU6N5Vkul
X-Google-Smtp-Source: AGHT+IGtcUe05745ulu3glKbeosXQTYJWkvT/KOtq1/81naw8u8LYhjFqZWX0809q4bqpv2DXjdELQLTweXDr2y1p6U=
X-Received: by 2002:a4a:301:0:b0:5a0:396d:2489 with SMTP id
 1-20020a4a0301000000b005a0396d2489mr2666361ooi.1.1709227389013; Thu, 29 Feb
 2024 09:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64137e23-e374-4129-8e3c-dcd7606364d4@linux.alibaba.com>
In-Reply-To: <64137e23-e374-4129-8e3c-dcd7606364d4@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 18:22:57 +0100
Message-ID: <CAJZ5v0hG7vpWd9-pdeuNZDpDQ13MuwzgPkFnyG7TuQ=DRAMo6Q@mail.gmail.com>
Subject: Re: [PATCH] x86/cstate: fix mwait hint target cstate calc
To: He Rongguang <herongguang@linux.alibaba.com>
Cc: jacob.jun.pan@linux.intel.com, lenb@kernel.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	shannon.zhao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:28=E2=80=AFAM He Rongguang
<herongguang@linux.alibaba.com> wrote:
>
> According to x86 manual (Intel SDM Vol 2, Table 4-11. MWAIT Hints
> Register (EAX) and AMD manual Vol 3, MWAIT), mwait hint[7:4] adds 1 is
> the corresponding cstate, and 0xF means C0, so fix the handling of
> 0xF -> C0.
>
> Intel: "Value of 0 means C1; 1 means C2 and so on
> Value of 01111B means C0".
>
> AMD: "The processor C-state is EAX[7:4]+1, so to request C0 is to place
> the value F in EAX[7:4] and to request C1 is to place the value 0 in
> EAX[7:4].".

Yes, 0x0F is defined to correspond to C0.  However, the value in
question is never equal to 0x0F in any of the functions modified by
this patch.

What's the purpose of the modification, then?

> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---
>   arch/x86/kernel/acpi/cstate.c | 4 ++--
>   drivers/idle/intel_idle.c     | 3 ++-
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.=
c
> index 401808b47af3..f3ffd0a3a012 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -131,8 +131,8 @@ static long acpi_processor_ffh_cstate_probe_cpu(void
> *_cx)
>          cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
>
>          /* Check whether this particular cx_type (in CST) is supported
> or not */
> -       cstate_type =3D ((cx->address >> MWAIT_SUBSTATE_SIZE) &
> -                       MWAIT_CSTATE_MASK) + 1;
> +       cstate_type =3D (((cx->address >> MWAIT_SUBSTATE_SIZE) &
> +                       MWAIT_CSTATE_MASK) + 1) & MWAIT_CSTATE_MASK;
>          edx_part =3D edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
>          num_cstate_subtype =3D edx_part & MWAIT_SUBSTATE_MASK;
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index bcf1198e8991..e486027f8b07 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1934,7 +1934,8 @@ static void __init spr_idle_state_table_update(void=
)
>
>   static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>   {
> -       unsigned int mwait_cstate =3D MWAIT_HINT2CSTATE(mwait_hint) + 1;
> +       unsigned int mwait_cstate =3D (MWAIT_HINT2CSTATE(mwait_hint) + 1)=
 &
> +                                       MWAIT_CSTATE_MASK;
>          unsigned int num_substates =3D (mwait_substates >> mwait_cstate =
*
> 4) &
>                                          MWAIT_SUBSTATE_MASK;
>
> --

