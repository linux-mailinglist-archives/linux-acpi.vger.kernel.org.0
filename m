Return-Path: <linux-acpi+bounces-20835-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJQqMXnygWkMNAMAu9opvQ
	(envelope-from <linux-acpi+bounces-20835-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 14:04:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F35D9991
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 14:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48A831575A3
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD76346AF8;
	Tue,  3 Feb 2026 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx2/TQeg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D970346AF0
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123413; cv=none; b=LS55OwiPkbht46E/R6c7AU8aJZcebsqnQFswQJzMmHnXl0TFbsLS1HyLGCZHsd83krOAEDuKX1H8Y/du/f41k3k5lB1Chc4D+64GRGTew3x3yhDkXpMK25B7EiWX2OZqsDAg/mkwdHzdr15l4z+xOgL9X1HKQbNfiWzYJ31M0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123413; c=relaxed/simple;
	bh=QDznFHUaLKGLq1dqz3otfTk5y5Zaylek6NAlM01jnCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4FUc8aIIlAhfyriydO4klzA5zkoUldfOCz85nvKbIPB7R9QIp/PHGl3Ysxu3B7z/u9fJ9kfiPPMC+smKZ4zINqBDn8TibyS35fLGjqqbMWOHSwRmgdTFxq1V+Qxw9o+drthW98GmrIiETQ/1tL/OtP/anyaSZL8nCbM653Tlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx2/TQeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1608C19425
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123412;
	bh=QDznFHUaLKGLq1dqz3otfTk5y5Zaylek6NAlM01jnCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qx2/TQegAsSWiipFMdK+vo90oma21ZoSN1DizYY/NiI1Hn9adwceGeib03x3sYGCr
	 LFJA5DlxjC6K0H3rdLPERYAUkAZiIejtloUZsoN81OJaoaYQDQidG0drdS97swqcx4
	 RTKZPFX0+DpQKwavbow4ZGNGp0xkXTM9zN1s+L982srVWqKOBqnsUW6zeHFuRZ6kGE
	 jr8tyyCEhMZo4JAR7tAVGKgqHpS/1KLTRK7SSDsbDUXsbHZ7GMBDDLy8zOO3Y14R1U
	 xsFsevi0EEdgi6XVlekKs6xBXxLcN54Hd7IhmsJ1pasPiCJ6+KhLVdUKzWn+yyBOUA
	 Sea4YmlMYC45A==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cfd8ca8191so2161869a34.3
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2026 04:56:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfx3Bt4+TDYESAsXIGtP/BVvBONTAMDAyfG7sjqauia30aLderraqyErGINTZUVUNDsuSLfUXa6EGY@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4/Ivd6zNGBRW5VaFRbMP7BebJMGUhSFB1RRUW6X0VzbWWH1j
	WmAv2UjLwxoOKx1zutTyxk9Vf6kU4KT0mRGEonOH76TcS3LMJJVmXxsy7Od9azYlmoGy3PrSS2S
	hLTbw5ZRmkoyCDkZeOUlsp3vNoAQCMUI=
X-Received: by 2002:a05:6830:410b:b0:7d1:8ad3:ce7 with SMTP id
 46e09a7af769-7d1a5232cf6mr7191660a34.1.1770123411993; Tue, 03 Feb 2026
 04:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23A877C77DF26B7C+20260203021233.8178-1-jiawenwu@trustnetic.com>
In-Reply-To: <23A877C77DF26B7C+20260203021233.8178-1-jiawenwu@trustnetic.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 13:56:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i4ds3Cjc5x+Umx2m57ebf4w_MOf1saE=iEFrqsv5ZrQA@mail.gmail.com>
X-Gm-Features: AZwV_QiWZ2t-z7TMPETs93NzcoUSceD278nEv1wv3pNL9RpOUYp7yG90gdFH2Vw
Message-ID: <CAJZ5v0i4ds3Cjc5x+Umx2m57ebf4w_MOf1saE=iEFrqsv5ZrQA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Avoid NULL pointer dereference in ghes_estatus_pool_region_free
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, Shiju Jose <shiju.jose@huawei.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20835-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38F35D9991
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:14=E2=80=AFAM Jiawen Wu <jiawenwu@trustnetic.com> =
wrote:
>
> The function ghes_estatus_pool_region_free() is exported and be called
> by the PCIe AER recovery path, which unconditionally invokes it to free
> aer_capability_regs memory.
>
> Although current AER usage assumes memory comes from the GHES pool,
> robustness requires guarding against pool unavailability. Add a NULL chec=
k
> before calling gen_pool_free() to prevent crashes when the pool is not
> initialized. This also makes the API safer for potential future use by
> non-GHES callers.

Are any such callers going to be added any time soon?

> Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error stat=
us data has multiple sections")

It doesn't fix anything, the lack of the check is not an error
currently, AFAICS.

> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/acpi/apei/ghes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0dc767392a6c..e81c007464a9 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -236,7 +236,8 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
>   */
>  void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
>  {
> -       gen_pool_free(ghes_estatus_pool, addr, size);
> +       if (ghes_estatus_pool)
> +               gen_pool_free(ghes_estatus_pool, addr, size);
>  }
>  EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
>
> --

