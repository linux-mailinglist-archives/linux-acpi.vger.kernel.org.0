Return-Path: <linux-acpi+bounces-9089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3DA9B5273
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 20:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2192847A4
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0276206E93;
	Tue, 29 Oct 2024 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="jeeXrg47";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7smLFMK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B91FBF50;
	Tue, 29 Oct 2024 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229069; cv=none; b=h7+/ZeSHyIbzjjmLQN57Jt6oB7S6+tyE2UXhyzV4W38CnaYZNuUjfEtRp+QgehyOhOTlbWx/TVTb23IPX3axf7za9gzMru6C5vCkzMkrqDOCMzv4FnmXJmImTosYIjP/gSmHO7phcmmFt3emOmaht6uKgxQ729FjJw25/k3+bUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229069; c=relaxed/simple;
	bh=n9ca/wig78LRP2Bp6VofPAhsp3VTMSA7jWv2d7WpOTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4lJOeLu1VtntMuJZpfQw7PUssUV2UcELpFVoqP3WgRVONtzfZhDLktFVfbfurQShUm70xUQqT5y57jgu1uvcM3ZFIztvxhBP3XA+/gP82o3D9aGf5oH+3hlf8ArkTUtKInJoImk4lah7GuY7p9z4aq1wC8HjZ3c9a9oIGqexE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=jeeXrg47; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7smLFMK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E1E3D138026E;
	Tue, 29 Oct 2024 15:11:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 29 Oct 2024 15:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730229065;
	 x=1730315465; bh=2/QxyYSwgEenSj5UTUbmSdnftP3pA8phAAui6JoA8Fc=; b=
	jeeXrg47bqY3NVayEp6ZiQBpH9gK4vjUqifMdTEb/r84tW5WV46Qs8YJLV6hauHb
	V63ix0dLzSDmyNqZK89/lzI1PmI2rbLH1zX3YNm6JGltSopd1+nuKa/J+Y7XUpnV
	BuGqcCtY+wCOEhjLfUGjng0hNe4zqVdPMHosEtUMtdL3g42RoSVn/9CfXijqJTD3
	GIS7Ww+DDOOsqH1eqBqpKq9XzdToLrmZU8QWHFD1Zy5tn4Fi9A4PJIl/Q45cLJcA
	rJ8m8FKg6A3BTHrz6oPhe7jVAQt0/XWCMT2zPcxF/5QPMPDuTNLpp1at9O+YHHty
	48yZPJ2p88Vh6kBbfwvXbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730229065; x=
	1730315465; bh=2/QxyYSwgEenSj5UTUbmSdnftP3pA8phAAui6JoA8Fc=; b=j
	7smLFMKW1EKL5FybpJesytNP4oYH/UQ1E6C9oOIshioIaEJrq/eJB41Pz7A+RfVD
	piULPk3t4imaxqhSWQ4fHZXKSWGlt0ZrmZjSde4R76ke7CHVG247/Czy+VFhpZfg
	HZ75qjZjerZJwoMoQmTIlzo7XG2K3Q+VGNbM1dD6LDPkGGGru2rdl1x2s7brF5zd
	wAtLbgI1LJMoDSj01FQu9sURHqra0h5HitpwVDiD1kDXcnO8tP9lyoJRu1I1mAYe
	rGWIKMIZY9H5ulUVlbaeDWL6Ov3Qw898Q7NwCMOAIyvvGZNitmsMtjrptd083rRI
	g3fpUX7j/zucv2kobYLwg==
X-ME-Sender: <xms:SDMhZ63lvoaU3i_vizkqUVT8XLNglvg_LZhykXPiIFKd1hjP4vo6Mg>
    <xme:SDMhZ9FUE-sq0vqgOxj8AAI4Khkr5jREWgKDbo8icRuJzDA1P1m9vLjXRh1L-Vobi
    nJMpG3g_ZrNGNxPUCs>
X-ME-Received: <xmr:SDMhZy47e9s_LMS4i7w6No7LzIbBblkeFtRADbqK6oIl6enw1EoVnVLryc1Ah-96H8kTUyFCop2EKl9-BETCojBUeWmFRcFV-OeRUkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhihnug
    gvnhhordgtrgeqnecuggftrfgrthhtvghrnhepleegkefhuddtudejjeefgfeigeekfeel
    ueekvdfgvdelffdvfeefhfeftdegieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggrpdhnsggp
    rhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhioh
    drlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehhuggvghhovggu
    vgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslh
    hinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hluhiimhgrgihimhhilhhirghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlvggv
    sehsuhhsvgdrtghomhdprhgtphhtthhopehshhihrghmqdhsuhhnuggrrhdrshdqkhesrg
    hmugdrtghomhdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:SDMhZ73y7uHKOUDgeKHx2dBKR0Ib8epk0xLLzOW-0C9Hhe9bplAoKQ>
    <xmx:SDMhZ9HsUsliQEVkPbOmN-KpmN4ihGWVjXx7jLZtYNawLe2_UlcgDg>
    <xmx:SDMhZ083pUgmJmXdovwQRXCrJi3VKr4MsFU7AkaO0oivpC0SWiYHrg>
    <xmx:SDMhZykYe09rSo2quQQJzjM0kzNoHnQwKJpOdW7FS9EIbSnTNDD3bg>
    <xmx:STMhZ21aQX8ke23RvJZb18h51t6trSb42D5EEpUfd_LRlnbsTJva07Z8>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 15:11:01 -0400 (EDT)
Message-ID: <75d6d50e-795c-4368-856e-ba530e1fbee3@lyndeno.ca>
Date: Tue, 29 Oct 2024 13:10:57 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] ACPI: platform-profile: Add a name member to handlers
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-2-mario.limonciello@amd.com>
Content-Language: en-US
Followup-To: 20241025193055.2235-1-mario.limonciello@amd.com
From: Lyndon Sanche <lsanche@lyndeno.ca>
In-Reply-To: <20241025193055.2235-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-25 1:30 p.m., Mario Limonciello wrote:
> In order to prepare for allowing multiple handlers, introduce
> a name field that can be used to distinguish between different
> handlers.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/surface/surface_platform_profile.c | 1 +
>   drivers/platform/x86/acer-wmi.c                     | 1 +
>   drivers/platform/x86/amd/pmf/sps.c                  | 1 +
>   drivers/platform/x86/asus-wmi.c                     | 1 +
>   drivers/platform/x86/dell/dell-pc.c                 | 1 +
>   drivers/platform/x86/hp/hp-wmi.c                    | 1 +
>   drivers/platform/x86/ideapad-laptop.c               | 1 +
>   drivers/platform/x86/inspur_platform_profile.c      | 1 +
>   drivers/platform/x86/thinkpad_acpi.c                | 1 +
>   include/linux/platform_profile.h                    | 1 +
>   10 files changed, 10 insertions(+)

This scope of the patch looks good to me.

Reviewed-by: Lyndon Sanche <lsanche@lyndeno.ca>

Thanks,

Lyndon


