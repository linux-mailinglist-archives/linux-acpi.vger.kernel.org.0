Return-Path: <linux-acpi+bounces-8593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B19D993B62
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 01:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9991C23381
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 23:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96918C907;
	Mon,  7 Oct 2024 23:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="naOxIQ4J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aq7bLMd4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9514317E;
	Mon,  7 Oct 2024 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344774; cv=none; b=o618i5vi3MTobX0hkk/bYvqQor0gd0jH3JDCVamrXZWylzg5RWMjWloFMYJTF5hVSCR/XPvUgipuHRV0fv//azWQx3I6m2xKE+TIUe9AdIRKvYu1uB0Z8bx3TPczvnPrB29Z38G5RPIA95zyo3s/SblqGxRzBsd6ud9YCYyWkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344774; c=relaxed/simple;
	bh=yWXQ35yOAfJiT2fwzNDA4YeCmrGUf8Vo/6hgAZghj/4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PWm2F7a4RsrXFz94ZLpVcCdP90vYXleyCSqqsOMD8qvAIGusOIocAAKkBgGfdl+Bj+oeLhbRxpSxb8KzRavc9m+xph/qU2G/IGG7/MAbU+xS+FIcMvmKYGJ1hgtHbsXobWHqXZ5dUIkls0SpLSLeQnIksxwNfjbKKYnrfZDPaok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=naOxIQ4J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aq7bLMd4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6EB7114023C;
	Mon,  7 Oct 2024 19:46:10 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Mon, 07 Oct 2024 19:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1728344770;
	 x=1728431170; bh=IE5CyDnd4iSaQgSeOBprBhIuCHaR09gbrV75arL8ucc=; b=
	naOxIQ4J8QrBfvek6Xo//Nu5/vqq0yI02TEcQ2mq91rC3NGqxEsQqwQQeHJJqmPT
	JrrEQB/1mZUACatstj8vestxbn/KmUUS+aKv8eEmzNlvBRliHaauRignYq08yutt
	0P4zcUS3p1auFe5SCXNYrM7YfnwiDrlvgMRo5Lb4xmJRyHbWOAiWLGO39zylNLaA
	mmR3+3KNhQ7f8nHl6oDS1eldhHyUFpGGFyaVekb/yB5KUrXtXFK7GW61QxZzetkQ
	QN2roL70bEYkk81jSuKT1+luBXVvnBTcvfzYnTw9wO/945Lk4zsGbwR+1lqy13Ga
	RcunSoHou2UDamzkVAbHRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728344770; x=
	1728431170; bh=IE5CyDnd4iSaQgSeOBprBhIuCHaR09gbrV75arL8ucc=; b=A
	q7bLMd47lEAPpET+8Hd2NlkEh4A/c/KoJRvDFteX2yYzDb3+OahdTpyrBAoYG6TQ
	DFyhW0kFg7J5js9Wg05g7FNUgYtIhigqKdbeKhmdPVaOnwGP2F1qARcg8iS51jNV
	wootY84wUaoYnfuGOBrROuIayZgdRWx8ynsbV6qTGPYhVL7MKXpJRguj7b3HuIEV
	Z0lzPaDvUn7w0NrlBd0KVTDln+qOyxtUF6cZjQdk9lDqadHCzPV6Z214D9t0Mgg4
	oIfwgj1pd+cZCOc77iOc1cNeFe3rUhVkLvJ+aewDaE5yOOIUwJ07PmYw8Ke7eTyH
	kbzESqgnSFqt84WqZNkTA==
X-ME-Sender: <xms:wnIEZ-YfyWZTMp-xgnf4M7txY8-HK8iioDB8O1pwd25E9GLRdVji3Q>
    <xme:wnIEZxZVSZoR6VVVefN1tzCCQBj0YKWXG2wS5b7nxu8Z62MB83SJKoBJadnYZ-Jvk
    6dZY0EelDEj1ijspaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfnfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvg
    hvqeenucggtffrrghtthgvrhhnpefgieffhedtgffhtedtiedutdefkedvjefgveehhfff
    vedthfejleegfeffkedvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphht
    thhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:wnIEZ49WUw_S_5w-SKcW_nhXYDDIRsD3AV_FjMrHrZ6p771usP6OrA>
    <xmx:wnIEZwrB93hSYFGhXhZwBS7lGtozFACmzF75N0ZUta3t0Q8mtcVzPQ>
    <xmx:wnIEZ5rxZ_YpPq9pGRbIA-dkF858VP_HP6IWC3gGuZaFS55y9KQUgw>
    <xmx:wnIEZ-TWMBTHYfzLKlsfTmYs6zL_o9oXx6PywuR3F52L7FI9ltXPWg>
    <xmx:wnIEZw3YgaBBDUnFlHyp_aLFzSVjXXdYjxGLuza_At8-yKcErlKsYkmZ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E5AE3360026; Mon,  7 Oct 2024 19:46:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 12:45:50 +1300
From: "Luke Jones" <luke@ljones.dev>
To: "Hans de Goede" <hdegoede@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Message-Id: <c69b7d7a-37b4-4f80-a1e8-373cbf1212f2@app.fastmail.com>
In-Reply-To: <20241005212819.354681-4-hdegoede@redhat.com>
References: <20241005212819.354681-1-hdegoede@redhat.com>
 <20241005212819.354681-4-hdegoede@redhat.com>
Subject: Re: [PATCH 3/4] ACPI: resource: Fold Asus ExpertBook B1402C* and B1502C* DMI
 quirks together
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 6 Oct 2024, at 10:28 AM, Hans de Goede wrote:
> Asus has 2 ExpertBook B1402C models:
>
> B1402CBA with 12th gen Intel CPUs
> B1402CVA with 13th gen Intel CPUs
>
> Fold the 2 DMI quirks for these into a single quirk to reduce the number
> of quirks.
>
> Likewise Asus has 3 ExpertBook B1502C models:
>
> B1502CBA with 12th gen Intel CPUs
> B1502CGA with 12th gen Intel N-series CPUs
> B1502CVA with 13th gen Intel CPUs
>
> Fold the 3 DMI quirks for these into a single quirk to reduce the number
> of quirks.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/resource.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 0eb52e372467..2c17d3ea4d3c 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -448,40 +448,19 @@ static const struct dmi_system_id 
> irq1_level_low_skip_override[] = {
>  		},
>  	},
>  	{
> -		/* Asus ExpertBook B1402CBA */
> +		/* Asus ExpertBook B1402C* */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
> +			DMI_MATCH(DMI_BOARD_NAME, "B1402C"),
>  		},
>  	},
>  	{
> -		/* Asus ExpertBook B1402CVA */
> +		/* Asus ExpertBook B1502C* */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
> +			DMI_MATCH(DMI_BOARD_NAME, "B1502C"),
>  		},
>  	},
> -	{
> -		/* Asus ExpertBook B1502CBA */
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
> -		},
> -	},
> -	{
> -		/* Asus ExpertBook B1502CGA */
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
> -		},
> -	},
> -        {
> -                /* Asus ExpertBook B1502CVA */
> -                .matches = {
> -                        DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER 
> INC."),
> -                        DMI_MATCH(DMI_BOARD_NAME, "B1502CVA"),
> -                },
> -        },
>  	{
>  		/* Asus ExpertBook B2402 (B2402CBA / B2402FBA / B2402CVA / B2402FVA) 
> */
>  		.matches = {
> -- 
> 2.46.2

All patch look good. This does make me wonder if perhaps there are more places still in the kernel where the DMI matching can be further reduced.

My experience in the last 5 years of working on ASUS products is that they tend to be fairly consistent and not deviate from their model numbering scheme or the "base platform" that the variants are built on - the model number base does increment if the platform changes in some way (typically mobo or chip changes).

Regards,
Luke.

