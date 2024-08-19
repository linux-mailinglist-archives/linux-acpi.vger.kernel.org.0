Return-Path: <linux-acpi+bounces-7677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F4957673
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 23:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3181C21216
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402FE15A851;
	Mon, 19 Aug 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DtT2Pe2n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F21598F4
	for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102671; cv=none; b=h7fNe79PZAXedaKsWTvofnXJXsYGlsRTtbQQVxdlalp6PsOqpRHU5quNX4Tr9If5rDjP7Xz8fP5D37m/myS+xr09AM4uzAqXNdIvSHrADJFLtgnVIII5qAwiVy6uZeVd3hrCak5GGs0Lk3ZVvFvL2FzNQhc1dYgDm+vCI3gH8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102671; c=relaxed/simple;
	bh=u+0m0US3QFw84sTqEbjna9w6FE0gpMTeeaVLynF5j9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMVB0nEz7BmAKvGROxnvEBkDr1zG7odDkUkvCnPuQtPO3S/tMo+rE78DSGEnQydJlLnmpGdOpr6/ZU4mus72t7JWfp5AmfKRdU2qQ/1gSwg4Pq2MIVw/Kz6l6ZnbLsWFSuyxYtNFTer5D6X4rcablTCZJX1R18UryXGbh/QDLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DtT2Pe2n; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-842fdb1afb1so1610549241.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724102668; x=1724707468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiPuVEIARbs7nZfPRgac3ucMDQpztOtq3lJp2GBYRco=;
        b=DtT2Pe2nLR8VRYk0rzMM5mkYnn7GTF2EUNu+8domdSg4KxZeqI11Xr/cxFMlfc/KAh
         mMU133RBG1J3pUjS3ctF3SRH/Def2K3meDQDnUqVIOf84YjiqPpwUKff0hlF1ZNsTpcz
         xBbdIYoignoJ2+JXnD6Pf7qwvRLjtsTqcbjWDR6jVwN8hTrr2Cq/6vayKOI9MZlUVpZ3
         +OQHciyI/stwtWAKCzNvsU1DEgSSyp+d99Xjq18T5KTZ64cIRRos5ax/tUJFUyWVKvg2
         /Y29uijJjsczD5QAnAGvHOXEpHoj5tAeze44gDdiNPA7vCwttJTMmZ9wUHcmmYlD4trp
         4LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724102668; x=1724707468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiPuVEIARbs7nZfPRgac3ucMDQpztOtq3lJp2GBYRco=;
        b=PT16qHNF3IXQIEtyHETw/YBH/FZtTYpcpv7qroHnt4zTkqYeR+q0wxGF9Thhy3fhCq
         t92eDk1LzIy+oCv+og54vhumYbhCHpLX9UYFLZuDVifPdWfQ6N5g3u3kJuDeGo11xm1R
         yoet6FDSItTOQcb+xJPgS+W292t0TRoe8F6NTUXpRh0+mB3f4XCoFI/V2vTZVQ6AnWD/
         es9bfCArWL095+kGeB9YMzIUIaPEIDhuqHiLX2kz2nRERIk/dqVMC1QXnOTNUtRpE3W2
         Wt5QTC+Xb6YSIANS+h8vNPIQFD7zfoUWA1/9SbrHnwOwTPdbCgYhzVuwQIK/6j5REq2/
         whog==
X-Forwarded-Encrypted: i=1; AJvYcCWVio3OixmHbK9UNChtgWFKoMz2U0G+bPb6aVMp1nTkFsa9sNxlr5NTwo2oMUXF2W7f47HGntPY5LAZJgNwsySe6d7evM1uWQ5iJg==
X-Gm-Message-State: AOJu0YxWL0thvno+vljLJnk0X7/tEbakKh7bsM8dX4DdDnk8xeZ9evDQ
	h+03usnNUkPNReEQkwZQpbImkiNfPNCR+YIJav4H4kF9ChdSRKqvUyTCk7CSETokI+Dwat0Jrf2
	UmsFNmx8Ad2r1QBEXwHW25XgZ90KKnG1R4qvo
X-Google-Smtp-Source: AGHT+IE+E6VJ5JvA7Lqq7iQmAIRzeQu5arI3TDl9cLtuS06laSaYx2Gcf5jbf18gxD5V1/WytLtXiNijQYFV+DdrRxA=
X-Received: by 2002:a05:6102:304d:b0:48f:8ead:7b7 with SMTP id
 ada2fe7eead31-4977997fc1fmr14487889137.21.1724102667560; Mon, 19 Aug 2024
 14:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-acpi-platform_profile-fix-cfi-violation-v1-1-479365d848f6@kernel.org>
In-Reply-To: <20240819-acpi-platform_profile-fix-cfi-violation-v1-1-479365d848f6@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 19 Aug 2024 14:23:49 -0700
Message-ID: <CABCJKue4NgOVxfjcU=oE23rogqgfiiJMqLHp-NSoSs=o1=22kg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: platform-profile: Fix CFI violation when accessing
 sysfs files
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Mark Pearson <markpearson@lenovo.com>, 
	Kees Cook <kees@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org, 
	John Rowley <lkml@johnrowley.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, Aug 19, 2024 at 12:09=E2=80=AFPM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> When an attribute group is created with sysfs_create_group(), the
> ->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
> and ->store() callbacks to kobj_attr_show() and kobj_attr_store()
> respectively. These functions use container_of() to get the respective
> callback from the passed attribute, meaning that these callbacks need to
> be the same type as the callbacks in 'struct kobj_attribute'.
>
> However, the platform_profile sysfs functions have the type of the
> ->show() and ->store() callbacks in 'struct device_attribute', which
> results a CFI violation when accessing platform_profile or
> platform_profile_choices under /sys/firmware/acpi because the types do
> not match:
>
>   CFI failure at kobj_attr_show+0x19/0x30 (target: platform_profile_choic=
es_show+0x0/0x140; expected type: 0x7a69590c)
>
> This happens to work because the layout of 'struct kobj_attribute' and
> 'struct device_attribute' are the same, so the container_of() cast
> happens to allow the callbacks to still work.
>
> Change the type of platform_profile_choices_show() and
> platform_profile_{show,store}() to match the callbacks in
> 'struct kobj_attribute' and update the attribute variables to match,
> which resolves the CFI violation.
>
> Cc: stable@vger.kernel.org
> Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
> Reported-by: John Rowley <lkml@johnrowley.me>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2047
> Tested-by: John Rowley <lkml@johnrowley.me>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/acpi/platform_profile.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Looks good to me, thanks for fixing this!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

