Return-Path: <linux-acpi+bounces-13844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9AEABFD94
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 21:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE80188E133
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68823183D;
	Wed, 21 May 2025 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TwXx5gxS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ecs8cHPK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935CB12E5D;
	Wed, 21 May 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747857153; cv=none; b=XgCgXwyYZMy6kgu5O24PDQILx/oH8GSVhuPFKRnNX3ydtZC1+L0iw2bqENIp0V8PzGHA/t8CkEfYNK7ex1FdVhy+Puc/vHZymUPiz45q7Cw8LchxAFwkoeFtOiBGZRNjNeoC5dMY+th/zDXFjtjAn1cXL8bOjJj7jTe72mqceAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747857153; c=relaxed/simple;
	bh=dD1AvwBxRdWt10BaspQ28iWmfJwCDQdE/S10cWPvHRk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZxD88JC6GF7Yw12K4HCRl/qsQJOH3FXUB2z0zxyiPT2IY1RxA2CmojEawV8tDglOA/jNpL9SrqemwW9OU1iFaXXCvwfOiZ2ROHqjEREr5jizOitBMIWep0Bxe0bKqDIDHtqNg1LfxRX9qHbZv1IG5avO/beTV33h7XaAaK+xtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TwXx5gxS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ecs8cHPK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A21C1140138;
	Wed, 21 May 2025 15:52:29 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Wed, 21 May 2025 15:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747857149;
	 x=1747943549; bh=vrJOBnORlJ76z7DTYBnqd66weSA7jp1DtSP1OwHgLjg=; b=
	TwXx5gxSvyAwO6Z6Z/FE6xPiGxYRJa6J2jq9/+BntDJJkLDgVtvELNsxf+qac5YA
	9z4JxfvWP3uECEh10qq7s+sEeX322a5oxAnRy9eot0UjIlDxznKAJHtu92nrC9SO
	906wxVqqi7g1eaorDCkS+Nm+vCZ6FDHlx3AiNYnSaCnBaG8PcEFshs7E8gMxt1f3
	Ku53BOPLLi0Lmq4tXziyT/9wvwH1qu2vibt1fIuXJJdpoEETRG27ZQnQq6wIMcEl
	Qy29fBgr6wJuUD4KrGalndKuHNOScD88DWDkdL4p0xfS0eb7nLGa4bMXOtG2NwMp
	lwfY9CvlR5Tg4vnQ0YK9Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747857149; x=1747943549; bh=v
	rJOBnORlJ76z7DTYBnqd66weSA7jp1DtSP1OwHgLjg=; b=Ecs8cHPKFgGWM2t8O
	yJnBt9feMXhFKo0IBo3lnpEEIVPC53dqTaH/0zj0mbbzpaPKYTtZV/uSOZ+qrYUs
	xE544ANMQvRRVMqXksWIqalHxjjGF5k5GgH/KO0UzjMfgrnuKPxbzDSDyRbFOZPm
	yZIVpTknA7pqybhjcmW1c6/0YV7wpjSxPcgRlU1ueuzlCns/dHhmLquGGcEgZlMU
	Cta8mIjIqRYfghy7Kam6vvzuf4CwIOFs7a+k/0hwaUTIqoDMblrdqCkp/KFI/kd8
	C0k5sNR4WspqYj/GtOYP7yaQjv5p3Vkw92VtJx4HwH4pzIOLztZtIeOk00q9FrcN
	KgFPA==
X-ME-Sender: <xms:-y4uaGwVAGRQASYTk74tCTz_MVFrVxII3wdsvt9SRZ0sg6xQEP_5KA>
    <xme:-y4uaCRDzlbB0iS98t2G71oHgk6DZ8H7TNfZO4_uSVjxd97SjjisowKum0miDU0l_
    tm46_93ZQjdkbyXLkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghf
    ufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoe
    grrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpedtgeevteeiteelleeh
    keffteeuffevleethfefvdegheeuteehhfekgeegheeuvdenucffohhmrghinhepsghooh
    htlhhinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhm
    pdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtth
    hopegrlhgvgiesghhhihhtihdrfhhrpdhrtghpthhtohepshihiihkrghllhgvrhdqsghu
    ghhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrh
    hvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    rhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehprg
    hulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehmphgvrghr
    shhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhrtghpthhtohepshihiigsohhtod
    dvtggrvgelvdguvggujeehkedtkeeffhehsgguvgesshihiihkrghllhgvrhdrrghpphhs
    phhothhmrghilhdrtghomh
X-ME-Proxy: <xmx:-y4uaIVGtVrYPk8SCNYfsoJQfotrEhR3knHsnHwijsQNQUNeQp_9Lg>
    <xmx:-y4uaMjwCRpmKYl72u-RxtXw5uPFIePzKTmD0got7NPQI-D17QioRA>
    <xmx:-y4uaID5MqkIbAEL87qTMRO3FwGY-W0M1vW7dnBL987csBsRHjQ9Vw>
    <xmx:-y4uaNLXw1mZJPVJ7NJ3b1hD3-6eeU0p8nZOx2IjTLBi0oUaqd0hnw>
    <xmx:_S4uaPis0yfxq6H4Ug4LlXX8Ruh9g92plOtQx_Ya5JgEV3Dz_myaNKQE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 89E001060061; Wed, 21 May 2025 15:52:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T583c151a77edcc97
Date: Wed, 21 May 2025 21:51:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexandre Ghiti" <alex@ghiti.fr>,
 syzbot <syzbot+2cae92ded758083f5bde@syzkaller.appspotmail.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>, syzkaller-bugs@googlegroups.com,
 "Mark Pearson" <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-acpi@vger.kernel.org
Message-Id: <fcbb98be-3a15-4a24-96ab-74d169337983@app.fastmail.com>
In-Reply-To: <8368aa6d-e5a9-4136-8eb6-c059bc888979@ghiti.fr>
References: <682b0412.a70a0220.3849cf.00b1.GAE@google.com>
 <8368aa6d-e5a9-4136-8eb6-c059bc888979@ghiti.fr>
Subject: Re: [syzbot] riscv/fixes test error: can't ssh into the instance (2)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025, at 18:35, Alexandre Ghiti wrote:
> On 5/19/25 12:12, syzbot wrote:
>
> Because we don't have acpi enabled and then acpi_kobj is null=20
> (https://elixir.bootlin.com/linux/v6.15-rc6/source/fs/sysfs/group.c#L1=
31).
>
> The following patch fixes it, but not sure this is the right way, let =
me=20
> know if I should send it, it would be nice to have it in 6.15:
>

> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -688,6 +688,9 @@ static int __init platform_profile_init(void)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (acpi_disabled)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -ENOTSUPP;
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D class_register(&pl=
atform_profile_class);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)

The change makes sense to me.

I double-checked that returning an error from the initcall
causes no problems, but it is only used for printing it with trace_initc=
all_finish_cb().

As far as I can tell, the problem has existed in theory since
linux-6.14, when the sysfs_create_group() call was moved
from platform_profile_register() to the module_init call.

Maybe clarify this and add

Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI plat=
form profile")

      Arnd

