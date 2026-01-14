Return-Path: <linux-acpi+bounces-20344-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DCAD20FE5
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 20:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D52D30361F1
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979233D6FF;
	Wed, 14 Jan 2026 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxkdCpmX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3D32E15B
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418337; cv=none; b=Snu6a0tSbAbJvkCjVOD+OE807oeoZO2YfEY37l4YLB6kX5IwMwxYfkGpaTcupi5F6lNtO23X3JNJ8wYR+QibI6pYm8d615Kkm9Z7Xlv3WXkgqSq35/RPG2Auxc3wGq8o4mKtufOtVcYSaBdmKqFR8l6uPh7o9hpNa+PlX2XlNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418337; c=relaxed/simple;
	bh=mRW+ApTGFAYjUH5LWaHBTUWR0qFpz/SlGT1yEm15qL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEFfbZ8WxzvSLYvLAfeTY+KTR3Qz0h1pKXwHd8wQZNQiHICKBKaXTZ9N6krV5nakkyHvR6D2Jj1aODKZ6eVNQAe4+woN1c5ZctsAAb6c8tGBsWx2Upzm3fuIT4w0oF83A5irw1Lz8Vz/KLnCuDuMfMiWxURTGV37q00U74Kirag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxkdCpmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A5BC2BC9E
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768418337;
	bh=mRW+ApTGFAYjUH5LWaHBTUWR0qFpz/SlGT1yEm15qL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oxkdCpmXpq8Mv0dyNEbVoh3t3Fh5YrWVmk7/uxKgdrRTPKtLa9A5Lgjn2w87vrall
	 fsNzHCljsoe43AEf7S1tfi6kQ2Si/KiQoNxtSksW8tPTA0MuFJ/ZnhSSIQ3md3C7mB
	 JWdpis5qryjzE5XTWhiBPXdNNHHC1aS8jz9z/vaALSUui1uc9P+ox+7spYCOlNCgW8
	 /Yvj0VPF2igkl8ZmtQziM18tOSiGbJ4bw9IU27pHxXeJvboHn1ba3yBocTu+jFyb9P
	 F/fu+oQMB2VwCBoooUNrdV0zNB2tFNQ5Auf1kJEeSwYrynn52hMqr/KXPV/9KFrVZi
	 NhsW6LRzslvIQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c7660192b0so121269a34.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 11:18:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9Si6mNE7XDEMfkbqF34Awkn3+q+iB4oUDjDeYmYhkcWdDHIGr9ZvpyzCa/NPykwob+3hd+2vF7V5J@vger.kernel.org
X-Gm-Message-State: AOJu0YwhxdDvqwcVR0L5fHhywwNZ4PgGfbSx4epAXElEQmP1u4fvmCWz
	79KxrZp1qfRG9D8KPwVivYJFoyqjagW4Cyu7k8gQPN/f+kdrfL6ZG3n3XqDgNuPIMa4wG204xpX
	2kcEHHFw8NrZs6L8A0sE3Aq478qsl8d4=
X-Received: by 2002:a05:6820:1b14:b0:65f:6aa6:fc36 with SMTP id
 006d021491bc7-66100677720mr2596728eaf.10.1768418336219; Wed, 14 Jan 2026
 11:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125072933.3706006-1-lihuisong@huawei.com> <20251125072933.3706006-2-lihuisong@huawei.com>
In-Reply-To: <20251125072933.3706006-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 20:18:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
X-Gm-Features: AZwV_QhR6WRuasvLQqO4WuvP1GW9ALDTBK-uCuRmSFHKnx6jeWckhJP1vMUiGpY
Message-ID: <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 8:29=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> The global switch of cpuidle can be turned back on in some case.
> So add enable_cpuidle().

No, this is not going to work.  The "off" switch only affects
initialization AFAICS.

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/cpuidle/cpuidle.c | 5 ++++-
>  include/linux/cpuidle.h   | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 56132e843c99..980ddfd3d930 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -48,7 +48,10 @@ void disable_cpuidle(void)
>  {
>         off =3D 1;
>  }
> -
> +void enable_cpuidle(void)
> +{
> +       off =3D 0;
> +}
>  bool cpuidle_not_available(struct cpuidle_driver *drv,
>                            struct cpuidle_device *dev)
>  {
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index a9ee4fe55dcf..94c030748af3 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -168,6 +168,7 @@ struct cpuidle_driver {
>  };
>
>  #ifdef CONFIG_CPU_IDLE
> +extern void enable_cpuidle(void);
>  extern void disable_cpuidle(void);
>  extern bool cpuidle_not_available(struct cpuidle_driver *drv,
>                                   struct cpuidle_device *dev);
> @@ -203,6 +204,7 @@ extern struct cpuidle_driver *cpuidle_get_cpu_driver(=
struct cpuidle_device *dev)
>  static inline struct cpuidle_device *cpuidle_get_device(void)
>  {return __this_cpu_read(cpuidle_devices); }
>  #else
> +static inline void enable_cpuidle(void) { }
>  static inline void disable_cpuidle(void) { }
>  static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
>                                          struct cpuidle_device *dev)
> --
> 2.33.0
>

