Return-Path: <linux-acpi+bounces-7599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1CC952D3E
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5646F28322A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F1F7DA84;
	Thu, 15 Aug 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="iBR1wMYI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVMre4P/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from flow8-smtp.messagingengine.com (flow8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADB1AC8AC;
	Thu, 15 Aug 2024 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720278; cv=none; b=FZxbwynd08E88lhgjD8rB1q0Xj86GarggNFTcErDakxpRwd8pQRTLbgtn2zVy05y5JsqnTb/sbMemtA4tUDad7AjYRQWQvLQDqCNSWVjSyg9zzIE0Qfd45dezcNttgTZRSa3UkDYr+YwaHVSZB0UxUQdCV8jDj7+ujH8WPrpMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720278; c=relaxed/simple;
	bh=cM/oa+aXFrNIzMB4+mBWw40HctDtv+Aci9IQkyQCuug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+oLQYWx8j5va+GZvxrBv7X+PN5WAA0/TGXFVhLnQXzju3PLQRzfUNyJ8fMUJaQV72i1tpENdUB6mfMGG5E2OXigKIfHXDqWGqUxz9yFOvmuIqbVVPVOj5chR+q1Jmndyq1huyGajLbg/NcYnFiekh9ANq1498mZCdERRXxgVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=iBR1wMYI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVMre4P/; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailflow.nyi.internal (Postfix) with ESMTP id 464B5200A34;
	Thu, 15 Aug 2024 05:24:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 15 Aug 2024 05:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723713866; x=1723721066; bh=DJrlepPVyE
	+yZqIgbQ54BkO2ZvNmAfile0WCqAW+g3Q=; b=iBR1wMYIvM5n4U4j9ojUn2xlhC
	TxvTDAwt/nwgs+2zmiaHQZDMqoqh1T8AGAWcfVi3d5dcZi3Hugw09lt2CFrR2yMG
	a3VWsCVkCMOsmGZSNweIEkNVa2T3Mi9vFA2VdJ5F03VSiP8uhJ2fGuCccEGMs6g9
	ENiDFWbPGoL6f7ZGhkknVGz7Fn/trhE+cCNF/6XdM47Jq6uT4zMs7SH/vSdQGY+Q
	I1Zvf/WWb58YdMlqrCn9x8sKjpUp1oGgr4wcpksLTlzF6ZwgO9X1D2FDZA0iEV7L
	HPkXEUJgKXP3kjUcNqxZIjr0xAKbP7vAZwFVfMuI+CRNXtOIE5RaHO45qlJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723713866; x=1723721066; bh=DJrlepPVyE+yZqIgbQ54BkO2ZvNm
	Afile0WCqAW+g3Q=; b=KVMre4P/zOVhUEqNei7d4gCpmWhHoJ7TMwaIs9mXpkIa
	8Kr1YzdEg/ucwYT+fTLlcQbuzMD3FMfE9iFyix/6pSVMkEiK46LuO0/kIQGVlLsW
	L3pxTn5aBuEtPK3kER2Kmt8F+Sfo97p67lWcDkt9hMs/IPEwlS1inU+9dKNtqY7D
	QwxSs8Z3Kk3g6zcVTe6RS4+uKnlM8EBoJEmoJ0dpyLSgzU1JKAVjIXeX/I/yfhQK
	eOoJ0DzF25tGyR8gS+PzuWSA3d8b2088lRLRjLlYEAGt3eBn7QsbirBbNZH9I+dT
	Ep1w/wtpcfCdu47jA0BXbP3/xqQ8ET60I9X7KmE1ug==
X-ME-Sender: <xms:Scm9Zr44ufvsXsylmy04oXubruVNMTwC_NH8lxtvpjrFxphYCzgp0w>
    <xme:Scm9Zg759fHIramAPVWZWOcfnaWS7Mgl9BnqTgssZwgk5OExyIiGFiyMBIGTT0RN0
    jO2WS6ej06Whw>
X-ME-Received: <xmr:Scm9Zif3xbeEDC2d37bvApihyPYrYAptc7X2PiNnCS1r60iWr1xBOQHZ1GsFLzoDFBkLY70AabKozf82Eq2Qo_ujlVzqrznUFcDJvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeehtddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhivghrrhgvrdhgohhnughoihhssegrrhhmrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghr
    sehlihhnrghrohdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnth
    gvlhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfigvug
    hsohhnrghfsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Scm9ZsKxLgryY2bIonp-45LEqE5IFULfg2yV1sKSkkOSCR-cf4PBeg>
    <xmx:Scm9ZvK_saCXo3XcEjOkFk5yNo0CJrsQZSZVCcTVgX2M45Y7G9mXVg>
    <xmx:Scm9ZlzCIG7C4fIwfrhCpuh07SdtuXzlVJ4FKzCvqmemALBno60U7Q>
    <xmx:Scm9ZrL6_rnIvDjhmzhOOvu7InSxqGihlTolXs-HCyjcpaijTbm-QA>
    <xmx:Ssm9ZpTgcQ0NxjHBc_8hQ_LOehZMU26etWUiR8XZL1I9PDF9of7bvgZT>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:24:24 -0400 (EDT)
Date: Thu, 15 Aug 2024 11:24:23 +0200
From: Greg KH <greg@kroah.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Robert Moore <robert.moore@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] rust: cpufreq: Add rust implementation of
 cppc_cpufreq driver
Message-ID: <2024081519-magenta-giddily-09ad@gregkh>
References: <20240815082916.1210110-1-pierre.gondois@arm.com>
 <20240815082916.1210110-7-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815082916.1210110-7-pierre.gondois@arm.com>

On Thu, Aug 15, 2024 at 10:29:10AM +0200, Pierre Gondois wrote:
> In an effort to add test/support the cpufreq framework in rust,
> add a rust implementation of the cppc_cpufreq driver named:
> `rcppc_cpufreq`.
> 
> This implementation doesn't support/implement:
> - vendor specific workarounds
> - Frequency Invariance Engine (FIE)
> - artificial Energy Model (EM)
> - (struct cpufreq_driver).attr field
> - QoS requests
> 
> Basic support is provided to get/set the frequency on a platform
> implementing the CPPC section of the ACPI spec.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/Kconfig          |  16 ++
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/rcppc_cpufreq.rs | 333 +++++++++++++++++++++++++++++++
>  3 files changed, 350 insertions(+)
>  create mode 100644 drivers/cpufreq/rcppc_cpufreq.rs

I'm missing why you want to re-implement an existing driver here.  Why
are you going to have 2 drivers for the same functionality/hardware?

How is the system going to handle switching between the two drivers?

thanks,

greg k-h

