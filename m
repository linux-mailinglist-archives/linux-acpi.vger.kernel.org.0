Return-Path: <linux-acpi+bounces-21120-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAbpOo9znWmAQAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21120-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:46:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DCF184E53
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 512ED301AD15
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5D036E472;
	Tue, 24 Feb 2026 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD7uR6J8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD2366DA7;
	Tue, 24 Feb 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926275; cv=none; b=DaIH1DaCrHR0/fbIHH4UZ8SES7K9P/CL+66gmObhZtpWIFiTJvle3PIEldqYPbzprVWGFsH4OzCuChAd5kh7z+JfoKoEjJ3m1kuD7i7EObSqYPsggO1i/CBiRvhqg/i1aAQxOjdOtieTlreg17JjYen/arPay+WZAoOi4nbm3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926275; c=relaxed/simple;
	bh=HctdBnsORT395ESB7MJ8tadwd8gBNHYdqC/SecwtrmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTM0aiUVg/fz/QfhX4u62Bquab0rW2jV87n7BgrPS5HkorPGAM+zzQsndpQrHbUAiN2ISFK7+pZVcS5noYYdIAVOACyHI7MVX2zqvCOSPhJdE6D7vwIB99yj7Bj1ljj4ula+FptzJ9kyM6wPKN6dBRPdfNh03P/B7zrJMeVrMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD7uR6J8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A84C116D0;
	Tue, 24 Feb 2026 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771926274;
	bh=HctdBnsORT395ESB7MJ8tadwd8gBNHYdqC/SecwtrmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CD7uR6J8TOmW2CcKz03WVUfVhQHDSyxUH+yZVjSd+HthiDXWCGBIabhquiZyLGw6m
	 6pAmZ6wg0798MkvysoEY+h/CWsP1K9hvgIemcWPCJE9KcIyHEE5jJRHa6KFvZS/NZl
	 CuUxXtDrT19e1P4ml95+3Pe+w2quTSS7VyCAD26sL5fibgHWWsC7KjEoBR1N7mKZn3
	 Mhr3Q8wtCEDDJxeX9Y8rI34o22rdBAWplxMg3APGvbW3zYK7n3DzkQR4lrMUg/0pFl
	 bn8yo4Mbxx7Ykml1GrGtwae8Ax73XXQrJ4BTSUcsKKO8w0Rn4o+GElPBuiKabKifi9
	 BhKiFVRfSrsDQ==
Date: Tue, 24 Feb 2026 09:44:29 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@cixtech.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Fugang Duan <fugang.duan@cixtech.com>,
	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH] mailbox: remove superfluous internal header
Message-ID: <20260224-antique-fair-swift-89e5bc@sudeepholla>
References: <20260224085720.18055-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224085720.18055-2-wsa+renesas@sang-engineering.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21120-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,cixtech.com,kernel.org,gmail.com,nxp.com,pengutronix.de,nvidia.com,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52DCF184E53
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 09:50:21AM +0100, Wolfram Sang wrote:
> Quite some controller drivers use the defines from the internal header
> already. This prevents controller drivers outside the mailbox directory.
> Move the defines to the public controller header to allow this again as
> the defines are not strictly internal anyhow.
> 

Makes sense to me.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep

