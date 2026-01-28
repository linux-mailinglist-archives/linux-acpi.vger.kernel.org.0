Return-Path: <linux-acpi+bounces-20709-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLeICn0GemlE1gEAu9opvQ
	(envelope-from <linux-acpi+bounces-20709-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 13:52:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4720A19C2
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 13:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D5D7305DEE0
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEB9327BF3;
	Wed, 28 Jan 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrNUFQfm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFF1E5B70;
	Wed, 28 Jan 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604488; cv=none; b=oi3g/lQkzZg+h2NXBIR0YKJv5HnGtKMaUQLGBA5EWBWnCXnEtiR4DHQI7pJlZI5IuKEoXQd6PFn+S7UBJzKIPaDt79yKgW2bg7RpEHRAEEvDOex0AZ98prVgHxkP7LSI+Vzp2ycytaVQAzFqdvizVAv5CLgY6Urmo1o5nMpMMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604488; c=relaxed/simple;
	bh=cYO6crenLBEK2opbHoNH4cg+Jq0cJyPTTPSva7fZ8nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8xZ4b1B1qeZpalf4dDWez4Ja60MzIetWWoV1LLhIcCiVPTXQoOrhmgyhPxrsP8Kq+JL9lCWmXRMI6nRIeqaaf8a7WJSnPQNHSTW5EW360k5ZumcLNDKy+YiXcAiS8IQo0RapR9P4OsvxS6dsnmRqTsxmhoaSJ+cy+rijqwbyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrNUFQfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AADC4CEF1;
	Wed, 28 Jan 2026 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769604488;
	bh=cYO6crenLBEK2opbHoNH4cg+Jq0cJyPTTPSva7fZ8nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrNUFQfm7R4xG/m8UYnPHNznqAECvb6T53ZKhH3cZ4bcxiQZZ7OMc/bH/rh9nN+C0
	 ++REgKN0F4neIB8i66JX4R40Uk56c86p1QSSkz8pez4nIYsrkEZbyFuyBy+/VdU1zL
	 0nSA0YBFbqcf9RCr3TeMLgUDJjVRU/qwF8mCN/awpZRWpg3LHtmFxzoeXpxD7vPf1G
	 379qPLdE5Jcc2s0Ow3ePrkfONXB60rrmDPi7KRk6xc7kYOWPYUtw5u1GVwLZlNTgKF
	 iL/q9A0Ao9/8J+L/nzHZkUreIl5sV3tneisthCTgjFgqs7ZT0WdfHsMC9Fvh5dm6te
	 Rji9MKItIVJQw==
Date: Wed, 28 Jan 2026 12:48:04 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Beleswar Padhi <b-padhi@ti.com>,
	Andrew Davis <afd@ti.com>, Yuntao Dai <d1581209858@live.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mailbox@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2] mailbox: Remove mailbox_client.h from controller
 drivers
Message-ID: <aXoFhMUKIvsP-DVd@bogus>
References: <20260128-mailbox-v1-v2-1-54936bb08f15@nxp.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-mailbox-v1-v2-1-54936bb08f15@nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ti.com,live.com,vger.kernel.org,lists.linux.dev,nxp.com];
	TAGGED_FROM(0.00)[bounces-20709-lists,linux-acpi=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: C4720A19C2
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 08:32:10PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> mailbox_client.h should be used by mailbox consumer drivers, not mailbox
> controller (provider) drivers. The affected drivers do not use any mailbox
> client APIs, so the include can be safely removed.
>

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep

