Return-Path: <linux-acpi+bounces-20652-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG3ZHwqeeGm/rQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20652-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:14:18 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840793726
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1CCE3004F31
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C4346766;
	Tue, 27 Jan 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9r/w5g4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DE63451C6;
	Tue, 27 Jan 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512455; cv=none; b=nalTk5oJI6FuR+Tu+ow3M8eO4QIbd0ENffviHNTaegLlnmGwpe+Cf+2TytfhBL137ECsFCdeE7wyQpdVfu1EShFlMkx1bPbuBRQbPxFuJHgRWfLBm9mUyUg7LsSMrhg/kA7v74atZB6f1+PN+vHoVcDyTkrBoxEzOs4/8JkB7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512455; c=relaxed/simple;
	bh=9Gs83gn8tecEYpFvmr++HgEc+cCrMJRna7f6l8UgdN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9EJsLdhMcSUF71opGNe3NBhCEIXMsNzKrsF/yMyR2v+4kuqlMdQODzvbOLb2fLVib0CW0vCrpfmhQBWHwAl3JGF0HIYx/vSiNNcIeLGtG7fxb0R2E77os2QSqJ9raHo2ybfIHqb/jCwb9/6Ld7ODqiHwfLFPnq8RBqrsNtOFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9r/w5g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650D6C116C6;
	Tue, 27 Jan 2026 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769512455;
	bh=9Gs83gn8tecEYpFvmr++HgEc+cCrMJRna7f6l8UgdN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9r/w5g4dAeFIwCesvrBF6RNltI8Ld66BHBpgctZ+VFpsQoaBNY5rhOQbMlkj2Z/C
	 Hsr4IrYy7AZG5jnAbeLBagHkIxwyXJRChpVQo3IZAXU5eODO3Up02So7B4eL0eZLAZ
	 i8i6Tg4riMamtuLQgzXfsKYCO8+JXC84escaZzStaRLsJ5yqHJHmoi72Zta8XJaiAA
	 fct35fcCd6b9ZJFCwGixN93RASB4K5LjYkVzCl0vG9fBQ5GJlGMiRVoBDHiU9LEHNB
	 cZn93hPh06VvRE/BAoet20GG1FBU9qT7J7LxyYVyKLULOXB0qkwsX+AL8BFme+IBNL
	 gTxo5OVka7R1w==
Date: Tue, 27 Jan 2026 11:14:11 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Beleswar Padhi <b-padhi@ti.com>, Andrew Davis <afd@ti.com>,
	Yuntao Dai <d1581209858@live.com>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, mailbox@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mailbox: Clean up the usage of mailbox_client.h
Message-ID: <aXieA6vpJEUvEKRe@bogus>
References: <20260127-mailbox-v1-v1-1-cf15d7cece48@nxp.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-mailbox-v1-v1-1-cf15d7cece48@nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,live.com,vger.kernel.org,lists.linux.dev,nxp.com];
	TAGGED_FROM(0.00)[bounces-20652-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1840793726
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:02:53AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> mailbox_client.h is should be used by consumer drivers, not mailbox
> provider.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mailbox/bcm-flexrm-mailbox.c | 1 -
>  drivers/mailbox/cv1800-mailbox.c     | 1 -
>  drivers/mailbox/omap-mailbox.c       | 1 -
>  drivers/mailbox/pcc.c                | 1 -
>  4 files changed, 4 deletions(-)
> 

[...]

>  
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 22e70af1ae5d14e6e8c684fe032c2864f6ae4d6c..6ca84596e7637114f66d32a95d12c863e942b756 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -55,7 +55,6 @@
>  #include <linux/log2.h>
>  #include <linux/platform_device.h>
>  #include <linux/mailbox_controller.h>
> -#include <linux/mailbox_client.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <acpi/pcc.h>
>  

There is a call to mbox_bind_client() in pcc.c that is declared in
linux/mailbox_client.h

You didn't see any build warning or errors with this change ? Esp if build
as module.

-- 
Regards,
Sudeep

