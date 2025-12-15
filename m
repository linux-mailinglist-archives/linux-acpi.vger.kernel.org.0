Return-Path: <linux-acpi+bounces-19567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04252CBDBA2
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 13:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B49C6303B1B7
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B4244664;
	Mon, 15 Dec 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ8NOF4d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B73223DFB
	for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800164; cv=none; b=LoS8tTcXj9+6vA1l6EoHMyv5nCNTjHMXakD6cv0weAz6iHeE0UcU43UtVAPs0o4nyAlLgOkKIaZPGGB3r+zvvERhgrYwWJVgNrU/bfbnIe7floaSdypSF/ZpLyO5TBnnCLfSM+MAkMBvDGZB/DJqph51Coc5syHI518lOjwcvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800164; c=relaxed/simple;
	bh=JXTZb/1CDH6CIRF0EK1c3nh1c62edMPXPaI/Aiy4/4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWheqdCbJmoOKFnIfeWfplAXwul05INPT3psLRrEQFDCxBCj9hq4tjNzMF0QN6/6d4o6oiP6vPsjap4UwJ22PbcWKYV8B4+lJzv30yFL/dvdQFEvIOdzOH/I0cj/XPpoiFiuZz3dYnWvDCg9+GwTVC/BVt3Slo7JNAbHPnO5zzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ8NOF4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50292C2BCAF
	for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765800164;
	bh=JXTZb/1CDH6CIRF0EK1c3nh1c62edMPXPaI/Aiy4/4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GZ8NOF4dMmvqI2B2NLruVWdcit3smgBXr9dOLIKM1HKDRLa2CkATjmwAPXM+j/T3j
	 ED18/GFgscrfrqVqBmIgsq3PgQ/emO1IECVuxDL99L2Hnfe6gnzp+d/+M/i8jLLvta
	 lf9/RKlvMR0MyYRzNn6W5k8ZkNqWxoFsmc492r/Zcae+G6r0F3pBAyvUnUTLxF/00C
	 bPZ+kkGZMCaB07cm3FS+tL81dC8w6KWwOpOEVopk6C3+JcYDG65sFXO4p6TQ342XuZ
	 e6YIL/KHKTaJqkYtWLVfY7hFoOEV+rGB1LRQlek1SKj51E+f+9hq2BPX3FPRk7yXqS
	 FK9eHXPpQC6kQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-65b1f030a08so2094118eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 04:02:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPWoJAOiavoy3EyC/Cea5uDptilyEkd20TNpWORZUXw3V5bVPENjqBQyLKla/XZcsPxMikwRUTORcd@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0zA7BtQD1DGr8WXYrBRLx/GOhS/KFRwO3mODS08fqZsFnGVH
	JsETl8KEihqdqPTDA+K575khY0CoVV9DnbOpu5Q5/9PB+4zBZijfiArveyBI/HH9wUFuIq2/4Rf
	2dj8mQhJ1x67P6nNS5S9havOkZv78RrE=
X-Google-Smtp-Source: AGHT+IGWpOnYdM2AKB6XWm5zUzGfehCXqeIimn4bB+PT4sWn547tBFzZUB43AH9e97dQQX04rPxEaHKKn2Daranux20=
X-Received: by 2002:a05:6820:f006:b0:659:9a49:9057 with SMTP id
 006d021491bc7-65b451b0b2dmr4938689eaf.34.1765800163569; Mon, 15 Dec 2025
 04:02:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210132634.2050033-1-zhangpengjie2@huawei.com>
In-Reply-To: <20251210132634.2050033-1-zhangpengjie2@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 13:02:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jk=Z-uq=gEd5d1CgNFH7=M5ojNbb6M-Y-qE6J_0dfE8A@mail.gmail.com>
X-Gm-Features: AQt7F2orUGThi7hZYA_KJv5wezHkeCb-ajZhqLPUWHQyD_gZqGHbOpx_uuJr4bM
Message-ID: <CAJZ5v0jk=Z-uq=gEd5d1CgNFH7=M5ojNbb6M-Y-qE6J_0dfE8A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PCC: Fix race condition by removing static qualifier
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, lihuisong@huawei.com, 
	sudeep.holla@arm.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, linhongye@h-partners.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 2:26=E2=80=AFPM Pengjie Zhang <zhangpengjie2@huawei=
.com> wrote:
>
> The variable 'ret' in acpi_pcc_address_space_setup() is currently
> declared with the 'static' storage specifier. This can lead to race
> conditions in a multithreaded environment.
>
> Remove the 'static' qualifier to ensure 'ret' is allocated directly
> on the stack as a local variable.
>
> Fixes: a10b1c99e2dc ("ACPI: PCC: Setup PCC Opregion handler only if platf=
orm interrupt is available")
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>  drivers/acpi/acpi_pcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> index 97064e943768..e3f302b9dee5 100644
> --- a/drivers/acpi/acpi_pcc.c
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -52,7 +52,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle,=
 u32 function,
>         struct pcc_data *data;
>         struct acpi_pcc_info *ctx =3D handler_context;
>         struct pcc_mbox_chan *pcc_chan;
> -       static acpi_status ret;
> +       acpi_status ret;
>
>         data =3D kzalloc(sizeof(*data), GFP_KERNEL);
>         if (!data)
> --

Applied as 6.19-rc material, thanks!

